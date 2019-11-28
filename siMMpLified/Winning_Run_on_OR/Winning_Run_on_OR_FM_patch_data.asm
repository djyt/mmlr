
;                                                   ***** SET TABS TO 8 *****

;--------------------------------------------------------------------------------------------------------------------------------;
;-------------------------------------------------------- FM patch data ---------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; It would be advisable to have the YM 2151 manual open whilst reading this source, to understand better how sounds are created. ;
;                                                                                                                                ; 
; In the OR audio program FM sound patches are stored as 26 tuples of (register,value) plus an all-important terminating byte.   ;
; In the SHO audio program FM sound patches are stored as 25 bytes of value data with no terminating byte (the register comes    ;
; from a lookup table at $0904) (PMS_AMS is set to zero for ALL sound patches by the patch loading code @ $08fa)                 ;
; The patches below have been 'converted' from 25-byte SHO format to 53-byte OR format.                                          ;
;                                                                                                                                ;
; In OR patches are assigned per tune whereas in SHO the patches are global.                                                     ;
; Winning Run uses 11 distinct FM sound patches.  Splash Wave/Magical Sound Shower/Last Wave all share the same                  ;
; bank of 14 patches.  Passing Breeze has its own set of 7 patches.                                                              ;
;                                                                                                                                ;
; I'd strongly recommend the VOPM VSTi plug-in (https://www.kvraudio.com/product/vopm-by-sam) with your favourite DAW for        ;
; patch editing purposes, but be aware that, by default, it emulates a clock input of 3.58MHz and you'll need to change that to  ;
; 4MHz (via sending a few MIDI control codes) to match the 4MHz driven YM2151 of OR, or the patches will sound incorrect.        ;
; Details of how to change the input clock frequency are in the VOPM user manual.                                                ;
;--------------------------------------------------------------------------------------------------------------------------------;

; pointers to the 11 patches used in this tune
WinningRunFMPatchData:	defw	WRunPatch1				; originally patch $14 in SHO
			defw	WRunPatch2				; originally patch $0b
			defw	WRunPatch3				; originally patch $10
			defw	WRunPatch4				; originally patch $0d
			defw	WRunPatch5				; originally patch $12
			defw	WRunPatch6				; originally patch $0e
			defw	WRunPatch7				; originally patch $11
			defw	WRunPatch8				; originally patch $13
			defw	WRunPatch9				; originally patch $0c
			defw	WRunPatch10				; originally patch $0a
			defw	WRunPatch11				; originally patch $0f

;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 1 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $14 data                                                                                                             ;
; 0CF3: FC			; RL (right/left), FB (feedback level), CONNECT (operator arrangement)                           ;
; 0CF4: 1E 10 20 12		; TL (total level) for all 4 operators (M1/C1/M2/C2)                                             ;
; 0CF8: 14 12 14 12		; KS (key scaling) and AR (attack rate) for all 4 ops (M1/C1/M2/C2)                              ;
; 0CFC: 32 33 63 01		; DT1 (detune 1) and MUL (phase multiplier) for all 4 ops (M1/C1/M2/C2)                          ;
; 0D00: 04 0A 04 0A		; D1R (decay 1 rate) and AMS-ON (amp mod sensitivity) for all 4 ops (M1/C1/M2/C2)                ;
; 0D04: 02 08 04 08		; DT2 (detune 2) and D2R (decay 2 rate) for all 4 ops (M1/C1/M2/C2)                              ;
; 0D08: 12 17 12 16		; D1L (decay 1 level) and RR (release rate) for all 4 ops (M1/C1/M2/C2)                          ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch1:		defb	TL_M1,		$1e			; total level
			defb	TL_C1,		$10
			defb	TL_M2,		$20
			defb	TL_C2,		$12
			
			defb	KS_AR_M1,	$14			; key scaling / attack rate
			defb	KS_AR_C1,	$12
			defb	KS_AR_M2,	$14
			defb	KS_AR_C2,	$12
			
			defb	DT1_MUL_M1,	$32			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$33
			defb	DT1_MUL_M2,	$63
			defb	DT1_MUL_C2,	$01
			
			defb	D1R_M1,		4			; decay 1 rate
			defb	D1R_C1,		10
			defb	D1R_M2,		4
			defb	D1R_C2,		10
			
			defb	DT2_D2R_M1,	2			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	8
			defb	DT2_D2R_M2,	4
			defb	DT2_D2R_C2,	8
			
			defb	D1L_RR_M1,	$12			; decay 1 level / release rate
			defb	D1L_RR_C1,	$17
			defb	D1L_RR_M2,	$12
			defb	D1L_RR_C2,	$16
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$fc			; right/left, feedback level, operator connections
		
			defb	2					; terminating byte
			

