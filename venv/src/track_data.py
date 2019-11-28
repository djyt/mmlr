import globals


class TrackData:
    CMD_END_FM_TRACK = 0x84         # end playback of this FM track (DO NOT USE ON PCM TRACKS)
    CMD_SET_TL = 0x86               # set the total level of operators (only partially working on OutRun and unused)
    CMD_KEY_FRACTIONS = 0x87        # enable key fractions (slight pitch change)
    CMD_CALL = 0x88                 # call a subroutine
    CMD_RET = 0x89                  # return from a subroutine
    CMD_LOOP_FOREVER = 0x8A
    CMD_LOOP = 0x8C                 # loop n number of times (allows nested loops via second parameter)
    CMD_PITCH_BEND_START = 0x8D     # Pitch Bend Start
    CMD_LOAD_PATCH = 0x91           # load FM patch data
    CMD_LONG = 0x95                 # used for 'long' notes, rests and percussion samples

    def is_end(self, cmd):
        return cmd == self.CMD_END_FM_TRACK or cmd == self.CMD_RET or cmd == self.CMD_LOOP_FOREVER

    # Format: Command String Name [0], Length of Arguments [1]
    @staticmethod
    def get_cmd(cmd):
        convert = {
            # Rest in music
            0x00: ("REST         ", 1),

            # FM Notes
            0x01: ("Cs_1         ", 1),
            0x02: ("D_1          ", 1),
            0x03: ("Ds_1         ", 1),
            0x04: ("E_1          ", 1),
            0x05: ("F_1          ", 1),
            0x06: ("Fs_1         ", 1),
            0x07: ("G_1          ", 1),
            0x08: ("Gs_1         ", 1),
            0x09: ("A_1          ", 1),
            0x0A: ("As_1         ", 1),
            0x0B: ("B_1          ", 1),
            0x0C: ("C0           ", 1),
            0x0D: ("Cs0          ", 1),
            0x0E: ("D0           ", 1),
            0x0F: ("Ds0          ", 1),
            0x10: ("E0           ", 1),
            0x11: ("F0           ", 1),
            0x12: ("Fs0          ", 1),
            0x13: ("G0           ", 1),
            0x14: ("Gs0          ", 1),
            0x15: ("A0           ", 1),
            0x16: ("As0          ", 1),
            0x17: ("B0           ", 1),
            0x18: ("C1           ", 1),
            0x19: ("Cs1          ", 1),
            0x1A: ("D1           ", 1),
            0x1B: ("Ds1          ", 1),
            0x1C: ("E1           ", 1),
            0x1D: ("F1           ", 1),
            0x1E: ("Fs1          ", 1),
            0x1F: ("G1           ", 1),
            0x20: ("Gs1          ", 1),
            0x21: ("A1           ", 1),
            0x22: ("As1          ", 1),
            0x23: ("B1           ", 1),
            0x24: ("C2           ", 1),
            0x25: ("Cs2          ", 1),
            0x26: ("D2           ", 1),
            0x27: ("Ds2          ", 1),
            0x28: ("E2           ", 1),
            0x29: ("F2           ", 1),
            0x2A: ("Fs2          ", 1),
            0x2B: ("G2           ", 1),
            0x2C: ("Gs2          ", 1),
            0x2D: ("A2           ", 1),
            0x2E: ("As2          ", 1),
            0x2F: ("B2           ", 1),
            0x30: ("C3           ", 1),
            0x31: ("Cs3          ", 1),
            0x32: ("D3           ", 1),
            0x33: ("Ds3          ", 1),
            0x34: ("E3           ", 1),
            0x35: ("F3           ", 1),
            0x36: ("Fs3          ", 1),
            0x37: ("G3           ", 1),
            0x38: ("Gs3          ", 1),
            0x39: ("A3           ", 1),
            0x3A: ("As3          ", 1),
            0x3B: ("B3           ", 1),
            0x3C: ("C4           ", 1),
            0x3D: ("Cs4          ", 1),
            0x3E: ("D4           ", 1),
            0x3F: ("Ds4          ", 1),
            0x40: ("E4           ", 1),
            0x41: ("F4           ", 1),
            0x42: ("Fs4          ", 1),
            0x43: ("G4           ", 1),
            0x44: ("Gs4          ", 1),
            0x45: ("A4           ", 1),
            0x46: ("As4          ", 1),
            0x47: ("B4           ", 1),
            0x48: ("C5           ", 1),
            0x49: ("Cs5          ", 1),
            0x4A: ("D5           ", 1),
            0x4B: ("Ds5          ", 1),
            0x4C: ("E5           ", 1),
            0x4D: ("F5           ", 1),
            0x4E: ("Fs5          ", 1),
            0x4F: ("G5           ", 1),
            0x50: ("Gs5          ", 1),
            0x51: ("A5           ", 1),
            0x52: ("As5          ", 1),
            0x53: ("B5           ", 1),
            0x54: ("C6           ", 1),
            0x55: ("Cs6          ", 1),
            0x56: ("D6           ", 1),
            0x57: ("Ds6          ", 1),
            0x58: ("E6           ", 1),
            0x59: ("F6           ", 1),
            0x5A: ("Fs6          ", 1),
            0x5B: ("G6           ", 1),
            0x5C: ("Gs6          ", 1),
            0x5D: ("A6           ", 1),
            0x5E: ("As6          ", 1),
            0x5F: ("B6           ", 1),

            # Command Language Defines
            0x81: ("TEMPO        ", 1),
            0x82: ("SAMPLE_VOL   ", 2),
            0x83: ("SEAMLESS     ", 0),
            0x84: ("END_FM_TRACK ", 0),
            0x85: ("NOISE_ON     ", 0),
            0x86: ("SET_TL       ", 2),
            0x87: ("KEY_FRACTION ", 1),
            0x88: ("CALL_SUB     ", 2),
            0x89: ("RETURN       ", 0),
            0x8a: ("LOOP_FOREVER ", 2),
            0x8b: ("TRANSPOSE    ", 1),
            0x8c: ("LOOP         ", 4),
            0x8d: ("P_BEND_START ", 0),
            0x8e: ("P_BEND_END   ", 0),
            0x91: ("LOAD_PATCH   ", 1),
            0x92: ("NOISE_OFF    ", 0),
            0x93: ("VOICE_PITCH  ", 1),
            0x94: ("FIXED_TEMPO  ", 0),
            0x95: ("LONG_NOTE    ", 3),     # LONG_NOTE always replaced with actual note/rest/percussion name
            0x96: ("RIGHT_CH_ONLY", 0),
            0x97: ("LEFT_CH_ONLY ", 0),
            0x98: ("BOTH_CHANNELS", 0),

            # Drum/Percussion Defines
            0xc0: ("OPEN_HI_HAT  ", 1),
            0xc1: ("CLOSED_HI_HAT", 1),
            0xc2: ("SNARE_DRUM1  ", 1),
            0xc3: ("TOM_TOM_L    ", 1),
            0xc4: ("WOOD_RIM     ", 1),
            0xc5: ("RIM_SHOT     ", 1),
            0xc6: ("KICK_DRUM    ", 1),
            0xc7: ("TOM_TOM_M    ", 1),
            0xc8: ("TOM_TOM_H    ", 1),
            0xc9: ("CRASH_CYMBAL ", 1),
            0xca: ("HAND_CLAP    ", 1),
            0xcb: ("SHAKER       ", 1),
            0xcc: ("SNARE_DRUM2  ", 1),
            0xcd: ("RIDE_CYMBAL  ", 1),
            0xce: ("FINGER_SNAP  ", 1),

            # Voice Sample Defines
            0xdc: ("CHECKPOINT   ", 1),
            0xdd: ("CONGRATS     ", 1),
            0xde: ("GET_READY    ", 1),
        }
# NOTE, PITCH_BEND
        return convert.get(cmd, (globals.asm_hex(cmd), "Invalid Command"))
