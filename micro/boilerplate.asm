;/*-===========================================================================/
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
;/===========================================================================-*/

;/*-===========================================================================/
; START STANDARD CODE TEMPLATE
;/===========================================================================-*/
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF _Startup, main
            ; we export both '_Startup' and 'main' as symbols. Either can
            ; be referenced in the linker .prm file or from C/C++ later on
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack

; variable/data section
MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition

;/*-===================================/
;  RAM variables here 
;/===================================-*/
; key	ds	1

DEFAULT_ROM			SECTION

;/*-===================================/
;  ROM variables here
;/===================================-*/
;ROM_table    dc   $45,%01000010,$32,$fc,0

;/*-===================================/
; code section
;/===================================-*/
MyCode:     SECTION
          
main:
_Startup:
    LDHX   #__SEG_END_SSTACK    ; initialize the stack pointer
    jsr     initializeIo        ; disable COP, pull up all inputs

;/*-===================================/
; END STANDARD CODE TEMPLATE
;/===================================-*/
; Phew! Time to get to some actual code.

;/*-===========================================================================/
; Initialize Registers
;/===========================================================================-*/

;/*-===========================================================================/
; Main Loop
;/===========================================================================-*/
Start: 



end:    BRA    end

;/*-===========================================================================/
; Subroutine Definitions
;/===========================================================================-*/



;/*-===========================================================================/
; Vector Interrupt Table Definitions
;/===========================================================================-*/

