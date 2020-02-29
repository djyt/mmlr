                                                  -----------                                             
                                                  siMMpLified 
                                                  -----------
                                                    cmonkey
                                                  -----------
                                                 SET TABS TO 8
                                                 -------------
                                                 
            A simplified way of creating new tunes for Sega Out Run hardware (without resorting to MML)



Welcome to siMMpLified, a (hopefully) simpler way of creating new FM+PCM tunes for Sega's Out Run hardware.  This project
was bourne out of a comment that was made on the UKVAC forums about porting the 'Winning Run' tune from Sega's iconic
motorbike racing game Super Hang-On (SHO) into Out Run (OR).  Having had previous experience of putting new music into
SHO I already had a good working knowledge of the tune format and audio engine capabilities in that game.  It didn't 
then take long to learn the (small) differences between the SHO tune format and the OR tune format.  

It took around 2 weeks to port the tune, that includes the time taken to add extra functionality to the OR audio engine,
needed to make the tune sound correct.  I made the decision to release this info in the hope that people may want to put
their own composition(s) into OR but don't have the requisite technical knowledge to do so.  Hopefully this will make
it easier for them.  It won't write the tune for you, you have to do that yourself, all it will do is help you to get
it into the OR game easier than without this info (hopefully!).

Basically the tunes in SHO and OR (and also many other 16-bit Sega arcade titles of the same era like Hang-On, Space
Harrier, Enduro Racer, After Burner, Power Drift, etc) are simply streams of MIDI note values and durations.  According
to various sources on the internet (reassembler's blog being the main one that I refer to) the tunes were originally 
transcribed from sheet music into MML (Music Macro Language).  After the transription it's possible there would then 
have been some kind of tool to convert the MML data into the format used by the audio engine of OR/SHO/etc.

The power and flexibility of the audio engine comes in the form of the extended commands which can be used to perform 
such tasks and applying pitch bend to notes, transposing notes up/down, loading new FM patch data into the sound chip, 
loop sections of the tune, call subroutines in the tune, change tempo, etc.   This document will explain how each 
extended command works.  In conjunction with the many examples in the package this will hopefully get you on your way
to getting your own tune(s) into OR.

Tunes in OR/SHO are comprised of up-to 8 FM tracks, played by the Yamaha YM2151 sound chip and up-to 5 PCM tracks, 
played by the custom Sega 315-5218 PCM sample playback chip.  You don't need to use all 8 FM tracks and all 5 PCM 
tracks in your tunes (e.g. Last Wave uses 8 FM tracks and 0 PCM tracks), it's completely feasible to use just a single
FM or PCM track (as shown by many of the examples in this archive).

In creating this kit I tried to make it user friendly by abstracting as much of the complexity of the OR audio engine
as possible into more meaningful and human-readable macros.  The macros, in conjunction with the unique defines, per
game, are what effectively make up the helper kit.  It would be relatively easy to modify the macros and defines to
support other games (e.g. SHO) as big chunks of them would stay exactly the same.  The SHO audio engine has a couple of
new features which were added during development of that game, one of which has had to be backported to OR to allow 
Winning Run to sound identical when running on the OR audio engine.

This document assumes a basic level of knowledge of the YM2151 sound chip.  It would be advisable to have the YM2151
manual to hand, to refer to, whilst reading this.

So, without further ado, let's get into the nitty gritty of the OR tune format.


Tune format
-----------
Each tune starts with 4 pointers :-

1) pointer to number of tracks and FM/PCM track headers
2) pointer to TL adjustments (all existing tunes use an address of $6997, so should your tune in the beginning)
3) pointer to key fractions lookups (all existing tunes use an address of $6997, so should your tune in the beginning)
4) pointer to YM2151 FM sound patch data bank

There then follows a single byte which dictates how many tracks (FM+PCM) are used by this tune.  Even though it's 
perfectly feasible to set this value to 1, to indicate that your tune only uses a single track, it's better to always
set it to 13 (8 FM + 5 PCM) and then create null track headers in the next section.  Doing it this way ensures that 
the audio engine correctly initialises all 13 track headers in RAM (even if you're planning on leaving 12 of those 
tracks disabled)

Next up are pointers to the track headers themselves.  If you set the number of tracks to 13 in the step above then 
there'll be 13 pointers to track headers in this section.

Finally there are the track headers.  These are 14 byte data structures which are loaded to audio RAM @ $f820
and padded with zeroes to 32-byte boundaries (in the case of OR) or 40-byte boundaries (in the case of SHO).

