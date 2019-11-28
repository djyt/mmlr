import globals


class TrackHeader:

    # Source Offset
    offset = 0

    # The format of a 14-byte track header is as follows :-

    # 	byte	various track flags (e.g. track enabled/disabled, pitch bend enabled, etc)
    #	byte	track type and index (whether this is an FM or PCM track and its index (0-7 for FM) (0-4 for PCM)
    #	byte	tempo (this is only applicable for variable tempo tracks, more on this later)
    #	word	counter for currently playing note (used during playback of the tune)
    #	word	duration of currently playing note (used during playback of the tune)
    #	word	pointer to current address within the track (usually points to first byte of the corresponding track)
    #	byte	transpose value, in semi-tones (can be -ve or +ve)
    #	byte	offset from start of 32-byte data structure in RAM to "stack" return address (set this to 32 for all tracks)
    #	byte	key fractions value (used during playback of the tune)
    #	byte	current FM patch number in use by this track (used during playback of the tune)
    #	byte	more flags (fixed/variable tempo, long notes, etc) (used during playback of the tune)

    flags1      = 0
    type        = 0
    tempo       = 0
    counter     = 0
    duration    = 0
    ptr         = 0
    transpose   = 0
    stack       = 0
    fraction    = 0
    patch       = 0
    flags2      = 0

    # Subroutine label to use for decompilation
    label = ""

    # True if this track points to exactly the same location as another
    dupe_pointer = False

    def write(self):
        output = \
            self.get_header_label() + "\n" + \
            self.w("defb", self.get_flags1(),      "; flags") + \
            self.w("defb", self.get_type(),        "; track type and index") +\
            self.w("defb", str(self.tempo),        "; tempo") + \
            self.w("defw", str(self.counter),      "; current note counter (used during playback)") + \
            self.w("defw", str(self.duration),     "; current note duration (used during playback)") + \
            self.w("defw", self.get_track_label(), "; pointer to current address within track") + \
            self.w("defb", str(self.transpose),    "; transpose value (in semi-tones)") + \
            self.w("defb", str(self.stack),        "; offset to 'stack' for subroutine usage") + \
            self.w("defb", str(self.fraction),     "; key fractions (used during playback)") + \
            self.w("defb", str(self.patch),        "; current FM patch (used during playback)") + \
            self.w("defb", str(self.flags2),       "; more flags (used during playback)")
        return output

    @staticmethod
    def w(size, name, comment):
        if comment:
            return globals.ASMLINE.format(size, name, comment)
        else:
            return globals.SPACE + size + globals.SPACE + name + "\n"

    def get_header_label(self):
        return self.get_type().lower() + ":"

    # Create text label for track data
    def get_track_label(self):
        return str(self.label.lower()) + "_data"

    def get_flags1(self):

        if self.flags1 & 0x80:
            s = "TRACK_ENABLED"
        else:
            s = "TRACK_DISABLED"

        if self.flags1 & 1:
            s += " | SEAMLESS_BIT"
        if self.flags1 & 2:
            s += " | NOISE_BIT"
        if self.flags1 & 4:
            s += " | TRACK_MUTE_BIT"
        if self.flags1 & 8:
            s += " | UNKNOWN_BIT3"
        if self.flags1 & 0x10:
            s += " | UNKNOWN_BIT4"
        if self.flags1 & 0x20:
            s += " | PITCH_BEND_BIT"
        if self.flags1 & 0x40:
            s += " | UNKNOWN_BIT6"

        return s

    def is_enabled(self):
        return self.flags1 & 0x80

    def get_type(self):
        convert = {
            0x40: "PCM_TRACK_0",
            0x41: "PCM_TRACK_1",
            0x42: "PCM_TRACK_2",
            0x43: "PCM_TRACK_3",
            0x44: "PCM_TRACK_4",
            0x45: "PCM_TRACK_5",
            0x46: "PCM_TRACK_6",
            0x47: "PCM_TRACK_7",
            0x48: "PCM_TRACK_8",
            0x49: "PCM_TRACK_9",
            0x4A: "PCM_TRACK_10",
            0x4B: "PCM_TRACK_11",
            0x4C: "PCM_TRACK_12",
            0x4D: "PCM_TRACK_13",
            0x4E: "PCM_TRACK_14",
            0x4F: "PCM_TRACK_15",

            0x80: "FM_TRACK_0",
            0x81: "FM_TRACK_1",
            0x82: "FM_TRACK_2",
            0x83: "FM_TRACK_3",
            0x84: "FM_TRACK_4",
            0x85: "FM_TRACK_5",
            0x86: "FM_TRACK_6",
            0x87: "FM_TRACK_7",
        }

        return convert.get(self.type, "INVALID TYPE!")
