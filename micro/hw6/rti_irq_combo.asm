;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; This is a standard code template.
;
; Homework 6 coding challenge. Blink LED4 at approx 10 Hz using RTIs. In reality, I'll be blinking the light once every 128 ms, but that's close enough for my purposes.
; Blink LED5 50 times at 20 Hz using IRQs. IRQ is falling edge triggered.
;
; This code is meant to be used with the MC9S08QG8 chip. On my board, switches
; and LEDs are connected to the registers as shown here:
; LED3 = PTBD:3
; LED4 = PTBD:2
; LED5 = PTBD:1
; LED6 = PTBD:0
; S1 = PTAD:3
; S2 = PTAD:2
; S3 = PTAD:1
; S4 = PTAD:5
;/----------------------------------------------------------------------------*/
;*******************************************************************************
; START STANDARD CODE
;*******************************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF _Startup, main
            ; we export both '_Startup' and 'main' as symbols. Either can
            ; be referenced in the linker .prm file or from C/C++ later on
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack

; variable/data section
MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition

;****************************************
;  RAM variables here 
;****************************************

DEFAULT_ROM			SECTION

;****************************************
;  ROM variables here
;****************************************
;ROM_table    dc   $45,%01000010,$32,$fc,0

;****************************************
; code section
;****************************************
MyCode:     SECTION
          
main:
_Startup:
            LDHX   #__SEG_END_SSTACK ; initialize the stack pointer
            TXS
            CLI                     ; enable interrupts
            lda #$52                ; disable COP
            sta SOPT1
;*******************************************************************************
; END STANDARD CODE
;*******************************************************************************

;/*----------------------------------------------------------------------------/
; Initialize Registers
;/----------------------------------------------------------------------------*/
; setup LED 4 and 5 as outputs
	lda	PTBDD
	ora	#%00000110
	sta	PTBDD

; Turn off both LEDs for a consistent starting point.
	lda	PTBD
	ora	#%00000110	; active low
	sta	PTBD

; enable PTA:5 (S4) as IRQ input.
	lda	PTADD
	and	#%11011111
	sta	PTADD

; enable IRQs
	lda	IRQSC
	and	#%00000000
	ora	#%00010010	; falling edge interrupt
	sta	IRQSC

; enable RTIs
	lda	SRTISC
	and	#%00000000
	ora	#%00010100	; enable RTI every 128 ms
	sta	SRTISC

;/*----------------------------------------------------------------------------/
; Main Loop
;/----------------------------------------------------------------------------*/
Start: 

; Main loop does nothing. IRQs and RTIs take care of all the action.

end:    BRA    end

;/*----------------------------------------------------------------------------/
; Subroutine Definitions
;/----------------------------------------------------------------------------*/
;/*------------------------------------/
; IRQ: blink LED 5 50 times at 20 Hz
;/------------------------------------*/
IRQ_SR

	ldx	#50		; Blink LED 50 times. This is the counter

IRQ_SR_BLINKAGAIN

	lda	PTBD
	eor	#%00000010	; invert LED 5
	sta	PTBD
	jsr	DELAY_10MS
	jsr	DELAY_10MS
	jsr	DELAY_1MS
	jsr	DELAY_1MS
	jsr	DELAY_1MS
	jsr	DELAY_1MS
	jsr	DELAY_1MS	; LED spends 25 ms on...

	lda	PTBD
	eor	#%00000010	; invert LED 5
	sta	PTBD
	jsr	DELAY_10MS
	jsr	DELAY_10MS
	jsr	DELAY_1MS
	jsr	DELAY_1MS
	jsr	DELAY_1MS
	jsr	DELAY_1MS	; and LED spends 25 ms off. Total cycle takes
	jsr	DELAY_1MS	; 50 ms. A 50 ms cycle produces 20 Hz blink.

	decx			; Decrement counter
	txa			; Put counter in A
	bne	IRQ_SR_BLINKAGAIN	; If counter has not reached zero, 
				; blink again
	lda	IRQSC
	ora	#%00000100
	sta	IRQSC
	rti			; If counter has reached zero, end IRQ

;/*------------------------------------/
; RTI: blink LED 4 at 10 Hz
;/------------------------------------*/
RTI_SR
	lda	PTBD
	eor	#%00000100	; invert LED 4, will be called again in 128 ms
	sta	PTBD

	lda	SRTISC
	ora	#%01000000	; RTIACK. Clear RTI flag.
	sta	SRTISC
	rti

;/*------------------------------------/
; Subroutine to delay by 10us
;/------------------------------------*/
DELAY_10US
	psha
	lda	#8

DELAY_10US_LOOP
	deca
	bne	DELAY_10US_LOOP

	pula
	rts

;/*------------------------------------/
; Subroutine to delay by 100us
;/------------------------------------*/
DELAY_100US
	psha
	lda	#10

DELAY_100US_LOOP
	jsr	DELAY_10US
	deca
	bne	DELAY_100US_LOOP

	pula
	rts

;/*------------------------------------/
; Subroutine to delay by 1ms
;/------------------------------------*/
DELAY_1MS
	psha
	lda	#10

DELAY_1MS_LOOP
	jsr	DELAY_100US
	deca
	bne	DELAY_1MS_LOOP

	pula
	rts

;/*------------------------------------/
; Subroutine to delay by 10ms
;/------------------------------------*/
DELAY_10MS
	psha
	lda	#10

DELAY_10MS_LOOP
	jsr	DELAY_1MS
	deca
	bne	DELAY_10MS_LOOP

	pula
	rts

;/*------------------------------------/
; Subroutine to delay by 100ms
;/------------------------------------*/
DELAY_100MS
	psha
	lda	#10

DELAY_100MS_LOOP
	jsr	DELAY_10MS
	deca
	bne	DELAY_100MS_LOOP

	pula
	rts

;/*------------------------------------/
; Subroutine to delay by 1s
;/------------------------------------*/
DELAY_1S
	psha
	lda	#10

DELAY_1S_LOOP
	jsr	DELAY_100MS
	deca
	bne	DELAY_1S_LOOP

	pula
	rts

;/*----------------------------------------------------------------------------/
; Vector Interrupt Table Definitions
;/----------------------------------------------------------------------------*/
; IRQ
	org	$fffa
	dc.w	IRQ_SR

; RTI
	org	$ffd0
	dc.w	RTI_SR