;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 2 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;	 
; SHO patch $0b data                                                                                                             ;
; 0C12: BC                                                                                                                       ;
; 0C13: 1E 0A 1E 0B                                                                                                              ;
; 0C17: 14 12 14 12                                                                                                              ;
; 0C1B: 32 33 62 01                                                                                                              ;
; 0C1F: 04 06 04 06                                                                                                              ;
; 0C23: 02 04 04 04                                                                                                              ;
; 0C27: 12 16 12 15                                                                                                              ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch2:		defb	TL_M1,		$1e			; total level
			defb	TL_C1,		$0a
			defb	TL_M2,		$1e
			defb	TL_C2,		$0b
			
			defb	KS_AR_M1,	$14			; key scaling / attack rate
			defb	KS_AR_C1,	$12
			defb	KS_AR_M2,	$14
			defb	KS_AR_C2,	$12
			
			defb	DT1_MUL_M1,	$32			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$33
			defb	DT1_MUL_M2,	$62
			defb	DT1_MUL_C2,	$01
			
			defb	D1R_M1,		4			; decay 1 rate
			defb	D1R_C1,		6
			defb	D1R_M2,		4
			defb	D1R_C2,		6
			
			defb	DT2_D2R_M1,	2			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	4
			defb	DT2_D2R_M2,	4
			defb	DT2_D2R_C2,	4
			
			defb	D1L_RR_M1,	$12			; decay 1 level / release rate
			defb	D1L_RR_C1,	$16
			defb	D1L_RR_M2,	$12
			defb	D1L_RR_C2,	$15
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$bc			; right/left, feedback level, operator connections

			defb	2					; terminating byte


;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 3 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $10 data                                                                                                             ;
; 0C8F: 7C                                                                                                                       ;
; 0C90: 20 08 20 0B                                                                                                              ;
; 0C94: 12 10 14 10                                                                                                              ;
; 0C98: 31 43 62 01                                                                                                              ;
; 0C9C: 04 08 04 08                                                                                                              ;
; 0CA0: 02 05 04 07                                                                                                              ;
; 0CA4: 12 15 12 15                                                                                                              ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch3:		defb	TL_M1,		$20			; total level
			defb	TL_C1,		$08
			defb	TL_M2,		$20
			defb	TL_C2,		$0b
			
			defb	KS_AR_M1,	$12			; key scaling / attack rate
			defb	KS_AR_C1,	$10
			defb	KS_AR_M2,	$14
			defb	KS_AR_C2,	$10
			
			defb	DT1_MUL_M1,	$31			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$43
			defb	DT1_MUL_M2,	$62
			defb	DT1_MUL_C2,	$01
			
			defb	D1R_M1,		4			; decay 1 rate
			defb	D1R_C1,		8
			defb	D1R_M2,		4
			defb	D1R_C2,		8
			
			defb	DT2_D2R_M1,	2			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	5
			defb	DT2_D2R_M2,	4
			defb	DT2_D2R_C2,	7
			
			defb	D1L_RR_M1,	$12			; decay 1 level / release rate
			defb	D1L_RR_C1,	$15
			defb	D1L_RR_M2,	$12
			defb	D1L_RR_C2,	$15
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$7c			; right/left, feedback level, operator connections
	
			defb	2					; terminating byte
			

