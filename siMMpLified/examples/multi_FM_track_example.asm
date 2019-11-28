; multi channel FM example
;
;  pasmo --bin multi_FM_track_example.asm multi_FM_track_example.bin
;  paste into OR at $3d5f
;  play MUSIC 1 from service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG	MagicalSound			; let's stomp all over Magical Sound Shower
			
; master header
testTune:		defw	tuneHeaders
			defw	$6997
			defw	$6997
			defw	PassingBreezePatchBank		; we'll use Passing Breeze's FM patches for this tune
			
tuneHeaders:		defb	13				; 13 tracks but we're only using 3 of them

			defw	FMtrack0			; pointer to FM track 0 header
			defw	FMtrack1
			defw	FMtrack2
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			
			defw	unusedTrack			; we're not using any PCM tracks in this example
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack

; FM track 0 header			
FMtrack0:		defb	TRACK_ENABLED			; track enabled (bit 7 is set)
			defb	FM_TRACK_0			; track 0 / patch bank 1
			defb	1				; tempo
			defw	0
			defw	1
			defw	FMtrack0data			; pointer to FM track 0 data
			defb	0				; transpose key
			defb	$20				; offset to subroutine stack end
			defb	0
			defb	0
			defb	0		

FMtrack1:		defb	TRACK_ENABLED			; track enabled (bit 7 is set)
			defb	FM_TRACK_1			; track 1 / patch bank 1
			defb	1				; tempo
			defw	0
			defw	1
			defw	FMtrack1data			; pointer to FM track 1 data
			defb	0				; transpose key
			defb	$20				; offset to subroutine stack end
			defb	0
			defb	0
			defb	0
			
FMtrack2:		defb	TRACK_ENABLED			; track enabled (bit 7 is set)
			defb	FM_TRACK_2			; track 2 / patch bank 2
			defb	1				; tempo
			defw	0
			defw	1
			defw	FMtrack2data			; pointer to FM track 2 data
			defb	0				; transpose key
			defb	$20				; offset to subroutine stack end
			defb	0
			defb	0
			defb	0
			
unusedTrack:		defw	0


FMtrack0data:		LOAD_PATCH	1
			C3		$40			; C major chord note 1
			REST		$30
			D3		$40			; D minor chord note 1
			REST		$30
			E3		$40			; E minor chord note 1
			REST		$30
			LOOP_FOREVER	FMtrack0data+2
			
FMtrack1data:		LOAD_PATCH	2
			E3		$40			; C major chord note 2
			REST		$30
			F3		$40			; D minor chord note 2
			REST		$30
			G3		$40			; E minor chord note 2
			REST		$30
			LOOP_FOREVER	FMtrack1data+2
			
FMtrack2data:		LOAD_PATCH	3
			G3		$40			; C major chord note 3
			REST		$30
			A3		$40			; D minor chord note 3
			REST		$30
			B3		$40			; E minor chord note 3
			REST		$30
			LOOP_FOREVER	FMtrack2data+2
			


