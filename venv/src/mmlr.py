import argparse
import collections

import globals
import decompilehelper
import track_header
import track_data
import patch_data

# -------------------------------------------------------------------------------------------------
# MML Reassembler - reassembler.blogspot.com
# A decompiler for Sega OutRun audio data.
#
# (c) 2019 Chris White
# -------------------------------------------------------------------------------------------------

# Source origin input binary compiled to
src_origin = 0


# Convert a byte array to an integer with correct byte order
def to_int(file, sign=False):
    return int.from_bytes(file, byteorder='little', signed=sign)


# Get a word sized pointer, and ensure it is adjusted using the origin
def get_word_p(file):
    return to_int(file.read(2)) - src_origin


# Create text label for subroutine
def get_sub_label(sub):
    return "\nsub_" + hex(sub) + ":"


def read_master_header(inputf, outputf, offset):
    print("Reading Headers...")
    inputf.seek(offset)
    decomp = decompilehelper.DecompileHelper()
    decomp.offset_headers = get_word_p(inputf)  # List of Channel Addresses
    decomp.offset_tl = get_word_p(inputf)       # TL Adjustments
    decomp.offset_kf = get_word_p(inputf)       # Key Fractions
    decomp.offset_patches = get_word_p(inputf)  # FM Patch Data

    outputf.write("\n" + globals.write_comment_header(
        "Pointers. For space reasons, you may want to remove the surplus KF and FM Patch data." +
        "\n; and point towards the original tables shown as [$xxxx] below"))

    outputf.write("\nmain:\n")
    write_header_pointer(outputf, "track_headers", "; pointer to track headers", decomp.offset_headers)
    write_header_pointer(outputf, "tl", "; pointer to Total Level adjustment lookups", decomp.offset_tl)
    write_header_pointer(outputf, "kf", "; pointer to Key Fraction lookups", decomp.offset_kf)
    write_header_pointer(outputf, "fm_patches", "; pointer to FM patch data", decomp.offset_patches)

    track_headers = setup_track_headers(inputf, outputf, decomp.offset_headers)

    # Pass 1 - Create Subroutine List Only
    print("Pass 1: Find subroutines in main tracks...")
    for track in track_headers:
        if track.is_enabled():
            outputf.write("\n" + track.write())
            setup_track_data(inputf, outputf, track.ptr, decomp, False)

    outputf.write("\nunused:\n")
    outputf.write(globals.SPACE + "defw" + globals.SPACE + "0\n")

    sub_count = 0

    # Parse Found Subroutines. And Parse Subroutines in those subroutines
    while True:
        sub_count += 1
        print("Pass 1: Find nested subroutines... ", sub_count)
        subroutines_copy = decomp.subroutines.copy()
        for sub in subroutines_copy:
            setup_track_data(inputf, outputf, sub, decomp, False)

        # Break out of loop when no new subroutines found
        if subroutines_copy == decomp.subroutines:
            break

    # Sort subroutines into address order to avoid 'fall-through' decompilation issues
    decomp.subroutines = collections.OrderedDict(sorted(decomp.subroutines.items(), key=lambda kv: kv[0]))

    # Create FM Patch Data
    print("Create FM Patch Data...")
    setup_patch_data(inputf, outputf, decomp)

    # Create Total Level / Key Fraction Data
    setup_tl_kf_data(inputf, outputf, "Total Level Data. Used by SET_TL command.", "tl",
                     decomp.offset_tl, decomp.total_levels)
    setup_tl_kf_data(inputf, outputf, "Key Fraction Data. Used by KEY_FRACTION command.", "kf",
                     decomp.offset_kf, decomp.key_fractions)

    # Pass 2 - Create Track Data
    print("Pass 2: Create Track Data...")
    for track in track_headers:
        if track.is_enabled() and not track.dupe_pointer:
            outputf.write("\n" + globals.write_comment_header(track.get_type().replace("_", " ")))
            outputf.write("\n" + track.get_track_label() + ":\n")
            setup_track_data(inputf, outputf, track.ptr, decomp, True)

    for sub in decomp.subroutines:
        setup_track_data(inputf, outputf, sub, decomp, True)

    return


def write_header_pointer(outputf, label, comment, offset):
    comment += " [" + globals.asm_hex(offset + src_origin) + "]"
    outputf.write(globals.ASMLINE.format("defw", label, comment))
    return