;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 4 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $0d data                                                                                                             ;
; 0C44: BC                                                                                                                       ;
; 0C45: 1E 16 20 18                                                                                                              ;
; 0C49: 14 0E 14 0E                                                                                                              ;
; 0C4D: 32 33 63 01                                                                                                              ;
; 0C51: 04 08 04 08                                                                                                              ;
; 0C55: 02 05 04 07                                                                                                              ;
; 0C59: 12 16 12 16                                                                                                              ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch4:		defb	TL_M1,		$1e			; total level
			defb	TL_C1,		$16
			defb	TL_M2,		$20
			defb	TL_C2,		$18
			
			defb	KS_AR_M1,	$14			; key scaling / attack rate
			defb	KS_AR_C1,	$0e
			defb	KS_AR_M2,	$14
			defb	KS_AR_C2,	$0e
			
			defb	DT1_MUL_M1,	$32			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$33
			defb	DT1_MUL_M2,	$63
			defb	DT1_MUL_C2,	$01
			
			defb	D1R_M1,		4			; decay 1 rate
			defb	D1R_C1,		8
			defb	D1R_M2,		4
			defb	D1R_C2,		8
			
			defb	DT2_D2R_M1,	2			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	5
			defb	DT2_D2R_M2,	4
			defb	DT2_D2R_C2,	7
			
			defb	D1L_RR_M1,	$12			; decay 1 level / release rate
			defb	D1L_RR_C1,	$16
			defb	D1L_RR_M2,	$12
			defb	D1L_RR_C2,	$16
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$bc			; right/left, feedback level, operator connections

			defb	2					; terminating byte


;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 5 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $12 data                                                                                                             ;
; 0CC1: BA                                                                                                                       ;
; 0CC2: 1E 1C 24 06                                                                                                              ;
; 0CC6: 50 18 18 90                                                                                                              ;
; 0CCA: 32 21 62 01                                                                                                              ;
; 0CCE: 02 02 02 04                                                                                                              ;
; 0CD2: 03 04 02 04                                                                                                              ;
; 0CD6: 12 12 12 15                                                                                                              ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch5:		defb	TL_M1,		$1e			; total level
			defb	TL_C1,		$1c
			defb	TL_M2,		$24
			defb	TL_C2,		$06
			
			defb	KS_AR_M1,	$50			; key scaling / attack rate
			defb	KS_AR_C1,	$18
			defb	KS_AR_M2,	$18
			defb	KS_AR_C2,	$90
			
			defb	DT1_MUL_M1,	$32			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$21
			defb	DT1_MUL_M2,	$62
			defb	DT1_MUL_C2,	$01
			
			defb	D1R_M1,		2			; decay 1 rate
			defb	D1R_C1,		2
			defb	D1R_M2,		2
			defb	D1R_C2,		4
			
			defb	DT2_D2R_M1,	3			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	4
			defb	DT2_D2R_M2,	2
			defb	DT2_D2R_C2,	4
			
			defb	D1L_RR_M1,	$12			; decay 1 level / release rate
			defb	D1L_RR_C1,	$12
			defb	D1L_RR_M2,	$12
			defb	D1L_RR_C2,	$15
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$ba			; right/left, feedback level, operator connections

			defb	2					; terminating byte
			
			
;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 6 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $0e data                                                                                                             ;
; 0C5D: 7C                                                                                                                       ;
; 0C5E: 20 12 20 14                                                                                                              ;
; 0C62: 14 0E 14 0E                                                                                                              ;
; 0C66: 32 33 62 01                                                                                                              ;
; 0C6A: 04 06 04 06                                                                                                              ;
; 0C6E: 02 04 04 04                                                                                                              ;
; 0C72: 12 16 12 15                                                                                                              ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch6:		defb	TL_M1,		$20			; total level
			defb	TL_C1,		$12
			defb	TL_M2,		$20
			defb	TL_C2,		$14
			
			defb	KS_AR_M1,	$14			; key scaling / attack rate
			defb	KS_AR_C1,	$0e
			defb	KS_AR_M2,	$14
			defb	KS_AR_C2,	$0e
			
			defb	DT1_MUL_M1,	$32			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$33
			defb	DT1_MUL_M2,	$62
			defb	DT1_MUL_C2,	$01
			
			defb	D1R_M1,		4			; decay 1 rate
			defb	D1R_C1,		6
			defb	D1R_M2,		4
			defb	D1R_C2,		6
			
			defb	DT2_D2R_M1,	2			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	4
			defb	DT2_D2R_M2,	4
			defb	DT2_D2R_C2,	4
			
			defb	D1L_RR_M1,	$12			; decay 1 level / release rate
			defb	D1L_RR_C1,	$16
			defb	D1L_RR_M2,	$12
			defb	D1L_RR_C2,	$15
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$7c			; right/left, feedback level, operator connections

			defb	2					; terminating byte


