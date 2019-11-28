
;                                             ***** SET TABS TO 8 *****

; A few macros to siMMpLify things (pun intended)

; macro for loading a patch to the YM2151
LOAD_PATCH		MACRO	patchNumber
			defb	CMD_LOAD_PATCH, patchNumber
			ENDM

; macro for calling a subroutine
CALL_SUB		MACRO	subAddress
			defb	CMD_CALL
			defw	subAddress
			ENDM

; macro for returning from a subroutine
RETURN			MACRO
			defb	CMD_RET
			ENDM
			
; macro for pitch bend start
P_BEND_START		MACRO
			defb	CMD_PITCH_BEND_START
			ENDM
						
; macro for pitch bending (probably should wrap P_BEND_START and P_BEND_END around this, to simplify)
PITCH_BEND		MACRO	pitchStart, pitchEnd, duration
			defb	pitchStart, pitchEnd, duration
			ENDM
			
; macro for pitch bend end (this is also used to cancel the effects of SEAMLESS so could also be called SEAMLESS_END)
P_BEND_END		MACRO
			defb	CMD_PITCH_BEND_END
			ENDM
			
; macro for seamless note transition (no 'key off' command sent to sound chip between two distinct notes)
SEAMLESS		MACRO
			defb	CMD_SEAMLESS
			ENDM
	
; macro for turning noise bit on ***** IMPORTANT ***** noise effect can ONLY be used on track 7 (1st track is track 0)
NOISE_ON		MACRO
			defb	CMD_NOISE_ON
			ENDM
			
; macro for turning noise bit off
NOISE_OFF		MACRO
			defb	CMD_NOISE_OFF
			ENDM

; macro for ending playback of an FM track (DO NOT USE ON PCM TRACKS!!)
END_FM_TRACK		MACRO
			defb	CMD_END_FM_TRACK
			ENDM
							
; macro for looping n number of times (loopNumber allows for loops within loops)
LOOP			MACRO	loopNumber, loopCount, loopAddress
			defb	CMD_LOOP, loopNumber, loopCount
			defw	loopAddress
			ENDM
			
; macro for looping forever
LOOP_FOREVER		MACRO	loopForeverAddress
			defb	CMD_LOOP_FOREVER
			defw	loopForeverAddress
			ENDM

; *** OPTIONAL *** macro to handle arbitrary length (<65536) notes (if duration > 255 then can only be used on FIXED_TEMPO tracks)
NOTE			MACRO	pitch, duration
			IF	duration < 256
			defb	pitch, duration
			ELSE
			defb	CMD_LONG, pitch
			defw	duration
			ENDM

; macro to handle arbitrary length (<65536) rests (if duration > 255 then can only be used on FIXED_TEMPO tracks)		
REST			MACRO	duration
			IF	duration < 256
			defb	0, duration
			ELSE
			defb	CMD_LONG, 0
			defw	duration
			ENDM

; macro to change tempo of a track (higher value = slower tempo) (must NOT have issued a FIXED_TEMPO on this track for this to be effective)
TEMPO			MACRO	newTempo
			defb	CMD_TEMPO, newTempo
			ENDM

; macro to fix the tempo of the track by ensuring note durations are read, as is, from the track data (tempo changes are NOT permitted in this case via the TEMPO command)
FIXED_TEMPO		MACRO
			defb	CMD_FIXED_TEMPO
			ENDM

; macro to change the transpose value applied to current FM track (in semi-tones) (new value is added to currently effective transpose value)
TRANSPOSE		MACRO	newTransposeValue
			defb	CMD_TRANSPOSE, newTransposeValue
			ENDM

; macro to set pitch of a PCM voice sample like 'Checkpoint' or 'Get Ready'
VOICE_PITCH		MACRO	pitch
			defb	CMD_VOICE_PITCH, pitch
			ENDM
						
