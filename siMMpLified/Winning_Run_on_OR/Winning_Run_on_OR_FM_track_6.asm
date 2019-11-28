;
;                                                    ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;---------------------------------------------------------- FM track 6 ----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunFMtrack6:		LOAD_PATCH	10
			REST		$B0  
					    
WRunTrack6MainLoop:	CALL_SUB	WRunTrack6Sub1
			REST		$2C      
			Cs4		$16      
			Cs4		$16      
			REST		$16      
			Cs4		$16      
			Cs4		$16      
			REST		$16      
			REST		$2C      
			Cs4		$16    
			Cs4		$16    
			REST		$16      
			Cs4		$16    
			Cs4		$16    
			REST		$16    
			F3		$16    
			F3		$16    
			F3		$16    
			F3		$16    
			F3		$16    
			REST		$2C       
			F3		$16
			REST		$2C       
			F3		$58       
			REST		$2C       

WRunTrack6Loop1:	As3		$B0
			Gs3		$B0       
			Fs3		$B0    
			Gs3		$B0    
			CALL_SUB	WRunTrack6Sub2
			As3		$B0 
			Gs3		$B0       
			Fs3		$B0    
			Gs3		$B0    
			CALL_SUB	WRunTrack6Sub2

WRunTrack6Loop2:	Gs3		$42    
			Gs3		$2C    
			Gs3		$2C    
			REST		$16
			Gs3		$42       
			Gs3		$2C    
			Gs3		$2C    
			REST		$16      
			As3		$42       
			As3		$2C
			As3		$2C       
			REST		$16 
			As3		$42       
			As3		$2C 
			As3		$2C       
			REST		$16 
			LOOP		0, 2, WRunTrack6Loop2
      
			Fs3		$B0       
			Fs3		$B0       
			Gs3		$42       
			Gs3		$2C       
			Gs3		$2C       
			REST		$16         
			REST		$16       
			Gs3		$16       
			Gs3		$16       
			REST		$16       
			Gs3		$16       
			Gs3		$16       
			REST		$2C          
			Fs3		$B0       
			Fs3		$B0       
			As3		$16 
			As3		$16    
			As3		$16       
			As3		$16       
			As3		$16       
			REST		$2C          
			As3		$16    
			REST		$2C          
			As3		$84 
			LOOP		1, 2, WRunTrack6Loop1

WRunTrack6Loop3:	CALL_SUB	WRunTrack6Sub1
			LOOP		0, 4, WRunTrack6Loop3          
			
			LOAD_PATCH	11

WRunTrack6Loop4:	REST		$58          
			As3		$58 
			REST		$42          
			Gs3		$2C       
			Gs3		$42       
			LOOP		0, 2, WRunTrack6Loop4
       
			LOAD_PATCH	10
			
			Fs3		$6E     
			Fs3		$16     
			REST		$16       
			Fs3		$C6     
			Gs3		$42        
			Gs3		$2C     
			Gs3		$2C     
			REST		$16       
			REST		$16     
			Gs3		$16     
			Gs3		$16     
			REST		$16     
			Gs3		$16     
			Gs3		$16     
			REST		$2C        
			Fs3		$6E     
			Fs3		$16     
			REST		$16       
			Fs3		$C6     
			F3		$42        
			F3		$2C        
			F3		$2C        
			REST		$16       
			F3		$16     
			Fs3		$16     
			REST		$16     
			G3		$21     
			REST		$0B  
			Gs3		$21     
			REST		$0B        
			A3		$16         
			As3		$6E         
			As3		$16 
			REST		$16   
			As3		$C6      
			Gs3		$6E            
			Gs3		$16      
			REST		$16        
			Gs3		$C6      
			Fs3		$6E         
			Fs3		$16      
			REST		$16         
			Fs3		$C6      
			F3		$6E		         
			F3		$16         
			REST		$16      
			F3		$C6      
			As3		$6E         
			As3		$16
			REST		$16   
			As3		$C6      
			Gs3		$6E         
			Gs3		$16      
			REST		$16        
			Gs3		$C6      
			Fs3		$6E         
			Fs3		$16      
			REST		$16         
			Fs3		$C6      
			REST		$58               
			As3		$58
			REST		$58         
			Gs3		$2C    
			Gs3		$2C    
			REST		$58       
			As3		$58 
			REST		$58       
			Gs3		$2C    
			Gs3		$2C    
			Fs3		$42    
			Fs3		$2C    
			Fs3		$42    
			Fs3		$42    
			Fs3		$2C    
			Fs3		$42    
			Gs3		$42    
			Gs3		$2C    
			Gs3		$42    
			Gs3		$42    
			Gs3		$2C    
			Gs3		$42    
			Fs3		$42    
			Fs3		$2C    
			Fs3		$42    
			Fs3		$42    
			Fs3		$2C    
			Fs3		$42    
			F3		$42       
			F3		$2C       
			F3		$2C       
			REST		$16       
			F3		$16     
			Fs3		$16     
			REST		$16     
			G3		$21     
			REST		$0B  
			Gs3		$21     
			REST		$0B        
			A3		$16       
			
			LOOP_FOREVER	WRunTrack6MainLoop	


WRunTrack6Sub1:		REST		$2C  
			Cs4		$16  
			Cs4		$16  
			REST		$16  
			Cs4		$16  
			Cs4		$16  
			REST		$16  
			REST		$2C  	
			Cs4		$16  
			Cs4		$16  
			REST		$16  
			Cs4		$16  
			Cs4		$16  
			REST		$16  
			REST		$2C  
			Cs4		$16  
			Cs4		$16  
			REST		$16  
			Cs4		$16  
			Cs4		$16  
			REST		$16  
			REST		$2C  
			Fs3		$16  
			Fs3		$16  
			REST		$16  
			Fs3		$16  
			Fs3		$16  
			REST		$16 
			 
			RETURN     


WRunTrack6Sub2:		As3		$16
			As3		$16   
			As3		$16 
			As3		$16   
			REST		$16   
			As3		$16   
			REST		$16   
			As3		$16   
			REST		$16   
			Cs4		$16   
			REST		$16   
			Cs4		$16   
			REST		$16   
			Gs3		$42      
			As3		$16 
			As3		$16 
			As3		$16   
			As3		$16   
			REST		$16   
			As3		$16   
			REST		$16   
			As3		$16   
			REST		$16   
			Cs4		$16   
			REST		$16   
			As3		$16   
			As3		$58    
			  
			RETURN     
