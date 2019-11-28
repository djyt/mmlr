; this is an example of nested loops
; i wouldn't advise using deeper than 3 nested loops as you risk smashing into the stack used for subroutines
;
;  pasmo --bin loop_test.asm loop_test.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
			INCLUDE		example_header.asm
			

FMtrack0:		LOAD_PATCH	1

loop1:			C3		$30
			E3		$30
			G3		$30

loop2:			D3		$30
			F3		$30
			A3		$30
			
loop3:			E3		$30
			G3		$30
			B3		$30
			LOOP		2, 4, loop3		; do loop3 4 times (innermost loop)
			
			LOOP		1, 3, loop2		; do loop2 3 times (middle loop)
			
			LOOP		0, 2, loop1		; do loop1 twice (outer loop)
			
			F3		$30
			REST		$20
			A3		$30
			REST		$20
			C4		$30
			REST		$20

			LOOP_FOREVER 	loop1
