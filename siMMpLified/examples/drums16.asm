; Let's have some fun with the PCM sample player and create a 'tune' which uses all 16 PCM channels!
; I'd recommend only playing this via service mode when the game engine isn't using some of the normally reserved PCM channels
; for things like tyre screechs, Ferrari engine noise and other traffic noise.  You actually CAN play this 'tune' during normal
; gameplay but you won't get the full 16 channels as some of them will be used by the audio engine for other things
;
; Prepare your ears for abuse!
;
; NOT TESTED ON REAL HARDWARE, ONLY TESTED IN MAME
;
;  pasmo --bin drums16.asm drums16.bin
;  paste into OR sound ROM @ $20c8
;  play MUSIC 3 from service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave		; let's stomp all over Splash Wave @ $20c8
		
			
; master tune header
testTune:		defw		trackHeaderPointers
			defw		$6997
			defw		$6997
			defw		FMPatches		; no FM patches needed for this 'tune'
			
trackHeaderPointers:	defb		24			; are you crazy dude!!

			defw		unusedTrack		; no FM tracks for this 'tune'
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			
			defw		PCMtrack0		; the PCM chip supports 16 channels so let's use 'em all!
			defw		PCMtrack1
			defw		PCMtrack2
			defw		PCMtrack3
			defw		PCMtrack4
			defw		PCMtrack5
			defw		PCMtrack6
			defw		PCMtrack7
			defw		PCMtrack8
			defw		PCMtrack9
			defw		PCMtrack10
			defw		PCMtrack11
			defw		PCMtrack12
			defw		PCMtrack13
			defw		PCMtrack14
			defw		PCMtrack15
			

unusedTrack:		defw		0			; all unused tracks point here		

FMPatches:		defw		0			; no FM patches need for this 'tune'

		
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
			
PCMtrack1:		defb		TRACK_ENABLED
			defb		PCM_TRACK_1
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack1		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack2:		defb		TRACK_ENABLED
			defb		PCM_TRACK_2
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack2		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
		
PCMtrack3:		defb		TRACK_ENABLED
			defb		PCM_TRACK_3
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack3		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack4:		defb		TRACK_ENABLED
			defb		PCM_TRACK_4
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack4		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack5:		defb		TRACK_ENABLED
			defb		$45			; would be PCM_TRACK_5 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack5		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack6:		defb		TRACK_ENABLED
			defb		$46			; would be PCM_TRACK_6 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack6		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
	
PCMtrack7:		defb		TRACK_ENABLED
			defb		$47			; would be PCM_TRACK_7 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack7		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
	
PCMtrack8:		defb		TRACK_ENABLED
			defb		$48			; would be PCM_TRACK_8 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack8		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack9:		defb		TRACK_ENABLED
			defb		$49			; would be PCM_TRACK_9 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack9		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack10:		defb		TRACK_ENABLED
			defb		$4a			; would be PCM_TRACK_10 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack10		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack11:		defb		TRACK_ENABLED
			defb		$4b			; would be PCM_TRACK_11 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack11		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack12:		defb		TRACK_ENABLED
			defb		$4c			; would be PCM_TRACK_12 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack12		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack13:		defb		TRACK_ENABLED
			defb		$4d			; would be PCM_TRACK_13 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack13		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
PCMtrack14:		defb		TRACK_ENABLED
			defb		$4e			; would be PCM_TRACK_14 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack14		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
	
PCMtrack15:		defb		TRACK_ENABLED
			defb		$4f			; would be PCM_TRACK_15 (if it were defined)
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack15		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
		
pcmTrack0:		SAMPLE_VOL	63,63
			SHAKER		15
			REST		15
			LOOP_FOREVER	pcmTrack0+3

pcmTrack1:		SAMPLE_VOL	63,63
			REST		10
			CRASH_CYMBAL	15
			REST		15
			LOOP_FOREVER	pcmTrack1+3

pcmTrack2:		SAMPLE_VOL	63,63
			REST		20
			RIDE_CYMBAL	15
			REST		5
			LOOP_FOREVER	pcmTrack2+3

pcmTrack3:		SAMPLE_VOL	63,63
			REST		30
			OPEN_HI_HAT	15
			REST		10
			LOOP_FOREVER	pcmTrack3+3

pcmTrack4:		SAMPLE_VOL	63,63
			REST		40
			CLOSED_HI_HAT	15
			REST		15
			LOOP_FOREVER	pcmTrack4+3

pcmTrack5:		SAMPLE_VOL	63,63
			REST		50
			SNARE_DRUM1	15
			REST		25
			LOOP_FOREVER	pcmTrack5+3

pcmTrack6:		SAMPLE_VOL	63,63
			REST		60
			SNARE_DRUM2	15
			REST		5
			LOOP_FOREVER	pcmTrack6+3

pcmTrack7:		SAMPLE_VOL	63,63
			REST		70
			KICK_DRUM	15
			REST		10
			LOOP_FOREVER	pcmTrack7+3

pcmTrack8:		SAMPLE_VOL	63,63
			REST		80
			TOM_TOM_L	15
			REST		25
			LOOP_FOREVER	pcmTrack8+3

pcmTrack9:		SAMPLE_VOL	63,63
			REST		90
			TOM_TOM_M	15
			REST		10
			LOOP_FOREVER	pcmTrack9+3

pcmTrack10:		SAMPLE_VOL	63,63
			REST		100
			TOM_TOM_H	15
			REST		25
			LOOP_FOREVER	pcmTrack10+3

pcmTrack11:		SAMPLE_VOL	63,63
			REST		110
			HAND_CLAP	15
			REST		5
			LOOP_FOREVER	pcmTrack11+3

pcmTrack12:		SAMPLE_VOL	63,63
			REST		120
			FINGER_SNAP	15
			REST		35
			LOOP_FOREVER	pcmTrack12+3

pcmTrack13:		SAMPLE_VOL	63,63
			REST		130
			RIM_SHOT	15
			REST		5
			LOOP_FOREVER	pcmTrack13+3

pcmTrack14:		SAMPLE_VOL	63,63
			REST		140
			WOOD_RIM	15
			REST		20
			LOOP_FOREVER	pcmTrack14+3

pcmTrack15:		SAMPLE_VOL	63,63
			REST		150
			SHAKER		10			; there are only 15 samples in total so we need to re-use one
			LOOP_FOREVER	pcmTrack15+3