The format of a 14-byte track header is as follows :-

	byte	various track flags (e.g. track enabled/disabled, pitch bend enabled, etc)
	byte	track type and index (whether this is an FM or PCM track and its index (0-7 for FM) (0-4 for PCM)
	byte	tempo (this is only applicable for variable tempo tracks, more on this later)
	word	counter for currently playing note (used during playback of the tune)
	word	duration of currently playing note (used during playback of the tune)
	word	pointer to current address within the track (usually points to first byte of the corresponding track)
	byte	transpose value, in semi-tones (can be -ve or +ve)
	byte	offset from start of 32-byte data structure in RAM to 'stack' return address (set this to 32 for all tracks)
	byte	key fractions value (used during playback of the tune)
	byte	current FM patch number in use by this track (used during playback of the tune)
	byte	more flags (fixed/variable tempo, long notes, etc) (used during playback of the tune)
		
If you don't want to use a particular track then set the track header pointer to point to a null word.  This effectively
disables the track by setting the first byte of the track data structure in RAM to zero (flag=track disabled).  See
the examples in the archive for an example of this.

After the track headers comes the FM and PCM track data.


So, how does this look using a real OR tune (Passing Breeze) as an example :-

; master tune header
PassingBreeze:			defw	PassingBreezeTrackHeaders	; pointer to number of tracks and track headers
				defw	PassingBreezeTLAdjustments	; pointer to TL adjustment lookups ($6997)
				defw	PassingBreezeKeyFractions	; pointer to key fractions lookups ($6997)
				defw	PassingBreezeFMPatchData	; pointer to FM patch data
		
PassingBreezeTrackHeaders:	defb	13				; number of tracks in this tune	

; track header pointers
				defw	PBfmTrack0header		; pointer to FM track 0 header
				defw	PBfmTrack1header
				defw	PBfmTrack2header
				defw	PBfmTrack3header
				defw	PBfmTrack4header
				defw	PBfmTrack5header
				defw	PBfmTrack6header
				defw	PBfmTrack7header
		
				defw	PBpcmTrack0header		; pointer to PCM track 0 header
				defw	PBpcmTrack1header
				defw	PBpcmTrack2header
				defw	PBpcmTrack3header
				defw	PBpcmTrack4header
		
; 8 x FM track headers
PBfmTrack0header:		defb	TRACK_ENABLED			; flags
				defb	FM_TRACK_0			; track type and index
				defb	5				; tempo
				defw	0				; current note counter (used during playback)
				defw	1				; current note duration (used during playback)
				defw	PBfmTrack0data			; pointer to current address within track
				defb	-3				; transpose value (in semi-tones)
				defb	32				; offset to 'stack' for subroutine usage
				defb	0				; key fractions (used during playback)
				defb	0				; current FM patch (used during playback)
				defb	0				; more flags (used during playback)
		
		
				and so on, for the remaining 7 FM track headers
				.
				.
				.
				.
				.
		
; 5 x PCM track headers
PBpcmTrack0header:		defb	TRACK_ENABLED			; flags
				defb	PCM_TRACK_0			; track type and index
				defb	5				; tempo
				defw	0				; current note counter
				defw	1				; current note duration
				defw	PBpcmTrack0data			; pointer to current address within track
				defb	0				; transpose value (unused for PCM tracks)
				defb	32				; offset to 'stack' for subroutine usage
				defb	0				; key fractions (unused for PCM tracks)
				defb	0				; current FM patch (unused for PCM tracks)
				defb	0				; more flags
				
				
				and so on, for the remaining 4 PCM track headers
				.
				.
				.
				.
				
				

You'll always need to create your own master tune header, track header pointers and track headers, for each new tune 
you create.



Track data
----------

FM tracks
---------
The majority of the FM track data is in the form of note/duration or rest/duration.  The power comes in the extended 
commands, which also form part of the track data.  The notes are MIDI note values (e.g. C4 (middle C) is 60, etc).  
There are a possible 8 octaves to play with, from C-1 to B6.  To simplify things I've created defines for every single
note in the range, so that instead of having to remember the MIDI note value for C3 you can just type C3, and so on.

The note/rest durations are in multiples of 8ms.  This is because the overall tempo of the tune is controlled by
timer A on the sound chip.  This timer is loaded with a value of 524 during initialisation of the audio engine.  The 
calculation used for the timer A period (in ms) is :-

   tA = 64 * (1024 - tAvalue) / input clock (KHz)
 
The YM2151 in OR/SHO has an input clock of 4 MHz (4000 KHz).  So this means the timer A period is calculated as :-
 
   64 * (1024 - 524) / 4000 = 8ms
 
This means there'll be just over two 'ticks' (or 'beats' or 'durations') per frame (frame time is 16.6667ms)
 
So, to play a note for 1 second, you'd pass a value of 125 as the duration (125 * 8ms = 1000ms = 1s).  In reality,
I've found that a duration of 126 gives a tone which lasts for 4 scanlines short of 60 frames, whereas a duration
of 125 gives a tone which lasts for 130 scanlines short of 60 frames.  However this is all subject to how accurate
MAME's beamx/beamy figures are, as that's where I've taken my timings from.
 
The duration paramater for notes/rests/percussion samples takes any value from 0 to 65535 but if any of your tracks use 
notes/rests/percussion samples that are longer than 255 beats in duration then a FIXED_TEMPO command MUST be issued
on that track BEFORE these longer notes/rests/percussion samples are played.  See the note_and_rest_duration_test.asm
example for more info on this.
 
Usually the very first thing you'll do in each FM track is to load new FM patch data into the YM2151.  This is done by
extended command $91 in the audio engine, which I've macro'd to be called LOAD_PATCH.  After you've loaded patch data
into the sound chip you're free to start playing notes/rests.  

Notes can be played in one of two ways:-

	1) NOTE	value, duration		(e.g.	NOTE	C3, 50)
	2) value	duration	(e.g.	C3	50) (this is the preferred way)
 

Rests and handled by the REST macro, which expects a single duration parameter (e.g. REST	50)
 
At the end of your track you have two options, you can either end playback of the track using the END_FM_TRACK macro
or loop back to some point in the track.  The LOOP_FOREVER macro will jump back to an earlier point in the track and
resume playback of the track from there.  This macro expects a single parameter, which is the label whereby the track
should loop back to.
 
