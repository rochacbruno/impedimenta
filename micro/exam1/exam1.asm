;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; Take-home exam #1.
;
; This program blinks an LED continuously. By pushing in one button, the light will blink with a greater frequency. By pushing the second button, the light will blink with a lesser frequency. The check to see whether a button is pressed in is performed using an RTI. If both buttons are pressed, then the light will blink with a greater frequency. LED 6 is the LED that will blink. S1 will increase the blink frequency, and LED6 will decrease the blink frequency. An RTI to increase/decrease blink frequency will occur once every 512 ms. No variables are used in this program. The blink length is kept track of using the X register.
;
; Here's a sample run-through: H is initialized to 0, X is initialized to 10, LED6 is initialized for output, and S1 and S2 are initialized for input. The main loop then starts. First, DELAY_HXMS is called. Second, LED6 is inverted. Repeat. During an RTI, X is either increased or decreased depending upon whether S1 or S2 is pressed, respectively.
;
; IMPORTANT NOTE: delay_xhms will be modified to run 10 times its titular length. For example, if delay_xhms is called when xh has a value of 5, a delay of 50 ms will occur, (not a delay of 5ms).
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

; setup LED 6 as output
	lda	PTBDD
	ora	#%00000001
	sta	PTBDD

; enable S1 and S2 as input
	lda	PTADD
	and	#%11110011
	sta	PTADD

; enable RTIs once every 512 ms
	lda	#0
	ora	#%00010110
	sta	SRTISC

; H is initialized to 0, X is initialized to 10
	ldhx	#10

;/*----------------------------------------------------------------------------/
; Main Loop
;/----------------------------------------------------------------------------*/
Start: 

; delay program...
	jsr	DELAY_HXMS

; and invert LED. That's it for the body of the program. The RTI takes care of the length of the delay.
	lda	PTBD
	eor	#%00000001
	sta	PPBD

; do it over again
	bra	Start

end:    BRA    end

;/*----------------------------------------------------------------------------/
; Subroutine Definitions
;/----------------------------------------------------------------------------*/

;/*------------------------------------/
; RTI definition
; During an RTI, X is either increased or decreased depending upon whether S1 or S2 is pressed, respectively.
; X will not be increased above 255 or decreased below 0
; S1 and S2 use PTAD:3 and PTAD:2, respectively.
;/------------------------------------*/
RTI_SR
	; check S1 (PTAD:3)
	lda	PTAD
	bit	#%00001000
	beq	RTI_SR_INCREASE

	; check S2 (PTAD:2)
	bit	#%00000100
	beq	RTI_SR_DECREASE

RTI_SR_INCREASE
	; increment X, and thus the length of LED blinks
	; copy X into A and invert the bits. If X is 11111111, eor will change value to 00000000
	txa
	eor	#%11111111

	; then check to see if A is equal to 0 (and thus if X was equal to 255)
	bit	#%11111111

	; if X was equal to 255, do not increment. End.
	beq	RTI_SR_END

	; if X not equal to 255, increment.
	incx
	bra	RTI_SR_END

RTI_SR_DECREASE
	; decrement X, and thus the length of LED blinks
	; copy X into A. Do not invert bits this time around
	txa

	; check to see if A (X) is equal to 0. 
	bit	#%11111111

	; if X equal to 0, end and do not decrement
	beq	RTI_SR_END

	; If X not equal to 0 (x is greater than 0) then decrement.
	decx
	beq	RTI_SR_END

RTI_SR_END
	rti

;/*------------------------------------/
; Delay subroutines
;/------------------------------------*/
; Utilities used for making the processor do nothing. (delay utilities)
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

DELAY_10MS
	psha
	lda	#10
DELAY_10MS_LOOP
	jsr	delay_1ms
	deca
	bne DELAY_10MS_LOOP
	pula
	rts

delay_100ms    psha
              lda #10
dly_lp4:      jsr delay_10ms
              deca
              bne dly_lp4              
              
              pula
              rts

delay_1s    psha
              lda #10
dly_lp5:      jsr delay_100ms
              deca
              bne dly_lp5              
              pula
              rts

DELAY_HXMS   
             
             cphx #0
             beq zro
dly_lp6:     
             jsr delay_10ms
             decx
             bne dly_lp6
             
             pshh
             pulx
             tstx
             beq zro
             decx
             pshx
             pulh
             ldx #$ff
             bne dly_lp6
zro             
             rts

;/*----------------------------------------------------------------------------/
; Vector Interrupt Table Definitions
;/----------------------------------------------------------------------------*/
; RTI setup
	org	$ffd0
	dc.w	RTI_SR
