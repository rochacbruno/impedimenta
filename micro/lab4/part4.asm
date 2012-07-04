;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; This is a standard code template.
;
; In this program, S1 and S2 are used to blink LEDs. If S1 is pushed, then the
; LEDs are blinked 20 times at 50 Hz. If the button stays pushed in, then the
; LEDs will not continue blinking. In fact, the chip will not respond to any
; other button presses if the button stays pushed in.
;
; If S2 is pushed, then the LEDs are blinked 20 times at 50 Hz. If the button
; stays pushed in, then the LEDs will continue blinking. The chip will not
; respond to any other button presses as long as the button stays pushed in.
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

counter ds 1

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

; Setup all four LEDs as outputs.
	lda	PTBDD
	ora	#%00001111
	sta	PTBDD

; Setup S1 and S2 as inputs
	lda	PTADD
	and	#%11110011
	sta	PTADD

; S1 and S2 need to be pulled up
	lda	PTAPE
	ora	#%00001100
	sta	PTAPE

; Turn off LEDs so they all blink in tandem
	lda	PTBD
	ora	#%00001111
	sta	PTBD

;/*----------------------------------------------------------------------------/
; Main Loop
;/----------------------------------------------------------------------------*/
Start: 

	lda	PTAD
	bit	#%00001000	; Check if S1 is pushed in
	beq	S1_PUSHED
	bit	#%00000100	; check if S2 is pushed in
	beq	S2_PUSHED
	bra	Start

S1_PUSHED
	jsr	BLINK_20_50HZ
S1_PUSHED_STILL
	lda	PTAD
	bit	#%00001000
	beq	S1_PUSHED_STILL	; If S1 still pushed, do NOT blink LEDs again.
	bra	Start

S2_PUSHED
	jsr	BLINK_20_50HZ
	lda	PTAD
	bit	#%00000100
	beq	S2_PUSHED	; If S2 still pushed, DO blink LEDs again.
	bra	Start

end:    BRA    end

;/*----------------------------------------------------------------------------/
; Subroutine Definitions
;/----------------------------------------------------------------------------*/

;/*------------------------------------/
; Subroutine to blink LEDs 20 times at 50 Hz
;/------------------------------------*/

BLINK_20_50HZ
	psha
	pshx
	mov	#20,counter	; Blink LEDs 20 times.

BLINK_20_50HZ_LOOP
	lda	PTBD
	eor	#%00001111  ; Invert all four LEDs
	sta	PTBD
	jsr	DELAY_10MS
	jsr	DELAY_10MS	; 20ms delay creates 50 Hz flash

	ldx counter
	decx            ; decrement the counter
	stx counter

  lda counter
	bit	#%11111111	; Has the counter reached zero?
	bne	BLINK_20_50HZ_LOOP	; If counter has not reached zero, blink again.
	
	pulx
	pula
	rts			; If counter has reached zero, finish blinking.

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

