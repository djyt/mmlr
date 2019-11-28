;
;                                                    ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;---------------------------------------------------------- FM track 4 ----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunFMtrack4:		LOAD_PATCH	10
			REST		$B0
 
WRunTrack4MainLoop:	CALL_SUB	WRunTrack4Sub1
			REST		$2C     
			Fs4		$16     
			F4		$16     
			REST		$16     
			Fs4		$16     
			F4		$16     
			REST		$16     
			REST		$2C     
			Fs4		$16     
			F4		$16     
			REST		$16     
			Fs4		$16     
			F4		$16     
			REST		$16     
			Cs4		$16     
			Cs4		$16     
			Cs4		$16     
			Cs4		$16     
			Cs4		$16     
			REST		$2C     
			Cs4		$16 
			REST		$2C     
			Cs4		$58     
			REST		$2C    
			 
WRunTrack4Loop1:	Fs4		$B0     
			F4		$B0     
			Ds4		$B0     
			F4		$B0 
			CALL_SUB	WRunTrack4Sub2
			Fs4		$B0         
			F4		$B0       
			Ds4		$B0           
			F4		$B0           
			CALL_SUB	WRunTrack4Sub2
		
WRunTrack4Loop2:	F4		$42    
			F4		$2C    
			F4		$2C    
			REST		$16   
			F4		$42    
			F4		$2C    
			F4		$2C    
			REST		$16   
			Fs4		$42    
			Fs4		$2C    
			Fs4		$2C    
			REST		$16    
			Fs4		$42    
			Fs4		$2C    
			Fs4		$2C    
			REST		$16    
			LOOP		0, 2, WRunTrack4Loop2
			
			Ds4		$B0   
			Ds4		$B0   
			F4		$42   
			F4		$2C   
			F4		$2C   
			REST		$16      
			REST		$16    
			Fs4		$16    
			F4		$16    
			Cs4		$16    
			Fs4		$16    
			F4		$16    
			Cs4		$2C        
			Ds4		$B0           
			Ds4		$B0       
			F4		$16      
			F4		$16    
			F4		$16    
			F4		$16    
			F4		$16  
			REST		$2C        
			F4		$16      
			REST		$2C         
			F4		$84       
			LOOP		1, 2, WRunTrack4Loop1      
			
WRunTrack4Loop3:	CALL_SUB	WRunTrack4Sub1
			LOOP		0, 4, WRunTrack4Loop3  
			
			LOAD_PATCH	11
			   
WRunTrack4Loop4:	As2		$16     
			As2		$16     
			As2		$16     
			As2		$16     
			F4		$58     
			As2		$16     
			As2		$16     
			As2		$16     
			Ds4		$2C     
			Ds4		$42     
			LOOP		0, 2, WRunTrack4Loop4

			LOAD_PATCH	10
			
			Ds4		$6E     
			Ds4		$16        
			REST		$16     
			Ds4		$C6     
			F4		$42            
			F4		$2C        
			F4		$2C        	
			REST		$16            
			REST		$16         
			Fs4		$16         
			F4		$16         
			Cs4		$16         
			Fs4		$16         
			F4		$16         
			Cs4		$2C                  
			Ds4		$6E            
			Ds4		$16           
			REST		$16         
			Ds4		$C6         
			Cs4		$42                    
			Cs4		$2C            
			Cs4		$2C            
			REST		$16           
			Cs4		$16         
			Ds4		$16         
			REST		$16         
			E4		$21         
			REST		$0B      
			F4		$21            
			REST		$0B      
			Fs4		$16            
			Fs4		$6E                    
			Fs4		$16           
			REST		$16         
			Fs4		$C6         
			F4		$6E                    
			F4		$16           
			REST		$16         
			F4		$C6         
			Ds4		$6E            
			Ds4		$16   
			REST		$16
			Ds4		$C6
			Cs4		$6E
			Cs4		$16  
			REST		$16
			Cs4		$C6
			Fs4		$6E 
			Fs4		$16  
			REST		$16
			Fs4		$C6
			F4		$6E
			F4		$16  
			REST		$16
			F4		$C6
			Ds4		$6E   
			Ds4		$16   
			REST		$16
			Ds4		$C6
			As2		$16
			As2		$16
			As2		$16
			As2		$16
			F4		$58 
			As2		$16
			As2		$16
			As2		$16
			As2		$16
			Ds4		$2C   
			Ds4		$2C   
			As2		$16
			As2		$16
			As2		$16
			As2		$16	
			F4		$58    
			As2		$16    
			As2		$16    
			As2		$16    
			As2		$16    
			Ds4		$2C    
			Ds4		$2C    
			Ds4		$42    
			Ds4		$2C    
			Ds4		$42    
			Ds4		$42    
			Ds4		$2C    
			Ds4		$42    
			F4		$42    
			F4		$2C    
			F4		$42    
			F4		$42    
			F4		$2C    
			F4		$42    
			Ds4		$42    
			Ds4		$2C    
			Ds4		$42    
			Ds4		$42    
			Ds4		$2C    
			Ds4		$42    
			Cs4		$42    
			Cs4		$2C    
			Cs4		$2C    
			REST		$16    
			Cs4		$16    
			Ds4		$16    
			REST		$16    
			E4		$21    
			REST		$0B    
			F4		$21    
			REST		$0B    
			Fs4		$16 
	
			LOOP_FOREVER	WRunTrack4MainLoop
			    
			    
WRunTrack4Sub1:		REST		$2C
			Fs4		$16    
			F4		$16 
			REST		$16 
			Fs4		$16 
			F4		$16 
			REST		$16 
			REST		$2C    
			Fs4		$16   
			F4		$16 
			REST		$16 
			Fs4		$16 
			F4		$16 
			REST		$16 
			REST		$2C    
			Fs4		$16    
			F4		$16 
			REST		$16 
			Fs4		$16 
			F4		$16 
			REST		$16 
			REST		$2C    
			Ds4		$16    
			D4		$16 
			REST		$16 
			Ds4		$16 
			D4		$16 
			REST		$16 
			 
			RETURN

WRunTrack4Sub2:		Fs4		$16  
			Fs4		$16
			F4		$16
			Fs4		$16
			REST		$16
			F4		$16
			REST		$16
			Fs4		$16
			REST		$16
			As4		$16
			REST		$16
			Gs4		$16
			REST		$16
			F4		$42   
			Fs4		$16   
			Fs4		$16
			F4		$16
			Fs4		$16
			REST		$16
			F4		$16
			REST		$16
			Fs4		$16
			REST		$16
			Gs4		$16
			REST		$16
			F4		$16
			Fs4		$58
			
			RETURN 
