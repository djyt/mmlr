;
;                                                    ***** SET TABS TO 8 *****
;
;--------------------------------------------------------------------------------------------------------------------------------;
;---------------------------------------------------------- FM track 0 ----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;			
WRunFMtrack0:		LOAD_PATCH	1
			REST		$B0     
			
WRunTrack0MainLoop:	LOAD_PATCH	1
			Fs4		$B0      
			Ds4		$B0      
			Ds4		$B0      
			F4		$B0      
			Fs4		$B0      
			Ds4		$B0      
			As4		$16      
			As4		$16      
			As4		$16      
			As4		$16      
			As4		$16      
			REST		$2C      
			As4		$16      
			REST		$2C      
			As4		$58      
			REST		$2C  
			
WRunTrack0Loop1:	LOAD_PATCH	2
			CALL_SUB	WRunTrack0Sub1
			LOAD_PATCH	3
			CALL_SUB	WRunTrack0Sub2	
			REST		$B0
			LOOP		0, 2, WRunTrack0Loop1
			
			LOAD_PATCH	1
			
WRunTrack0Loop2		Fs4		$B0         
			Ds4		$B0         
			Ds4		$B0         
			F4		$B0     
			LOOP		0, 4, WRunTrack0Loop2
			
			LOAD_PATCH	4
			CALL_SUB	WRunTrack0Sub3
			REST		$6E
			LOAD_PATCH	3
			CALL_SUB	WRunTrack0Sub4
			LOAD_PATCH	5
			CALL_SUB	WRunTrack0Sub5
			CALL_SUB	WRunTrack0Sub6
			CALL_SUB	WRunTrack0Sub7
			CALL_SUB	WRunTrack0Sub8
			CALL_SUB	WRunTrack0Sub9
			CALL_SUB	WRunTrack0Sub10
			CALL_SUB	WRunTrack0Sub11
			
			P_BEND_START            
			PITCH_BEND	Fs2, Fs2, $58			; no pitch bend applied to first note
			SEAMLESS					; seamlessly transition into second note (tie)
			PITCH_BEND	Fs2, Cs2, $58			; apply pitch bend to second note
			P_BEND_END            

			LOOP_FOREVER	WRunTrack0MainLoop		; start again from beginning
			

WRunTrack0Sub1:		Fs4		$58            
			Fs4		$16         
			F4		$16         
			Fs4		$16         
			Gs4		$6E            
			Gs4		$16           
			Fs4		$16         
			Gs4		$16         
			As4		$42                     
			Ds5		$16 
			REST		$16         
			Gs4		$2C            
			Fs4		$16            
			Gs4		$6E                     
			Fs4		$16           
			Gs4		$2C 
			
			As4		$C6  
			SEAMLESS					; seamlessly transition into next note (tie)
			As4		$B0
			P_BEND_END					; a.k.a. SEAMLESS_END
			
			REST		$B0            
			REST		$B0            
			Fs4		$58            
			Fs4		$16 
			F4		$16 
			Fs4		$16 
			Gs4		$6E            
			Gs4		$16           
			Fs4		$16         
			Gs4		$16         
			As4		$42                     
			Ds5		$16           
			REST		$16         
			Gs4		$2C                     
			Fs4		$16            
			Gs4		$42            
			Fs4		$2C            
			Gs4		$2C            
			F4		$2C            
			Fs4		$16 
			
			Ds4		$9A
			SEAMLESS					; seamlessly transition into next note (tie)
			Ds4		$B0
			P_BEND_END					; a.k.a. SEAMLESS_END
			
			REST		$B0            
			REST		$B0  
			          
			RETURN


WRunTrack0Sub2:		REST		$42            
			Fs4		$16            
			F4		$2C         
			Cs4		$16            
			Gs3		$42         
			REST		$16            
			Fs4		$16         
			F4		$2C         
			Cs4		$16            
			As3		$6E         
			REST		$58            
			REST		$B0            
			REST		$42            
			Fs4		$16            
			F4		$2C         
			Cs4		$16            
			Gs3		$42         
			REST		$16            
			Fs4		$16         
			F4		$2C         
			Cs4		$16            
			Ds4		$6E         
			REST		$58            
			REST		$B0            
			REST		$6E            
			Fs3		$16         
			As3		$16 
			Cs4		$16      
			B3		$2C         
			Ds4		$16            
			Fs4		$2C         
			Gs4		$2C            
			Fs4		$16            
			F4		$84            
			Cs4		$16 
			As3		$9A            
			REST		$2C            
			REST		$6E            
			Fs3		$16         
			As3		$16      
			Cs4		$16         
			B3		$2C            
			Ds4		$2C            
			Fs4		$16 
			Gs4		$2C            
			Fs4		$16  
			          
			F4		$0B     
			SEAMLESS					; slur (as pitch of second note differs from pitch of first note)
			Fs4		$0B
			P_BEND_END                       
			
			F4		$58            
			REST		$42   
			         
			RETURN
 
 
 
