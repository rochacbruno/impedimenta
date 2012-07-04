;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; This is a standard code template.
;
; Create functions that can be used to delay the chip for a certain amount of
; time. Use these functions to blink LEDs at 10Hz. That's it: blink, blink,
; blink.
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

; Enable all four LEDs
	lda	PTBDD
	ora	#%00001111
	sta	PTBDD

;/*----------------------------------------------------------------------------/
; Main Loop
;/----------------------------------------------------------------------------*/
Start: 

	lda	PTBD
	ora	#%00001111	; Turn off all four LEDs
	sta	PTBD

BLINK_10HZ
	lda	PTBD
	eor	#%00001111	; Invert the state of all the LEDs
	sta	PTBD
	jsr	DELAY_100MS	; Blink LEDs at 10Hz
	bra	BLINK_10HZ

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
; Subroutine to delay by 100ms
;/------------------------------------*/
DELAY_100MS
	psha
	lda	#100

DELAY_100MS_LOOP
	jsr	DELAY_1MS
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

;/*------------------------------------/
; Subroutine to delay by XH milliseconds. Does not change XH registers.
;
; The structure of this subroutine warrants an explanation. The MC9S08QG8 chip
; offers no decrement command that will decrement X and H as if they were one
; single register. Thus, logic must be implemented to decrement them as if they
; were one single register.
;
; Th logic below will perform a series of branching checks. If H is zero, check
; X. If X is zero, perform some action. Else, perform some other action... so on
; and so forth. Depending upon the status of the two registers, an action will
; be taken. Here is the chart of actions:
; H == 0, X == 0: done
; H == 0, X != 0: decrement X
; H != 0, X != 0: decrement X
; H != 0, X == 0: dech, X = ff
;/------------------------------------*/
;DELAY_HXMS
;	psha
;	delay_hxms_hx ds 2
;	cphx	delay_hxms_hx
;
;DELAY_HXMS_START
;	lda	1,delay_hxms_hx
;	bit	#%11111111
;	beq	DELAY_HXMS_HEQ0		; If H is equal to zero, branch here.
;	bra	DELAY_HXMS_HNE0		; Else, branch here.
;
;DELAY_HXMS_HEQ0
;	lda	0,delay_hxms_hx
;	bit	#%11111111
;	beq	DELAY_HXMS_DONE		; If X is also equal to zero, done.
;	deca				; Otherwise, adjust counter.
;	sta	0,delay_hxms_hx
;
;DELAY_HXMS_HNE0
;	lda	0,delay_hxms_hx
;	bit	#%11111111
;	
;	
;
;DELAY_HXMS_DONE
;	pula
;	rts
