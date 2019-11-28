; this is an example of noise in an FM track
; remember - noise only works on FM track 7
;
;  pasmo --bin noise_example.asm noise_example.bin
;  paste into OR at $20c8
;  play MUSIC 3 in service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave
			
; master header
testTune:		defw	tuneHeaders
			defw	$6997
			defw	$6997
			defw	PassingBreezePatchBank		; we'll use Passing Breeze's FM patches for this tune
			
tuneHeaders:		defb	13				; number of tracks

			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	FMtrack7			; NOISE only works on FM track 7
			
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack

; FM track 7 header			
FMtrack7:		defb	TRACK_ENABLED			; track enabled (bit 7 is set)
			defb	FM_TRACK_7			; track 7 / patch bank 7
			defb	1				; tempo
			defw	0
			defw	1
			defw	FMtrack7data			; pointer to FM track 0 data
			defb	0				; transpose key
			defb	$20				; offset to subroutine stack end
			defb	0
			defb	0
			defb	0		
			
unusedTrack:		defw	0


FMtrack7data:		LOAD_PATCH	4

			NOISE_ON
			C3		40
			D3		40
			E3		40
			
			NOISE_OFF
			C3		40
			D3		40
			E3		40
			
			LOOP_FOREVER	FMtrack7data+2
