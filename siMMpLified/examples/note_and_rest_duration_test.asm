; test of notes and rests with a duration > 255 beats
; percussion samples (like CRASH_CYMBAL, etc) can also use durations > 255 beats but are not demonstrated here
; 
; You MUST issue a FIXED_TEMPO command on the track BEFORE playing any notes/rest/samples that have a duration > 255 beats
; you can also use durations < 256 on FIXED_TEMPO tracks
;
;  pasmo --bin note_and_rest_duration_test.asm note_and_rest_duration_test.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
			INCLUDE		example_header.asm
	
FMtrack0:		LOAD_PATCH	1
			
			FIXED_TEMPO				; MUST ISSUE A FIXED_TEMPO COMMAND BEFORE DURATIONS > 255
			
			C3		50			; play C3 for 400ms (0.4s)
			C3		512			; play C3 for 4096ms (circa 4 seconds) (512x8=4096ms)
			C3		1000			; play C3 for 8s
			
			REST		50			; rest for 0.4s
			REST		512			; rest for 4096ms
			REST		1000			; rest for 8s
			
			LOOP_FOREVER	FMtrack0+2
