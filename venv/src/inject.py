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
             "5 = Unused Command / Create New Bank at 0x8000 for destination (default)\n\n" +\
             "Timer argument is required only when injecting music from other Sega engines.\n" +\
             "(e.g. Turbo OutRun requires 0x96)"

    parser = argparse.ArgumentParser(
        description="MML Injector - A quick way to inject music data in OutRun's Z80 EPROM.",
        epilog=epilog,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("inputFile", help="Original Z80 program code (probably named epr-10187.88)")
    parser.add_argument("injectFile", help="Binary music data to inject")
    parser.add_argument("outputFile", help="Output Z80 program code")
    parser.add_argument("-data", help="Target data to replace", type=int, choices=range(1, 6), default=5)
    parser.add_argument("-cmd", help="Z80 command to replace", type=int, choices=range(1, 6), default=5)
    parser.add_argument("-timer", help="Timer A value (hex)", type=str, default=0)
    args = parser.parse_args()

    cmd_replace = int(args.cmd)
    cmd_id = commands[cmd_replace]

    data_replace = int(args.data) - 1
    data_target = destination[data_replace]
    data_length = lengths[data_replace]

    timera = int(args.timer, 0)

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
                update_z80_code(outputf, data_target, cmd_id, timera)

                print("Done")
    return


def update_z80_code(outputf, data_target, cmd_id, timera):
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

    # SEAMLESS command support
    outputf.seek(0x014d)
    outputf.write(bytes([0xc3, 0x00, 0x7e]))           # change a call $0a70 to a jp $7e00
    outputf.seek(0x0296)
    outputf.write(bytes([0x3, 0x7e]))                  # change a jp target address from $0150 to $7e03
    outputf.seek(0x0b99)
    outputf.write(bytes([0x15, 0x7e]))                 # change pointer to unused command $83 to new command $83 routine
    outputf.seek(0xbaf)
    outputf.write(bytes([0xb, 0x7e]))                  # change pointer to command $8e to new command $8e routine
    # check for 'seamless' bit and DON'T turn current note off if it's set
    outputf.seek(0x7e00)
    outputf.write(bytes([0xcd, 0x70, 0x0a]))           # call $0a70		; write data to sound chip
    outputf.write(bytes([0xdd, 0xcb, 0x00, 0x46]))     # bit 0,(ix+0)   ; test 'seamless' bit
    outputf.write(bytes([0xc0]))                       # ret nz			; return if it's set
    outputf.write(bytes([0xc3, 0x50, 0x01]))           # jp $0150		; else continue
    # updated command $8e to clear 'seamless' bit as well as 'pitch bend' bit
    outputf.write(bytes([0xdd, 0xcb, 0x00, 0xae]))     # res  5,(ix+$00)		; clear 'pitch bend' bit
    outputf.write(bytes([0xdd, 0xcb, 0x00, 0x86]))     # res  0,(ix+$00)		; clear 'seamless' bit
    outputf.write(bytes([0x1b, 0xc9]))                 # dec de, ret
    # new command $83 for 'seamless' note transition support
    outputf.write(bytes([0xdd, 0xcb, 0x00, 0xc6]))     # set  0,(ix+$00)		; set 'seamless' bit
    outputf.write(bytes([0x1b, 0xc9]))                 # dec de, ret

    # Insert New Routine
    outputf.seek(z80_dst)
    outputf.write(bytes([0xcd, 0x61, 0x05]))           # call $0561		; reset FM chip

    # Only used if we are porting a tune from a different engine with a unique TimerA value
    # For example, Turbo OutRun uses $96, which shifted twice is $258 (600)
    # (64 * (1024 - 600) / 4000 = 6.36ms)
    if timera:
        outputf.write(bytes([0x3e, timera]))           # ld a, $xx      ; Load Timer A value
        outputf.write(bytes([0x0e, 0x10]))             # ld c, $10      ; Load Register value
        outputf.write(bytes([0xcd, 0x75, 0x0a]))       # call $0a75     ; Write timer value to register

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