So, a real world example of an FM track which simply plays the middle C note for 0.5 seconds and then rests for 0.5
seconds and then loops forever would look something like this :-
 
FMtrack0:			LOAD_PATCH	1			; patch number indexing starts at 1 (NOT zero)
mainLoop:			C4		63			; play note C4 for 0.5 seconds
 				REST		63			; rest for 0.5 seconds
 				LOOP_FOREVER	mainLoop		; overall duration of track is 126 beats
 				
Admittedly this is not exactly the most exciting tune to race down Coconut Beach to but this does represent a completely
valid FM track which the audio engine would happily play forever.


A quick note about FM track 7 - you should avoid using FM track 7 as the 'lead' track of your tune.  This is because the
audio engine will temporarily mute FM track 7 when it needs to repurpose it for such things as the countdown beeps, 
checkpoint beeps and insert coin sounds.  When they've finished playing FM track 7 will be unmuted.  You can simulate
the effects of this by writing a 'tune' which only uses FM track 7 and then repeatedly hitting the 'insert coin' button
in MAME, all you'll hear will be insert coin sound effect and NOT your tune (until you stop hitting the 'insert coin'
button).  You should use FM track 7 as an 'occasional track' with the thoughts that it WILL be temporarily muted at 
various points in the game.



PCM tracks
----------
PCM tracks are handled much the same way as FM tracks but instead of loading FM patch data into the sound chip you set
the sample volume (using the SAMPLE_VOL macro) on the left and right channels and then play any of the 15 different 
samples available.  All 15 samples have been given human-readable names, to make it easier for you.  To play a sample
simply use the sample name followed by a duration (in multiples of 8ms, as with the FM tracks).
You cannot alter the pitch which the PCM drum/percussion samples play at, it's hard-coded in the audio engine.  
This is one of the areas which is more flexible in the SHO audio engine as you CAN play drum/percussion samples at 
12 different pitches in that game.
 
So, a real world example of a PCM track would look something like this :-

PCMtrack0:			SAMPLE_VOL	63,63			; set left/right sample volume (0-63)
mainLoop:			KICK_DRUM	31
				REST		32
				SNARE_DRUM1	31
				REST		32
				LOOP_FOREVER	mainLoop		; overall duration of track is 126 beats
												

You cannot use the END_FM_TRACK macro on a PCM track but the same effect can achieved by simply creating a REST and
then using a LOOP_FOREVER to loop back to the REST command.
		
As this PCM track also has a mainLoop duration of 126 beats (1 second), just like the simple FM track above, you could
play them both together and they'd both loop at the same time and you've got the beginnings of a new OR masterpiece!



Voice samples
-------------
You can also use the 3 voice samples (Checkpoint, Get Ready and Congratulations) in your tunes too, should you want to.
I'm not sure why you'd want to, but they're there for you if you feel they'll add something to your tune.  The voice
samples, unlike the drum/percussion samples, can be played using variable pitch.  The pitch that they're played at in 
the game is $48.  Higher pitch will result in faster sample playback, lower pitch will result in slower sample playback.

It's also worth noting that once the voice play command has been submitted the sample will play through to completion,
(i.e. you can't stop a sample playing once you've started it, not without stopping playback of the entire track anyway).
In that respect the duration parameter isn't dictating how long to play the sample for, instead it's dictating how many
beats will pass until the next command on the track is interpreted.  This allows you to play a drum/percussion sample 
(on the same track) immediately after the command to play the sampled voice and the drum/percussion sample will play 
over the top of the voice sample.

CAVEAT - this is how it behaves in MAME, this is not tested on real hardware.  Dependent on how accurate MAME's emulation 
of the PCM sample chip is will dictate whether or not it behaves this way on hardware.  Also it's worth noting that in 
the real game the voice samples are played as one-shot samples in their own PCM channel, where no other drum/percussions 
samples will be playing at the same time, but here we're playing the voice samples in one of the 5 PCM channels of a tune 
where it's possible to play drums/percussion over the top of the voice samples.  As this is not normal behaviour for the 
audio engine it's hard to say how the sample chip would interpret this on real hardware.  TODO - test on hardware.

The voice samples are stored at a 9KHz rate in the sample ROMs and have durations as follows :-

Checkpoint      - 0.63s		which equates to a duration of 79 beats    (79 * 8ms = 632ms)
Get Ready       - 0.48s		which equates to a duration of 60 beats    (60 * 8ms = 480ms)
Congratulations - 1.09s		which equates to a duration of 137 beats  (137 * 8ms = 1096ms)

e.g.
PCMtrack0:			SAMPLE_VOL	63,63			; set left/right sample volume
				VOICE_PITCH	$48			; set default pitch for the 3 voices	
				GET_READY	60			; play full Get Ready voice
				CONGRATS	63			; play full sample (even though duration is only 504ms)
				CRASH_CYMBAL	40			; crash cymbal will begin 0.5s after Congrats starts
				CHECKPOINT	1			; play full voice (even though duration is only 8ms)
				SNARE_DRUM1	20			; snare drum will begin 8ms after start of Checkpoint
				LOOP_FOREVER	PCMtrack0+5		; loop from GET_READY  60




