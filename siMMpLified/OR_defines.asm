
;                                             ***** SET TABS TO 8 *****

; start addresses of original 4 tunes for easy ORG'ing purposes
PassingBreeze		EQU	$0e26			; keep your tune + FM patches length to $12a2 or less
SplashWave		EQU	$20c8			; keep your tune + FM patches length to $1f99 or less
MagicalSound		EQU	$3d5f			; keep your tune + FM patches length to $24d0 or less
LastWave		EQU	$5f2d			; keep your tune + FM patches length to $0a6a or less


; addresses of 2 original FM patch banks (Passing Breeze has its own patch bank, the other 3 tunes share the same patch bank)
PassingBreezePatchBank	EQU	$1ed6			; 7 patches in this bank
SplashWavePatchBank	EQU	$6695			; 14 patches in this bank (used by 3 tunes)


; various flags used on first byte of each track data structure (TODO - make this better!)
TRACK_DISABLED		EQU	0			; bit 7 clear = track disabled
SEAMLESS_BIT		EQU	1			; bit 0 (backported from SHO) (not originally supported by OR)
NOISE_BIT		EQU	2			; bit 1
TRACK_MUTE_BIT		EQU	4			; bit 2 (used to mute an FM channel to 'free it up' for other purposes, such a checkpoint beeps, etc)
UNKNOWN_BIT		EQU	8			; bit 3 (set/reset by commands $8f and $90 but no tunes appear to use this bit)
PITCH_BEND_BIT		EQU	$20			; bit 5
TRACK_ENABLED		EQU	$80			; if bit 7 is set then track is enabled


; track type and index
FM_TRACK_0		EQU	$80			; low 3-bits dictates channel used on YM2151, giving 8 channels for 8 note polyphony
FM_TRACK_1		EQU	$81			; if bit 7 set (AND bit 6 clear) then this is an FM track
FM_TRACK_2		EQU	$82
FM_TRACK_3		EQU	$83
FM_TRACK_4		EQU	$84
FM_TRACK_5		EQU	$85
FM_TRACK_6		EQU	$86
FM_TRACK_7		EQU	$87

PCM_TRACK_0		EQU	$40			; if bit 6 set (AND bit 7 clear) then this is a PCM track
PCM_TRACK_1		EQU	$41
PCM_TRACK_2		EQU	$42
PCM_TRACK_3		EQU	$43
PCM_TRACK_4		EQU	$44



