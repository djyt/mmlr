; simple example of a tune which uses a single FM track and a single PCM track
;
;  pasmo --bin multi_track_example.asm multi_track_example.bin
;  paste into OR at $20c8
;  play MUSIC 3 from service mode

			INCLUDE	../OR_defines.asm
			INCLUDE	../OR_macros.asm
			
			ORG	SplashWave			; let's stomp all over Splash Wave
			
; master header
testTune:		defw	tuneHeaders
			defw	$6997
			defw	$6997
			defw	PassingBreezePatchBank		; we'll use Passing Breeze's FM patches for this tune
			
tuneHeaders:		defb	13				; number of tracks

			defw	FMtrack0			; pointer to FM track 0 header
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			
			defw	PCMtrack0			; pointer to PCM track 0 header
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack

; FM track 0 header			
FMtrack0:		defb	TRACK_ENABLED			; track enabled (bit 7 is set)
			defb	FM_TRACK_0			; track 0 / patch bank 0
			defb	1				; tempo
			defw	0
			defw	1
			defw	FMtrack0data			; pointer to FM track 0 data
			defb	0				; transpose key
			defb	$20				; offset to subroutine stack end
			defb	0
			defb	0
			defb	0		

; PCM track 0 header
PCMtrack0:		defb	TRACK_ENABLED          
			defb	PCM_TRACK_0            
			defb	1					
			defw	0                
			defw	1 
			defw	PCMtrack0data			; pointer to PCM track 0 data			
			defb	0            
			defb	$20
			defb	0         
			defb	0            
			defb	0 

unusedTrack:		defw	0				; first 12 bytes of FMtrack0data will be copied into ram after this
								; word but they'll be ignored by the playback engine as it's only
								; concerned with bit 7 of the first byte of each track and we're 
								; setting that to zero here, to effectively disable that track
							

; total length of track = $c0 beats
FMtrack0data:		LOAD_PATCH	1
			C3		$40
			D3		$40
			E3		$40		
			LOOP_FOREVER	FMtrack0data+2

; total length of track = $c0 beats
PCMtrack0data:		SAMPLE_VOL	$3C, $3C

			SNARE_DRUM1	$20
			REST		$20

			SNARE_DRUM2	$20
			REST		$20

			CLOSED_HI_HAT	$20
			CLOSED_HI_HAT	$20			
			
			LOOP_FOREVER	PCMtrack0data+3