Extended command set
--------------------
Simply looping notes, samples and rests will certainly give you a tune worth listening to but the power of the audio 
engine is greatly enhanced by use of the extended commands.  These are special instructions to the audio engine to do 
things such as transpose notes, pitch bend notes, alter the track tempo, etc.  All extended commands that are used
by the FM/PCM playback engine have been macro'd, to make them easier to use.  The extended commands that are available
for you, in macro form, are :-

TEMPO		- sets tempo of this track
SAMPLE_VOL	- sets PCM sample left/right channel volume
SEAMLESS	- allows 'seamless' transition between two notes (this command is NOT originally implemented in OR)
END_FM_TRACK	- ends playback of current FM track (CANNOT BE USED ON PCM TRACKS)
NOISE_ON	- enable 'noise' channel (can ONLY be used on FM track 7)
SET_TL		- sets TL (total level) of C1/M1 operators of this FM patch (*BUGGY* - unused by any tune in OR)
KEY_FRACTION	- slightly alters the pitch of the next note played (4 different values from 0-3)
CALL_SUB	- jump to a subroutine in the track
RETURN		- returns from a subroutine in the track
LOOP_FOREVER	- as the name implies
TRANSPOSE	- transposes subsequent notes either up or down
LOOP		- loop a section of the track n number of times (nested loops are handled too)
P_BEND_START	- must be issued prior to pitch bending a note
PITCH_BEND	- pitch bends a note
P_BEND_END	- must be issued after pitch bending a note
LOAD_PATCH	- load new FM patch data into the sound chip
NOISE_OFF	- disable 'noise' channel on FM track 7
VOICE_PITCH	- set pitch for one of the 3 sampled voices
FIXED_TEMPO	- use fixed tempo rather than variable tempo for this track (also allows notes/rests longer than 255 beats)
RIGHT_CH_ONLY	- send FM output to right channel only
LEFT_CH_ONLY	- send FM output to left channel only
BOTH_CHANNELS	- send FM output to both channels



Macros in detail
----------------

TEMPO	value	  

This macro allows you to change the tempo of the track during playback.  It accepts a single parameter
which is used as a multiplicand against the tempo value in the track header, to give a final duration
for the note to be played.  You CANNOT use the TEMPO macro if you have previously used the FIXED_TEMPO
macro on a track.
                  
 example of usage:	TEMPO   3
                  
Using the above example, if you'd already set the tempo for this track to be 1 in the track header 
then all note durations after this command was issued would multipled by 3 (making the notes 3 times 
longer in duration)

                  
     
                
SAMPLE_VOL	leftChannelVolume, righChannelVolume
                  
This macro sets the left/right channel sample volume for PCM samples.  The volume range is from 0 to 63

 example of usage:	SAMPLE_VOL   63,63




SEAMLESS (no parameters)

*** THIS COMMAND IS NOT PART OF THE STANDARD OUT RUN EXTENDED COMMAND SET.  IT HAS BEEN BACKPORTED FROM SHO ***
This macro allows the seamless transition from one note to another.  It does so by supressing the sending of the
'key off' command to the sound chip when the note duration ends.  This allows you to perform the musical equivalent
of ties (holding a note across two bars) and slurs (play notes without separation) in your tracks.  This command 
features heavily in Winning Run and hence had to be backported to the OR audio engine to make it sound accurate, 
when compared to the same tune running in SHO.  It makes use of an unused extended command ($83) to implement it.  
If you are wanting to create tunes that run on an unmodified OR audio engine then you will not be able to use this 
command.  You cancel the effect of SEAMLESS by issuing a P_BEND_END command (P_BEND_END is used to cancel the effects
of both pitch bending and seamless transitions)

 example of usage:	NOTE	C3, $c6
 			SEAMLESS			; tie (hold same note across two bars)
 			NOTE	C3, $b0
 			P_BEND_END			; cancel effects of SEAMLESS
 				
 			NOTE	As3, $16
 			SEAMLESS			; slur (play notes of different pitch without separation)
 			NOTE	Gs3, $16
 			P_BEND_END			; cancel effects of SEAMLESS




END_FM_TRACK (no parameters)

This macro will end processing of the current FM track and turn off all notes on the track.  Once a track has been ended
in this way you cannot restart processing of events on this track again.  CANNOT BE USED ON PCM TRACKS.




NOISE_ON (no parameters)

This enables the noise slot on the C2 carrier on channel 8 (of 8).  The command only has an effect when used on FM track 7.
The noise frequency comes from the low order 5-bits of the MIDI note value that is played when noise is enabled.  For more
information on the noise frequency and period see section 2.1.5 (p.11) of the YM2151 synthesis PDF.




SET_TL	index, opMask

This is a broken (a.k.a. buggy) command which only partially works in OR.  It's obvious that the audio program developers
gave up on this command as it is not used in any of the 4 tunes in the game.  It's broken in the sense that the second 
parameter is a bit mask of operators (bit 0 = C2, bit 1 = M2, bit 2 = C1, bit 3 = M1) but you can only safely use two of
the four operators (M1 and C1) as bits 0 and 1 (M2 and C2) are destroyed by other extended commands.  This means that this
command is crippled in its functionality as it can only operate on 2 of the 4 operators of a patch.  It's supposed to be 
able to dynamically adjust the TL (total level) of all 4 operators but due to the bug it only safely works on the TL for
the M1 and C1 operators.  You can only successfully use the full power of this command IF your track is NOT using the 
FIXED_TEMPO and LONG_NOTE commands.  I believe this command was an attempt to simulate the same effects as velocity
sensitivity on a synthesizer but the very fact that it's not used in any tune leads me to believe that the developers
never really believed that it worked as it should.  My advice would be to NOT use this command in your tune.




