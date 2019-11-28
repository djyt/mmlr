# Master Information For Song


class DecompileHelper:
    offset_headers = 0      # List of Channel Addresses
    offset_tl = 0           # TL Adjustments
    offset_kf = 0           # Key Fractions
    offset_patches = 0      # FM Patch Data

    subroutines = dict()    # Track list of decompiled subroutines
    patches = set()         # Track FM patches that are in use
    key_fractions = set()   # Track Key Fractions that are in use
    total_levels = set()    # Track Total Levels that are in use
