; this is an example of pitch bending notes and seamless note transition 
; ** IMPORTANT ** seamless note transition is NOT part of the original OR audio program, you need to patch the audio
; engine to support it.  Full details of how to do that are in the readme.
;
;  pasmo --bin pitch_bend_and_seamless_example.asm pitch_bend_and_seamless_example.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
			INCLUDE		example_header.asm
			

FMtrack0:		LOAD_PATCH	1
			
			P_BEND_START			; pitch bend start
			PITCH_BEND	C3, C4, $60	; pitch bend up
			P_BEND_END			; pitch bend end
			
			REST	$40
			
			P_BEND_START			; pitch bend start
			PITCH_BEND	C3, C2, $60	; pitch bend down
			P_BEND_END			; pitch bend end
			
			REST	$40
			
			; police siren - with seamless note transition (for this to be really effective you need to
			; choose a patch which has a slow release rate so that the note naturally sustains to the 
			; point of the transition to the next note)
			; THIS WILL SOUND IDENTICAL TO THE SECOND POLICE SIREN EXAMPLE ON AN UNPATCHED OR AUDIO ENGINE
			P_BEND_START			; pitch bend start
			PITCH_BEND	C3, B3, $50	; pitch bend up
			
			SEAMLESS			; seamless transition (only possible with modified audio program)
							; this HAS to go AFTER first pitch bent note
							; then all subsequent pitch bends will be seamless until P_BEND_END
							
			PITCH_BEND	B3, C3, $50	; pitch bend down
			PITCH_BEND	C3, B3, $50	; pitch bend up
			PITCH_BEND	B3, C3, $50	; pitch bend down
			PITCH_BEND	C3, B3, $50	; pitch bend up
			PITCH_BEND	B3, C3, $50	; pitch bend down
			P_BEND_END			; end pitch bend (and also the effects of SEAMLESS)
			
			REST		$40
			
			; police siren - without seamless note transition
			; you can clearly hear the 'note off' command between individual notes
			P_BEND_START			; pitch bend start
			PITCH_BEND	C3, B3, $50	; pitch bend up
			PITCH_BEND	B3, C3, $50	; pitch bend down
			PITCH_BEND	C3, B3, $50	; pitch bend up
			PITCH_BEND	B3, C3, $50	; pitch bend down
			PITCH_BEND	C3, B3, $50	; pitch bend up
			PITCH_BEND	B3, C3, $50	; pitch bend down
			P_BEND_END			; end pitch bend
			
			REST		$40
			
			C3		$60
			SEAMLESS			; NEED A PATCHED OR AUDIO ENGINE TO FULLY APPRECIATE THIS
			B2		$50
			P_BEND_END
			
			REST		$40
			
			P_BEND_START
			PITCH_BEND	C3, C3, $90
			SEAMLESS			; NEED A PATCHED OR AUDIO ENGINE TO FULLY APPRECIATE THIS
			PITCH_BEND	C3, F2, $90
			P_BEND_END
			
			REST	$40

			LOOP_FOREVER	FMtrack0+2


