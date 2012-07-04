;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; export symbols
    XDEF asm_main
    XDEF initializeIo
    XDEF DELAY_10US
    XDEF DELAY_100US
    XDEF DELAY_1MS
    XDEF DELAY_10MS
    XDEF DELAY_100MS
    XDEF DELAY_1S
    XDEF ANYKEY          ; returns 1 if key pressed, 0 if not
    XDEF GETKEY          ; returns which key pressed, if any
    XDEF keypadInit      ; initializes the keypad for use
    XDEF PWM1_init       ; set the PWM period in us
    XDEF PWM1_duty       ; set the PWM duty cycle in us

    ; Include derivative-specific definitions
    INCLUDE 'derivative.inc'

; variable/data section
MY_ZEROPAGE: SECTION  SHORT
; Insert here your data definition. For demonstration, temp_byte is used.
; temp_byte:  DS.B   1

; code section
MyCode:     SECTION
; this assembly routine is called the C/C++ application

;/*-===========================================================================/
; Assembly functions
;/===========================================================================-*/
;/*-===================================/
; asm_main function
;/===================================-*/
; invert two leds
asm_main:
    lda     PTBD
    eor     #%00001001
    sta     PTBD

    RTS

;/*-===================================/
; initializeIo
;/===================================-*/
initializeIo:
; disable COP
    lda     #%01010010
    sta     SOPT1

; pull up all inputs
    lda     #%11111111
    sta     PTAPE
    sta     PTBPE

    rts

;/*====================================/
; Subroutine to DELAY by 10us
;/====================================*/
DELAY_10US
	psha
	lda	#8

DELAY_10US_LOOP
	deca
	bne	DELAY_10US_LOOP

	pula
	rts

;/*====================================/
; Subroutine to DELAY by 100us
;/====================================*/
DELAY_100US
	psha
	lda	#10

DELAY_100US_LOOP
	jsr	DELAY_10US
	deca
	bne	DELAY_100US_LOOP

	pula
	rts

;/*====================================/
; Subroutine to DELAY by 1ms
;/====================================*/
DELAY_1MS
	psha
	lda	#10

DELAY_1MS_LOOP
	jsr	DELAY_100US
	deca
	bne	DELAY_1MS_LOOP

	pula
	rts

;/*====================================/
; Subroutine to DELAY by 10ms
;/====================================*/
DELAY_10MS
	psha
	lda	#10

DELAY_10MS_LOOP
	jsr	DELAY_1MS
	deca
	bne	DELAY_10MS_LOOP

	pula
	rts

;/*====================================/
; Subroutine to DELAY by 100ms
;/====================================*/
DELAY_100MS
	psha
	lda	#10

DELAY_100MS_LOOP
	jsr	DELAY_10MS
	deca
	bne	DELAY_100MS_LOOP

	pula
	rts

;/*====================================/
; Subroutine to DELAY by 1s
;/====================================*/
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
; subroutine: ANYKEY
; If a key is pressed, then a 1 will be returned
;/------------------------------------*/
ANYKEY
	; ptad is output, ptbd is input
    lda     PTAD
    and     #$f0	; Set outputs low. Wait for electrical jitter to stop.
    sta     PTAD
    jsr     DELAY_10US

	; Status bits  are PTB:0-3 (last four bits in register).
	; By default, PTBD will be xxxx1111. If any of these bits are 0, then key is pressed.
	brclr   0,PTBD,ANYKEY_RETURN_1
	brclr   1,PTBD,ANYKEY_RETURN_1
	brclr   2,PTBD,ANYKEY_RETURN_1
	brclr   3,PTBD,ANYKEY_RETURN_1
	bra     ANYKEY_RETURN_0

; Key has been pressed. 
ANYKEY_RETURN_1
    lda     #1
    rts

ANYKEY_RETURN_0
    lda     #0
    rts

;/*------------------------------------/
; subroutine: GETKEY
; returns whichever key is pressed, if any. If no key pressed, return ' '
; When used in a C program, this sub will return a character.
;/------------------------------------*/
GETKEY
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
	brclr   1,PTBD,GETKEY_KEY9
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
    lda     #' '
    rts

;------------------- column 1 ----------
GETKEY_KEY1:
	lda     #'1'
    rts
GETKEY_KEY2:
	lda     #'2'
	rts
GETKEY_KEY3:
	lda     #'3'
	rts
GETKEY_KEYA:
	lda     #'A'
	rts
;------------------- column 2 ----------
GETKEY_KEY4:
	lda     #'4'
    rts
GETKEY_KEY5:
	lda     #'5'
    rts
GETKEY_KEY6:
	lda     #'6'
    rts
GETKEY_KEYB:
	lda     #'B'
    rts
;------------------- column 3 ----------
GETKEY_KEY7:
	lda     #'7'
    rts
GETKEY_KEY8:
	lda     #'8'
    rts
GETKEY_KEY9:
	lda     #'9'
    rts
GETKEY_KEYC:
	lda     #'C'
    rts
;------------------- column 4 ----------        
GETKEY_KEYS:
	lda     #'*'
    rts
GETKEY_KEY0:
	lda     #'0'
    rts
GETKEY_KEYP:
	lda     #'#'
    rts
GETKEY_KEYD:
	lda     #'D'
    rts

;/*------------------------------------/
; subroutine: keypadInit
; This subroutine initializes the keypad
;/------------------------------------*/
keypadInit
    mov     #$0f,PTADD   ;A0,3 output
    mov     #$00,PTBDD   ;B0,3 input

    rts

;/*------------------------------------/
; subroutine: PWM1_init
; Pass an integer to this subroutine. The PWM pulse width will be set equal
; to the number set. The number passed is assumed to specify microseconds.
;/------------------------------------*/
PWM1_init
    psha

    ; Timer will count to hx, where hx is a number that describes microseconds.
    ; HX can be any value between 0 and 65000. If it is higher, behavour is
    ; undefined. This allows the pulse width to be between 0 and 65 ms.
    sthx    TPMMOD

    ; Default duty cycle of 0. duty cycle = TPMCnV / TPMMOD
    lda     #0
    sta     TPMC1VH
    sta     TPMC1VL

    ; no hardware interrupts. Enable high-true left-aligned PWM output.
    lda     #%00101000
    sta     TPMC1SC

    ; disable interrupts. use internal clock (8MHz). Clock divisor of 8.
    lda     #%00001011
    sta     TPMSC

    pula
    rts

;/*------------------------------------/
; subroutine: PWM1_duty
; Set the PWM duty cycle equal to the integer passed. The int passed is assumed
; to specify a time, in microseconds. If you use this function in conjunction
; with PWM1_init like this, then duty cycle = arg1 / arg2. Assume arg1 and arg2
; come from this expression: PWM1_duty(arg1) / PWM1_init(arg2)
;/------------------------------------*/
PWM1_duty
    psha

    sthx    TPMC1V

    pula
    rts
