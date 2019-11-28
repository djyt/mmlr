; this is an example of a transposing notes
; REMEMBER - new transpose value is added to existing transpose value (initially set in track header)
;
;  pasmo --bin transpose_example.asm transpose_example.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
			INCLUDE		example_header.asm
			

FMtrack0:		LOAD_PATCH	2
			
			C3		$b0
			TRANSPOSE	2				; transpose next 2 notes up by 2 semi-tones
			C3		$b0				; will actually play a D3
			As2		$b0				; will actually play a C3
			TRANSPOSE	-2				; reset the transpose applied to this track
			C3		$b0				; back to normal now
			
			LOOP_FOREVER	FMtrack0+2
			
