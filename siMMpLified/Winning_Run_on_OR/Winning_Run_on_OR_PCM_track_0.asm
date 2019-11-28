;
;                                                   ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;--------------------------------------------------------- PCM track 0 ----------------------------------------------------------;
;---------------------------------------------------------- kick drum -----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunPCMtrack0:		FIXED_TEMPO
			SAMPLE_VOL	$2C, $2C
			
			REST		$6E            
			KICK_DRUM	$0B 
			KICK_DRUM	$0B            
			REST		$2C  
			          
WRunPCMtrack0MainLoop:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 6, WRunPCMtrack0MainLoop  
			
			KICK_DRUM	$2C 
			KICK_DRUM	$2C            
			KICK_DRUM	$2C      
			REST		$16         
			KICK_DRUM	$16         
			REST		$2C            
			KICK_DRUM	$2C      
			REST		$58            

WRunPCMtrack0Loop1:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 4, WRunPCMtrack0Loop1           

WRunPCMtrack0Loop2:	CALL_SUB	WRunPCMtrack0Sub2            
			LOOP		0, 2, WRunPCMtrack0Loop2 

WRunPCMtrack0Loop3:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 4, WRunPCMtrack0Loop3            

WRunPCMtrack0Loop4:	CALL_SUB	WRunPCMtrack0Sub2            
			LOOP		0, 2, WRunPCMtrack0Loop4         

WRunPCMtrack0Loop5:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 4, WRunPCMtrack0Loop5            

WRunPCMtrack0Loop6:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 10, WRunPCMtrack0Loop6         

			KICK_DRUM	$2C      
			KICK_DRUM	$2C            
			KICK_DRUM	$2C      
			REST		$16         
			KICK_DRUM	$16         
			REST		$2C            
			KICK_DRUM	$2C      
			REST		$58            
			LOOP		1, 2, WRunPCMtrack0Loop1  
			          
WRunPCMtrack0Loop7:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 16, WRunPCMtrack0Loop7   
			        
			CALL_SUB	WRunPCMtrack0Sub3            
			CALL_SUB	WRunPCMtrack0Sub3     
			       
WRunPCMtrack0Loop8:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 7, WRunPCMtrack0Loop8         

			
			KICK_DRUM	$2C      
			REST		$16         
			KICK_DRUM	$2C            
			KICK_DRUM	$2C      
			REST		$16        
			
WRunPCMtrack0Loop9:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 14, WRunPCMtrack0Loop9
			          
WRunPCMtrack0Loop10:	KICK_DRUM	$16      
			KICK_DRUM	$16         
			REST		$84            
			KICK_DRUM	$16      
			KICK_DRUM	$16         
			REST		$42            
			KICK_DRUM	$16      
			REST		$16         
			KICK_DRUM	$16         
			LOOP		0, 2, WRunPCMtrack0Loop10   
			  
WRunPCMtrack0Loop11:	CALL_SUB	WRunPCMtrack0Sub1            
			LOOP		0, 7, WRunPCMtrack0Loop11    
			       
			KICK_DRUM	$2C      
			REST		$16         
			KICK_DRUM	$2C            
			KICK_DRUM	$2C      
			REST		$16
			         
			LOOP_FOREVER	WRunPCMtrack0MainLoop            
			

WRunPCMtrack0Sub1:	KICK_DRUM	$21      
			KICK_DRUM	$0B            
			REST		$2C            
			KICK_DRUM	$16      
			KICK_DRUM	$42            
			RETURN   
				    
WRunPCMtrack0Sub2:	KICK_DRUM	$16      
			KICK_DRUM	$16         
			REST		$16         
			KICK_DRUM	$2C            
			KICK_DRUM	$2C      
			REST		$16          
			KICK_DRUM	$2C            
			KICK_DRUM	$2C      
			KICK_DRUM	$16         
			KICK_DRUM	$0B            
			KICK_DRUM	$0B       
			REST		$2C            
			RETURN  

WRunPCMtrack0Sub3:	KICK_DRUM	$16      
			KICK_DRUM	$16         
			REST		$84            
			KICK_DRUM	$16      
			KICK_DRUM	$16         
			REST		$42            
			KICK_DRUM	$16      
			REST		$16         
			KICK_DRUM	$16 
			RETURN   
