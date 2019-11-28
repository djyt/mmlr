;
;                                                   ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;--------------------------------------------------------- PCM track 4 ----------------------------------------------------------;
;--------------------------------------------------------- crash cymbal ---------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunPCMtrack4:		FIXED_TEMPO   
			SAMPLE_VOL	$14, $14    	     
			REST		$B0
			            
WRunPCMtrack4MainLoop:	CRASH_CYMBAL	$B0 
			LOOP		0, 6, WRunPCMtrack4MainLoop
				           
			REST		$B0            
			REST		$2C            
			CRASH_CYMBAL	$84
			
WRunPCMtrack4Loop1:	REST		$B0            
			LOOP		0, 4, WRunPCMtrack4Loop1
				
			REST		$B0            
			REST		$84            
			CRASH_CYMBAL	$DC 
			REST		$84            
			CRASH_CYMBAL	$DC
			REST		$B0            
			REST		$B0            
			REST		$B0            
			REST		$B0            
			REST		$84            
			CRASH_CYMBAL	$DC  
			REST		$84        
			CRASH_CYMBAL	$DC
			REST		$B0        
			REST		$B0        
			REST		$2C        
			CRASH_CYMBAL	$58 
			CRASH_CYMBAL	$DC
			
WRunPCMtrack4Loop2:	REST		$B0  
			LOOP		0, 3, WRunPCMtrack4Loop2      

			CRASH_CYMBAL	$B0      
			REST		$B0            
			CRASH_CYMBAL	$B0      
			CRASH_CYMBAL	$B0            
			REST		$B0            
			REST		$B0            
			REST		$B0            
			REST		$2C            
			CRASH_CYMBAL	$84 
			LOOP		1, 2, WRunPCMtrack4Loop1
			           
WRunPCMtrack4Loop3:	CRASH_CYMBAL	$B0
			LOOP		0, 16, WRunPCMtrack4Loop3  
			          
			REST		$58            
			CRASH_CYMBAL	$DC 
			REST		$2C            
			REST		$58            
			CRASH_CYMBAL	$DC      
			REST		$2C  
			          
WRunPCMtrack4Loop4:	CRASH_CYMBAL	$B0
			LOOP		0, 7, WRunPCMtrack4Loop4
			           
			REST		$B0            
			CRASH_CYMBAL	$B0 
			
WRunPCMtrack4Loop5:	REST		$B0            
			LOOP		0, 13, WRunPCMtrack4Loop5
			
			REST		$58            
			CRASH_CYMBAL	$DC
			REST		$2C            
			REST		$58            
			CRASH_CYMBAL	$DC      
			REST		$2C            
			CRASH_CYMBAL	$B0
			REST		$B0 
			           
WRunPCMtrack4Loop6:	REST		$B0            
			LOOP		0, 6, WRunPCMtrack4Loop6
				            
			LOOP_FOREVER	WRunPCMtrack4MainLoop
