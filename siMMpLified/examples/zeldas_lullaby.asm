; SET TABS TO 8
; First 8 bars of Zelda's Lullaby - (c) Nintendo 1998
;
;  pasmo --bin zeldas_lullaby.asm zelda.bin
;  paste the assembled binary into OR audio program @ 20c8
;  choose Splash Wave from music selection screen or MUSIC 3 from SOUND TEST of service mode

			INCLUDE		../OR_defines.asm
			INCLUDE		../OR_macros.asm
			
			ORG		SplashWave		; let's stomp all over Splash Wave @ $20c8
		
PianoLow		EQU		1
PianoMid		EQU		2
			
; master tune header
testTune:		defw		trackHeaderPointers
			defw		$6997
			defw		$6997
			defw		FMPatches		
	
; track header pointers		
trackHeaderPointers:	defb		13			; 13 tracks but we're only using 3 of them

			defw		FMtrack0		; pointer to FM track 0 header
			defw		FMtrack1
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			
			defw		PCMtrack0		; 1 PCM track in this tune
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack
			defw		unusedTrack

unusedTrack:		defw		0			; all unused tracks point here


; track headers			
FMtrack0:		defb		TRACK_ENABLED
			defb		FM_TRACK_0
			defb		1			; tempo
			defw		0
			defw		1
			defw		track0			; pointer to track data
			defb		0			; transpose
			defb		32			; byte offset to 'stack' for subroutines
			defb		0
			defb		0
			defb		0		

FMtrack1:		defb		TRACK_ENABLED
			defb		FM_TRACK_1
			defb		1			; tempo
			defw		0
			defw		1
			defw		track1			; pointer to track data
			defb		0			; transpose
			defb		32			
			defb		0
			defb		0
			defb		0
			
PCMtrack0:		defb		TRACK_ENABLED
			defb		PCM_TRACK_0
			defb		1			; tempo
			defw		0
			defw		1
			defw		pcmTrack0		; pointer to track data
			defb		0
			defb		32
			defb		0
			defb		0
			defb		0
			
			


; track data
track0:			LOAD_PATCH	PianoMid		; electric piano from Last Wave

			CALL_SUB	track0sub		; bar 1 (subroutine)
			
			A3		140			; bar 2
			G3		35
			A3		35
		
			CALL_SUB	track0sub		; bar 3 (subroutine)
		
			A3		210			; bar 4
		
			CALL_SUB	track0sub		; bar 5 (subroutine)
		
			A4		140			; bar 6
			G4		70
		
			D4		140			; bar 7
			C4		35
			B3		35
		
			A3		210			; bar 8

			LOOP_FOREVER	track0+2		; loop forever from first CALL_SUB
		
			
track0sub:		B3		140
			D4		70
			RETURN			
		
		
		
track1:			LOAD_PATCH	PianoLow
			
			C1		35			; bar 1
			G1		35
			E2		140
			
			C1		35			; bar 2
			A1		35
			Fs2		140
			
			C1		35			; bar 3
			G1		35
			E2		140
			
			C1		35			; bar 4
			A1		35
			Fs2		140
			
			B0		35			; bar 5
			D2		35
			A2		140
			
			As0		35			; bar 6
			Cs2		35
			G2		140
			
			A0		35			; bar 7
			C2		35
			G2		140
			
			D1		35			; bar 8
			A1		35
			Fs2		140
					
			LOOP_FOREVER	track1+2		; loop forever from 1st note of track
			
	
; this is completely out of place in Zelda's lullaby but what the heck!	
pcmTrack0:		SAMPLE_VOL	63,63
			TOM_TOM_L	35
			REST		35
			TOM_TOM_M	35
			REST		35
			TOM_TOM_H	35
			REST		35
			LOOP		0,16,pcmTrack0+3
			
loop:			REST		210
			LOOP_FOREVER	loop			; loop forever on a rest to 'silence' the drum track
			
				
		
; FM patch data		
FMPatches:		defw		patch1			; piano low
			defw		patch2			; use Last Wave patch 14 (electric piano)
		
patch1:			defb		TL_M1,		$32
			defb		TL_C1,		$45
			defb		TL_M2,		$42
			defb		TL_C2, 		0
			defb		KS_AR_M1,	$1f
			defb		KS_AR_C1,	$9f
			defb		KS_AR_M2,	$5f
			defb		KS_AR_C2,	$5f
			defb		DT1_MUL_M1,	1
			defb		DT1_MUL_C1,	4
			defb		DT1_MUL_M2,	5
			defb		DT1_MUL_C2,	3
			defb		D1R_M1,		0
			defb		D1R_C1,		0
			defb		D1R_M2,		0
			defb		D1R_C2,		0
			defb		DT2_D2R_M1,	7
			defb		DT2_D2R_C1,	11
			defb		DT2_D2R_M2,	0
			defb		DT2_D2R_C2,	10
			defb		D1L_RR_M1,	4
			defb		D1L_RR_M1,	4
			defb		D1L_RR_M1,	0
			defb		D1L_RR_M1,	7
			defb		PMS_AMS,	0
			defb		RL_FB_CONNECT,	$c2

			defb		2			; terminating byte
				

; this is an exmample of how to use a pre-existing patch from another tune's patch bank
patch2:			defb		3			; this indicates that a pointer will follow
			defw		SplashWavePatchBank+(13*53) ; each patch is 53 bytes in size
		
			; no terminating byte required when using this approach 
		
		