KEY_FRACTION	value

This command uses value as the index into a lookup table to slightly alter the pitch of subsequent notes.  Value can be
any value between 0 and 5 (although values of 1 and 5 lead to the same data being read and hence give exactly the same
effect).  A value of 0 turns off the effects of key fractions.  For further infomation on key fractions see section
2.1.2 (p.7) of the YM2151 synthesis PDF.  In reality the effects of this command are quite minor and you need to have
well trained ears to be able to hear any difference in the pitch of the notes played under this effect.

 example of usage:	KEY_FRACTION	2
 
 


CALL_SUB	label

This command allows you to break your track up in to repeatable phrases and then treat them as though they were subroutines
in a procedural programming language.  Once you jump into a subroutine execution of the track will continue from the first
command in the subroutine and will return to caller when a RETURN instruction is encountered.  It's a very powerful 
concept which can greatly reduce overall tune size, when used effectively.  Nested subroutines are possible as the audio 
engine uses spare bytes at the end of each 32-byte track data structure as a 'stack' and 'pushes' the return address onto
the stack for each subroutine call.  I've successfully tested nested subroutines up to a depth of 3.  However you need to 
exercise caution if your track is also using nested loops as it's possible for the bytes used by the nested loops to
interfere with the 'stack' bytes used by the nested subroutines.  A general rules of thumb would be to stick to a maximum
of two deep with your subroutines.  Subroutines have global scope, in that you can call a subroutine in any track from 
any another track, so take this into consideration when naming your subroutines so that you don't inadvertently call the
wrong subroutine.

 example of usage:	CALL_SUB	mySubroutine
 



RETURN (no paramters)

This command returns from a subroutine.




LOOP_FOREVER	label

Pretty self explanatory.  This command can be used at the end of a track to loop back to a point in the track and resume
playback from that point.  You don't necessarily have to loop back to the first note/rest in your track, you can
loop back to any point in the track and loop from that point.

 example of usage:	LOOP_FOREVER	mainLoop




TRANSPOSE	value

This commands allows you to transpose subsequent notes up or down by 'value' semi-tones.  The value is added to the currently
effective transpose value (which is set initially in the track header).  This means that if the transpose value in the track
header is zero and you issue a TRANSPOSE 2 command then you'll need to issue a TRANSPOSE -2 command to get back to your
original tranpose value of 0, when you've finished playing the transposed notes.  This command is ideal for creating
Westlife-sounding tunes, as the final verse of their songs ALWAYS shifts up a key ;-)

 example of usage:	TRANSPOSE	2




LOOP	loopNumber, loopCount, loopAddress

This command allows you to loop sections of your track, up to 255 times.  Nested loops are permitted.  The loopNumber
parameter is used by the audio engine to keep track of which loop is which.  I've successfully tested loops 3 deep.  As 
mentioned in the CALL_SUB instructions, you need to be aware if you're using deeply nested loops as well as nested
subroutines as both commands use spare bytes at the end of each 32-byte data structure and it's possible for the two to
'collide', with unexpected (and likely undesirable!) effects.  A general rule of thumb would be stick to a maximum of 3 
deep nested loops, in conjunction with 2 deep nested subroutines.

 example of usage:	loop1:	C3	20
 				D3	20
 				E3	20
 				LOOP	0, 4, loop1	; play the 3 notes 4 times
 			
 				
 example of nested loops:
 			outer:	C3	20
 				D3	20
 				E3	20
 				
 			inner:	C4	20
 				D4	20
 				E4	20
 				
 				LOOP	1, 2, inner	; play the 3 notes in the inner loop (loopNumber 1) twice
 				
 				LOOP	0, 3, outer	; play outer loop notes 3 times (which will play the inner loop
 							; notes twice for each iteration of the outer loop)
 				LOOP_FOREVER	outer
 				
 The nested loop example will play the notes as follows :-
  C3, D3, E3, C4, D4, E4, C4, D4, E4, C3, D3, E3, C4, D4, E4, C4, D4, E4, C3, D3, E3, C4, D4, E4, C4, D4, E4, loop forever




P_BEND_START (no parameters)

This command MUST be issued before you pitch bend a note.  It prepares the audio engine for receiving a pitch bend note as
the next note it reads from the track data.




PITCH_BEND	pitchStart, pitchEnd, duration

This command allow you to apply pitch bend to a note.  Duration is, as always, in ms.

 example of usage:	PITCH_BEND	C3, A3, 83	; pitch bend from C3 to A3 in 664ms (2/3 of a second)
 



P_BEND_END (no parameters)

This command ends the effects of both P_BEND_START and SEAMLESS (and so could quite easily have been named SEAMLESS_END).
You MUST issue this command when you finish using pitch bend notes and/or seamless transitions.




LOAD_PATCH	patchNumber

This command loads new FM patch data into the sound chip.  The patchNumber is a number from 1 to however many patches you
have defined for your tune.  Patches are discussed in more detail later in this document.

 example of usage:	LOAD_PATCH	4




NOISE_OFF (no parameters)

