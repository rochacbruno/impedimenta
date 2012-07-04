;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; This is a standard code template.
;
; Lab 4, part 2. Turn on one of two LEDs, depending upon whether S1 is pressed
; in. If S1 is pressed in, turn on LED3. Else, turn on LED4. I assume that these
; actions are mutually exclusive; that is, if LED3 is on, LED 4 should be of.
; Similarly, if LED4 is on, LED3 should be off.
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

; Enable LED3 and LED4 as output
	lda	PTBDD
	ora	#%00001100
	sta	PTBDD

; Enable S1 as input
	lda	PTADD
	and	#%11110111
	sta	PTADD

; Switches are active low. Need S1 to be pulled up.
	lda	PTAPE
	ora	#%00001000
	sta	PTAPE

;/*----------------------------------------------------------------------------/
; Main Loop
;/----------------------------------------------------------------------------*/
;*******************
Start: 
;*******************
; Check to see if S1 is pushed in. Active low. If pushed in, then PTAD will be
; xxxx0xxx. If not pushed in, PTAD will be xxxx1xxx.
	lda	PTAD
	bit	#%00001000
	beq	LED3_ON		; If pressed, turn on LED3 (exclusive).
	bra	LED4_ON		; Else, turn on LED4 (exclusive).

;*******************
LED3_ON
;*******************
	lda	PTBD
	and	#%11110111	; Turn on LED3 (LEDs are active low)
	ora	#%00000100	; Turn off LED4
	sta	PTBD

	bra	Start

;*******************
LED4_ON
;*******************
	lda	PTBD
	and	#%11111011	; Turn on LED4 (LEDs are active low)
	ora	#%00001000	; Turn off LED3
	sta	PTBD

	bra	Start

end:    BRA    end

;/*----------------------------------------------------------------------------/
; Subroutine Definitions
;/----------------------------------------------------------------------------*/