WRunTrack0Sub3:		F5		$0B
			E5		$0B            
			As4		$0B            
			F4		$0B 
			LOOP		0, 4, WRunTrack0Sub3
       
WRunTrack0Loop3:	Ds5		$0B            
			B4		$0B            
			Gs4		$0B            
			Ds4		$0B    
			LOOP		0, 4, WRunTrack0Loop3
			LOOP		1, 2, WRunTrack0Sub3
			
			RETURN
 

WRunTrack0Sub4:		Fs4		$16            
			F4		$16         
			Ds4		$16         
			Gs4		$2C            
			Fs4		$16         
			F4		$2C            
			Fs4		$2C            
			Gs4		$16            
			F4		$84                     
			Cs4		$16           
			As3		$9A                     
			REST		$2C            
			REST		$6E            
			Fs3		$16         
			As3		$16      
			Cs4		$16         
			B3		$2C            
			Ds4		$2C            
			Fs4		$16 
			Gs4		$2C            
			Fs4		$16            
			F4		$0B                    
			Fs4		$0B                    
			F4		$58            
			REST		$42            
			REST		$B0
			            
			RETURN


WRunTrack0Sub5:		Ds5		$0B            
			F5		$21 
			Fs5		$16      
			KEY_FRACTION	1
			Ds5		$6E      
			KEY_FRACTION	0
			
			RETURN


WRunTrack0Sub6:		Fs4		$16 

			Gs4		$0B            
			SEAMLESS					; seamlessly transition into next note (slur)
			As4		$21 
			P_BEND_END					; a.k.a. SEAMLESS_END

			Gs4		$0B            
			Fs4		$0B            
			Gs4		$16 
			Fs4		$16 
			F4		$16 
			Fs4		$16 
			F4		$16 
			Cs4		$84            
			As3		$0B 
			Cs4		$0B            

WRunTrack0Loop4:	Cs4		$0B            
			Ds4		$0B            
			Cs4		$0B            
			As3		$0B    
			LOOP		0, 4, WRunTrack0Loop4

			
			F4		$0B            
			Fs4		$0B            
			Gs4		$0B            
			As4		$0B            
			Gs4		$0B            
			Fs4		$0B            
			F4		$0B            
			Ds4		$0B            
			F4		$2C            
			Ds4		$16 
			Cs4		$16 
			F4		$16 
			Cs4		$16 
			Ds4		$16 
			B3		$16 
			Cs4		$16 
			As3		$16 
			B3		$16 
			Gs3		$16 
			Fs4		$2C            
			F4		$16 
			Ds4		$16 
			Gs4		$16 
			Fs4		$16 
			F4		$16 
			Ds4		$16 
			F4		$16 
			Fs4		$16 
			Ds4		$16 
			Cs4		$16 
			REST		$16 
			
			P_BEND_START
			PITCH_BEND	Gs4, Gs4, $0B	
			SEAMLESS					; tie
			PITCH_BEND	Gs4, As4, $0B					
			P_BEND_END
			
			As4		$16 
			Cs5		$16
			 
			RETURN


WRunTrack0Sub7:		P_BEND_START
			PITCH_BEND	Cs5, Cs5, $0B				
			SEAMLESS					; tie
			PITCH_BEND	Cs5, Ds5, $0B 
			P_BEND_END
			
			Ds5		$16 
			
			Ds5		$2C            
			SEAMLESS					; tie
			KEY_FRACTION	1				; supposed to slightly alter pitch of next note but effect is barely noticable
			Ds5		$42      
			P_BEND_END					; a.k.a. SEAMLESS_END
			
			KEY_FRACTION	0
			
			Ds5		$08            
			Cs5		$07            
			As4		$07
			            
			RETURN


