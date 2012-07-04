;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; Lab 8 homework: using a keypad.
; 
; In this program, an 8-pin keypad is connected to the MC9S08QG8 chip. The
; keypad is read, one key at a time, and the inputs are stored. If someone
; presses the keys '1', '2', and '3', then the keypad locks up for a moment and
; the LEDs blink.
;
; The subroutines used in this program are:
; ANYKEY	<< Detects whether any keypad button has been pressed
; GETKEY	<< Stores whatever button is being pressed in the 'key' variable.
; STOREKEY	<< Stores the 'key' variable in keyArray. Old values in keyArray are shifted right.
; TEST_CODE	<< Compares 'code' and 'keyArray'. If match, Z = 1. Else, Z = 0.
; INVERT_LED	<< Blink LEDs. Causes keypad to ignore input for 1 second.
; DELAY_[time]	<< This is a collection of delay subroutines all named similarly.
; 
; The main program itself is very short and therefore easily understood.
; The main loop simply loops repeatedly until ANYKEY detects input. Once input
; is detected, the key pressed is gotten using GETKEY and the keys that have
; been input are tested using TEST_CODE. INVERT_LED is only called if TEST_CODE
; found a match between 'code' (a hardcoded password) and 'keyArray' (the user
; input).
;
; If we input to the column pins, PTA0:3, then we can read PTB0:3 as input. 
; If the output pins are set low and no buttons are pressed, the input pins will
; still read high (as the input pins are tied high). If a button is pressed,
; then a short is created between the input and output and one of the input pins
; will be low.
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
; 
; Look at the keypad from behind. Connect the pins as shown below.
;
;  1  2  3  4  5  6  7  8     pins on keypad  
; a0 a1 a2 a3 b0 b1 b2 b3
; 16 15 14 13 12 11 10  9     pins on qg8 processor
;
;      a3  a2  a1  a0
;    +---+---+---+---+
; b3 | 1 | 2 | 3 | A |
;    +---+---+---+---+
; b2 | 4 | 5 | 6 | B |
;    +---+---+---+---+
; b1 | 7 | 8 | 9 | C |
;    +---+---+---+---+
; b0 | * | 0 | # | D |
;    +---+---+---+---+
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

key	ds	1
keyArray ds	3

DEFAULT_ROM			SECTION

;****************************************
;  ROM variables here
;****************************************
;ROM_table    dc   $45,%01000010,$32,$fc,0
code	dc	'3','2','1'

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

            lda #$ff                ; make all parallel inputs
            sta PTAPE               ; pull up  
            sta PTBPE

;*******************************************************************************
; END STANDARD CODE
;*******************************************************************************

;/*----------------------------------------------------------------------------/
; Initialize Registers
;/----------------------------------------------------------------------------*/
	mov     #$0f,PTADD   ;A0,3 output
	mov     #$00,PTBDD   ;B0,3 input

;/*----------------------------------------------------------------------------/
; Main Loop
;/----------------------------------------------------------------------------*/
Start: 

	jsr	ANYKEY
;	Note to self: beq GETKEY. If a button is pushed, the z bit is set
	bne	Start
	
	jsr	GETKEY
	jsr	TEST_CODE
	beq	MAIN_INVERT_LED	; After testing the keys entered, either invert
	bra	MAIN_END	; LED or end main loop.

MAIN_INVERT_LED
	jsr	INVERT_LED

MAIN_END:
	bra	Start

;/*----------------------------------------------------------------------------/
; Subroutine Definitions
;/----------------------------------------------------------------------------*/
;/*------------------------------------/
; subroutine: ANYKEY
; If a key is pressed, then Z bit will be set when routine finishes.
;/------------------------------------*/
ANYKEY
	psha

	; ptad is output, ptbd is input
    lda     PTAD
    and     #$f0	; Set outputs low. Wait for electrical jitter to stop.
    sta     PTAD
    jsr     DELAY_10US

	; Status bits  are PTB:0-3 (last four bits in register).
	; By default, PTBD will be xxxx1111. If any of these bits are 0, then key is pressed.
	brclr   0,PTBD,ANYKEY_SET_Z
	brclr   1,PTBD,ANYKEY_SET_Z
	brclr   2,PTBD,ANYKEY_SET_Z
	brclr   3,PTBD,ANYKEY_SET_Z
	bra     ANYKEY_CLEAR_Z

; Key has been pressed. 
ANYKEY_SET_Z
	bit     #%00000000
    pula
    rts

ANYKEY_CLEAR_Z
	lda     #%11111111
	bit     #%11111111
    pula
    rts

