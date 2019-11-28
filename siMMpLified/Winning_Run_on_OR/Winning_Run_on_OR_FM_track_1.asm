;
;                                                    ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;---------------------------------------------------------- FM track 1 ----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunFMtrack1:		LOAD_PATCH	1
			REST		$B0

WRunTrack1MainLoop:	LOAD_PATCH	1

			Ds4		$B0           
			B3		$B0           
			B3		$B0           
			Cs4		$B0           
			Ds4		$B0           
			B3		$B0           
			F4		$16 
			F4		$16 
			F4		$16 
			F4		$16 
			F4		$16 
			REST		$2C    
			F4		$16
			REST		$2C    
			F4		$58    
			REST		$2C   
			 
WRunTrack1Loop1:	LOAD_PATCH	2

			Ds4		$58    
			Ds4		$16 
			Cs4		$16 
			Ds4		$16 
			F4		$6E    
			F4		$16 
			Ds4		$16 
			F4		$16 
			Fs4		$42    
			As4		$16 
			REST		$16 
			F4		$2C    
			Ds4		$16 
			F4		$6E    
			Ds4		$16
			F4		$2C  
			
			Fs4		$C6 
			SEAMLESS					; tie
			Fs4		$B0 
			P_BEND_END
			
			REST		$B0    
			REST		$B0    
			Ds4		$58    
			Ds4		$16 
			Cs4		$16 
			Ds4		$16 
			F4		$6E    
			F4		$16 
			Ds4		$16 
			F4		$16 
			Fs4		$42    
			As4		$16 
			REST		$16 
			F4		$2C    
			Ds4		$16 
			F4		$42    
			Ds4		$2C    
			F4		$2C    
			Cs4		$2C           
			Ds4		$16 
			
			As3		$9A
			SEAMLESS					; tie
			As3		$B0
			P_BEND_END
			
			REST		$B0           
			REST		$B0  
			         
WRunTrack1Loop2:	REST		$B0  
			LOOP		0, 16, WRunTrack1Loop2
			LOOP		1, 2, WRunTrack1Loop1
			
			LOAD_PATCH	1
			
WRunTrack1Loop3:	Ds4		$B0         
			B3		$B0         
			B3		$B0         
			Cs4		$B0    
			LOOP		0, 4, WRunTrack1Loop3
			
WRunTrack1Loop4:	REST		$B0
			LOOP		0, 24, WRunTrack1Loop4
			
WRunTrack1Loop5:	REST		$B0
			LOOP		0, 13, WRunTrack1Loop5
			
			LOAD_PATCH	5
			
           		P_BEND_START
           		PITCH_BEND	Fs3, Fs3, $58
           		SEAMLESS					; tie
           		PITCH_BEND	Fs3, As2, $58
           		P_BEND_END
           		
			LOOP_FOREVER	WRunTrack1MainLoop
