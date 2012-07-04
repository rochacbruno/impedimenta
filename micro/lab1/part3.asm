;*******************************************************************
;  Observe the LED in the SPYDER08 as you run this program.
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

var1:  ds.b 1
var2   ds.b 1



; code section
MyCode:     SECTION
main:
_Startup:
            LDHX   #__SEG_END_SSTACK ; initialize the stack pointer
            TXS
            CLI                     ; enable interrupts


            ; Insert your code here
            
            lda #$01
            sta PTADD    ; make the 1st pin an output pin
            
mainLoop:            
             
            lda PTAD    ;load the port into A
            jsr delay_100ms
           
            eor #$01    ;toggle the pin
           
            
            sta PTAD    ;restore the value
            jsr delay_100ms
           
            
            NOP

            feed_watchdog
            BRA    mainLoop
            
            
            ;Utilities is a file where we will store our assorted applications



delay_10us    psha
              lda #7
dly_lp1:      deca
              bne dly_lp1              
              pula
              rts

delay_100us    psha
              lda #10
dly_lp2:      jsr delay_10us
              deca
              bne dly_lp2              
              pula
              rts

delay_1ms    psha
              lda #10
dly_lp3:      jsr delay_100us
              deca
              bne dly_lp3              
              pula
              rts

delay_100ms    psha
              lda #100
dly_lp4:      jsr delay_1ms
              deca
              bne dly_lp4              
              
              pula
              rts
