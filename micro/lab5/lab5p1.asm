;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; This is a standard code template.
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

; setup LED 5 and 6 as output.
	lda	PTBDD
	ora	#%00000011
	sta	PTBDD
	
; turn off LEDs for a consistent starting point
	lda	PTBD
	ora	#%00000011	; active low
	sta	PTBD
	
; enable S1 as input
	lda	PTADD
	and	#%11110111
	sta	PTADD
	
; S1 needs to be pulled up
	lda	PTAPE
	ora	#%00001000
	sta	PTAPE

;/*----------------------------------------------------------------------------/
; Main Loop
;/----------------------------------------------------------------------------*/
Start: 

; check to see if S1 is pushed in
	lda	PTAD
	bit	#%00001000
	beq	BLINK_LED_5	; If it is, blink LED 5 at 20Hz
	
; if S1 not pushed in, blink LED 6 once at 10 Hz and start over again
	lda	PTBD
	eor	#%00000001	; invert LED 6
	sta	PTBD
	jsr DELAY_100MS	; 100ms delay produces 10 Hz blink
	
	lda	PTBD
	eor	#%00000001
	sta	PTBD
	jsr DELAY_100MS
	
	bra	Start

;/*------------------------------------/
; Blink LED 5 at 20Hz
;/------------------------------------*/
BLINK_LED_5

	lda	PTBD
	eor	#%00000010	; Invert LED 5
	sta	PTBD
	jsr DELAY_10MS
	jsr DELAY_10MS
	jsr DELAY_10MS
	jsr DELAY_10MS
	jsr DELAY_10MS	; 50ms delay produces 20Hz blink
	
	lda	PTBD
	eor	#%00000010	; Invert LED 5
	sta	PTBD
	jsr DELAY_10MS
	jsr DELAY_10MS
	jsr DELAY_10MS
	jsr DELAY_10MS
	jsr DELAY_10MS	; 50ms delay produces 20Hz blink
	
	bra	Start

end:    BRA    end

;/*----------------------------------------------------------------------------/
; Subroutine Definitions
;/----------------------------------------------------------------------------*/

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