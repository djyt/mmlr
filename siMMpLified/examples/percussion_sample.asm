; Example of all 15 drum/percussion samples available to you
;
;  pasmo --bin percussion_sample.asm percussion_sample.bin
;  paste into OR sound rom at $20c8
;  play MUSIC 3 from service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave		; let's stomp all over Splash Wave @ $20c8
		
			
; master tune header
testTune:		defw		trackHeaderPointers
			defw		$6997
			defw		$6997
			defw		FMPatches		; no FM patches needed for this 'tune'
			
trackHeaderPointers:	defb		13			; 13 tracks	

			defw		unusedTrack		; no FM tracks in this 'tune'	
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			
			defw		PCMtrack0		; just 1 PCM track in this 'tune'
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack


unusedTrack:		defw		0			; all unused tracks point here		

FMPatches:		defw		0			; no FM patches needed for this 'tune'
		
PCMtrack0:		defb		TRACK_ENABLED
			defb		PCM_TRACK_0
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack0		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0


pcmTrack0:		SAMPLE_VOL	63, 63			; give us max. volume on both channels

			SNARE_DRUM1	$2c
			REST		$20
			SNARE_DRUM1	$2c
			REST		$20
			
			SNARE_DRUM2	$2c
			REST		$20
			SNARE_DRUM2	$2c
			REST		$20
			
			FINGER_SNAP	$2c		
			REST		$20
			FINGER_SNAP	$2c
			REST		$20
			
			HAND_CLAP	$30
			REST		$20
			HAND_CLAP	$30
			REST		$20
			
			CRASH_CYMBAL	$b0
			REST		$20
			CRASH_CYMBAL	$b0
			REST		$20
			
			RIDE_CYMBAL	$b0
			REST		$20
			RIDE_CYMBAL	$b0
			REST		$20
			
			OPEN_HI_HAT	$2c
			REST		$20
			OPEN_HI_HAT	$2c
			REST		$20
			
			CLOSED_HI_HAT	$2c
			REST		$20
			CLOSED_HI_HAT	$2c
			REST		$20

			TOM_TOM_L	$16
			REST		$20
			TOM_TOM_L	$16
			REST		$20
			
			TOM_TOM_M	$16
			REST		$20
			TOM_TOM_M	$16
			REST		$20
			
			TOM_TOM_H	$16
			REST		$20
			TOM_TOM_H	$16
			REST		$20
			
			KICK_DRUM	$2c
			REST		$20
			KICK_DRUM	$2c
			REST		$20
			
			RIM_SHOT	$20
			REST		$20
			RIM_SHOT	$20
			REST		$20
			
			WOOD_RIM	$20
			REST		$20
			WOOD_RIM	$20
			REST		$20
			
			SHAKER		$30
			REST		$20
			SHAKER		$30
			REST		$20
			
			LOOP_FOREVER	pcmTrack0+3
			
			
		
			