WRunTrack0Sub8:		P_BEND_START
			PITCH_BEND	Cs5, Ds5, $09            
			SEAMLESS					; tie
			PITCH_BEND	Ds5, Ds5, $09            
			P_BEND_END					; pitch bend/seamless note transition off
			
			Ds5		$08            
			Cs5		$09            
			As4		$09  
			
			LOOP		0, 4, WRunTrack0Sub8
			          
			P_BEND_START
			PITCH_BEND	Cs5, Ds5, $09            
			SEAMLESS					; tie
			PITCH_BEND	Ds5, Ds5, $09            
			P_BEND_END					; pitch bend/seamless note transition off
			
			Ds5		$08            
			Fs5		$09            
			Ds5		$09            
			F5		$0B            
			Ds5		$0B            
			Cs5		$0B            
			Ds5		$0B            
			Cs5		$0B            
			As4		$0B            
			Cs5		$0B            
			As4		$0B            
			Gs4		$0B            
			As4		$0B            
			Gs4		$0B            
			Fs4		$0B            
			Gs4		$0B            
			Fs4		$0B            
			Ds4		$0B            
			Fs4		$0B            
			F4		$0B            
			Ds4		$0B            
			F4		$0B            
			Cs4		$0B            
			Ds4		$0B            
			F4		$0B            
			Fs4		$0B            
			Ds4		$0B            
			F4		$0B            
			Fs4		$0B            
			Gs4		$0B            
			F4		$0B            
			Fs4		$0B            
			Gs4		$0B            
			As4		$0B            
			Fs4		$0B            
			Gs4		$0B            
			As4		$0B            
			B4		$0B            
			Gs4		$0B            
			As4		$2C            
			Gs4		$16        
			Fs4		$16         
			F4		$16         
			Fs4		$16         
			F4		$16         
			Cs4		$6E            
			Ds4		$16           
			Cs4		$16         
			Ds4		$16        
			F4		$16         
			Ds4		$16         
			F4		$16        
			Fs4		$16         
			F4		$16         
			Fs4		$16         
			Gs4		$16         
			Fs4		$16         
			Gs4		$16         
			As4		$16         
			Gs4		$16         
			As4		$2C      
			               
			RETURN


WRunTrack0Sub9:		Ds4		$0B            
			Cs4		$0B            
			Ds4		$16         
			F4		$0B            
			Ds4		$0B            
			F4		$16         
			Fs4		$0B            
			F4		$0B            
			Fs4		$16 
			Gs4		$0B            
			Fs4		$0B            
			Gs4		$16 
			F4		$0F            
			Ds4		$0F            
			F4		$0E 
			Fs4		$0F            
			F4		$0F            
			Fs4		$0E 
			Gs4		$0F            
			Fs4		$0F            
			Gs4		$0E 
			As4		$0F            
			Gs4		$0F            
			As4		$0E 
			Fs4		$2C            
			Gs4		$16 
			Fs4		$16 
			Ds4		$16 
			As3		$16 
	
			SEAMLESS					; slur
			Gs3		$16         
			P_BEND_END					; a.k.a. SEAMLESS_END
			Fs3		$16  
			       
			RETURN


WRunTrack0Sub10:	Cs4		$0B            
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
			P_BEND_END					; pitch bend/seamless note transition off
			
			Fs4		$0B            
			KEY_FRACTION	1
			Gs4		$58      
			KEY_FRACTION	0
			
			RETURN


WRunTrack0Sub11: 	Ds4		$0B            
			Cs4		$0B            
			Ds4		$0B            
			F4		$0B            
			Fs4		$0B            
			Ds4		$0B            
			F4		$0B            
			Fs4		$0B            
			Gs4		$0B            
			F4		$0B            
			Fs4		$0B            
			Gs4		$0B            
			As4		$0B            
			Fs4		$0B            
			Gs4		$0B            
			As4		$0B            
			B4		$0B            
			Gs4		$0B            
			As4		$0B            
			B4		$0B            
			Cs5		$0B            
			As4		$0B            
			B4		$0B            
			Cs5		$0B            
			Ds5		$0B            
			Gs4		$0B            
			F5		$0B            
			Gs4		$0B            
			Fs5		$0B            
			Gs4		$0B            
			F5		$0B            
			Gs4		$0B    
			        
			P_BEND_START            
			PITCH_BEND	F5, F5, $0B            
			SEAMLESS					; tie
			PITCH_BEND	F5, Fs5, $0B       
			PITCH_BEND	Fs5, Fs5, $16 
			P_BEND_END         
			
			F5		$16 
			Cs5		$2C            
			As4		$2C            
			Fs4		$16 
			
			P_BEND_START         
			PITCH_BEND	Gs4, Gs4, $0B            
			SEAMLESS					; tie
			PITCH_BEND	Gs4, As4, $0B
			PITCH_BEND	As4, Gs4, $0B            
			P_BEND_END            
			
			Fs4		$0B            
			Gs4		$16 
			Fs4		$42            
			REST		$2C            
			Ds4		$16 
			
			P_BEND_START         
			PITCH_BEND	As3, As3, $0B      
			SEAMLESS					; tie
			PITCH_BEND	As3, Gs3, $0B
			PITCH_BEND	Gs3, Gs3, $16 
			P_BEND_END         
			
			Fs3		$16         
			Gs3		$16         
			Fs3		$16         
			Ds3		$16 
			Fs3		$16 
			
			RETURN