This command cancels the effects of the NOISE_ON command.




VOICE_PITCH	pitch

Sets the pitch for the sampled voices (Checkpoint/Get Ready/Congratulations).  The default pitch, as used by the game,
is $48.  Higher pitch = faster sample playback, lower pitch = slower sample playback.

 example of usage:	VOICE_PITCH	$48




FIXED_TEMPO (no parameters)

This command forces the audio engine to use the note/rest duration dictated by each NOTE/REST command, untouched.  Issuing
this command on a track will prevent you from using the TEMPO command to dynamically change the tempo of the track.  When
using variable tempo tracks the note/rest duration is multiplied by the tempo value in the track header.  When using fixed
tempo tracks the tempo value in the track header is ignored and the note/rest duration is used, as is, from the track data.
If any of your tracks are going to use notes/rests/percussion samples that are longer than 255 beats in duration then you 
MUST issue a FIXED_TEMPO command BEFORE you use them.




RIGHT_CH_ONLY (no parameters)

This command sends FM output to just the right channel/speaker.




LEFT_CH_ONLY (no parameters)

This command sends FM output to just the left channel/speaker.




BOTH_CHANNELS (no parameters)

This command sends FM output to both channels/speakers.





FM patches
----------
If your song utilises at least 1 FM track then you'll need to define at least one FM patch or else you won't hear anything
when you play notes.  Tunes in OR have a pointer in the master tune header which points to the FM patch data bank.  Multiple 
tunes can happily point to the same bank of patch data.  In OR the tunes Splash Wave, Magical Sound Shower and Last Wave 
all have their FM patch data pointer pointing to the same bank of 14 FM patches.  Passing Breeze has it's own bank of 7 FM
patches.  You have a choice when creating you own tunes as to whether you want to use the patches used by the 4 tunes already
in OR or create your own patches (or use a mixture of both, more on that later).  

When starting out on creating new tunes for OR it would be much quicker to simply piggyback on the back of the FM patches
that already exist for the 4 tunes in the game.  To do so simply point your FM patch data pointer to one of the two
pre-defined patch bank addresses given in the OR_defines.asm file.

When you're ready to start creating your own FM patches, to give your tunes a more personal touch, you have a few options
available to you, to help with FM patch creation :-

1) VOPM/VOPMex - a VSTi plugin that emulates a YM2151 sound chip and is used with your favourite DAW (I use this)
2) DefleMask   - a truly incredible YM2151+Sega PCM tracker which has a built-in FM patch editor (I use this)
3) a DX21, DX27 or DX100 synthesizer - these use a YM2164, which is functionally identical to the YM2151, as far as patches go
4) a Yamaha FB-01 synth module in conjunction with a SysEx librarian and many freely available patches online (I use this)


None of the above will export FM patch data in the format that is understood by the OR audio engine, so some legwork will
be needed to convert their output into OR compatible patch data.  Probably the easiest format to convert would be the .opm
files.  These are the text based patch files that are read/written by VOPM/VOPMex.  It shouldn't take more than a few lines
of python to read the patch data in a .opm file and convert it to OR compatible patch data.  The .dmp files that are read
and written by DefleMask are binary files, so might need a little more work (although not much) to convert.

If you're planning on using VOPM/VOPMex then be aware that, by default, the input clock of the emulated YM2151 is 3.58MHz,
so patches created by it won't sound the same as when the same patch data is loaded into the 4MHz YM2151 of OR.  You can 
change the clock speed of the emulated YM2151 to 4MHz by sending a couple of MIDI CC's to the plugin, by doing so the 
patches will sound identical in VOPM/VOPMex and when played in OR.  Details of how to do this are in the VOPM manual.

The FM patch data is stored as 26 pairs of register/value data followed by a terminating byte.  This means that each patch
takes up 53 bytes in ROM.  This is in contrast to SHO where only the value is stored, with the register coming from 
a lookup table (as the registers will ALWAYS be the same, it makes sense to only store them once).  Hence patches in 
SHO only use 25 bytes in ROM (the value for AMS/PMS is always hard-coded to zero).

To create your own patches you need to assign a pointer to each patch and then populate the 53 bytes of patch data, per
patch, as follows :-


myFMpatches:			defw	FMpatch1
				defw	FMpatch2
				.
				.
				.
				.
				
FMpatch1:			defb	TL_M1,		$1e			; total level for M1 operator
				defb	TL_C1,		$10			; total level for C1 operator
				defb	TL_M2,		$20			; total level for M2 operator
				defb	TL_C2,		$12			; total level for C2 operator
			
				defb	KS_AR_M1,	$14			; key scaling / attack rate for M1
				defb	KS_AR_C1,	$12			; KS/AR for C1
				defb	KS_AR_M2,	$14			; KS/AR for M2
				defb	KS_AR_C2,	$12			; KS/AR for C2
			
				defb	DT1_MUL_M1,	$32			; detune 1 / phase multiplier for M1
				defb	DT1_MUL_C1,	$33			; DT1/MUL for C1
				defb	DT1_MUL_M2,	$63			; DT1/MUL for M2
				defb	DT1_MUL_C2,	$01			; DT1/MUL for C2
			
				defb	D1R_M1,		4			; decay 1 rate for M1
				defb	D1R_C1,		10			; D1R for C1
				defb	D1R_M2,		4			; D1R for M2
				defb	D1R_C2,		10			; D1R for C2
			
				defb	DT2_D2R_M1,	2			; detune 2 / decay 2 rate for M1
				defb	DT2_D2R_C1,	8			; DT2/D2R for C1
				defb	DT2_D2R_M2,	4			; DT2/D2R for M2
				defb	DT2_D2R_C2,	8			; DT2/D2R for C2
			
				defb	D1L_RR_M1,	$12			; decay 1 level / release rate for M1
				defb	D1L_RR_C1,	$17			; D1L/RR for C1
				defb	D1L_RR_M2,	$12			; D1L/RR for M2
				defb	D1L_RR_C2,	$16			; D1L/RR for C2
			
				defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
				defb	RL_FB_CONNECT,	$fc			; right/left, feedback level, operator connections
		
				defb	2					; terminating byte (VERY IMPORTANT)


