;
;                                                   ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;--------------------------------------------------------- PCM track 2 ----------------------------------------------------------;
;--------------------------------------------------------- snare drum -----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunPCMtrack2: 		FIXED_TEMPO           
			SAMPLE_VOL	$2C, $2C            
			REST		$84            
			SNARE_DRUM1	$2C
			      
WRunPCMtrack2MainLoop:	CALL_SUB	WRunPCMtrack2Sub1	     
			LOOP		0, 6, WRunPCMtrack2MainLoop
							         
			SNARE_DRUM1	$16      
			SNARE_DRUM1	$16         
			SNARE_DRUM1	$16         
			SNARE_DRUM1	$16         
			SNARE_DRUM1	$16
			REST		$2C            
			SNARE_DRUM1	$16      
			REST		$2C            
			SNARE_DRUM1	$2C      
			REST		$58
			            
WRunPCMtrack2Loop1:	CALL_SUB	WRunPCMtrack2Sub1	
			LOOP		0, 4, WRunPCMtrack2Loop1
				  
WRunPCMtrack2Loop2:	REST		$16 	
			SNARE_DRUM1	$16 
			REST		$84     
			REST		$B0     
			LOOP		0, 2, WRunPCMtrack2Loop2
				  
WRunPCMtrack2Loop3:	CALL_SUB	WRunPCMtrack2Sub1	  
			LOOP		0, 4, WRunPCMtrack2Loop3	  
			
WRunPCMtrack2Loop4:	REST		$16 	
			SNARE_DRUM1	$16 
			REST		$84     
			REST		$B0     
			LOOP		0, 2, WRunPCMtrack2Loop4
				  
WRunPCMtrack2Loop5:	CALL_SUB	WRunPCMtrack2Sub1	  
			LOOP		0, 3, WRunPCMtrack2Loop5	  

			REST		$16           
			SNARE_DRUM1	$0B            
			SNARE_DRUM1	$0B      
			REST		$42            
			SNARE_DRUM1	$0B      
			SNARE_DRUM1	$0B      
			REST		$2C
			        
WRunPCMtrack2Loop6:	CALL_SUB	WRunPCMtrack2Sub1         
			LOOP		0, 10, WRunPCMtrack2Loop6	
				 
			SNARE_DRUM1	$16      
			SNARE_DRUM1	$16      
			SNARE_DRUM1	$16      
			SNARE_DRUM1	$16      
			SNARE_DRUM1	$16      
			REST		$2C        
			SNARE_DRUM1	$16      
			REST		$2C        
			SNARE_DRUM1	$2C      
			REST		$58        
			LOOP		1, 2, WRunPCMtrack2Loop1	
				 
WRunPCMtrack2Loop7:	CALL_SUB	WRunPCMtrack2Sub1         
			LOOP		0, 16, WRunPCMtrack2Loop7		 

WRunPCMtrack2Loop8:	REST		$58        
			SNARE_DRUM1	$2C      
			SNARE_DRUM1	$2C      
			REST		$42        
			SNARE_DRUM1	$16      
			REST		$16        
			SNARE_DRUM1	$16      
			REST		$2C        
			LOOP		0, 2, WRunPCMtrack2Loop8
					 
WRunPCMtrack2Loop9:	CALL_SUB	WRunPCMtrack2Sub1		 
			LOOP		0, 7, WRunPCMtrack2Loop9
					
			SNARE_DRUM1	$2C     
			REST		$84
			       
WRunPCMtrack2Loop10:	CALL_SUB	WRunPCMtrack2Sub1		   
			LOOP		0, 14, WRunPCMtrack2Loop10	   

WRunPCMtrack2Loop11:	REST		$58          
			SNARE_DRUM1	$2C     
			SNARE_DRUM1	$2C     
			REST		$42       
			SNARE_DRUM1	$16     
			REST		$16       
			SNARE_DRUM1	$16     
			REST		$2C       
			LOOP		0, 2, WRunPCMtrack2Loop11
				
WRunPCMtrack2Loop12:	CALL_SUB	WRunPCMtrack2Sub1		   
			LOOP		0, 7, WRunPCMtrack2Loop12
				   
			SNARE_DRUM1	$2C     
			REST		$84            
				        
			LOOP_FOREVER	WRunPCMtrack2MainLoop
	
	
WRunPCMtrack2Sub1:	REST		$2C            
			SNARE_DRUM1	$2C		; **** should be 1 semi-tone higher pitch but OR audio program doesn't support PCM sample pitch changes (pitch is hard coded)          
			REST		$2C            
			SNARE_DRUM1	$2C 
			RETURN      
