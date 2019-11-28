;
;                                                    ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;---------------------------------------------------------- FM track 5 ----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunFMtrack5:		LOAD_PATCH	10
			REST		$B0
			
WRunTrack5MainLoop:	CALL_SUB	WRunTrack5Sub1
			REST		$2C
			Ds4		$16
			Ds4		$16
			REST		$16
			Ds4		$16
			Ds4		$16
			REST		$16
			REST		$2C
			Ds4		$16
			Ds4		$16
			REST		$16
			Ds4		$16
			Ds4		$16
			REST		$16
			As3		$16
			As3		$16
			As3		$16
			As3		$16
			As3		$16
			REST		$2C
			As3		$16
			REST		$2C
			As3		$58
			REST		$2C
			
WRunTrack5Loop1: 	Ds4		$B0
			Cs4		$B0
			B3		$B0
			Cs4		$B0
			CALL_SUB	WRunTrack5Sub2
			Ds4		$B0
			Cs4		$B0
			B3		$B0
			Cs4		$B0
			CALL_SUB	WRunTrack5Sub2

WRunTrack5Loop2:	Cs4		$42 
			Cs4		$2C 
			Cs4		$2C 
			REST		$16 
			Cs4		$42   
			Cs4		$2C   
			Cs4		$2C   
			REST		$16 
			Ds4		$42   
			Ds4		$2C   
			Ds4		$2C   
			REST		$16 
			Ds4		$42   
			Ds4		$2C   
			Ds4		$2C   
			REST		$16 
			LOOP		0, 2, WRunTrack5Loop2   

			B3		$B0    
			B3		$B0    
			Cs4		$42    
			Cs4		$2C    
			Cs4		$2C    
			REST		$16   
			REST		$16 
			Cs4		$16 
			Cs4		$16 
			Gs3		$16 
			Cs4		$16 
			Cs4		$16 
			Gs3		$2C    
			B3		$B0    
			B3		$B0    
			Cs4		$16   
			Cs4		$16 
			Cs4		$16 
			Cs4		$16 
			Cs4		$16 
			REST		$2C  
			Cs4		$16   
			REST		$2C    
			Cs4		$84    
			LOOP		1, 2, WRunTrack5Loop1
		
WRunTrack5Loop3:	CALL_SUB	WRunTrack5Sub1
			LOOP		0, 4, WRunTrack5Loop3
			     
			LOAD_PATCH	11

WRunTrack5Loop4:	REST		$58      
			D4		$58   
			REST		$42      
			B3		$2C      
			B3		$42      
			LOOP		0, 2, WRunTrack5Loop4

			LOAD_PATCH	10
			
			B3		$6E      
			B3		$16     
			REST		$16   
			B3		$C6   
			Cs4		$42         
			Cs4		$2C      
			Cs4		$2C      
			REST		$16      
			REST		$16     
			Cs4		$16     
			Cs4		$16     
			Gs3		$16     
			Cs4		$16     
			Cs4		$16     
			Gs3		$2C             
			B3		$6E        
			B3		$16 
			REST		$16     
			B3		$C6     
			As3		$42             
			As3		$2C
			As3		$2C       
			REST		$16            
			As3		$16         
			B3		$16         
			REST		$16         
			C4		$21         
			REST		$0B      
			Cs4		$21            
			REST		$0B      
			D4		$16         
			Ds4		$6E            
			Ds4		$16           
			REST		$16         
			Ds4		$C6         
			Cs4		$6E            
			Cs4		$16            
			REST		$16         
			Cs4		$C6         
			B3		$6E                    
			B3		$16           
			REST		$16         
			B3		$C6         
			As3		$6E                     
			As3		$16
			REST		$16      
			As3		$C6         
			Ds4		$6E                     
			Ds4		$16           
			REST		$16         
			Ds4		$C6         
			Cs4		$6E                     
			Cs4		$16           
			REST		$16         
			Cs4		$C6         
			B3		$6E            
			B3		$16 
			REST		$16 
			B3		$C6 
			REST		$58    
			D4		$58 
			REST		$58    
			B3		$2C    
			B3		$2C    
			REST		$58    
			D4		$58 
			REST		$58    
			B3		$2C    
			B3		$2C    
			B3		$42    
			B3		$2C    
			B3		$42    
			B3		$42    
			B3		$2C    
			B3		$42 
			Cs4		$42 
			Cs4		$2C 
			Cs4		$42 
			Cs4		$42 
			Cs4		$2C        
			Cs4		$42        
			B3		$42        
			B3		$2C        
			B3		$42        
			B3		$42        
			B3		$2C        
			B3		$42        
			As3		$42 
			As3		$2C        
			As3		$2C 
			REST		$16
			As3		$16     
			B3		$16     
			REST		$16     
			C4		$21     
			REST		$0B  
			Cs4		$21        
			REST		$0B  
			D4		$16     
				     
			LOOP_FOREVER	WRunTrack5MainLoop


WRunTrack5Sub1:		REST		$2C
			Ds4		$16  
			Ds4		$16
			REST		$16
			Ds4		$16
			Ds4		$16
			REST		$16
			REST		$2C 
			Ds4		$16  
			Ds4		$16
			REST		$16
			Ds4		$16
			Ds4		$16
			REST		$16
			REST		$2C   
			Ds4		$16 
			Ds4		$16
			REST		$16
			Ds4		$16
			Ds4		$16
			REST		$16
			REST		$2C   
			As3		$16 
			As3		$16
			REST		$16
			As3		$16
			As3		$16
			REST		$16
			
			RETURN

WRunTrack5Sub2:		Ds4		$16
			Ds4		$16 
			Cs4		$16 
			Ds4		$16 
			REST		$16 
			Cs4		$16 
			REST		$16 
			Ds4		$16 
			REST		$16 
			Fs4		$16 
			REST		$16 
			F4		$16 
			REST		$16 
			Cs4		$42   
			Ds4		$16 
			Ds4		$16 
			Cs4		$16 
			Ds4		$16 
			REST		$16 
			Cs4		$16 
			REST		$16 
			Ds4		$16 
			REST		$16 
			F4		$16 
			REST		$16 
			Cs4		$16 
			Ds4		$58   
			
			RETURN   