FMpatch2:			defb	TL_M1,		$1f
				.
				.
				.
				.
				.
				.

				defb	2					; terminating byte



IMPORTANT NOTE
--------------
The ordering of the first 25 register pairings shown above is irrelevant but you MUST ensure that the RL/FB/CONNECT pair is the 
26th and final pairing of the patch data set, this is because the LEFT_CH_ONLY/RIGHT_CH_ONLY/BOTH_CHANNELS commands expect the 
RL/FB/CONNECT value to be located exactly 51 bytes from the start of the patch data set. 

You MUST also remember to terminate each patch data set with a terminating value of 2.


If the patch loader reads 3 as the register value it treats the next 2 bytes it reads as a pointer and reads the patch data
from the address of that pointer.  This allows you use patch data that already exists, elsewhere in the ROM.  For example, 
your tune could define its own patches for slots 1 and 2 and then point at patch 6 of Passing Breeze's patch bank for slot 
3 by simply using a value of 3 as the first byte of patch 3 data and then using a pointer to patch 6 of Passing Breeze's 
patch bank (you'd need to know at least the base address of Passing Breeze's patch bank to do this).

e.g.				

FMpatch3:			defb	3					; read patch data from next pointer
				defw	PassingBreezePatchBank+(5*53)		; use Passing Breeze's patch 6 data
				
This flexibility allows you to mix and match between your own patches and the pre-existing patches of the 4 tunes in OR.
If you piggyback on the back of existing patches in this way you don't need to use a terminating 2 byte after the pointer
to the patch data as the terminating byte will instead be found at the end of the data that you're pointing to.


Then simply point the pointer in your master tune header to myFMpatches and your tune will use your newly created patch
data.





Putting it all together
-----------------------
So, to summarise what's needed to get your own music into OR :-