; command language defines
CMD_TEMPO		EQU	$81			; change tempo of track (only possible for non-FIXED_TEMPO tracks)
CMD_SAMPLE_LEVEL	EQU	$82			; set sample left/right volume
CMD_SEAMLESS		EQU	$83			; make use of unused command $83 for 'seamless' note transitions
CMD_END_FM_TRACK	EQU	$84			; end playback of this FM track (DO NOT USE ON PCM TRACKS)
CMD_NOISE_ON		EQU	$85			; set noise bit (only works on FM track 7)
CMD_SET_TL		EQU	$86			; only partially working (can't use bits 0 and 1)
CMD_KEY_FRACTIONS	EQU	$87			; little to no audible difference
CMD_CALL		EQU	$88			; call a subroutine
CMD_RET			EQU	$89			; return from a subroutine
CMD_LOOP_FOREVER	EQU	$8a			; self explanatory
CMD_TRANSPOSE		EQU	$8b			; transpose subsequent notes up or down
CMD_LOOP		EQU	$8c			; loop n number of times (allows nested loops via second parameter)
CMD_PITCH_BEND_START	EQU	$8d			; pitch bend start
CMD_PITCH_BEND_END	EQU	$8e			; pitch bend AND 'seamless' end
CMD_LOAD_PATCH		EQU	$91			; load new FM patch data into the sound chip registers
CMD_NOISE_OFF		EQU	$92			; clear noise bit (set by cmd $85)
CMD_VOICE_PITCH		EQU	$93			; set pitch of PCM voice like 'Checkpoint' or 'Get Ready'
CMD_FIXED_TEMPO		EQU	$94			; note duration is read directly from track rather than being computed
CMD_LONG		EQU	$95			; used for 'long' notes, rests and percussion samples
CMD_RIGHT_CH_ONLY	EQU	$96			; send FM output to right channel/speaker only
CMD_LEFT_CH_ONLY	EQU	$97			; send FM output to left channel/speaker only
CMD_BOTH_CH		EQU	$98			; send FM output to both channels/speakers


; drum/percussion defines (fixed pitch)
OPEN_HI_HAT_SAMPLE	EQU	$c0			; SHO sample $01
CLOSED_HI_HAT_SAMPLE	EQU	$c1			; SHO sample $04
SNARE_DRUM1_SAMPLE	EQU	$c2			; SHO sample $03
TOM_TOM_LO_SAMPLE	EQU	$c3			; SHO sample $02
WOOD_RIM_SAMPLE		EQU	$c4			; NOT IN SHO (at least I *think* it's supposed to be a wood rim!!)
RIM_SHOT_SAMPLE		EQU	$c5			; NOT IN SHO (at least I *think* it's supposed to be a rim shot!!)
KICK_DRUM_SAMPLE	EQU	$c6			; SHO sample $06
TOM_TOM_MID_SAMPLE	EQU	$c7			; SHO sample $07
TOM_TOM_HI_SAMPLE	EQU	$c8			; SHO sample $08
CRASH_CYMBAL_SAMPLE	EQU	$c9			; SHO sample $0A
HAND_CLAP_SAMPLE	EQU	$ca			; NOT IN SHO
SHAKER_SAMPLE		EQU	$cb			; NOT IN SHO
SNARE_DRUM2_SAMPLE	EQU	$cc			; NOT IN SHO
RIDE_CYMBAL_SAMPLE	EQU	$cd			; SHO sample $09
FINGER_SNAP_SAMPLE	EQU	$ce			; NOT IN SHO


; voice samples (variable pitch) (default pitch used by game is $48)
CHECKPOINT_VOICE	EQU	$dc
CONGRATS_VOICE		EQU	$dd
GET_READY_VOICE		EQU	$de



; YM 2151 register assignments for loading patch data (refer to YM2151 manual for further info on how these work to make sounds)
RL_FB_CONNECT		EQU	$20			; right/left (bits 6-7) / feedback level (bits 3-5) / operator connections (bits 0-2)

PMS_AMS			EQU	$38			; phase modulation sensitivty (bits 4-6) / amplitude modulation sensitivity (bits 0-1)

DT1_MUL_M1		EQU	$40			; detune 1 (bits 4-6) / phase multiply (bits 0-3)
DT1_MUL_M2		EQU	$48
DT1_MUL_C1		EQU	$50
DT1_MUL_C2		EQU	$58

TL_M1			EQU	$60			; total level (bits 0-6)
TL_M2			EQU	$68
TL_C1			EQU	$70
TL_C2			EQU	$78

KS_AR_M1		EQU	$80			; key scaling (bits 6-7) / attack rate (bits 0-4)
KS_AR_M2		EQU	$88
KS_AR_C1		EQU	$90
KS_AR_C2		EQU	$98

D1R_M1			EQU	$a0			; decay 1 rate (bits 0-4)     (AMS-EN is bit 7)
D1R_M2			EQU	$a8
D1R_C1			EQU	$b0
D1R_C2			EQU	$b8

DT2_D2R_M1		EQU	$c0			; detune 2 (bits 6-7) / decay 2 rate (bits 0-4)
DT2_D2R_M2		EQU	$c8
DT2_D2R_C1		EQU	$d0
DT2_D2R_C2		EQU	$d8

D1L_RR_M1		EQU	$e0			; decay 1 level (bits 4-7) / release rate (bits 0-3)
D1L_RR_M2		EQU	$e8
D1L_RR_C1		EQU	$f0
D1L_RR_C2		EQU	$f8



; MIDI note numbers (including all enharmonic equivalents)
C_1			EQU	$00			; C-1
Cs_1			EQU	$01			; C#-1
Db_1			EQU	$01			; D flat -1
D_1			EQU	$02			; D-1
Ds_1			EQU	$03			; D#-1
Eb_1			EQU	$03			; E flat -1
E_1			EQU	$04			; E-1
F_1			EQU	$05			; F-1
Fs_1			EQU	$06			; F#-1
Gb_1			EQU	$06			; G flat -1
G_1			EQU	$07			; G-1
Gs_1			EQU	$08			; G#-1
Ab_1			EQU	$08			; A flat -1
A_1			EQU	$09			; A-1
As_1			EQU	$0a			; A#-1
Bb_1			EQU	$0a			; B flat -1
B_1			EQU	$0b			; B-1

C0			EQU	$0c
Cs0			EQU	$0d
Db0			EQU	$0d
D0			EQU	$0e
Ds0			EQU	$0f
Eb0			EQU	$0f
E0			EQU	$10
F0			EQU	$11
Fs0			EQU	$12
Gb0			EQU	$12
G0			EQU	$13
Gs0			EQU	$14
Ab0			EQU	$14
A0			EQU	$15
As0			EQU	$16
Bb0			EQU	$16
B0			EQU	$17

C1			EQU	$18
Cs1			EQU	$19
Db1			EQU	$19
D1			EQU	$1a
Ds1			EQU	$1b
Eb1			EQU	$1b
E1			EQU	$1c
F1			EQU	$1d
Fs1			EQU	$1e
Gb1			EQU	$1e
G1			EQU	$1f
Gs1			EQU	$20
Ab1			EQU	$20
A1			EQU	$21
As1			EQU	$22
Bb1			EQU	$22
B1			EQU	$23

C2			EQU	$24
Cs2			EQU	$25
Db2			EQU	$25
D2			EQU	$26
Ds2			EQU	$27
Eb2			EQU	$27
E2			EQU	$28
F2			EQU	$29
Fs2			EQU	$2a
Gb2			EQU	$2a
G2			EQU	$2b
Gs2			EQU	$2c
Ab2			EQU	$2c
A2			EQU	$2d
As2			EQU	$2e
Bb2			EQU	$2e
B2			EQU	$2f

C3			EQU	$30
Cs3			EQU	$31			; C#3
Db3			EQU	$31			; D flat 3
D3			EQU	$32
Ds3			EQU	$33			; D#3
Eb3			EQU	$33			; E flat 3
E3			EQU	$34
F3			EQU	$35
Fs3			EQU	$36			; F#3
Gb3			EQU	$36			; G flat 3
G3			EQU	$37
Gs3			EQU	$38			; G#3
Ab3			EQU	$38			; A flat 3
A3			EQU	$39
As3			EQU	$3a			; A#3
Bb3			EQU	$3a			; B flat 3
B3			EQU	$3b

C4			EQU	$3c
Cs4			EQU	$3d
Db4			EQU	$3d
D4			EQU	$3e
Ds4			EQU	$3f
Eb4			EQU	$3f
E4			EQU	$40
F4			EQU	$41
Fs4			EQU	$42
Gb4			EQU	$42
G4			EQU	$43
Gs4			EQU	$44
Ab4			EQU	$44
A4			EQU	$45
As4			EQU	$46
Bb4			EQU	$46
B4			EQU	$47

C5			EQU	$48
Cs5			EQU	$49
Db5			EQU	$49
D5			EQU	$4a
Ds5			EQU	$4b
Eb5			EQU	$4b
E5			EQU	$4c
F5			EQU	$4d
Fs5			EQU	$4e
Gb5			EQU	$4e
G5			EQU	$4f
Gs5			EQU	$50
Ab5			EQU	$50
A5			EQU	$51
As5			EQU	$52
Bb5			EQU	$52
B5			EQU	$53

C6			EQU	$54
Cs6			EQU	$55
Db6			EQU	$55
D6			EQU	$56
Ds6			EQU	$57
Eb6			EQU	$57
E6			EQU	$58
F6			EQU	$59
Fs6			EQU	$5a
Gb6			EQU	$5a
G6			EQU	$5b
Gs6			EQU	$5c
Ab6			EQU	$5c
A6			EQU	$5d
As6			EQU	$5e
Bb6			EQU	$5e
B6			EQU	$5f