;/*------------------------------------/
; subroutine: GETKEY
;/------------------------------------*/
GETKEY
	psha

	; set leftmost column low, wait for jitter to end, and test rows
	lda     #%11110111
	sta     PTAD
	jsr     DELAY_10US
	brclr   3,PTBD,GETKEY_KEY1
	brclr   2,PTBD,GETKEY_KEY4
	brclr   1,PTBD,GETKEY_KEY7
	brclr   0,PTBD,GETKEY_KEYS
	
	; set second column low, wait for jitter to end, and test rows
	lda     #%11111011
	sta     PTAD
	jsr     DELAY_10US
	brclr   3,PTBD,GETKEY_KEY2
	brclr   2,PTBD,GETKEY_KEY5
	brclr   1,PTBD,GETKEY_KEY8
	brclr   0,PTBD,GETKEY_KEY0
	
	; set third column low, wait for jitter to end, and test rows
	lda     #%11111101
	sta     PTAD
	jsr     DELAY_10US
	brclr   3,PTBD,GETKEY_KEY3
	brclr   2,PTBD,GETKEY_KEY6
	brclr   1,PTBD,GETKEY_KEY3
	brclr   0,PTBD,GETKEY_KEYP
	
	; set rightmost column low, wait for jitter to end, and test rows
	lda     #%11111110
	sta     PTAD
	jsr     DELAY_10US
	brclr   3,PTBD,GETKEY_KEYA
	brclr   2,PTBD,GETKEY_KEYB
	brclr   1,PTBD,GETKEY_KEYC
	brclr   0,PTBD,GETKEY_KEYD
	
    ; If no keys pressed, exit sub. 
	bra     donekey 

GETKEY_KEY1:
	mov     #'1',key
    bra     donekey
GETKEY_KEY2:
	mov     #'2',key
	bra     donekey
GETKEY_KEY3:
	mov     #'3',key
	bra     donekey
GETKEY_KEYA:
	mov     #'A',key
	bra     donekey
;---------------------------------------
GETKEY_KEY4:
	mov     #'4',key
    bra     donekey
GETKEY_KEY5:
	mov     #'5',key
    bra     donekey
GETKEY_KEY6:
	mov     #'6',key
    bra     donekey
GETKEY_KEYB:
	mov     #'B',key
    bra     donekey
;---------------------------------------
GETKEY_KEY7:
	mov     #'7',key
    bra     donekey
GETKEY_KEY8:
	mov     #'8',key
    bra     donekey
GETKEY_KEY9:
	mov     #'9',key
    bra     donekey
GETKEY_KEYC:
	mov     #'C',key
    bra     donekey
;---------------------------------------        
GETKEY_KEYS:
	mov     #'*',key
    bra     donekey
GETKEY_KEY0:
	mov     #'0',key
    bra     donekey
GETKEY_KEYP:
	mov     #'#',key
    bra     donekey
GETKEY_KEYD:
	mov     #'D',key
    bra     donekey

donekey:
; if a key has been pressed, then record key in array and exit.
	jsr	STOREKEY
	
	; while any key is pressed, loop. Only continue once keys have been let go.
GETKEY_LOOP
	jsr ANYKEY
	beq GETKEY_LOOP
	
	pula
	rts

;/*------------------------------------/
; Subroutine to store variable 'key' in array 
;/------------------------------------*/
STOREKEY:
	psha
	pshx
	pshh
	
	; load hx with address of keyArray. push keyArray[0] and keyArray[1] to keyArray[1] and keyArray[2], respectively
	ldhx	#keyArray
	lda	1,x
	sta	2,x
	lda	0,x
	sta	1,x
	; then, store the value of key in keyArray[0]
	lda	key
	sta	0,x

	; end	
	pulh
	pulx	
	pula
	rts

;/*------------------------------------/
; Subroutine to check if the user enters a certain code
; returns Z = 1 if code matches entry
;/------------------------------------*/
TEST_CODE
	psha
	pshx
	pshh
	
	; the next three code blocks compare 'code' against 'keyArray'.
	; if they differ at any point, set z to 0 and exit.
	ldhx	#keyArray
	lda	0,x
	ldhx	#code
	cmp	0,x
	bne	TEST_CODE_NO_MATCH
	
	ldhx	#keyArray
	lda	1,x
	ldhx	#code
	cmp	1,x
	bne	TEST_CODE_NO_MATCH
	
	ldhx	#keyArray
	lda	2,x
	ldhx	#code
	cmp	2,x
	bne	TEST_CODE_NO_MATCH
	
	; If the program has gotten to here, then the user has entered 'code'
	bit	#%00000000
	pulh
	pulx
	pula
	rts
	
TEST_CODE_NO_MATCH

	lda	#%11111111	; these two lines of code set z = 0
	bit	#%11111111
	pulh			; the rest ends the sub normally
	pulx
	pula
	rts

;/*------------------------------------/
; Invert LEDs
;/------------------------------------*/
INVERT_LED
	psha
	
	; setup PTBD as outputs (have been using them as inputs to read keypad)
	lda	PTBDD
	ora	#%00001111
	sta	PTBDD
	
	; invert leds, delay for 1s, and invert leds back to their original state
	lda	PTBD
	eor	#%11111111
	sta	PTBD
	jsr	DELAY_1S
	
	lda	PTBD
	eor	#%11111111
	sta	PTBD
	jsr	DELAY_1S
	
	; setup PTBD as inputs again to read keypad
	lda	PTBDD
	and	#%11110000
	sta	PTBDD
	
	pula
	rts

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

;/*----------------------------------------------------------------------------/
; Vector Interrupt Table Definitions
;/----------------------------------------------------------------------------*/

