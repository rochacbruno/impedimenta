;*******************************************************************************
; Jeremy Audet
; Micro -- Matt Gallagher
; Homework for week 3: use a pair of switches to turn on and off a corresponding
; pair of LEDs. 
;*******************************************************************************

;*******************************************************************************
; Initialize registers
;*******************************************************************************
lda	PTADD
and	#%11110011
sta	PTADD

lda	PTAPE
ora	#%00001100
sta	PTAPE

lda	PTBDD
ora	#%00001100
sta	PTBDD

;*******************************************************************************
; Check if S1 is on
;*******************************************************************************
CHECK_S1
lda	PTAD
bit	#%00001000
beq	LED3_ON
lda	PTAD
bit	#%00001000
bne	LED3_OFF

LED3_ON
lda	PTBD
ora	#%00001000
sta	PTBD
bra	CHECK_S2

LED3_OFF
lda	PTBD
and	#%11110111
sta	PTBD
bra	CHECK_S2

;*******************************************************************************
; Check if S2 is on
;*******************************************************************************
CHECK_S2
lda	PTAD
bit	#%00000100
beq	LED4_ON
lda	PTAD
bit	#%00000100
bne	LED4_OFF

LED4_ON
lda	PTBD
ora	#%00000100
sta	PTBD
bra	CHECK_S1

LED4_OFF
lda	PTBD
and	#%11111011
sta	PTBD
bra	CHECK_S1