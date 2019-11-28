;
;                                                   ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;--------------------------------------------------------- PCM track 3 ----------------------------------------------------------;
;----------------------------------------------------------- hi-hats ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunPCMtrack3:		FIXED_TEMPO
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$2C            
			OPEN_HI_HAT	$2C      
			OPEN_HI_HAT	$2C            
			REST		$2C   
			         
WRunPCMtrack3MainLoop:	CALL_SUB	WRunPCMtrack3Sub1						
			LOOP		0, 6, WRunPCMtrack3MainLoop  
			   
			OPEN_HI_HAT	$2C      
			OPEN_HI_HAT	$2C            
			OPEN_HI_HAT	$2C 
			SAMPLE_VOL	$10, $10 
			REST		$16 
			OPEN_HI_HAT	$16             
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$2C                      
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$2C                  
			OPEN_HI_HAT	$2C  
			    
WRunPCMtrack3Loop1:	CALL_SUB	WRunPCMtrack3Sub1			
			LOOP		0, 4, WRunPCMtrack3Loop1		           

			CALL_SUB	WRunPCMtrack3Sub3            
			CALL_SUB	WRunPCMtrack3Sub4           
			CALL_SUB	WRunPCMtrack3Sub3                   
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16      
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16                     
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16      
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16                     
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$2C  
			          
WRunPCMtrack3Loop2:	CALL_SUB	WRunPCMtrack3Sub1 
			LOOP		0, 4, WRunPCMtrack3Loop2          

			CALL_SUB	WRunPCMtrack3Sub3           
			CALL_SUB	WRunPCMtrack3Sub4           
			CALL_SUB	WRunPCMtrack3Sub3              
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16      
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16                           
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16     
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16                     
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$2C   
			         
WRunPCMtrack3Loop3:	CALL_SUB	WRunPCMtrack3Sub1 		
			LOOP		0, 3, WRunPCMtrack3Loop3  
			      
			REST		$B0
			
WRunPCMtrack3Loop4:	CALL_SUB	WRunPCMtrack3Sub2     		
			LOOP		0, 10, WRunPCMtrack3Loop4          

			CLOSED_HI_HAT	$2C 
			CLOSED_HI_HAT	$2C            
			CLOSED_HI_HAT	$2C 
			REST		$16 
			SAMPLE_VOL	$10, $10 
			OPEN_HI_HAT	$16            
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C 
			CLOSED_HI_HAT	$2C            
			SAMPLE_VOL	$10, $10 
			OPEN_HI_HAT	$2C            
			OPEN_HI_HAT	$2C 
			LOOP		1, 2, WRunPCMtrack3Loop1   
			        
WRunPCMtrack3Loop5:	CALL_SUB	WRunPCMtrack3Sub1
			LOOP		0, 16, WRunPCMtrack3Loop5         

WRunPCMtrack3Loop6:	CLOSED_HI_HAT	$2C		
			CLOSED_HI_HAT	$2C            
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$2C            
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$16      
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16                        
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16      
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16                   
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C 
			LOOP		0, 2, WRunPCMtrack3Loop6 
			
WRunPCMtrack3Loop7:	CALL_SUB	WRunPCMtrack3Sub1 			
			LOOP		0, 7, WRunPCMtrack3Loop7      
           
WRunPCMtrack3Loop8:	SAMPLE_VOL	$10, $10			
			CLOSED_HI_HAT	$16 
			SAMPLE_VOL	$10, $10
			OPEN_HI_HAT	$16 
			LOOP		0, 4, WRunPCMtrack3Loop8   
			        
WRunPCMtrack3Loop9:	CALL_SUB	WRunPCMtrack3Sub1				
			LOOP		0, 14, WRunPCMtrack3Loop9        
			    
WRunPCMtrack3Loop10:	CLOSED_HI_HAT	$2C      			
			CLOSED_HI_HAT	$2C            
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$2C            
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$16       
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16                     
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16      
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16                        
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C 
			LOOP		0, 2, WRunPCMtrack3Loop10           

WRunPCMtrack3Loop11:	CALL_SUB	WRunPCMtrack3Sub1			
			LOOP		0, 7, WRunPCMtrack3Loop11            
           
WRunPCMtrack3Loop12:	SAMPLE_VOL	$10, $10			    
			CLOSED_HI_HAT	$16
			SAMPLE_VOL	$10, $10
			OPEN_HI_HAT	$16
			LOOP		0, 4, WRunPCMtrack3Loop12
				            
			LOOP_FOREVER	WRunPCMtrack3MainLoop


WRunPCMtrack3Sub1:	SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16      
			CLOSED_HI_HAT	$16         
			CLOSED_HI_HAT	$16         
			CLOSED_HI_HAT	$16         
			CLOSED_HI_HAT	$16         
			CLOSED_HI_HAT	$16         
			CLOSED_HI_HAT	$16         
			CLOSED_HI_HAT	$16
			RETURN        

WRunPCMtrack3Sub2:	SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$2C            
			CLOSED_HI_HAT	$2C      
			CLOSED_HI_HAT	$2C            
			RETURN 

WRunPCMtrack3Sub3:	SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C                  
PCMt3Sub3Loop1:		SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16  
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16         
			LOOP		0, 3, PCMt3Sub3Loop1           
			RETURN 

WRunPCMtrack3Sub4:	SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$16      
			SAMPLE_VOL	$10, $10      
			OPEN_HI_HAT	$16         
			LOOP		0, 3, WRunPCMtrack3Sub4                       
			SAMPLE_VOL	$10, $10         
			CLOSED_HI_HAT	$2C 
			RETURN  
