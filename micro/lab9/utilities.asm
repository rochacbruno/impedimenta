;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; export symbols
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