; macro to enable key fractions (slight pitch change) (value can be from 0-3 (0 turns off key fractions) (doesn't appear to have much affect at all on the pitch of the sound)
KEY_FRACTION		MACRO	value
			defb	CMD_KEY_FRACTIONS, value
			ENDM
			
; macro to set the TL (total level) of operators C1/M1 of the currently active sound patch (lookupIndex is a value from 0-4, opMask is bit 2 for C1 and bit 3 for M1) (has to be used BEFORE any FIXED_TEMPO command is issued) (best not to use it, TBH)		
SET_TL			MACRO	lookupIndex, opMask
			defb	CMD_SET_TL, lookupIndex, opMask
			ENDM
						
; macro for setting PCM sample volume
SAMPLE_VOL		MACRO	leftChannelVolume, rightChannelVolume
			defb	CMD_SAMPLE_LEVEL, leftChannelVolume, rightChannelVolume
			ENDM
			
; macro to enable right channel and disable left channel, for currently loaded patch
RIGHT_CH_ONLY		MACRO	
			defb	CMD_RIGHT_CH_ONLY
			ENDM
	
; macro to enable left channel and disable right channel, for currently loaded patch	
LEFT_CH_ONLY		MACRO
			defb	CMD_LEFT_CH_ONLY
			ENDM
			
; macro to enable both left and right channels for currently loaded patch
BOTH_CHANNELS		MACRO
			defb	CMD_BOTH_CH
			ENDM





; macros for all the MIDI notes (including all enharmonic equivalents) (8 octaves)
; duration is 0-65535

C_1			MACRO	duration				; C-1
			IF	duration < 256
			defb	C_1, duration
			ELSE
			defb	CMD_LONG, C_1
			defw	duration
			ENDM 	

Cs_1			MACRO	duration				; C sharp -1
			IF	duration < 256
			defb	Cs_1, duration
			ELSE
			defb	CMD_LONG, Cs_1
			defw	duration
			ENDM 

Db_1			MACRO	duration				; D flat -1
			IF	duration < 256
			defb	Db_1, duration
			ELSE
			defb	CMD_LONG, Db_1
			defw	duration
			ENDM

D_1			MACRO	duration				; D-1
			IF	duration < 256
			defb	D_1, duration
			ELSE
			defb	CMD_LONG, D_1
			defw	duration
			ENDM 

Ds_1			MACRO	duration
			IF	duration < 256
			defb	Ds_1, duration
			ELSE
			defb	CMD_LONG, Ds_1
			defw	duration
			ENDM 

Eb_1			MACRO	duration
			IF	duration < 256
			defb	Eb_1, duration
			ELSE
			defb	CMD_LONG, Eb_1
			defw	duration
			ENDM 

E_1			MACRO	duration
			IF	duration < 256
			defb	E_1, duration
			ELSE
			defb	CMD_LONG, E_1
			defw	duration
			ENDM 			

F_1			MACRO	duration
			IF	duration < 256
			defb	F_1, duration
			ELSE
			defb	CMD_LONG, F_1
			defw	duration
			ENDM 

Fs_1			MACRO	duration
			IF	duration < 256
			defb	Fs_1, duration
			ELSE
			defb	CMD_LONG, Fs_1
			defw	duration
			ENDM 

Gb_1			MACRO	duration
			IF	duration < 256
			defb	Gb_1, duration
			ELSE
			defb	CMD_LONG, Gb_1
			defw	duration
			ENDM

G_1			MACRO	duration
			IF	duration < 256
			defb	G_1, duration
			ELSE
			defb	CMD_LONG, G_1
			defw	duration
			ENDM

Gs_1			MACRO	duration
			IF	duration < 256
			defb	Gs_1, duration
			ELSE
			defb	CMD_LONG, Gs_1
			defw	duration
			ENDM

Ab_1			MACRO	duration
			IF	duration < 256
			defb	Ab_1, duration
			ELSE
			defb	CMD_LONG, Ab_1
			defw	duration
			ENDM

A_1			MACRO	duration
			IF	duration < 256
			defb	A_1, duration
			ELSE
			defb	CMD_LONG, A_1
			defw	duration
			ENDM

As_1			MACRO	duration
			IF	duration < 256
			defb	As_1, duration
			ELSE
			defb	CMD_LONG, As_1
			defw	duration
			ENDM

Bb_1			MACRO	duration
			IF	duration < 256
			defb	Bb_1, duration
			ELSE
			defb	CMD_LONG, Bb_1
			defw	duration
			ENDM 

B_1			MACRO	duration
			IF	duration < 256
			defb	B_1, duration
			ELSE
			defb	CMD_LONG, B_1
			defw	duration
			ENDM 

C0			MACRO	duration
			IF	duration < 256
			defb	C0, duration
			ELSE
			defb	CMD_LONG, C0
			defw	duration
			ENDM 	

Cs0			MACRO	duration
			IF	duration < 256
			defb	Cs0, duration
			ELSE
			defb	CMD_LONG, Cs0
			defw	duration
			ENDM 

Db0			MACRO	duration
			IF	duration < 256
			defb	Db0, duration
			ELSE
			defb	CMD_LONG, Db0
			defw	duration
			ENDM

D0			MACRO	duration
			IF	duration < 256
			defb	D0, duration
			ELSE
			defb	CMD_LONG, D0
			defw	duration
			ENDM 

Ds0			MACRO	duration
			IF	duration < 256
			defb	Ds0, duration
			ELSE
			defb	CMD_LONG, Ds0
			defw	duration
			ENDM 

Eb0			MACRO	duration
			IF	duration < 256
			defb	Eb0, duration
			ELSE
			defb	CMD_LONG, Eb0
			defw	duration
			ENDM 

E0			MACRO	duration
			IF	duration < 256
			defb	E0, duration
			ELSE
			defb	CMD_LONG, E0
			defw	duration
			ENDM 			

F0			MACRO	duration
			IF	duration < 256
			defb	F0, duration
			ELSE
			defb	CMD_LONG, F0
			defw	duration
			ENDM 

Fs0			MACRO	duration
			IF	duration < 256
			defb	Fs0, duration
			ELSE
			defb	CMD_LONG, Fs0
			defw	duration
			ENDM 

Gb0			MACRO	duration
			IF	duration < 256
			defb	Gb0, duration
			ELSE
			defb	CMD_LONG, Gb0
			defw	duration
			ENDM

G0			MACRO	duration
			IF	duration < 256
			defb	G0, duration
			ELSE
			defb	CMD_LONG, G0
			defw	duration
			ENDM

Gs0			MACRO	duration
			IF	duration < 256
			defb	Gs0, duration
			ELSE
			defb	CMD_LONG, Gs0
			defw	duration
			ENDM

Ab0			MACRO	duration
			IF	duration < 256
			defb	Ab0, duration
			ELSE
			defb	CMD_LONG, Ab0
			defw	duration
			ENDM

A0			MACRO	duration
			IF	duration < 256
			defb	A0, duration
			ELSE
			defb	CMD_LONG, A0
			defw	duration
			ENDM

As0			MACRO	duration
			IF	duration < 256
			defb	As0, duration
			ELSE
			defb	CMD_LONG, As0
			defw	duration
			ENDM

Bb0			MACRO	duration
			IF	duration < 256
			defb	Bb0, duration
			ELSE
			defb	CMD_LONG, Bb0
			defw	duration
			ENDM 

B0			MACRO	duration
			IF	duration < 256
			defb	B0, duration
			ELSE
			defb	CMD_LONG, B0
			defw	duration
			ENDM 

C1			MACRO	duration
			IF	duration < 256
			defb	C1, duration
			ELSE
			defb	CMD_LONG, C1
			defw	duration
			ENDM 	

Cs1			MACRO	duration
			IF	duration < 256
			defb	Cs1, duration
			ELSE
			defb	CMD_LONG, Cs1
			defw	duration
			ENDM 

Db1			MACRO	duration
			IF	duration < 256
			defb	Db1, duration
			ELSE
			defb	CMD_LONG, Db1
			defw	duration
			ENDM

D1			MACRO	duration
			IF	duration < 256
			defb	D1, duration
			ELSE
			defb	CMD_LONG, D1
			defw	duration
			ENDM 

Ds1			MACRO	duration
			IF	duration < 256
			defb	Ds1, duration
			ELSE
			defb	CMD_LONG, Ds1
			defw	duration
			ENDM 

Eb1			MACRO	duration
			IF	duration < 256
			defb	Eb1, duration
			ELSE
			defb	CMD_LONG, Eb1
			defw	duration
			ENDM 

E1			MACRO	duration
			IF	duration < 256
			defb	E1, duration
			ELSE
			defb	CMD_LONG, E1
			defw	duration
			ENDM 			

F1			MACRO	duration
			IF	duration < 256
			defb	F1, duration
			ELSE
			defb	CMD_LONG, F1
			defw	duration
			ENDM 

Fs1			MACRO	duration
			IF	duration < 256
			defb	Fs1, duration
			ELSE
			defb	CMD_LONG, Fs1
			defw	duration
			ENDM 

Gb1			MACRO	duration
			IF	duration < 256
			defb	Gb1, duration
			ELSE
			defb	CMD_LONG, Gb1
			defw	duration
			ENDM

G1			MACRO	duration
			IF	duration < 256
			defb	G1, duration
			ELSE
			defb	CMD_LONG, G1
			defw	duration
			ENDM

Gs1			MACRO	duration
			IF	duration < 256
			defb	Gs1, duration
			ELSE
			defb	CMD_LONG, Gs1
			defw	duration
			ENDM

Ab1			MACRO	duration
			IF	duration < 256
			defb	Ab1, duration
			ELSE
			defb	CMD_LONG, Ab1
			defw	duration
			ENDM

A1			MACRO	duration
			IF	duration < 256
			defb	A1, duration
			ELSE
			defb	CMD_LONG, A1
			defw	duration
			ENDM

As1			MACRO	duration
			IF	duration < 256
			defb	As1, duration
			ELSE
			defb	CMD_LONG, As1
			defw	duration
			ENDM

Bb1			MACRO	duration
			IF	duration < 256
			defb	Bb1, duration
			ELSE
			defb	CMD_LONG, Bb1
			defw	duration
			ENDM 

B1			MACRO	duration
			IF	duration < 256
			defb	B1, duration
			ELSE
			defb	CMD_LONG, B1
			defw	duration
			ENDM 

C2			MACRO	duration
			IF	duration < 256
			defb	C2, duration
			ELSE
			defb	CMD_LONG, C2
			defw	duration
			ENDM 	

Cs2			MACRO	duration
			IF	duration < 256
			defb	Cs2, duration
			ELSE
			defb	CMD_LONG, Cs2
			defw	duration
			ENDM 

Db2			MACRO	duration
			IF	duration < 256
			defb	Db2, duration
			ELSE
			defb	CMD_LONG, Db2
			defw	duration
			ENDM

D2			MACRO	duration
			IF	duration < 256
			defb	D2, duration
			ELSE
			defb	CMD_LONG, D2
			defw	duration
			ENDM 

Ds2			MACRO	duration
			IF	duration < 256
			defb	Ds2, duration
			ELSE
			defb	CMD_LONG, Ds2
			defw	duration
			ENDM 

Eb2			MACRO	duration
			IF	duration < 256
			defb	Eb2, duration
			ELSE
			defb	CMD_LONG, Eb2
			defw	duration
			ENDM 

E2			MACRO	duration
			IF	duration < 256
			defb	E2, duration
			ELSE
			defb	CMD_LONG, E2
			defw	duration
			ENDM 			

F2			MACRO	duration
			IF	duration < 256
			defb	F2, duration
			ELSE
			defb	CMD_LONG, F2
			defw	duration
			ENDM 

Fs2			MACRO	duration
			IF	duration < 256
			defb	Fs2, duration
			ELSE
			defb	CMD_LONG, Fs2
			defw	duration
			ENDM 

Gb2			MACRO	duration
			IF	duration < 256
			defb	Gb2, duration
			ELSE
			defb	CMD_LONG, Gb2
			defw	duration
			ENDM

G2			MACRO	duration
			IF	duration < 256
			defb	G2, duration
			ELSE
			defb	CMD_LONG, G2
			defw	duration
			ENDM

Gs2			MACRO	duration
			IF	duration < 256
			defb	Gs2, duration
			ELSE
			defb	CMD_LONG, Gs2
			defw	duration
			ENDM

Ab2			MACRO	duration
			IF	duration < 256
			defb	Ab2, duration
			ELSE
			defb	CMD_LONG, Ab2
			defw	duration
			ENDM

A2			MACRO	duration
			IF	duration < 256
			defb	A2, duration
			ELSE
			defb	CMD_LONG, A2
			defw	duration
			ENDM

As2			MACRO	duration
			IF	duration < 256
			defb	As2, duration
			ELSE
			defb	CMD_LONG, As2
			defw	duration
			ENDM

Bb2			MACRO	duration
			IF	duration < 256
			defb	Bb2, duration
			ELSE
			defb	CMD_LONG, Bb2
			defw	duration
			ENDM 

B2			MACRO	duration
			IF	duration < 256
			defb	B2, duration
			ELSE
			defb	CMD_LONG, B2
			defw	duration
			ENDM 

C3			MACRO	duration
			IF	duration < 256
			defb	C3, duration
			ELSE
			defb	CMD_LONG, C3
			defw	duration
			ENDM 	

Cs3			MACRO	duration
			IF	duration < 256
			defb	Cs3, duration
			ELSE
			defb	CMD_LONG, Cs3
			defw	duration
			ENDM 

Db3			MACRO	duration
			IF	duration < 256
			defb	Db3, duration
			ELSE
			defb	CMD_LONG, Db3
			defw	duration
			ENDM

D3			MACRO	duration
			IF	duration < 256
			defb	D3, duration
			ELSE
			defb	CMD_LONG, D3
			defw	duration
			ENDM 

Ds3			MACRO	duration
			IF	duration < 256
			defb	Ds3, duration
			ELSE
			defb	CMD_LONG, Ds3
			defw	duration
			ENDM 

Eb3			MACRO	duration
			IF	duration < 256
			defb	Eb3, duration
			ELSE
			defb	CMD_LONG, Eb3
			defw	duration
			ENDM 

E3			MACRO	duration
			IF	duration < 256
			defb	E3, duration
			ELSE
			defb	CMD_LONG, E3
			defw	duration
			ENDM 			

F3			MACRO	duration
			IF	duration < 256
			defb	F3, duration
			ELSE
			defb	CMD_LONG, F3
			defw	duration
			ENDM 

Fs3			MACRO	duration
			IF	duration < 256
			defb	Fs3, duration
			ELSE
			defb	CMD_LONG, Fs3
			defw	duration
			ENDM 

Gb3			MACRO	duration
			IF	duration < 256
			defb	Gb3, duration
			ELSE
			defb	CMD_LONG, Gb3
			defw	duration
			ENDM

G3			MACRO	duration
			IF	duration < 256
			defb	G3, duration
			ELSE
			defb	CMD_LONG, G3
			defw	duration
			ENDM

Gs3			MACRO	duration
			IF	duration < 256
			defb	Gs3, duration
			ELSE
			defb	CMD_LONG, Gs3
			defw	duration
			ENDM

Ab3			MACRO	duration
			IF	duration < 256
			defb	Ab3, duration
			ELSE
			defb	CMD_LONG, Ab3
			defw	duration
			ENDM

A3			MACRO	duration
			IF	duration < 256
			defb	A3, duration
			ELSE
			defb	CMD_LONG, A3
			defw	duration
			ENDM

As3			MACRO	duration
			IF	duration < 256
			defb	As3, duration
			ELSE
			defb	CMD_LONG, As3
			defw	duration
			ENDM

Bb3			MACRO	duration
			IF	duration < 256
			defb	Bb3, duration
			ELSE
			defb	CMD_LONG, Bb3
			defw	duration
			ENDM

B3			MACRO	duration
			IF	duration < 256
			defb	B3, duration
			ELSE
			defb	CMD_LONG, B3
			defw	duration
			ENDM

C4			MACRO	duration
			IF	duration < 256
			defb	C4, duration
			ELSE
			defb	CMD_LONG, C4
			defw	duration
			ENDM 	

Cs4			MACRO	duration
			IF	duration < 256
			defb	Cs4, duration
			ELSE
			defb	CMD_LONG, Cs4
			defw	duration
			ENDM 

Db4			MACRO	duration
			IF	duration < 256
			defb	Db4, duration
			ELSE
			defb	CMD_LONG, Db4
			defw	duration
			ENDM

D4			MACRO	duration
			IF	duration < 256
			defb	D4, duration
			ELSE
			defb	CMD_LONG, D4
			defw	duration
			ENDM 

Ds4			MACRO	duration
			IF	duration < 256
			defb	Ds4, duration
			ELSE
			defb	CMD_LONG, Ds4
			defw	duration
			ENDM 

Eb4			MACRO	duration
			IF	duration < 256
			defb	Eb4, duration
			ELSE
			defb	CMD_LONG, Eb4
			defw	duration
			ENDM 

E4			MACRO	duration
			IF	duration < 256
			defb	E4, duration
			ELSE
			defb	CMD_LONG, E4
			defw	duration
			ENDM 			

F4			MACRO	duration
			IF	duration < 256
			defb	F4, duration
			ELSE
			defb	CMD_LONG, F4
			defw	duration
			ENDM 

Fs4			MACRO	duration
			IF	duration < 256
			defb	Fs4, duration
			ELSE
			defb	CMD_LONG, Fs4
			defw	duration
			ENDM 

Gb4			MACRO	duration
			IF	duration < 256
			defb	Gb4, duration
			ELSE
			defb	CMD_LONG, Gb4
			defw	duration
			ENDM

G4			MACRO	duration
			IF	duration < 256
			defb	G4, duration
			ELSE
			defb	CMD_LONG, G4
			defw	duration
			ENDM

Gs4			MACRO	duration
			IF	duration < 256
			defb	Gs4, duration
			ELSE
			defb	CMD_LONG, Gs4
			defw	duration
			ENDM

Ab4			MACRO	duration
			IF	duration < 256
			defb	Ab4, duration
			ELSE
			defb	CMD_LONG, Ab4
			defw	duration
			ENDM

A4			MACRO	duration
			IF	duration < 256
			defb	A4, duration
			ELSE
			defb	CMD_LONG, A4
			defw	duration
			ENDM

As4			MACRO	duration
			IF	duration < 256
			defb	As4, duration
			ELSE
			defb	CMD_LONG, As4
			defw	duration
			ENDM

Bb4			MACRO	duration
			IF	duration < 256
			defb	Bb4, duration
			ELSE
			defb	CMD_LONG, Bb4
			defw	duration
			ENDM

B4			MACRO	duration
			IF	duration < 256
			defb	B4, duration
			ELSE
			defb	CMD_LONG, B4
			defw	duration
			ENDM

C5			MACRO	duration
			IF	duration < 256
			defb	C5, duration
			ELSE
			defb	CMD_LONG, C5
			defw	duration
			ENDM 	

Cs5			MACRO	duration
			IF	duration < 256
			defb	Cs5, duration
			ELSE
			defb	CMD_LONG, Cs5
			defw	duration
			ENDM 

Db5			MACRO	duration
			IF	duration < 256
			defb	Db5, duration
			ELSE
			defb	CMD_LONG, Db5
			defw	duration
			ENDM

D5			MACRO	duration
			IF	duration < 256
			defb	D5, duration
			ELSE
			defb	CMD_LONG, D5
			defw	duration
			ENDM 

Ds5			MACRO	duration
			IF	duration < 256
			defb	Ds5, duration
			ELSE
			defb	CMD_LONG, Ds5
			defw	duration
			ENDM 

Eb5			MACRO	duration
			IF	duration < 256
			defb	Eb5, duration
			ELSE
			defb	CMD_LONG, Eb5
			defw	duration
			ENDM 

E5			MACRO	duration
			IF	duration < 256
			defb	E5, duration
			ELSE
			defb	CMD_LONG, E5
			defw	duration
			ENDM 			

F5			MACRO	duration
			IF	duration < 256
			defb	F5, duration
			ELSE
			defb	CMD_LONG, F5
			defw	duration
			ENDM 

Fs5			MACRO	duration
			IF	duration < 256
			defb	Fs5, duration
			ELSE
			defb	CMD_LONG, Fs5
			defw	duration
			ENDM 

Gb5			MACRO	duration
			IF	duration < 256
			defb	Gb5, duration
			ELSE
			defb	CMD_LONG, Gb5
			defw	duration
			ENDM

G5			MACRO	duration
			IF	duration < 256
			defb	G5, duration
			ELSE
			defb	CMD_LONG, G5
			defw	duration
			ENDM

Gs5			MACRO	duration
			IF	duration < 256
			defb	Gs5, duration
			ELSE
			defb	CMD_LONG, Gs5
			defw	duration
			ENDM

Ab5			MACRO	duration
			IF	duration < 256
			defb	Ab5, duration
			ELSE
			defb	CMD_LONG, Ab5
			defw	duration
			ENDM

A5			MACRO	duration
			IF	duration < 256
			defb	A5, duration
			ELSE
			defb	CMD_LONG, A5
			defw	duration
			ENDM

As5			MACRO	duration
			IF	duration < 256
			defb	As5, duration
			ELSE
			defb	CMD_LONG, As5
			defw	duration
			ENDM

Bb5			MACRO	duration
			IF	duration < 256
			defb	Bb5, duration
			ELSE
			defb	CMD_LONG, Bb5
			defw	duration
			ENDM

B5			MACRO	duration
			IF	duration < 256
			defb	B5, duration
			ELSE
			defb	CMD_LONG, B5
			defw	duration
			ENDM

C6			MACRO	duration
			IF	duration < 256
			defb	C6, duration
			ELSE
			defb	CMD_LONG, C6
			defw	duration
			ENDM 	

Cs6			MACRO	duration
			IF	duration < 256
			defb	Cs6, duration
			ELSE
			defb	CMD_LONG, Cs6
			defw	duration
			ENDM 

Db6			MACRO	duration
			IF	duration < 256
			defb	Db6, duration
			ELSE
			defb	CMD_LONG, Db6
			defw	duration
			ENDM

D6			MACRO	duration
			IF	duration < 256
			defb	D6, duration
			ELSE
			defb	CMD_LONG, D6
			defw	duration
			ENDM 

Ds6			MACRO	duration
			IF	duration < 256
			defb	Ds6, duration
			ELSE
			defb	CMD_LONG, Ds6
			defw	duration
			ENDM 

Eb6			MACRO	duration
			IF	duration < 256
			defb	Eb6, duration
			ELSE
			defb	CMD_LONG, Eb6
			defw	duration
			ENDM 

E6			MACRO	duration
			IF	duration < 256
			defb	E6, duration
			ELSE
			defb	CMD_LONG, E6
			defw	duration
			ENDM 			

F6			MACRO	duration
			IF	duration < 256
			defb	F6, duration
			ELSE
			defb	CMD_LONG, F6
			defw	duration
			ENDM 

Fs6			MACRO	duration
			IF	duration < 256
			defb	Fs6, duration
			ELSE
			defb	CMD_LONG, Fs6
			defw	duration
			ENDM 

Gb6			MACRO	duration
			IF	duration < 256
			defb	Gb6, duration
			ELSE
			defb	CMD_LONG, Gb6
			defw	duration
			ENDM

G6			MACRO	duration
			IF	duration < 256
			defb	G6, duration
			ELSE
			defb	CMD_LONG, G6
			defw	duration
			ENDM

Gs6			MACRO	duration
			IF	duration < 256
			defb	Gs6, duration
			ELSE
			defb	CMD_LONG, Gs6
			defw	duration
			ENDM

Ab6			MACRO	duration
			IF	duration < 256
			defb	Ab6, duration
			ELSE
			defb	CMD_LONG, Ab6
			defw	duration
			ENDM

A6			MACRO	duration
			IF	duration < 256
			defb	A6, duration
			ELSE
			defb	CMD_LONG, A6
			defw	duration
			ENDM

As6			MACRO	duration
			IF	duration < 256
			defb	As6, duration
			ELSE
			defb	CMD_LONG, As6
			defw	duration
			ENDM

Bb6			MACRO	duration
			IF	duration < 256
			defb	Bb6, duration
			ELSE
			defb	CMD_LONG, Bb6
			defw	duration
			ENDM

B6			MACRO	duration
			IF	duration < 256
			defb	B6, duration
			ELSE
			defb	CMD_LONG, B6
			defw	duration
			ENDM





; macros for the 15 drum/percussion samples available to us			
; duration is 0-65535
			
CRASH_CYMBAL		MACRO	duration
			IF	duration < 256
			defb	CRASH_CYMBAL_SAMPLE, duration
			ELSE
			defb	CMD_LONG, CRASH_CYMBAL_SAMPLE
			defw	duration
			ENDM
		
RIDE_CYMBAL		MACRO	duration
			IF	duration < 256
			defb	RIDE_CYMBAL_SAMPLE, duration
			ELSE
			defb	CMD_LONG, RIDE_CYMBAL_SAMPLE
			defw	duration
			ENDM
			
OPEN_HI_HAT		MACRO	duration
			IF	duration < 256
			defb	OPEN_HI_HAT_SAMPLE, duration
			ELSE
			defb	CMD_LONG, OPEN_HI_HAT_SAMPLE
			defw	duration
			ENDM
			
CLOSED_HI_HAT		MACRO	duration
			IF	duration < 256
			defb	CLOSED_HI_HAT_SAMPLE, duration
			ELSE
			defb	CMD_LONG, CLOSED_HI_HAT_SAMPLE
			defw	duration
			ENDM
			
SNARE_DRUM1		MACRO	duration
			IF	duration < 256
			defb	SNARE_DRUM1_SAMPLE, duration
			ELSE
			defb	CMD_LONG, SNARE_DRUM1_SAMPLE
			defw	duration
			ENDM

SNARE_DRUM2		MACRO	duration
			IF	duration < 256
			defb	SNARE_DRUM2_SAMPLE, duration
			ELSE
			defb	CMD_LONG, SNARE_DRUM2_SAMPLE
			defw	duration
			ENDM
								
TOM_TOM_L		MACRO	duration
			IF	duration < 256
			defb	TOM_TOM_LO_SAMPLE, duration
			ELSE
			defb	CMD_LONG, TOM_TOM_LO_SAMPLE
			defw	duration
			ENDM
			
TOM_TOM_M		MACRO	duration
			IF	duration < 256
			defb	TOM_TOM_MID_SAMPLE, duration
			ELSE
			defb	CMD_LONG, TOM_TOM_MID_SAMPLE
			defw	duration
			ENDM
		
TOM_TOM_H		MACRO	duration
			IF	duration < 256
			defb	TOM_TOM_HI_SAMPLE, duration
			ELSE
			defb	CMD_LONG, TOM_TOM_HI_SAMPLE
			defw	duration
			ENDM
					
KICK_DRUM		MACRO	duration
			IF	duration < 256
			defb	KICK_DRUM_SAMPLE, duration
			ELSE
			defb	CMD_LONG, KICK_DRUM_SAMPLE
			defw	duration
			ENDM
		
HAND_CLAP		MACRO	duration
			IF	duration < 256
			defb	HAND_CLAP_SAMPLE, duration
			ELSE
			defb	CMD_LONG, HAND_CLAP_SAMPLE
			defw	duration
			ENDM

FINGER_SNAP		MACRO	duration
			IF	duration < 256
			defb	FINGER_SNAP_SAMPLE, duration
			ELSE
			defb	CMD_LONG, FINGER_SNAP_SAMPLE
			defw	duration
			ENDM
			
RIM_SHOT		MACRO	duration
			IF	duration < 256
			defb	RIM_SHOT_SAMPLE, duration
			ELSE
			defb	CMD_LONG, RIM_SHOT_SAMPLE
			defw	duration
			ENDM
			
WOOD_RIM		MACRO	duration
			IF	duration < 256
			defb	WOOD_RIM_SAMPLE, duration
			ELSE
			defb	CMD_LONG, WOOD_RIM_SAMPLE
			defw	duration
			ENDM

SHAKER			MACRO	duration
			IF	duration < 256
			defb	SHAKER_SAMPLE, duration
			ELSE
			defb	CMD_LONG, SHAKER_SAMPLE
			defw	duration
			ENDM





; macros for the 3 voice samples used in OR
; duration is 0-255

CHECKPOINT		MACRO	duration
			defb	CHECKPOINT_VOICE, duration
			ENDM
			
CONGRATS		MACRO	duration
			defb	CONGRATS_VOICE, duration
			ENDM
	
GET_READY		MACRO	duration
			defb	GET_READY_VOICE, duration
			ENDM
