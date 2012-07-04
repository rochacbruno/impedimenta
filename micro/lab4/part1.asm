;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; This is a standard code template.
;
; Homework part 1. Turn on and off an led. That's it. In my code, I'll be
; turning on and off PTB:0
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

; Enable an LED as output
	lda	PTBDD
	ora	#%00000001
	sta	PTBDD

;/*----------------------------------------------------------------------------/
; Main Loop
;/----------------------------------------------------------------------------*/
Start: 

; Turn off LED. LEDs are active low.
	lda	PTBD
	ora	#%00000001
	sta	PTBD

; Turn on LED.
	lda	PTBD
	and	#%11111110
	sta	PTBD

; Turn off LED again
	lda	PTBD
	ora	#%00000001
	sta	PTBD


end:    BRA    end

;/*----------------------------------------------------------------------------/
; Subroutine Definitions
;/----------------------------------------------------------------------------*/

