;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF _Startup, main
           
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack




Const:  equ   20


MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition

     

DEFAULT_ROM			SECTION
    
temp3    dc   $45

; code section
MyCode:     SECTION
main:
_Startup:
            LDHX   #__SEG_END_SSTACK ; initialize the stack pointer
            TXS
            CLI                     ; enable interrupts

mainLoop:
            ; Insert your code here
            
            
            lda #76
            add #5
            sta $68
            clra
            lda $68
            add #$13
            
            
            
end:        nop
            BRA    end
