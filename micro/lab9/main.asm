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
            XDEF keyInit
            XDEF anyKey
            XDEF getKey
            XDEF blinkLeds

            ; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; variable/data section
MY_ZEROPAGE: SECTION  SHORT
; Insert here your data definition. For demonstration, temp_byte is used.
; temp_byte:  DS.B   1
    key:            ds.b    1
    dd_state:       ds.b    1   ; holds the state of a data direction register
    d_state:        ds.b    1   ; holds the state of a data register

; code section
MyCode:     SECTION
; this assembly routine is called the C/C++ application

;/*-===========================================================================/
; Assembly functions
;/===========================================================================-*/
;/*-===================================/
; asm_main() definition
;/===================================-*/
; do nothing
asm_main:
    nop

    rts

;/*-===================================/
; initializeIo() definition
;/===================================-*/
initializeIo:
; disable COP
    lda     #%01010010
    sta     SOPT1

; pullup all inputs
    lda     #%11111111
    sta     PTAPE
    sta     PTBPE

    rts

;/*-===================================/
; keyInit() definition
;/===================================-*/
keyInit:
    psha
 
    lda     #$0F
    sta     PTADD   ;A0 to A3 output
    lda     #$00
    sta     PTBDD   ; B0 to B3 input

    pula
    rts

;/*-===================================/
; anyKey() definition
; if a key is pressed, then return a 1 (in the Accumulator)
; if no key is pressed, then return a 0
;/===================================-*/
anyKey:
    ; ptad is output, ptbd is input
    ; set outputs low. wait for electrical jitter to stop
    lda     PTAD
    and     #$f0
    sta     PTAD
    jsr     DELAY_10US

    ; status bits are PTB:0-3 (last four bits in PTBD register)
    ; by default, PTBD will be xxxx1111. If any of these bits are
    ; 0, then key is being pressed
    brclr   0,PTBD,anyKey_return1
    brclr   1,PTBD,anyKey_return1
    brclr   2,PTBD,anyKey_return1
    brclr   3,PTBD,anyKey_return1
    bra     anyKey_return0

anyKey_return1
    lda     #$01
    rts

anyKey_return0
    lda     #$00
    rts

;/*-===================================/
; getKey() definition
;/===================================-*/
getKey:

	; set leftmost column low, wait for jitter to end, and test rows
	lda	#%11110111
	sta	PTAD
	jsr DELAY_10US
	brclr 3,PTBD,getKey_KEY1
	brclr 2,PTBD,getKey_KEY4
	brclr 1,PTBD,getKey_KEY7
	brclr 0,PTBD,getKey_KEYS
	
	; set second column low, wait for jitter to end, and test rows
	lda	#%11111011
	sta	PTAD
	jsr DELAY_10US
	brclr 3,PTBD,getKey_KEY2
	brclr 2,PTBD,getKey_KEY5
	brclr 1,PTBD,getKey_KEY8
	brclr 0,PTBD,getKey_KEY0
	
	; set third column low, wait for jitter to end, and test rows
	lda	#%11111101
	sta	PTAD
	jsr DELAY_10US
	brclr 3,PTBD,getKey_KEY3
	brclr 2,PTBD,getKey_KEY6
	brclr 1,PTBD,getKey_KEY3
	brclr 0,PTBD,getKey_KEYP
	
	; set rightmost column low, wait for jitter to end, and test rows
	lda	#%11111110
	sta	PTAD
	jsr DELAY_10US
	brclr 3,PTBD,getKey_KEYA
	brclr 2,PTBD,getKey_KEYB
	brclr 1,PTBD,getKey_KEYC
	brclr 0,PTBD,getKey_KEYD
	
        ; If no keys pressed, exit sub. 
    lda     #$00
    rts

getKey_KEY1:
	mov #'1',key
    bra getKey_END
getKey_KEY2:
	mov #'2',key
	bra getKey_END
getKey_KEY3:
	mov #'3',key
	bra getKey_END
getKey_KEYA:
	mov #'A',key
	bra getKey_END
;---------------------------------------
getKey_KEY4:
	mov #'4',key
    bra getKey_END
getKey_KEY5:
	mov #'5',key
    bra getKey_END
getKey_KEY6:
	mov #'6',key
    bra getKey_END
getKey_KEYB:
	mov #'B',key
    bra getKey_END
;---------------------------------------
getKey_KEY7:
	mov #'7',key
    bra getKey_END
getKey_KEY8:
	mov #'8',key
    bra getKey_END
getKey_KEY9:
	mov #'9',key
    bra getKey_END
getKey_KEYC:
	mov #'C',key
    bra getKey_END
;---------------------------------------        
getKey_KEYS:
	mov #'*',key
    bra getKey_END
getKey_KEY0:
	mov #'0',key
    bra getKey_END
getKey_KEYP:
	mov #'#',key
    bra getKey_END
getKey_KEYD:
	mov #'D',key
    bra getKey_END

getKey_END:	
	; while any key is pressed, loop. Only continue once keys have been let go.
getKey_LOOP
	jsr anyKey
	bne getKey_LOOP

    lda key	
    rts

;/*-===================================/
; Subroutine to briefly blink LEDs
;/===================================-*/
blinkLeds:
; store current state
    psha
    lda     PTBDD
    sta     dd_state
    lda     PTBD
    sta     d_state

; enable LEDs as output
    lda     #%00001111
    sta     PTBDD

    lda     #%00001010
    sta     PTBD
    jsr     DELAY_1S

    lda     #%00000101
    sta     PTBD
    jsr     DELAY_1S

; restore state
    lda     dd_state
    sta     PTBDD
    lda     d_state
    sta     PTBD
    pula
    rts

;/*-===========================================================================/
; Subroutines to delay
;/===========================================================================-*/
;/*====================================/
; Subroutine to delay by 10us
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
; Subroutine to delay by 100us
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
; Subroutine to delay by 1ms
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
; Subroutine to delay by 10ms
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
; Subroutine to delay by 100ms
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
; Subroutine to delay by 1s
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