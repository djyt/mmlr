; test of key fractions (breaks each note up into 100 parts so that you can fractionally alter the pitch of the note)
; personally i can't hear any difference between the 4 notes, maybe other people can??
;
;  pasmo --bin key_fractions_test.asm key_fractions_test.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
			INCLUDE		example_header.asm
			

FMtrack0:		LOAD_PATCH	1

			C3		$b0            
			KEY_FRACTION	1				; key fraction level 1
			C3		$b0     
			KEY_FRACTION	2				; key fraction level 2
			C3		$b0                
			KEY_FRACTION	3				; key fraction level 3
			C3		$b0      
			KEY_FRACTION	0				; key fraction off
			
			REST		$b0

			LOOP_FOREVER	FMtrack0+2
