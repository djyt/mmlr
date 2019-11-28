
;                                                      ***** SET TABS TO 8 *****

WRunPCMtrack0Header:	defb	TRACK_ENABLED          
			defb	PCM_TRACK_0            
			defb	1					; tempo (only applicable if FIXED_TEMPO has NOT been used on this track)
			defw	0                
			defw	1 
			defw	WRunPCMtrack0				; bass drum
			defb	0            
			defb	$20					; offset to stack for subroutines
			defb	0         
			defb	0            
			defb	0 

WRunPCMtrack1Header:	defb	TRACK_ENABLED            
			defb	PCM_TRACK_1           
			defb	1					; tempo (only applicable if FIXED_TEMPO has NOT been used on this track)            
			defw	0                
			defw	1 
			defw	WRunPCMtrack1				; tom-toms
			defb	0            
			defb	$20
			defb	0         
			defb	0            
			defb	0 

WRunPCMtrack2Header:	defb	TRACK_ENABLED            
			defb	PCM_TRACK_2            
			defb	1					; tempo (only applicable if FIXED_TEMPO has NOT been used on this track)            
			defw	0                
			defw	1 
			defw	WRunPCMtrack2				; snare drum
			defb	0            
			defb	$20
			defb	0         
			defb	0            
			defb	0 
		
WRunPCMtrack3Header:	defb	TRACK_ENABLED            
			defb	PCM_TRACK_3         
			defb	1					; tempo (only applicable if FIXED_TEMPO has NOT been used on this track)            
			defw	0                
			defw	1 
			defw	WRunPCMtrack3				; open hi-hat and closed hi-hat
			defb	0            
			defb	$20
			defb	0         
			defb	0            
			defb	0
				
WRunPCMtrack4Header:	defb	TRACK_ENABLED            
			defb	PCM_TRACK_4           
			defb	1					; tempo (only applicable if FIXED_TEMPO has NOT been used on this track)            
			defw	0                
			defw	1 
			defw	WRunPCMtrack4				; crash cymbal       
			defb	0            
			defb	$20
			defb	0         
			defb	0            
			defb	0
