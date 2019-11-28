; this is an example of TL (total level) adjustments
; this is buggy as hell in the OR audio engine and no OR tunes use it, as such i'd advise against using it too
; Don't use FIXED_TEMPO and note/rest/sample durations > 255 if attempting to use SET_TL as they destroy bits used by it
;
;  pasmo --bin TL_test.asm TL_test.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
			INCLUDE		example_header.asm
			

FMtrack0:		LOAD_PATCH	1

; final param is a bit mask for the 4 ops (bit 0 = C2, bit 1 = M2, bit 2 = C1, bit 3 = M1) 
; (but you can only safely use bits 2 (C1) and 3 (M1) as bits 0 and 1 are used by other functionality of the audio program)
; allows changing of TL for C1 and M1 ops of current patch to a value held in the lookup table data at $6997
; FUNCTIONALITY IS HEAVILY PATCH DEPENDENT
; THIS SOUNDS CRAP

			SET_TL		1, %00001111	; bits 0 (C2), 1 (M2), 2 (C1) and 3 (M1)					
			C3		$b0
			REST		$30
			
			SET_TL		4, %00001010	; bits 1 (M2) and 3 (M1)
			C3		$b0
			REST		$30
			
			SET_TL		3, %00000101	; bits 0 (C2) and 2 (C1)
			C3		$b0
			REST		$30
			
			SET_TL		2, %00000110	; bits 1 (M2) and 2 (C1) 
			C3		$b0
			REST		$30
			
			SET_TL		0, %00001111	; you need to remember to explicitly turn off the effects of SET_TL by
							; passing 0 as first parameter or it wil affect all other patches in this 
							; track going forward
			
			LOOP_FOREVER	FMtrack0	; need to reload patch after playing with TL stuff