def setup_track_headers(inputf, outputf, offset_headers):
    inputf.seek(offset_headers)
    channels = to_int(inputf.read(1))

    track_headers = list()
    pointers = list()

    for c in range(channels):
        th = track_header.TrackHeader()
        th.offset = get_word_p(inputf)
        track_headers.append(th)

    outputf.write("\n" + globals.write_comment_header("FM and PCM Track Headers"))
    outputf.write("\ntrack_headers:\n")
    outputf.write(globals.ASMLINE.format("defb", str(channels), "; number of channels"))

    for th in track_headers:
        inputf.seek(th.offset)
        th.flags1 = to_int(inputf.read(1))

        if th.is_enabled():
            th.type = to_int(inputf.read(1))
            th.tempo = to_int(inputf.read(1))
            th.counter = to_int(inputf.read(2))
            th.duration = to_int(inputf.read(2))
            th.ptr = get_word_p(inputf)
            # Fix for FM headers pointing to the same track, as in tune radio. An annoying edge case!
            if th.ptr in pointers:
                th.label = track_headers[pointers.index(th.ptr)].label
                th.dupe_pointer = True
            else:
                th.label = th.get_type()
            pointers.append(th.ptr)
            th.transpose = to_int(inputf.read(1), True)  # Note this is signed
            th.stack = to_int(inputf.read(1))
            th.fraction = to_int(inputf.read(1))
            th.patch = to_int(inputf.read(1))
            th.flags2 = to_int(inputf.read(1))
            outputf.write(globals.SPACE + "defw" + globals.SPACE + th.get_type().lower() + "\n")
        else:
            outputf.write(globals.SPACE + "defw" + globals.SPACE + "unused\n")

    return track_headers


def setup_track_data(inputf, outputf, offset, decomp, subs_done):
    # Avoid Decompiling Same Routine Twice
    if offset in decomp.subroutines and decomp.subroutines[offset] is True:
        return

    td = track_data.TrackData()

    inputf.seek(offset)

    # Get next command
    while True:
        # First check our current offset and determine whether we need to create a label
        if subs_done:
            pos = inputf.tell()
            if pos in decomp.subroutines:
                outputf.write(get_sub_label(pos) + "\n")
                # Mark subroutine as decompiled
                decomp.subroutines[pos] = True

        cmd = to_int(inputf.read(1))

        # Convert command to proper structure
        cmd_info = td.get_cmd(cmd)
        cmd_name = cmd_info[0]
        cmd_bytes = cmd_info[1]

        output = globals.SPACE + cmd_name

        # Commands with arguments
        if cmd_bytes > 0:
            output += globals.SPACE

            # Identify Subroutine Address and add to hitlist, mark as not decompiled
            if cmd == td.CMD_CALL or cmd == td.CMD_LOOP_FOREVER:
                adr = get_word_p(inputf)
                if not subs_done:
                    decomp.subroutines.update({adr: False})
                else:
                    output += "sub_" + hex(adr)

            elif cmd == td.CMD_LOOP:
                output += str(to_int(inputf.read(1))) + ", " + str(to_int(inputf.read(1))) + ", "
                adr = get_word_p(inputf)
                if not subs_done:
                    decomp.subroutines.update({adr: False})
                else:
                    output += "sub_" + hex(adr)

            elif cmd == td.CMD_LONG:
                note_name = str(td.get_cmd(to_int(inputf.read(1)))[0])
                output = globals.SPACE + note_name + globals.SPACE + str(to_int(inputf.read(2)))

            elif cmd == td.CMD_LOAD_PATCH:
                value = to_int(inputf.read(1))
                # Update list of patches in use when on first pass
                if not subs_done:
                    decomp.patches.add(value)
                else:
                    output += str(value)

            elif cmd == td.CMD_KEY_FRACTIONS:
                value = to_int(inputf.read(1))
                # Update list of key fractions in use when on first pass
                if not subs_done and value != 0:
                    decomp.key_fractions.add(value)
                else:
                    output += str(value)

            elif cmd == td.CMD_SET_TL:
                lookup_index = to_int(inputf.read(1))
                op_mask = to_int(inputf.read(1))
                if not subs_done and lookup_index != 0:
                    decomp.total_levels.add(lookup_index)
                else:
                    output += str(lookup_index) + ", " + str(op_mask)

            else:
                for b in range(cmd_bytes):
                    value = to_int(inputf.read(1))
                    if b > 0:
                        output += ", "

                    output += str(value)

        # Commands without arguments
        else:
            # Special case for pitch bend commands (append: start note, end note, duration)
            if cmd == td.CMD_PITCH_BEND_START:
                output += "\n" + globals.SPACE + "PITCH_BEND   " + globals.SPACE + \
                          str(td.get_cmd(to_int(inputf.read(1)))[0]).strip() + ", " + \
                          str(td.get_cmd(to_int(inputf.read(1)))[0]).strip() + ", " + \
                          str(to_int(inputf.read(1)))

        # We must be on the second pass, so we can now output the decompilation
        if subs_done:
            outputf.write(output + "\n")

        if td.is_end(cmd):
            break

    return