1) include the OR_defines.asm and OR_macros.asm at the start of your source
2) decide which address you want to ORG the resulting binary to (i.e. which tune you're going to stomp over in OR)
3) create a master tune header containing 4 pointers
4) decide how many FM and PCM tracks your tune will use
5) create 13 track header pointers (point to a null word for unused tracks)
6) create 13 track headers (use null word for unused tracks)
7) create your track data (don't forget to either END_FM_TRACK or LOOP_FOREVER at the end of each track)
8) create your own FM patches or piggyback on the back of existing tune patches (or mix and match)
9) assemble the whole lot with pasmo 0.6.0 (other macro assemblers will probably work but this is only tested with pasmo)
10) assuming no errors copy/paste the resulting binary into the OR rom at the address you ORG'ed it at
11) test the tune in OR (either in regular game play or service mode (can't use service mode for Last Wave overwrites)



 
 
A few words on the porting of Winning Run to OR
-----------------------------------------------
The first thing to do when considering the feasibility of porting Winning Run to OR was to get the overall size of the tune
and compare it to the sizes of the 4 tunes that currently exist in OR.  I wanted to be able to fit Winning Run into the 
standard 32Kb audio ROM used by OR so that people didn't have to resort to attacking their precious OR board sets with a 
soldering iron, to change the ROM strapping to 64Kb for the audio program.  If Winning Run was larger than each of the 
4 tunes in OR then it would have taken a considerable restructuring operation to squeeze it into the 32Kb ROM, not something
I'd have been prepared to do.  Thankfully the headers + track data for Winning Run are only 4922 bytes in length.  Add to 
that the fact that Winning Run uses 11 FM patches (at 53 bytes per patch + 11 pointers) which swells the size by another 
605 bytes, bringing the total tune size to 5527 bytes.

The size of the 4 OR tunes is as follows :-

  Splash Wave          - 8089 bytes
  Magical Sound Shower - 9424 bytes
  Passing Breeze       - 4770 bytes
  Last Wave            - 2666 bytes
  
So, armed with that knowledge, we now know it's possible to stomp over either Magical Sound Shower or Splash Wave with 
Winning Run and still stay within the 32Kb ROM limit.

Admittedly, I felt that it was *VERY* unlikely anybody would ever sacrifice either of those tunes for Winning Run, but, 
undeterred by that fact, I pressed on.

The next thing to do was to map the drum/percussion PCM samples between SHO and OR.  Thankfully, after analysis in Audacity,
I determined that the 9 PCM samples that exist in the SHO sample ROMs also exist in the OR sample ROMs.  It didn't take
long to map them.  Once that was done I knew there'd be few obstacles left to port the tune to OR.

The next hurdle to overcome was the lack of 'seamless transition' support in the OR audio engine.  This was noticed very
early in the porting process as it's a feature that's used near the beginning of FM track 0.  The only solution was to 
backport support for seamless note transitions into OR.  If you play Winning Run on an unmodified OR audio engine and 
compare it to the same tune running in SHO you'll soon understand why it was so important to implement this feature in OR.

The only other hurdle which was encountered after that, and one which can't (easily) be overcome is the fact that one
of the subroutines in the snare drum PCM track plays a snare drum at two different pitches.  This is not possible in OR
as the pitch of the PCM samples is hard-coded.  I investigated a couple of different ways of solving this but in the end
decided on not doing anything as the pitch change is only 1 semi-tone and you have to have very good ears to hear the 
difference, especially when 12 other tracks are playing at the same time.  The offending snare drum is commented in the 
source of the PCM track data, so you'll be able to compare OR vs SHO, to see if you can hear the offender.

Even after playing more than 50 games of OR with Winning Run it still sounds somewhat strange to hear a tune that is
so synonymous with SHO.  I almost feel like I need to open the Ferrari door and get my knee down when going around left
handers!  I'm not 100% convinced that the tune fits into the OR universe.  Coupled to that is the fact that SHO tunes in
general are a lot shorter in duration than OR tunes (Winning Run is 2 mins 57 secs in duration) due to the fact that a
game of SHO, on beginner skill level, can be completed in 3 minutes vs a game of OR which takes roughly 5 mins.  This 
means that, if you complete OR in around 5 mins 19 secs, whilst listening to Winning Run, you'll hear the tune exactly 
twice (due to the tune continuing to play throughout the end game sequence and course map screens).

All-in-all it was a fun exercise and one which has ultimately resulted in the creation of this helper kit, to hopefully
help people put their own musical compositions into the best driving game ever made.





A few words on patching the OR audio program to support seamless note transition
--------------------------------------------------------------------------------
In order to backport seamless note transition from SHO I make use of an unused command ($83) in the extended command set of
OR.  Doing it this way ensures there's no effect to the existing tunes in the game.

The changes done are as follows :-

$014d - change   cd 70 0a   to   c3 00 7e    (change a call $0a70 to a jp $7e00)
$0296 - change   50 01      to   03 7e       (change a jp target address from $0150 to $7e03)
$0b99 - change   6f 04      to   15 7e       (change pointer to unused command $83 to our new command $83)
$0baf - change   71 04      to   0b 7e       (change pointer to command $8e to our updated command $8e)

New code is added in the unused bytes at the end of the ROM, as follows :-

Add the following code at $7e00 :-
 
; check for 'seamless' bit and DON'T turn current note off if it's set
7e00: cd 70 0a		call $0a70		; write data to sound chip
7e03: dd cb 00 46	bit 0,(ix+0)		; test 'seamless' bit
7e07: c0		ret nz			; return if it's set
7e08: c3 50 01		jp $0150		; else continue

; updated command $8e to clear 'seamless' bit as well as 'pitch bend' bit
7e0b: dd cb 00 ae   	res  5,(ix+$00)		; clear 'pitch bend' bit
7e0f: dd cb 00 86	res  0,(ix+$00)		; clear 'seamless' bit
7e13: 1b		dec  de
7e14: c9		ret

; new command $83 for 'seamless' note transition support
7e15: dd cb 00 c6	set  0,(ix+$00)		; set 'seamless' bit
7e19: 1b		dec  de
7e1a: c9		ret





An unexpected surprise
----------------------
As you're probably aware the PCM sample playing chip is a 16 channel device.  Ordinarily OR tunes allocate 5 PCM channels
for drums/percussion which leaves 11 for other things like Ferrari engine noise, other traffic noise, tyre screeching,
crash sounds, etc.  Just for fun I thought I'd try creating a 'tune' which uses all 16 channels for drums/percussion,
with the idea of playing it in service mode, where I knew there'd be no other PCM channels being used for any other 
purpose.  Imagine my surprise when it worked perfectly and my ears were assaulted with 16 random drum/percussion 
samples all happening at the same time!  I wouldn't recommend creating tunes using more than 5 PCM channels for 
regular gameplay as the extra channels will be repurposed by the audio engine as and when it needs them, but it's fun 
to use the full power of the custom chip for demo purposes and effectively turns OR into a 8FM+16PCM channel sequencer!





Wny not simply write a DefleMask (.dmf) to OR tune format converter?
--------------------------------------------------------------------
That's a very good question!  This is an approach I considered at first as DefleMask is an amazing tracker which fully
supports YM2151+Sega PCM tune creation.  The main problem with tunes created by DefleMask is that they only support a
single loop command per track so you lose most of the flexibility of the powerful looping commands offered by the OR
extended command set and this will ultimately lead to converted tunes being much larger than they need to be.  It may
be possible to simulate OR looping by clever use of the pattern matrix and that's something I may revisit at some point
in the future.  The .dmf output from DefleMask is zlib compressed and the file format is freely available, so if anyone
feels like having a go at creating a converter then go for it.





Thanks
------
dj_yt/reassembler - for his excellent blog and tireless work on fully reversing OR many years ago.  His blog postings and
superlative knowledge of OR have been invaluable to me more times than I'd care to mention
MAMEdev - for the best emulator/debugger combo ever created
paulcan69 - for giving me the idea of creating this in the first place
Sega - for making great games for many generations



