; This is an example of using spare FM tracks to 'thicken' the sound of other tracks by adding a short rest to the spare
; track and then jumping into the execution of the track that you wish to thicken.
; The SHO tune 'Outride A Crisis' uses this technique to good effect by using tracks 5, 6 and 7 to 'thicken' the sound 
; of tracks 0, 1 and 4
; The only difference between this example and 'multi FM track example.asm' is that this tune uses spare tracks to 'thicken'
; the sound of tracks 0, 1 and 2
; If you assemble this to ORG at Splash Wave's address and then assemble 'multi FM track example.asm' to ORG at Magical
; Sound Shower's address and paste the resulting binaries into the sound rom at their intended addresses you'll easily be 
; able to compare the difference by going into the SOUND TEST screen in service mode and selecting MUSIC 1 and MUSIC 3.
;
;  pasmo --bin multi_FM_track_example_thicken.asm multi_FM_track_example_thicken.bin
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
			
tuneHeaders:		defb	13				; 13 tracks, but we're only using 4 of them

			defw	FMtrack0			; pointer to FM track 0 header
			defw	FMtrack1
			defw	FMtrack2
			defw	FMtrack3			; track used purely to 'thicken' track 0 sound
			defw	FMtrack4			; track used purely to 'thicken' track 1 sound
			defw	FMtrack5			; track used purely to 'thicken' track 2 sound
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
		
FMtrack3:		defb	TRACK_ENABLED			; track enabled (bit 7 is set)
			defb	FM_TRACK_3			; track 3 / patch bank 3
			defb	1				; tempo
			defw	0
			defw	1
			defw	FMtrack3data			; pointer to FM track 3 data
			defb	0				; transpose key
			defb	$20				; offset to subroutine stack end
			defb	0
			defb	0
			defb	0

FMtrack4:		defb	TRACK_ENABLED			; track enabled (bit 7 is set)
			defb	FM_TRACK_4			; track 4 / patch bank 4
			defb	1				; tempo
			defw	0
			defw	1
			defw	FMtrack4data			; pointer to FM track 4 data
			defb	0				; transpose key
			defb	$20				; offset to subroutine stack end
			defb	0
			defb	0
			defb	0
			
FMtrack5:		defb	TRACK_ENABLED			; track enabled (bit 7 is set)
			defb	FM_TRACK_5			; track 5 / patch bank 5
			defb	1				; tempo
			defw	0
			defw	1
			defw	FMtrack5data			; pointer to FM track 5 data
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
	
; These 3 tracks are used purely to 'thicken' the sound of tracks 0, 1 and 2			
FMtrack3data:		LOAD_PATCH	1
			KEY_FRACTION	2			; slight pitch adjustment on this patch to 'thicken' the FM track 0 sound
			REST		4			; a short rest (32ms) on this track will 'thicken' the FM track 0 sound
			LOOP_FOREVER	FMtrack0data+2		; jump into FM track 0 and loop forever		

FMtrack4data:		LOAD_PATCH	2
			KEY_FRACTION	2
			REST		4
			LOOP_FOREVER	FMtrack1data+2		; jump into FM track 1
			
FMtrack5data:		LOAD_PATCH	3
			KEY_FRACTION	2
			REST		4
			LOOP_FOREVER	FMtrack2data+2		; jump into FM track 2
