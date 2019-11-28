# Spacing (4 Spaces per Tab)
SPACE = "    "

# Comment Indent (Left align, 24 spaces). Format: size, command, comment
ASMLINE = SPACE + "{0}" + SPACE + "{1:<24}" + SPACE + "{2}\n"

# Format: size, command, argument, comment
ASMLINE2 = SPACE + "{0}" + SPACE + "{1:<15}" + SPACE + "{2:<5}" + SPACE + "{3}\n"

PROGRAM_NAME = "MML Reassembler"
VERSION = "v0.13"


# Convert value to assembly hex
def asm_hex(value):
    return "$" + hex(value)[2:]


def write_comment_header(s):
    return "; --------------------------------------------------------------------------------------------------\n" +\
           "; " + s + "\n"\
           "; --------------------------------------------------------------------------------------------------\n"
