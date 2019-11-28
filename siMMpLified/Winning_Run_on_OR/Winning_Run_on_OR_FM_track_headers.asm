
;                                             ***** SET TABS TO 8 *****

WRunFMtrack0Header:	defb	TRACK_ENABLED				; various flags (bit 7 set = track enabled)
			defb	FM_TRACK_0				; track 0 / patch bank 0
			defb	1					; tempo (higher = slower - note duration is multiplied by this value to give final note duration)
			defw	0					; counter for currently playing note duration
			defw	1					; duration to play current note/rest for
			defw	WRunFMtrack0				; pointer to current address in this track
			defb	-10					; transpose value in semi-tones (this is added to MIDI note value from track data to get final note value)
			defb	$20					; offset for subroutine return address
			defb	0					; key fractions value
			defb	0					; current FM patch number
			defb	0					; various flags (FIXED_TEMPO/etc)
	
WRunFMtrack1Header:	defb	TRACK_ENABLED				; track enabled (bit 7 is set)
			defb	FM_TRACK_1				; track 1 / patch bank 1
			defb	1					; tempo
			defw	0
			defw	1
			defw	WRunFMtrack1				; FM track 1 data pointer
			defb	-10					; transpose value
			defb	$20
			defb	0
			defb	0
			defb	0
	
WRunFMtrack2Header:	defb	TRACK_ENABLED				; track enabled (bit 7 is set)
			defb	FM_TRACK_2				; track 2 / patch bank 2
			defb	1					; tempo
			defw	0
			defw	1
			defw	WRunFMtrack2				; FM track 2 data pointer
			defb	-10					; transpose value
			defb	$20
			defb	0
			defb	0
			defb	0
			
WRunFMtrack3Header:	defb	TRACK_ENABLED				; track enabled (bit 7 is set)
			defb	FM_TRACK_3				; track 3 / patch bank 3
			defb	1 					; tempo
			defw	0
			defw	1
			defw	WRunFMtrack3				; FM track 3 data pointer (bass line) ($01f9 bytes)
			defb	-10					; transpose value
			defb	$20
			defb	0         
			defb	0            
			defb	0  						

WRunFMtrack4Header:	defb	TRACK_ENABLED				; track enabled (bit 7 is set)
			defb	FM_TRACK_4				; track 4 / patch bank 4
			defb	1 					; tempo
			defw	0
			defw	1
			defw	WRunFMtrack4				; FM track 4 data pointer
			defb	-10					; transpose value
			defb	$20
			defb	0         
			defb	0            
			defb	0 
	
WRunFMtrack5Header:	defb	TRACK_ENABLED				; track enabled (bit 7 is set)
			defb	FM_TRACK_5				; track 5 / patch bank 5
			defb	1 					; tempo
			defw	0
			defw	1
			defw	WRunFMtrack5				; FM track 5 data pointer
			defb	-10					; transpose value
			defb	$20
			defb	0         
			defb	0            
			defb	0 
			
WRunFMtrack6Header:	defb	TRACK_ENABLED				; track enabled (bit 7 is set)
			defb	FM_TRACK_6				; track 6 / patch bank 6
			defb	1 					; tempo
			defw	0
			defw	1
			defw	WRunFMtrack6				; FM track 6 data pointer
			defb	-10					; transpose value
			defb	$20
			defb	0         
			defb	0            
			defb	0 
				
WRunFMtrack7Header:	defb	TRACK_ENABLED				; track enabled (bit 7 is set)
			defb	FM_TRACK_7				; track 7 / patch bank 7
			defb	1 					; tempo
			defw	0
			defw	1
			defw	WRunFMtrack7				; FM track 7 data pointer
			defb	-10					; transpose value
			defb	$20
			defb	0         
			defb	0            
			defb	0  						
