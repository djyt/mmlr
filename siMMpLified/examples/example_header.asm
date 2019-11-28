; generic header used for testing purposes
; enables a single FM track and piggy backs on the Passing Breeze FM patch bank

test_tune:		defw	tuneHeaders
			defw	$6997				; TL adjustments
			defw	$6997				; key fractions
			defw	PassingBreezePatchBank		; use Passing Breeze's FM patches						
			
tuneHeaders:		defb	13				; number of tracks

			defw	FMtrack0header			; we're just using 1 FM track in this test
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			
			defw	unusedTrack			; not using any PCM tracks in this test
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			defw	unusedTrack
			
unusedTrack		defw	0

FMtrack0header:		defb	TRACK_ENABLED			; various flags (bit 7 set = track enabled)
			defb	FM_TRACK_0			; track 0 / patch bank 0
			defb	1				; tempo (higher = slower - note duration is multiplied by this value to give final note duration)
			defw	0				; counter for currently playing note duration
			defw	1				; duration to play current note/rest for
			defw	FMtrack0			; pointer to current address in this track
			defb	0				; transpose value in semi-tones (this is added to MIDI note value from track data to get final note value)
			defb	$20				; offset for subroutine return address
			defb	0				; key fractions value
			defb	0				; current FM patch number
			defb	0				; various flags (FIXED_TEMPO/etc)

			