;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 7 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $11 data                                                                                                             ;
; 0CA8: BC                                                                                                                       ;
; 0CA9: 22 0E 24 10                                                                                                              ;
; 0CAD: 12 10 14 10                                                                                                              ;
; 0CB1: 31 43 62 01                                                                                                              ;
; 0CB5: 04 08 04 08                                                                                                              ;
; 0CB9: 02 05 04 07                                                                                                              ;
; 0CBD: 12 15 12 15                                                                                                              ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch7:		defb	TL_M1,		$22			; total level
			defb	TL_C1,		$0e
			defb	TL_M2,		$24
			defb	TL_C2,		$10
			
			defb	KS_AR_M1,	$12			; key scaling / attack rate
			defb	KS_AR_C1,	$10
			defb	KS_AR_M2,	$14
			defb	KS_AR_C2,	$10
			
			defb	DT1_MUL_M1,	$31			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$43
			defb	DT1_MUL_M2,	$62
			defb	DT1_MUL_C2,	$01
			
			defb	D1R_M1,		4			; decay 1 rate
			defb	D1R_C1,		8
			defb	D1R_M2,		4
			defb	D1R_C2,		8
			
			defb	DT2_D2R_M1,	2			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	5
			defb	DT2_D2R_M2,	4
			defb	DT2_D2R_C2,	7
			
			defb	D1L_RR_M1,	$12			; decay 1 level / release rate
			defb	D1L_RR_C1,	$15
			defb	D1L_RR_M2,	$12
			defb	D1L_RR_C2,	$15
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$bc			; right/left, feedback level, operator connections

			defb	2					; terminating byte


;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 8 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $13 data                                                                                                             ;
; 0CDA: 7A                                                                                                                       ;
; 0CDB: 20 1C 25 10                                                                                                              ;
; 0CDF: 50 18 18 90                                                                                                              ;
; 0CE3: 32 21 62 01                                                                                                              ;
; 0CE7: 02 02 02 04                                                                                                              ;
; 0CEB: 03 04 02 04                                                                                                              ;
; 0CEF: 12 12 12 15                                                                                                              ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch8:		defb	TL_M1,		$20			; total level
			defb	TL_C1,		$1c
			defb	TL_M2,		$25
			defb	TL_C2,		$10
			
			defb	KS_AR_M1,	$50			; key scaling / attack rate
			defb	KS_AR_C1,	$18
			defb	KS_AR_M2,	$18
			defb	KS_AR_C2,	$90
			
			defb	DT1_MUL_M1,	$32			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$21
			defb	DT1_MUL_M2,	$62
			defb	DT1_MUL_C2,	$01
			
			defb	D1R_M1,		2			; decay 1 rate
			defb	D1R_C1,		2
			defb	D1R_M2,		2
			defb	D1R_C2,		4
			
			defb	DT2_D2R_M1,	3			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	4
			defb	DT2_D2R_M2,	2
			defb	DT2_D2R_C2,	4
			
			defb	D1L_RR_M1,	$12			; decay 1 level / release rate
			defb	D1L_RR_C1,	$12
			defb	D1L_RR_M2,	$12
			defb	D1L_RR_C2,	$15
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$7a			; right/left, feedback level, operator connections

			defb	2					; terminating byte


