;
;                                                    ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;---------------------------------------------------------- FM track 7 ----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunFMtrack7:		LOAD_PATCH	10
			REST		$B0
          
WRunTrack7MainLoop:	CALL_SUB	WRunTrack7Sub1            
			REST		$2C            
			As3		$16      
			As3		$16         
			REST		$16         
			As3		$16         
			As3		$16         
			REST		$16         
			REST		$2C            
			B3		$16            
			B3		$16         
			REST		$16         
			B3		$16         
			B3		$16         
			REST		$16         
			REST		$B0            
			REST		$B0
			            
WRunTrack7Loop1:	REST		$B0            
			LOOP		0, 32, WRunTrack7Loop1
			LOOP		1, 2, WRunTrack7Loop1
			            
WRunTrack7Loop2:	CALL_SUB	WRunTrack7Sub1           
			LOOP		0, 4, WRunTrack7Loop2
			           
WRunTrack7Loop3:	REST		$B0            
			LOOP		0, 38, WRunTrack7Loop3
			            
			LOOP_FOREVER	WRunTrack7MainLoop 

WRunTrack7Sub1:		REST		$2C            
			As3		$16      
			As3		$16         
			REST		$16         
			As3		$16         
			As3		$16         
			REST		$16         
			REST		$2C            
			B3		$16 
			B3		$16         
			REST		$16         
			B3		$16         
			B3		$16         
			REST		$16         
			REST		$2C            
			As3		$16      
			As3		$16         
			REST		$16         
			As3		$16         
			As3		$16         
			REST		$16         
			REST		$B0 
			           
			RETURN            
