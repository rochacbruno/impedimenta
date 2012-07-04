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
; turn off all four leds
asm_main:
    lda     PTBD
    ora     #%00001111  ; active low
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
; Subroutine to MAIN_DELAY by 10us
;/====================================*/
MAIN_DELAY_10US
	psha
	lda	#8

MAIN_DELAY_10US_LOOP
	deca
	bne	MAIN_DELAY_10US_LOOP

	pula
	rts

;/*====================================/
; Subroutine to MAIN_DELAY by 100us
;/====================================*/
MAIN_DELAY_100US
	psha
	lda	#10

MAIN_DELAY_100US_LOOP
	jsr	MAIN_DELAY_10US
	deca
	bne	MAIN_DELAY_100US_LOOP

	pula
	rts

;/*====================================/
; Subroutine to MAIN_DELAY by 1ms
;/====================================*/
MAIN_DELAY_1MS
	psha
	lda	#10

MAIN_DELAY_1MS_LOOP
	jsr	MAIN_DELAY_100US
	deca
	bne	MAIN_DELAY_1MS_LOOP

	pula
	rts

;/*====================================/
; Subroutine to MAIN_DELAY by 10ms
;/====================================*/
MAIN_DELAY_10MS
	psha
	lda	#10

MAIN_DELAY_10MS_LOOP
	jsr	MAIN_DELAY_1MS
	deca
	bne	MAIN_DELAY_10MS_LOOP

	pula
	rts

;/*====================================/
; Subroutine to MAIN_DELAY by 100ms
;/====================================*/
MAIN_DELAY_100MS
	psha
	lda	#10

MAIN_DELAY_100MS_LOOP
	jsr	MAIN_DELAY_10MS
	deca
	bne	MAIN_DELAY_100MS_LOOP

	pula
	rts

;/*====================================/
; Subroutine to MAIN_DELAY by 1s
;/====================================*/
MAIN_DELAY_1S
	psha
	lda	#10

MAIN_DELAY_1S_LOOP
	jsr	MAIN_DELAY_100MS
	deca
	bne	MAIN_DELAY_1S_LOOP

	pula
	rts