;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 9 ------------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $0c data - this patch is used for the bass line of Winning Run                                                       ;
; 0C2B: F9			; %11111001 = enable both left and right channels, feedback level 7, op arrangement = 1          ;
; 0C2C: 18			; TL (bits 0-6) = $18 for M1                                                                     ;
; 0C2D: 1E			; TL = $1e for C1                                                                                ;
; 0C2E: 21			; TL = $21 for M2                                                                                ;
; 0C2F: 00 			; TL = 0 for C2                                                                                  ;
; 0C30: 5F      		; %01011111 - KS (bits 6-7) = 1, AR (bits 0-4) = $1f for M1                                      ;
; 0C31: 5F            		; %01011111 = KS = 1, AR = $1f for C1                                                            ;
; 0C32: 5F			; %01011111 = KS = 1, AR = $1f for M2                                                            ;
; 0C33: 5F            		; %01011111 = KS = 1, AR = $1f for C2                                                            ;
; 0C34: 00            		; DT1 (bits 4-6) = 0, MUL (bits 0-3) = 0 for M1                                                  ;
; 0C35: 00            		; DT1 = 0, MUL = 0 for C1                                                                        ;
; 0C36: 01 			; DT1 = 0, MUL = 1 for M2                                                                        ;
; 0C37: 01 			; DT1 = 0, MUL = 1 for C2                                                                        ;
; 0C38: 0E      		; %00001110 - D1R (bits 0-4) = $e, AMS-ON (bit 7) = off for M1                                   ;
; 0C39: 0F            		; %00001111 - DIR = $f, AMS-ON = off for C1                                                      ;
; 0C3A: 0C            		; %00001100 - DIR = $c, AMS-ON = off for M2                                                      ;
; 0C3B: 0C            		; %00001100 - DIR = $c, AMS-ON = off for C2                                                      ;
; 0C3C: 07            		; %00000111 - DT2 (bits 6-7) = 0, D2R (bits 0-4) = 7 for M1                                      ;
; 0C3D: 02            		; DT2 = 0, D2R = 2 for C1                                                                        ;
; 0C3E: 02            		; DT2 = 0, D2R = 2 for M2                                                                        ;
; 0C3F: 02            		; DT2 = 0, D2R = 2 for C2                                                                        ;
; 0C40: 38 			; %00111000 - D1L (bits 4-7) = 3, RR (bits 0-3) = 8 for M1                                       ;
; 0C41: 08         		; D1L = 0, RR = 8 for C1                                                                         ;
; 0C42: 08            		; D1L = 0, RR = 8 for M2                                                                         ;
; 0C43: 48            		; D1L = 4, RR = 8 for C2                                                                         ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch9:		defb	TL_M1,		$18			; total level
			defb	TL_C1,		$1e
			defb	TL_M2,		$21
			defb	TL_C2,		0
			
			defb	KS_AR_M1,	$5f			; key scaling / attack rate
			defb	KS_AR_C1,	$5f
			defb	KS_AR_M2,	$5f
			defb	KS_AR_C2,	$5f
			
			defb	DT1_MUL_M1,	0			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	0
			defb	DT1_MUL_M2,	1
			defb	DT1_MUL_C2,	1
			
			defb	D1R_M1,		$0e			; decay 1 rate
			defb	D1R_C1,		$0f
			defb	D1R_M2,		$0c
			defb	D1R_C2,		$0c
			
			defb	DT2_D2R_M1,	7			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	2
			defb	DT2_D2R_M2,	2
			defb	DT2_D2R_C2,	2
			
			defb	D1L_RR_M1,	$38			; decay 1 level / release rate
			defb	D1L_RR_C1,	8
			defb	D1L_RR_M2,	8
			defb	D1L_RR_C2,	$48
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$f9			; right/left, feedback level, operator connections

			defb	2					; terminating byte

	
