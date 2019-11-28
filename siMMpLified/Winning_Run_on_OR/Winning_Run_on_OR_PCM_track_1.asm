;
;                                                   ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;--------------------------------------------------------- PCM track 1 ----------------------------------------------------------;
;---------------------------------------------------------- tom-toms ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunPCMtrack1:		FIXED_TEMPO
			SAMPLE_VOL	$2C, $0C		
			REST		$B0				

WRunPCMtrack1MainLoop:	REST		$B0           
			LOOP		0, 6, WRunPCMtrack1MainLoop
			
			REST		$84   
			SAMPLE_VOL	$24, $24            
			TOM_TOM_L	$0B
			SAMPLE_VOL	$1C, $3B            
			TOM_TOM_H	$0B
			REST		$16         
			REST		$B0  
			          
WRunPCMtrack1Loop1:	REST		$B0            
			LOOP		0, 4, WRunPCMtrack1Loop1

			CALL_SUB	WRunPCMtrack1Sub1
			CALL_SUB	WRunPCMtrack1Sub1
			REST		$B0            
			REST		$B0            
			REST		$B0            
			REST		$B0            
			CALL_SUB	WRunPCMtrack1Sub1
			CALL_SUB	WRunPCMtrack1Sub1
			REST		$B0            
			REST		$B0            
			REST		$B0            
	
WRunPCMtrack1Loop2:	SAMPLE_VOL	$2C, $0C            
			TOM_TOM_M	$0B
			SAMPLE_VOL	$24, $24            
			TOM_TOM_L	$0B
			TOM_TOM_L	$0B	
			SAMPLE_VOL	$1C, $3B            
			TOM_TOM_H	$0B
			REST		$2C            
			LOOP		0, 2, WRunPCMtrack1Loop2   
			        
WRunPCMtrack1Loop3:	REST		$B0            
			LOOP		0, 10, WRunPCMtrack1Loop3         

			REST		$84            
			SAMPLE_VOL	$24, $24            
			TOM_TOM_L	$0B      
			SAMPLE_VOL	$1C, $3B            
			TOM_TOM_H	$0B      
			REST		$C6         
			LOOP		1, 2, WRunPCMtrack1Loop1  
			          
WRunPCMtrack1Loop4:	REST		$B0            
			LOOP		0, 16, WRunPCMtrack1Loop4   
			         
WRunPCMtrack1Loop5:	REST		$B0            
			SAMPLE_VOL	$2C, $0C            
			TOM_TOM_M	$16      
			SAMPLE_VOL	$24, $24            
			TOM_TOM_L	$16      
			SAMPLE_VOL	$1C, $3B            
			TOM_TOM_H	$16      
			REST		$6E            
			LOOP		0, 2, WRunPCMtrack1Loop5    
			        
WRunPCMtrack1Loop6:	REST		$B0            
			LOOP		0, 34, WRunPCMtrack1Loop6      
								
			LOOP_FOREVER	WRunPCMtrack1MainLoop


WRunPCMtrack1Sub1:	SAMPLE_VOL	$24, $24            
			TOM_TOM_L	$16
			REST		$16         
			SAMPLE_VOL	$1C, $3B            
			TOM_TOM_H	$16
			REST		$2C            
			SAMPLE_VOL	$24, $24            
			TOM_TOM_L	$16
			REST		$16         
			TOM_TOM_L	$16
			REST		$16         
			TOM_TOM_L	$2C
			TOM_TOM_L	$2C
			REST		$16         
			TOM_TOM_L	$2C
			RETURN            
