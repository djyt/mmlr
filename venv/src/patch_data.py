import globals


class PatchData:

    # Assembly Label to Assign to Patch
    label = "undefined"

    # Source Offset
    offset = 0

    # Is this patch data referenced by the Macro Music Language?
    used = False

    # Check for terminating byte in sequence
    @staticmethod
    def is_end(cmd):
        return cmd == 2

    # YM 2151 register assignments for loading patch data
    @staticmethod
    def get_cmd(cmd):
        convert = {
            0x20: ("RL_FB_CONNECT",
                   "right/left (bits 6-7) / feedback level (bits 3-5) / operator connections (bits 0-2)"),

            0x38: ("PMS_AMS",
                   "phase modulation sensitivity (bits 4-6) / amplitude modulation sensitivity (bits 0-1)"),

            0x40: ("DT1_MUL_M1", "detune 1 (bits 4-6) / phase multiply (bits 0-3) for M1"),
            0x48: ("DT1_MUL_M2", "detune 1 (bits 4-6) / phase multiply (bits 0-3) for M2"),
            0x50: ("DT1_MUL_C1", "detune 1 (bits 4-6) / phase multiply (bits 0-3) for C1"),
            0x58: ("DT1_MUL_C2", "detune 1 (bits 4-6) / phase multiply (bits 0-3) for C2"),

            0x60: ("TL_M1", "total level for M1 operator"),
            0x68: ("TL_M2", "total level for M2 operator"),
            0x70: ("TL_C1", "total level for C1 operator"),
            0x78: ("TL_C2", "total level for C2 operator"),

            0x80: ("KS_AR_M1", "key scaling (bits 6-7) / attack rate (bits 0-4) for M1"),
            0x88: ("KS_AR_M2", "key scaling (bits 6-7) / attack rate (bits 0-4) for M2"),
            0x90: ("KS_AR_C1", "key scaling (bits 6-7) / attack rate (bits 0-4) for C1"),
            0x98: ("KS_AR_C2", "key scaling (bits 6-7) / attack rate (bits 0-4) for C2"),

            0xA0: ("D1R_M1", "decay 1 rate (bits 0-4)     (AMS-EN is bit 7) for M1"),
            0xA8: ("D1R_M2", "decay 1 rate (bits 0-4)     (AMS-EN is bit 7) for M2"),
            0xB0: ("D1R_C1", "decay 1 rate (bits 0-4)     (AMS-EN is bit 7) for C1"),
            0xB8: ("D1R_C2", "decay 1 rate (bits 0-4)     (AMS-EN is bit 7) for C2"),

            0xC0: ("DT2_D2R_M1", "detune 2 (bits 6-7) / decay 2 rate (bits 0-4) for M1"),
            0xC8: ("DT2_D2R_M2", "detune 2 (bits 6-7) / decay 2 rate (bits 0-4) for M2"),
            0xD0: ("DT2_D2R_C1", "detune 2 (bits 6-7) / decay 2 rate (bits 0-4) for C1"),
            0xD8: ("DT2_D2R_C2", "detune 2 (bits 6-7) / decay 2 rate (bits 0-4) for C2"),

            0xE0: ("D1L_RR_M1", "decay 1 level (bits 4-7) / release rate (bits 0-3) for M1"),
            0xE8: ("D1L_RR_M2", "decay 1 level (bits 4-7) / release rate (bits 0-3) for M2"),
            0xF0: ("D1L_RR_C1", "decay 1 level (bits 4-7) / release rate (bits 0-3) for C1"),
            0xF8: ("D1L_RR_C2", "decay 1 level (bits 4-7) / release rate (bits 0-3) for C2"),
        }
        return convert.get(cmd, (globals.asm_hex(cmd), "Invalid Patch Command"))