;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 10 -----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $0a data                                                                                                             ;
; 0BF9: FA 			; RL/FB/CON                                                                                      ;
; 0BFA: 22 24 28 0E      	; TL (total attenuation level)                                                                   ;
; 0BFE: 5F 1F 1F 9C            	; KS (key scaling) and AR (attack rate) for all 4 ops (KS = bits 6 and 7, AR = bits 0-4)         ;
; 0C02: 33 21 61 01      	; DT1 (detune 1) and MUL (multiplier) for all 4 ops (DT1 = bits 4-6, MUL = bits 0-3)             ;
; 0C06: 04 04 04 06 		; D1R (decay 1 rate) and AMS-ON (amplitude modulation sensitivity) for all 4 ops                 ;
; 0C0A: 03 04 02 06 		; DT2 (detune 2) and D2R for all 4 ops (DT2 = bits 6 and 7) (D2R = bits 0-4)                     ;
; 0C0E: 25 25 15 06 		; D1L (decay 1 level) and RR (release rate) for all 4 ops (D1L = bits 4-7, RR = bits 0-3)        ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch10:		defb	TL_M1,		$22			; total level
			defb	TL_C1,		$24
			defb	TL_M2,		$28
			defb	TL_C2,		$0e
			
			defb	KS_AR_M1,	$5f			; key scaling / attack rate
			defb	KS_AR_C1,	$1f
			defb	KS_AR_M2,	$1f
			defb	KS_AR_C2,	$9c
			
			defb	DT1_MUL_M1,	$33			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$21
			defb	DT1_MUL_M2,	$61
			defb	DT1_MUL_C2,	1
			
			defb	D1R_M1,		4			; decay 1 rate
			defb	D1R_C1,		4
			defb	D1R_M2,		4
			defb	D1R_C2,		6
			
			defb	DT2_D2R_M1,	3			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	4
			defb	DT2_D2R_M2,	2
			defb	DT2_D2R_C2,	6
			
			defb	D1L_RR_M1,	$25			; decay 1 level / release rate
			defb	D1L_RR_C1,	$25
			defb	D1L_RR_M2,	$15
			defb	D1L_RR_C2,	6
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$fa			; right/left, feedback level, operator connections

			defb	2					; terminating byte


;--------------------------------------------------------------------------------------------------------------------------------;
;----------------------------------------------------------- Patch 11 -----------------------------------------------------------;
;--------------------------------------------------------------------------------------------------------------------------------;
; SHO patch $0f data                                                                                                             ;
; 0C76: FA                                                                                                                       ;
; 0C77: 22 24 1E 08                                                                                                              ;
; 0C7B: 5F 1F 1F 9C                                                                                                              ;
; 0C7F: 32 21 60 01                                                                                                              ;
; 0C83: 04 04 04 06                                                                                                              ;
; 0C86: 03 04 02 06                                                                                                              ;
; 0C8A: 25 25 15 06                                                                                                              ;
;--------------------------------------------------------------------------------------------------------------------------------;

WRunPatch11:		defb	TL_M1,		$22			; total level
			defb	TL_C1,		$24
			defb	TL_M2,		$1e
			defb	TL_C2,		8
			
			defb	KS_AR_M1,	$5f			; key scaling / attack rate
			defb	KS_AR_C1,	$1f
			defb	KS_AR_M2,	$1f
			defb	KS_AR_C2,	$9c
			
			defb	DT1_MUL_M1,	$32			; detune 1 / phase multiplier
			defb	DT1_MUL_C1,	$21
			defb	DT1_MUL_M2,	$60
			defb	DT1_MUL_C2,	1
			
			defb	D1R_M1,		4			; decay 1 rate
			defb	D1R_C1,		4
			defb	D1R_M2,		4
			defb	D1R_C2,		6
			
			defb	DT2_D2R_M1,	3			; detune 2 / decay 2 rate
			defb	DT2_D2R_C1,	4
			defb	DT2_D2R_M2,	2
			defb	DT2_D2R_C2,	6
			
			defb	D1L_RR_M1,	$25			; decay 1 level / release rate
			defb	D1L_RR_C1,	$25
			defb	D1L_RR_M2,	$15
			defb	D1L_RR_C2,	6
			
			defb	PMS_AMS,	0			; phase and amplitude modulation sensitivity
			
			defb	RL_FB_CONNECT,	$fa			; right/left, feedback level, operator connections

			defb	2					; terminating byte

