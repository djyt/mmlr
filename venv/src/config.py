# -------------------------------------------------------------------------------------------------
# Example Files (filename, compiled origin, offset to header)
#
# 3DS & Switch Files:
#     - The first word of the 3DS file is the offset to the master header. I've encoded this below.
#     - Compiled to origin 0x8000
#
# OutRun Arcade Original Files:
#     - Stored in EPR-10187.88
#     - 0x0e26: Passing Breeze
#     - 0x20c8: Splash Wave
#     - 0x3d5f: Magical Sound Shower
#     - 0x5f2d: Last Wave
# -------------------------------------------------------------------------------------------------

# 3DS Camino Binary
#input_file = "../res/3ds_camino_a_mi_amor.bin"

# 3DS Cruising Line Binary
#input_file = "../res/3ds_cruising_line.bin"

# Switch Radiation
#input_file = "../res/switch_radiation.bin"

# Switch Step On Beat (Arcade)
#input_file = "../res/switch_steponbeat_arcade.bin"

# Switch Step On Beat (Megadrive)
#input_file = "../res/switch_steponbeat_megadrive.bin"
#org        = 0x8000
#offset     = 0x04b9

# Read original OutRun EPROMs
#input_file = "../res/epr-10187.88"
#org        = 0
#offset     = 0x703d         # Tune Radio
#offset     = 0x0e26        # Passing Breeze
#offset     = 0x20c8        # Splash Wave
#offset     = 0x3d5f        # Magical Sound Shower
#offset     = 0x5f2d        # Last Wave
