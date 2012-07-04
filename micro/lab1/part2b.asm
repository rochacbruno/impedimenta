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
            ; we export both '_Startup' and 'main' as symbols. Either can
            ; be referenced in the linker .prm file or from C/C++ later on

            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack


; variable/data section
MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition

;*********************************************************
mainLoop:
            ; Insert your code here
            lda #$01
            sta PTADD    ; make the 1st pin an output pin
            
            mov #$10,var1   ;use var1 as a counter.  Count from $10
            
loop1:      
             
            lda PTAD    ;load the port into A
            eor #$01    ;toggle the pin
            sta PTAD    ;restore the value
             dec var1   ;decrement the counter
            bne loop1   ;keep looping while var1 is not equal to 0. bne "Branch Not Equal"
            
            NOP

            feed_watchdog
            BRA    mainLoop

;*********************************************************