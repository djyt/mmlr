; test of sending FM output to left/right/both speakers
; you need make sure you use an FM patch which is designed to output to both channels for best effect
; (bits 6 & 7 both set in RL_FB_CONNECT parameter of the patch data)
;
;  pasmo --bin left_right_channel_test.asm left_right_channel_test.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
			INCLUDE		example_header.asm
	
FMtrack0:		LOAD_PATCH	1
			
			RIGHT_CH_ONLY			; send FM output to right speaker only
			C3		80
			D3		80
			E3		80
			
			LEFT_CH_ONLY			; send FM output to left speaker only
			C3		80
			D3		80
			E3		80
			
			BOTH_CHANNELS			; send FM output to both speakers
			C3		80
			D3		80
			E3		80
			
			LOOP_FOREVER	FMtrack0+2
			