import argparse

# -------------------------------------------------------------------------------------------------
# MML Injector - reassembler.blogspot.com
# A quick way to inject music data in OutRun's Z80 EPROM.
#
# (c) 2019 Chris White
# -------------------------------------------------------------------------------------------------

# Passing Breeze, Splash Wave, Magical Sound Shower, Last Wave, New Bank
destination = (0x0e26, 0x20c8, 0x3d5f, 0x5f2d, 0x8000)
lengths = (0x12a2, 0x1c97, 0x21ce, 0x0768, 0x7000)
commands = (0x80, 0x81, 0x82, 0x85, 0xA5, 0x83)


def to_bytes(value):
    return value.to_bytes(2, byteorder='little')

def main():

    epilog = "Target Data and Commands are as follows:\n" + \
             "1 = Passing Breeze        2 = Splash Wave\n" + \
             "3 = Magical Sound Shower  4 = Last Wave\n" + \
             "5 = Unused Command / Create New Bank at 0x8000 for destination (default)"

    parser = argparse.ArgumentParser(
        description="MML Injector - A quick way to inject music data in OutRun's Z80 EPROM.",
        epilog=epilog,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("inputFile", help="Original Z80 program code (probably named epr-10187.88)")
    parser.add_argument("injectFile", help="Binary music data to inject")
    parser.add_argument("outputFile", help="Output Z80 program code")
    parser.add_argument("-data", help="Target data to replace", type=int, choices=range(1, 6), default=5)
    parser.add_argument("-cmd", help="Z80 command to replace", type=int, choices=range(1, 6), default=5)
    args = parser.parse_args()

    cmd_replace = int(args.cmd)
    cmd_id = commands[cmd_replace]

    data_replace = int(args.data) - 1
    data_target = destination[data_replace]
    data_length = lengths[data_replace]

    with open(args.inputFile, "rb") as inputf:
        with open(args.injectFile, "rb") as injectf:
            with open(args.outputFile, "wb") as outputf:

                print("Injecting " + args.injectFile + " to " + args.outputFile + " at " + hex(data_target))

                # Check injection file will fit
                inject_bytes = injectf.read()
                if len(inject_bytes) > data_length:
                    print ("ERROR: Injection File is " + len(inject_bytes)-data_length +
                           "bytes too big for insertion here")
                    return

                # Read source file until we hit injection point
                src_bytes = inputf.read(data_target)
                outputf.write(src_bytes)

                # Inject new data
                outputf.write(inject_bytes)

                # Pad data if necessary
                if len(inject_bytes) < data_length:
                    padding = bytearray(data_length - len(inject_bytes))
                    outputf.write(padding)

                # Read remainder of source file
                inputf.seek(data_target + data_length)
                src_bytes = inputf.read()
                outputf.write(src_bytes)

                # Patch Z80 File To Insert New Tune
                update_z80_code(outputf, data_target, cmd_id)

                print("Done")
    return


def update_z80_code(outputf, data_target, cmd_id):
    # Entry to clobber in Z80 command table (2 is unused so best to use it!)
    command_index = (cmd_id & 0x7f) - 1

    # Routine Table
    z80_table = 0xBC7

    # Start of padding in Z80 file. We can write new routines here
    z80_dst = 0x7D43

    # Force a jump to new code on sound command
    offset = z80_table + (command_index * 2)
    outputf.seek(offset)
    outputf.write(to_bytes(z80_dst))

    # Update FM Data Table with pointer to new music
    fm_data_table = 0x99E
    fm_offset = fm_data_table + (command_index * 2)
    outputf.seek(fm_offset)
    outputf.write(to_bytes(data_target))

    # Insert New Routine
    outputf.seek(z80_dst)
    outputf.write(bytes([0xcd, 0x61, 0x05]))           # call $0561		; reset FM chip
    outputf.write(bytes([0x3a, 0x08, 0xf8]))           # ld a,($f808)	; get sound properties
    outputf.write(bytes([0xcb, 0xc7]))                 # set 0,a        ; trigger rev effect
    outputf.write(bytes([0x32, 0x08, 0xf8]))           # ld($f808), a   ; write back sound properties
    outputf.write(bytes([0x3e, command_index]))        # ld a, command  ; command index (0, 1, 2, 3 etc.)
    outputf.write(bytes([0x21]))                       # ld hl,$xxxx    ; point HL at new tune data
    outputf.write(to_bytes(data_target))
    outputf.write(bytes([0x11, 0x20, 0xf8]))	       # ld de,$f820    ; point DE at ram for sound track headers
    outputf.write(bytes([0xc3, 0xe8, 0x09]))           # jp $09e8		; init sound

    return


main()