---------------------------------------------------------------------------------------------------
                                 MML Reassembler and related tools
                                      reassembler.blogspot.com
                                      
                                      (c) 2019 dj_yt & cmonkey
...................................................................................................


---------------------------------------------------------------------------------------------------
 Overview
---------------------------------------------------------------------------------------------------

This package contains a set of tools to manipulate audio files written in Sega's in-house MML 
(Music Macro Language) format for OutRun. MML is a list of powerful, yet easily readable commands. 
These commands control the audio hardware including FM synthesis and PCM sample based playback. 

A set of separate tools are included in this package:

1/ MML Reassembler (dj_yt)

This decompiles a binary file into Music Macro Language. It works with both data from the original
arcade game and data from the recent 3DS and Switch ports. It outputs an MML file that can be 
edited and compiled using siMMpLified and a Z80 assembler.

If you wanted to edit, optimize or remix the original music, then this is the tool for you. 

2/ siMMpLified (cmonkey)

This is a set of Z80 based macros that facilitate audio creation for OutRun's audio engine. The
package includes a series of example compositions. 
Use siMMpLified with a Z80 assembler to compile to a binary. Additional documentation is provided.

3/ MML Injector (dj_yt)

A simple script to inject or insert new music into OutRun's original Z80 EPROM.

For the sake of completeness, you can think of the flow through these tools as follows, although
clearly this example is an extremity:

EPROM -> MML Reassembler -> ASM file + siMMpLified Libs -> Z80 Assembler -> MML Injector -> EPROM


---------------------------------------------------------------------------------------------------
 Required Software
---------------------------------------------------------------------------------------------------

 + Python 3.8:     https://www.python.org/downloads/
 + Z80 Assembler:  https://osdn.net/projects/freshmeat_pasmo/releases/
 + MAME:           https://www.mamedev.org/


---------------------------------------------------------------------------------------------------
 MML Reassembler Usage
---------------------------------------------------------------------------------------------------

usage: mmlr.py [-h] [-out outputFile.asm] [-org ORG] inputFile.bin offset

positional arguments:
  inputFile.bin        Input file to decompile
  offset               Track header offset in inputFile

optional arguments:
  -h, --help           show this help message and exit
  -out outputFile.asm  Output File Name
  -org ORG             Origin original binary was compiled to. (default = 0)

example offsets:
  0x0e26 Passing Breeze          0x20c8 Splash Wave
  0x3d5f Magical Sound Shower    0x5f2d Last Wave
  

 Example 1: Extracting Passing Breeze from Z80 EPROM
...................................................................................................

Here we pass in the original Z80 binary from OutRun (epr-10187.88). 
We specify the offset of Passing Breeze (0x0e26).

> python mmlr.py -out passing_breeze.asm epr-10187.88 0x0e26


 Example 2: Extracting Magical Sound Shower from Z80 EPROM
...................................................................................................

This is exactly the same as above, but we  change the offset parameter to match the location
of Magical Sound Shower (0x3d5f). 

> python mmlr.py -out magical.asm epr-10187.88 0x3d5f


 Example 3: Extracting 3DS and Switch Music
...................................................................................................

Guides to extracting binary data from 3DS and Switch games can be found online and won't be 
covered in this documentation.

From the 3DS binary, the two new tracks are located at the following addresses:

0x37bd60: Cruising Line
0x382d60: Camino A Mi Amor

From the main Switch binary, the new tracks are located at the following addresses:

0x78030e: Crusing Line
0x78730e: Camino A Mi Amor [3DS Version]
0x78e30e: Step on beat     [Arcade Version]
0x79530e: Radiation
0x79c30e: Camino A Mi Amor [Alternate Version] - Sounds very similar
0x7a330e: Step on beat     [Megadrive Version] - Not accessible through the front end of the game 
          Note, this track is $2907 bytes in length

- Each track should be extracted to a separate binary for the purposes of the tool.
- These tracks are all 0x7000 bytes in length, apart from Step On Beat Megadrive version.  
- All tracks expect a Z80 origin of 0x8000 when in use. 
- All tracks start with a word pointer to the track header at 0x4b9.

Assuming you extract each track from the 3DS or Switch music to a separate binary first:

> python mmlr.py -out camino.asm -org 0x8000 camino.bin 0x4b9


---------------------------------------------------------------------------------------------------
 MML Injector Usage
---------------------------------------------------------------------------------------------------

MML Injector - A quick way to inject music data in OutRun's Z80 EPROM.

usage: inject.py [-h] [-data {1,2,3,4,5}] [-cmd {1,2,3,4,5}] inputFile injectFile outputFile


positional arguments:
  inputFile          Original Z80 program code (probably named epr-10187.88)
  injectFile         Binary music data to inject
  outputFile         Output Z80 program code

optional arguments:
  -h, --help         show this help message and exit
  -data {1,2,3,4,5}  Target data to replace
  -cmd {1,2,3,4,5}   Z80 command to replace

Target Data and Commands are as follows:
1 = Passing Breeze        2 = Splash Wave
3 = Magical Sound Shower  4 = Last Wave
5 = Unused Command / Create New Bank at 0x8000 for destination (default)


 Example 1: Injecting a new tune over Passing Breeze (Easy)
...................................................................................................

> python inject.py -cmd 1 -data 1 epr-10187.88 my_new_tune.bin C:\mame\roms\outrun\epr-10187.88

In this example, we read the Z80 EPROM as an input (epr-10187.88), insert the new tune data 
(my_new_tune.bin), before outputing the final result to the directory containing the OutRun MAME 
roms (C:\mame\roms\outrun\epr-10187.88).

We specify '-cmd 1' to denote that the original Z80 command to play 'Passing Breeze' should be
used to play 'my_new_tune.bin' instead.

We specify '-data 1' to denote the tune data should overwrite the space in rom currently occupied
by 'Passing Breeze'. The tool will warn you if there isn't enough space in the chosen target data.


 Example 2: Injecting a new tune into extra space at the end of the EPROM (Advanced)
...................................................................................................

> python inject.py -cmd 1 -data 5 epr-10187.88 my_new_tune.bin C:\mame\roms\outrun\epr-10187.88

If we don't want to erase existing track data, it's possible to expand the EPROM size from 32K to 
64K,  although only the first 60K is accessible due to the Z80 memory map.

In the above example, the command to trigger Passing Breeze is mapped to the new music for ease of
testing. However, it would be expected that a new command would be used '-cmd 5'. However, this
would need to be activated in the MAME debugger, or by changing the main 68000 program code. 

For MAME to recognize the larger file, drivers/segaorun.cpp should be edited as follows:

ROM_REGION( 0x10000, "soundcpu", 0 ) // sound CPU
ROM_LOAD( "epr-10187.88", 0x00000, 0x8000, 
          CRC(a10abaa9) SHA1(01c8a819587a66d2ee4d255656e36fa0904377b0) )

becomes:

ROM_REGION( 0x10000, "soundcpu", 0 ) // sound CPU
ROM_LOAD( "epr-10187.88", 0x00000, 0x10000, 
          CRC(a10abaa9) SHA1(01c8a819587a66d2ee4d255656e36fa0904377b0) )
          
---------------------------------------------------------------------------------------------------