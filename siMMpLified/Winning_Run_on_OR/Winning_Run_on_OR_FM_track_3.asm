;
;                                                    ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;---------------------------------------------------------- FM track 3 ----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunFMtrack3:		LOAD_PATCH	9				; bass
			REST		$B0  
			          
WRunTrack3MainLoop:	CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub3
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub2
			As1		$16 
			As1		$16 
			As1		$16 
			As1		$16 
			As1		$16 
			REST		$2C            
			As1		$16 
			REST		$2C            
			As1		$58 
			REST		$2C            

WRunTrack3Loop1:	CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub4
			
			Ds2		$16
			Ds2		$16
			Cs2		$16
			Ds2		$16
			REST		$16        
			Cs2		$16         
			REST		$16         
			Ds2		$16         
			REST		$16         
			Fs2		$16         
			REST		$16         
			F2		$16         
			REST		$16         
			Cs2		$42         
			Ds2		$16            
			Ds2		$16         
			Cs2		$16         
			Ds2		$16         
			REST		$16         
			Cs2		$16         
			REST		$16         
			Ds2		$16         
			REST		$16         
			Fs2		$16         
			REST		$16         
			Cs2		$16         
			Ds2		$58
			
			CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub4
			
			Ds2		$16         
			Ds2		$16         
			Cs2		$16          
			Ds2		$16         
			REST		$16         
			Cs2		$16         
			REST		$16         
			Ds2		$16         
			REST		$16         
			Fs2		$16         
			REST		$16         
			F2		$16         
			REST		$16         
			Cs2		$42            
			Ds2		$16            
			Ds2		$16         
			Cs2		$16         
			Ds2		$16         
			REST		$16         
			Cs2		$16         
			REST		$16         
			Ds2		$16         
			REST		$16         
			Fs2		$16         
			REST		$16        
			Cs2		$16         
			Ds2		$58  
			       
WRunTrack3Loop2:	CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub1
			LOOP		0, 2, WRunTrack3Loop2
			
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub2
			As1		$16      
			As1		$16         
			As1		$16         
			As1		$16         
			As1		$16         
			REST		$2C            
			As1		$16      
			REST		$2C            
			As1		$84 
			LOOP		1, 2, WRunTrack3Loop1  
			         
WRunTrack3Loop3:	CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub3
			CALL_SUB	WRunTrack3Sub4
			LOOP		0, 4, WRunTrack3Loop3
			          
WRunTrack3Loop4:	As1		$16      
			As1		$16         
			As1		$16         
			As1		$16         
			F2		$58            
			As1		$16      
			As1		$16         
			As1		$16         
			As1		$16         
			Ds2		$2C            
			Ds2		$2C            
			LOOP		0, 2, WRunTrack3Loop4  
			        
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub2
			      
			As1		$2C 
			As1		$16      
			As1		$16         
			As1		$16         
			As1		$16         
			As1		$16         
			As1		$16         
			Gs1		$16         
			B1		$2C            
			B1		$2C            
			Cs2		$2C            
			D2		$16         
			
			CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub1
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub2
			      
			As1		$16      
			As1		$16         
			As1		$16        
			As1		$16         
			F2		$58            
			As1		$16      
			As1		$16         
			As1		$16         
			Ds2		$2C            
			Cs2		$42            
			As1		$16      
			As1		$16         
			As1		$16         
			As1		$16         
			F2		$58            
			As1		$16      
			As1		$16         
			As1		$16         
			Ds2		$2C            
			Cs2		$42            
			
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub4
			CALL_SUB	WRunTrack3Sub2
			CALL_SUB	WRunTrack3Sub2
			      
			As1		$2C      
			As1		$16         
			As1		$16         
			As1		$16         
			As1		$16         
			As1		$16         
			As1		$16         
			As1		$16         
			B1		$2C            
			B1		$2C            
			Cs2		$2C            
			D2		$16  
			       
			LOOP_FOREVER	WRunTrack3MainLoop         
	    
      
WRunTrack3Sub1:		Ds2		$2C            
			Ds2		$16         
			Ds2		$16         
			Ds2		$16         
			Ds2		$16         
			Ds2		$16         
			Ds2		$16
			RETURN
	
		        
WRunTrack3Sub2:		B1		$2C            
			B1		$16 
			B1		$16 
			B1		$16 
			B1		$16 
			B1		$16 
			B1		$16 
			RETURN
	
			
WRunTrack3Sub3:		C2		$2C            
			C2		$16 
			C2		$16 
			C2		$16 
			C2		$16 
			C2		$16 
			C2		$16 
			RETURN

		
WRunTrack3Sub4:		Cs2		$2C            
			Cs2		$16 
			Cs2		$16 
			Cs2		$16 
			Cs2		$16 
			Cs2		$16 
			Cs2		$16 
			RETURN
