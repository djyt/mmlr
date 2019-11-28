;
;                                                 ***** SET TABS TO 8 *****
;
;------------------------------------------------------------------------------------------------------------------------------
; Winning Run music track from SHO hacked into the OR audio program at address $8000
; Completed in a couple of weeks during Sept 2019
;
; ***** MAKE SURE YOU USE THE FIXED 10188.71 PCM SAMPLE ROM FROM 3DS OUTRUN OR THIS TRACK WILL SOUND CRAP! *****
;
;  pasmo --bin Winning_Run_on_OR.asm Winning_Run_on_OR.bin
;  paste into OR audio rom at the address that you ORG'ed it at (likely to be $20c8 or $3d5f)
;  play the game and enjoy!
;
;------------------------------------------------------------------------------------------------------------------------------
; The following patches will be required to the OR audio program to implement the 'seamless' note transition functionality 
; from SHO, in order that Winning Run plays correctly through the OR audio program.  The patches below will NOT affect any of
; the 4 existing tunes in OR as they makes use of an unused command in the track data language parsing routines.
;
; SHA-1 of original 10187.88 rom = 01c8a819587a66d2ee4d255656e36fa0904377b0
; SHA-1 of patched  10187.88 rom = 402707a9fd3567c8aed7910e9db0a23ab0b02853
;
; @ 014d - change   cd 70 0a   to   c3 00 7e    (change a call $0a70 to a jp $7e00)
; @ 0296 - change   50 01      to   03 7e       (change a jp target address from $0150 to $7e03)
; @ 0b99 - change   6f 04      to   15 7e       (change pointer to unused command $83 routine to our new command $83 routine)
; @ 0baf - change   71 04      to   0b 7e       (change pointer to command $8e routine to our updated command $8e routine)
;
; Add the following code at $7e00 :-
; 
; check for 'seamless' bit and DON'T turn current note off if it's set
; 7e00: cd 70 0a	call $0a70		; write data to sound chip
; 7e03: dd cb 00 46	bit 0,(ix+0)		; test 'seamless' bit
; 7e07: c0		ret nz			; return if it's set
; 7e08: c3 50 01	jp $0150		; else continue
;
; updated command $8e to clear 'seamless' bit as well as 'pitch bend' bit
; 7e0b: dd cb 00 ae   	res  5,(ix+$00)		; clear 'pitch bend' bit
; 7e0f: dd cb 00 86	res  0,(ix+$00)		; clear 'seamless' bit
; 7e13: 1b		dec  de
; 7e14: c9		ret
;
; new command $83 for 'seamless' note transition support
; 7e15: dd cb 00 c6	set  0,(ix+$00)		; set 'seamless' bit
; 7e19: 1b		dec  de
; 7e1a: c9		ret
;------------------------------------------------------------------------------------------------------------------------------


			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm		
			
			
;			ORG		PassingBreeze			; if you want to stomp all over Passing Breeze (but Winning Run is MUCH bigger than Last Wave)			
; 			ORG		SplashWave			; if you want to stomp all over Splash Wave
;			ORG		MagicalSound			; if you want to stomp all over Magical Sound Shower		
;			ORG		LastWave			; if you want to stomp all over Last Wave (but Winning Run is MUCH bigger than Last Wave)
;			ORG		$8000				; 10187.88 needs large (64Kb) rom strapping if we choose to ORG at $8000	
						
			ORG 		SplashWave			; let's stomp all over Splash Wave with this tune			
			
			
			
; master header consists of 4 pointers						
WinningRun:		defw		WinningRunTrackHeaders		; pointer to 13 FM/PCM track headers
			defw		$6997				; pointer to TL adjustments (all 4 OR tunes point to this address)
			defw		$6997				; pointer to key fractions  (all 4 OR tunes point to this address)
			defw		WinningRunFMPatchData		; pointer to FM patch data (11 patches)
		
		
WinningRunTrackHeaders:	defb		13				; 13 tracks (8 FM / 5 PCM)

			defw		WRunFMtrack0Header
			defw		WRunFMtrack1Header
			defw		WRunFMtrack2Header
			defw		WRunFMtrack3Header		; bass line
			defw		WRunFMtrack4Header
			defw		WRunFMtrack5Header
			defw		WRunFMtrack6Header
			defw		WRunFMtrack7Header
			
			defw		WRunPCMtrack0Header		; kick drum
			defw		WRunPCMtrack1Header		; tom-toms
			defw		WRunPCMtrack2Header		; snare drum
			defw		WRunPCMtrack3Header		; open/closed hi-hats
			defw		WRunPCMtrack4Header		; crash cymbal



			INCLUDE		Winning_Run_on_OR_FM_track_headers.asm
			
			INCLUDE		Winning_Run_on_OR_PCM_track_headers.asm	

			INCLUDE		Winning_Run_on_OR_FM_track_data.asm									

			INCLUDE		Winning_Run_on_OR_PCM_track_data.asm

			INCLUDE		Winning_Run_on_OR_FM_patch_data.asm
			