;*******************************************************************************
; Jeremy Audet
; Micro -- Matt Gallagher
; Homework for week 4: Use SW1-SW4 to affect LED3-LED6.
;
; A note on the program:
;
; LED3 = PTBD:3
; LED4 = PTBD:2
; LED5 = PTBD:1
; LED6 = PTBD:0
;
; S1 = PTAD:3
; S2 = PTAD:2
; S3 = PTAD:1
; S4 = PTAD:5
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

;*******************************************************************
;  RAM variables here 
;*******************************************************************        



;*******************************************************************

DEFAULT_ROM			SECTION

;*******************************************************************
;  ROM variables here
;*******************************************************************    
;ROM_table    dc   $45,%01000010,$32,$fc,0

;*******************************************************************
; code section
;*******************************************************************
MyCode:     SECTION
          
main:
_Startup:
            LDHX   #__SEG_END_SSTACK ; initialize the stack pointer
            TXS
            CLI                     ; enable interrupts
            lda #$52                ; disable COP
            sta SOPT1
            
;/*----------------------------------------------------------------------------/
; Main Program Starts Here
;/----------------------------------------------------------------------------*/
          
;*******************************************************************************
; Initialize registers
;*******************************************************************************
; These four pins are connected to leds.
    lda	PTBDD
    ora	#%00001111
    sta	PTBDD

; These four pins are connected to input switches. Must be pulled up.
    lda	PTAPE
    ora	#%00101110
    sta	PTAPE	
    lda PTADD	
    and	#%00000000
    sta	PTADD

;*******************************************************************************
; Check S1
;*******************************************************************************
CHECK_S1
    lda	PTAD
    bit	#%00001000
    bne	CHECK_S2	; If s1 pushed in, continue and execute the code below.
                  ; Otherwise, skip ahead and check switch 2.
   
   
    lda	PTBD
    ora	#%00000111  ; Turn off other three LEDs (set registers to 1, active low)
    and	#%11110111  ; Turn on corresponding LED (set register to 0, active low)
    sta	PTBD

;*******************************************************************************
; Check S2
;*******************************************************************************
CHECK_S2
    lda	PTAD
    bit	#%00000100
    bne	CHECK_S3
    
    
    lda	PTBD
    ora	#%00001011
    and	#%11111011
    sta 	PTBD

;*******************************************************************************
; Check S3
;*******************************************************************************
CHECK_S3     
    lda	PTAD
    bit	#%00000010
    bne	CHECK_S4
   
    lda	PTBD
    ora	#%00001101
    and	#%11111101
    sta 	PTBD

;*******************************************************************************
; Check S4
;*******************************************************************************
CHECK_S4
    lda	PTAD
    bit	#%00100000
    bne	CHECK_S1
   
   
    lda	PTBD
    ora	#%00001110
    and	#%11111110
    sta 	PTBD
    
    bra CHECK_S1