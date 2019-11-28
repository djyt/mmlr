; nested subroutine example
;
;  pasmo --bin subroutine_example.asm subroutine_example.bin
;  paste into OR at $20c8
;  play MUSIC 3 from service mode

			INCLUDE	../OR_defines.asm
			INCLUDE	../OR_macros.asm		

			ORG	SplashWave			; stomp all over Splash Wave
			
tune:			defw	tuneHeaders
			defw	$6997
			defw	$6997
			defw	PassingBreezePatchBank		; use Passing Breeze's FM patches						
			
tuneHeaders:		defb	1				; should really define all 13 tracks but i'm lazy here!

			defw	track0header
			
track0header:		defb	TRACK_ENABLED			; various flags (bit 7 set = track enabled)
			defb	FM_TRACK_0			; track 0 / patch bank 0
			defb	1				; tempo (higher = slower - note duration is multiplied by this value to give final note duration)
			defw	0				; counter for currently playing note duration
			defw	1				; duration to play current note/rest for
			defw	track0				; pointer to current address in this track
			defb	0				; transpose value in semi-tones (this is added to MIDI note value from track data to get final note value)
			defb	$20				; offset for subroutine return address
			defb	0				; key fractions value
			defb	0				; current FM patch number
			defb	0				; various flags (FIXED_TEMPO/etc)


track0:			LOAD_PATCH	1

			CALL_SUB	sub1			; call the first subroutine
			LOOP_FOREVER	track0+2
			
			
sub1:			C3		$40
			CALL_SUB	sub2			; first nested subroutine
			RETURN
			
sub2:			D3		$30
			CALL_SUB	sub3			; second nested subroutine (safe it you're not using deeply nested loops too)
			RETURN
			
sub3:			E3		$20			; third nested subroutine (potentially getting dangerous now if you're using nested loops too)
			RETURN
			
