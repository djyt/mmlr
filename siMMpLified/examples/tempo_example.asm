; this is an example of a variable tempo track
;
;  pasmo --bin tempo_example.asm tempo_example.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
			INCLUDE		example_header.asm
			

FMtrack0:		LOAD_PATCH	2

			TEMPO		5			; slowest
			CALL_SUB	mySub

			TEMPO		4
			CALL_SUB	mySub

			TEMPO		3			; medium
			CALL_SUB	mySub

			TEMPO		2
			CALL_SUB	mySub

			TEMPO		1			; fastest
			CALL_SUB	mySub
			
			LOOP_FOREVER	FMtrack0+2
		

mySub:			C3		10
			Cs3		10
			D3		10
			Ds3		10
			E3		10
			F3		10
			Fs3		10
			G3		10
			Gs3		10
			A3		10
			As3		10
			B3		10
			
			RETURN
