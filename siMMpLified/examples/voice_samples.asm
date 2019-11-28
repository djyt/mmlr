; example of usage of the 3 voice sample in OR
; i guess they weren't really designed to be used in a tune but that won't stop us ;-)
;
;  pasmo --bin voice_samples.asm voice_samples.bin
;  paste into OR sound rom at $20c8
;  play MUSIC 3 from service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		PassingBreeze		; let's stomp all over Splash Wave @ $20c8
		
			
; master tune header
testTune:		defw		trackHeaderPointers
			defw		$6997
			defw		$6997
			defw		FMPatches		; no FM patches needed for this 'tune'
			
trackHeaderPointers:	defb		13			

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

FMPatches:		defw		0
		
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


pcmTrack0:		SAMPLE_VOL	63,10
			VOICE_PITCH	$48
			GET_READY	30
					
			SAMPLE_VOL	10,63		
			VOICE_PITCH	$58
			GET_READY	150
			
			SAMPLE_VOL	63,10
			VOICE_PITCH	$68
			GET_READY	30
	
			SAMPLE_VOL	10,63
			VOICE_PITCH	$58
			GET_READY	150
			
			SAMPLE_VOL	63,63
			VOICE_PITCH	$48
			GET_READY	30
			
			SAMPLE_VOL	63,10
			VOICE_PITCH	$48
			CHECKPOINT	70
					
			SAMPLE_VOL	10,63		
			VOICE_PITCH	$58
			CHECKPOINT	70
			
			SAMPLE_VOL	63,10
			VOICE_PITCH	$68
			CHECKPOINT	70
	
			SAMPLE_VOL	10,63
			VOICE_PITCH	$58
			CHECKPOINT	70
			
			SAMPLE_VOL	63,63
			VOICE_PITCH	$48
			CHECKPOINT	70
			
			SAMPLE_VOL	63,10
			VOICE_PITCH	$48
			CONGRATS	50
					
			SAMPLE_VOL	10,63		
			VOICE_PITCH	$58
			CONGRATS	50
			
			SAMPLE_VOL	63,10
			VOICE_PITCH	$68
			CONGRATS	50
	
			SAMPLE_VOL	10,63
			VOICE_PITCH	$58
			CONGRATS	50
			
			SAMPLE_VOL	63,63
			VOICE_PITCH	$48
			CONGRATS	50
			
			REST		30
			FINGER_SNAP	15
			REST		10
			FINGER_SNAP	15
			REST		30
			
			LOOP_FOREVER	pcmTrack0