def setup_patch_data(inputf, outputf, decomp):
    inputf.seek(decomp.offset_patches)
    outputf.write("\n" + globals.write_comment_header("YM2151 FM Patches"))
    outputf.write("\nfm_patches:\n")
    patch_list = list()

    # Create pointers to patches
    # We have established how many patches are in use from the first pass of the track data
    for p in range(max(decomp.patches)):
        pd = patch_data.PatchData()
        pd.label = "patch_" + str(p + 1)  # Note patch indexing starts at 1, not 0
        pd.offset = get_word_p(inputf)
        pd.used = p + 1 in decomp.patches
        patch_list.append(pd)
        outputf.write(globals.ASMLINE.format("defw", pd.label,
                                             "; fm patch data" if pd.used else "; fm patch data (unused)"))

    # Decompile Patch Data
    for p in patch_list:
        inputf.seek(p.offset)
        outputf.write("\n" + p.label + ":\n")

        while True:
            cmd = to_int(inputf.read(1))
            if p.is_end(cmd):
                outputf.write(globals.ASMLINE.format("defb", "2", "; Terminating Byte"))
                break
            cmd_arg = to_int(inputf.read(1))
            cmd_info = p.get_cmd(cmd)
            cmd_name = cmd_info[0]
            comment = cmd_info[1]
            outputf.write(globals.ASMLINE2.format("defb", cmd_name + ",", globals.asm_hex(cmd_arg), "; " + comment))

    return


def setup_tl_kf_data(inputf, outputf, comment_header, prefix, offset, pset):
    outputf.write("\n" + globals.write_comment_header(comment_header))
    outputf.write("\n" + prefix + ":\n")

    if len(pset) < 1:
        outputf.write("\n; This functionality is unused by this track, so this table is empty.\n")
        return

    inputf.seek(offset)

    # Use list for these so they are ordered
    pointers = list()

    # Read pointers needed by MML commands
    count = 1
    name = prefix + "_entry_"

    for entry in range(max(pset)):
        suffix = None
        adr = get_word_p(inputf)
        # Ensure we don't duplicate pointers that point to same address
        if not pointers.count(adr):
            pointers.append(adr)
            suffix = str(count)
            count += 1
        else:
            suffix = str(pointers.index(adr) + 1)

        outputf.write(globals.ASMLINE.format("defw", name + suffix,
                                             "" if (entry + 1) in pset else "; unused by track"))

    # Write values to pointer location
    outputf.write("\n")
    count = 1
    for entry in pointers:
        inputf.seek(entry)
        value = to_int(inputf.read(2))
        outputf.write(name + str(count) + ":\n" +
                      globals.SPACE + "defw" + globals.SPACE + globals.asm_hex(value) + "\n")
        count += 1

    return


def main():
    program_info = globals.PROGRAM_NAME + " (" + globals.VERSION + ")"
    epilog = "example offsets:\n" + \
              "  0x0e26 Passing Breeze          0x20c8 Splash Wave\n" + \
              "  0x3d5f Magical Sound Shower    0x5f2d Last Wave"

    parser = argparse.ArgumentParser(description=program_info, epilog=epilog,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("inputFile", metavar='inputFile.bin', help="Input file to decompile")
    parser.add_argument("offset", help="Track header offset in inputFile")
    parser.add_argument("-out", metavar='outputFile.asm', help="Output File Name")
    parser.add_argument("-org", help="Origin original binary was compiled to. (default = 0)", default="0x0")

    args = parser.parse_args()

    src_offset = int(args.offset, 0)
    global src_origin
    src_origin = int(args.org, 0)

    print(program_info)
    print("Reading " + args.inputFile)

    with open(args.inputFile, "rb") as inputf:
        output_file = args.out if args.out else args.inputFile + ".asm"

        with open(output_file, "wt") as outputf:
            outputf.write(
                globals.write_comment_header("Decompiled with " + program_info + "\n; reassembler.blogspot.com" +
                                             "\n;\n; Input File: "+ args.inputFile +
                                             "\n; Offset:     " + hex(src_offset) +
                                             "\n; Origin:     " + hex(src_origin)))
            outputf.write("\n" +
                          globals.ASMLINE.format("INCLUDE", "OR_defines.asm", "; siMMpLified defines"))
            outputf.write(globals.ASMLINE.format("INCLUDE", "OR_macros.asm", "; siMMpLified macros"))
            outputf.write(globals.ASMLINE.format("org    ", globals.asm_hex(src_offset + src_origin),
                                                 "; Target Origin. Edit as required!"))

            read_master_header(inputf, outputf, src_offset)

            print("Output written to: "+output_file)
    return


main()
