;
;                                                    ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;---------------------------------------------------------- FM track 2 ----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
WRunFMtrack2:		LOAD_PATCH	1
			REST		$B0        
			
WRunTrack2MainLoop:	LOAD_PATCH	1

			As3		$B0 
			Fs3		$B0            
			G3		$B0            
			Gs3		$B0         
			As3		$B0 
			Fs3		$B0            
			D4		$16         
			D4		$16         
			D4		$16         
			D4		$16         
			D4		$16         
			REST		$2C            
			D4		$16         
			REST		$2C            
			D4		$58         
			REST		$2C 		
			LOAD_PATCH	6
			REST		$16         	
			KEY_FRACTION	2
			LOAD_PATCH	6
			CALL_SUB	WRunTrack0Sub1
			LOAD_PATCH	7
			CALL_SUB	WRunTrack0Sub2
			REST		$B0            
			LOAD_PATCH	6
			CALL_SUB	WRunTrack0Sub1
			LOAD_PATCH	7
			CALL_SUB	WRunTrack0Sub2
			REST		$9A            
			KEY_FRACTION	0
			LOAD_PATCH	1
			
WRunTrack2Loop1:	As3		$B0 
			Fs3		$B0            
			G3		$B0            
			Gs3		$B0         
			LOOP		0, 4, WRunTrack2Loop1
			
			LOAD_PATCH	6
			REST		$16 
			KEY_FRACTION	2
			CALL_SUB	WRunTrack0Sub3
			REST		$6E
			LOAD_PATCH	7
			CALL_SUB	WRunTrack0Sub4
			LOAD_PATCH	8
			CALL_SUB	WRunTrack2Sub1
			CALL_SUB	WRunTrack0Sub6
			CALL_SUB	WRunTrack2Sub2
			CALL_SUB	WRunTrack0Sub8
			CALL_SUB	WRunTrack0Sub9
			CALL_SUB	WRunTrack2Sub3
			CALL_SUB	WRunTrack0Sub11
			
			P_BEND_START 
			PITCH_BEND	Fs2, Fs2, $58      
			SEAMLESS					; tie
			PITCH_BEND	Fs2, Ds2, $42      
			P_BEND_END            
			
			KEY_FRACTION	0
			
			LOOP_FOREVER	WRunTrack2MainLoop


WRunTrack2Sub1:		Ds5		$0B            
			F5		$21 
			Fs5		$16      
			KEY_FRACTION	1
			Ds5		$6E      
			KEY_FRACTION	2
			
			RETURN


WRunTrack2Sub2:		P_BEND_START            
			PITCH_BEND	Cs5, Cs5, $0B            
			SEAMLESS					; tie
			PITCH_BEND	Cs5, Ds5, $0B            
			P_BEND_END            
			
			Ds5		$16 
			Ds5		$2C            
			SEAMLESS					; tie
			KEY_FRACTION	1				; apply tiny pitch shift to next note
			Ds5		$42      
			P_BEND_END					; a.k.a. SEAMLESS_END
			
			KEY_FRACTION	2
			Ds5		$08            
			Cs5		$07            
			As4		$07  
			          
			RETURN


WRunTrack2Sub3:		Cs4		$0B            
			SEAMLESS					; slur
			Ds4		$0B            
			P_BEND_END					; a.k.a. SEAMLESS_END
			
			Fs4		$16 
			
			P_BEND_START         
			PITCH_BEND	Gs4, Gs4, $0B            
			SEAMLESS					; tie
			PITCH_BEND	Gs4, As4, $0B            
			SEAMLESS					; tie
			PITCH_BEND	As4, Gs4, $0B            
			P_BEND_END            
			
			Fs4		$0B            
			KEY_FRACTION	1
			Gs4		$58      
			KEY_FRACTION	2
			
			RETURN
