; the 'insert coin' sound from the game
;
;  pasmo --bin insert_coin.asm insert_coin.bin
;  paste into OR at $20c8
;  play MUSIC 3 from service mode

			INCLUDE		../OR_defines.asm
			INCLUDe		../OR_macros.asm
			
			ORG		SplashWave
			
InsertCoin:		defw		tuneHeaders
			defw		$6ae9			; point TL adjustments at original rom data
			defw		$6ae9			; point key fractions at original rom data
			defw		insertCoinPatchData								
			
tuneHeaders:		defb		1			; should really define all 13 tracks but i'm lazy here!

			defw		track0header
			
track0header:		defb		TRACK_ENABLED			
			defb		FM_TRACK_0		; track 0 / patch bank 0
			defb		2			; tempo 
			defw		0				
			defw		1				
			defw		track0			
			defb		0				
			defb		$20				
			defb		0				
			defb		0			
			defb		0				
			
track0:			LOAD_PATCH	1
			KEY_FRACTION	1
			Ds2		2
			Gs2		2
			As2		2
			C3		2
			Ds3		2
			Gs3		2
			As3		2
			C4		2
			As3		2
			Gs3		2
			Ds3		2
			C3		2
			As2		2
			Gs2		20
			REST		35
			END_FM_TRACK   
			
insertCoinPatchData:	defw		patchData
		
patchData:		defb		3			; a pointer follows this
			defw		$6b10			; use the original patch data from the rom