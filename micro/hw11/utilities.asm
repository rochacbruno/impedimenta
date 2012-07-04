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
    XDEF ADC_init
    XDEF ADC_value

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
    lda     SOPT1
    and     #%01111111
    sta     SOPT1

    ; pull up all inputs
    lda     #%11111111
    sta     PTAPE
    sta     PTBPE

    ; some crazy shit that I don't understand. Found it in Matt's config files.
    lda     NV_FTRIM
    sta     ICSSC
    lda     NV_ICSTRM
    sta     ICSTRM

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

;/*====================================/
; Subroutine to setup the analog to digital converter
; Single converson, 10 bit, right justified
; ADC port 1
;/====================================*/
ADC_init
    psha
    ;mov #$00,ADCSC1    ; was already commented out...

    lda     #0
    sta     ADCSC2

    lda     #%00001000
    sta     ADCCFG

    pula
    rts

;/*====================================/
; Subroutine to get a value from the ADC
; 
; int ADC_value(void) operates by writing an ADC address value to ADCSC1 which 
; starts the ADC process of successive approximation. This is the software
; trigger approach. The ADC is configured to be non-continuous so we wait until
; the COCO or conversion complete pin is set which means the conversion is
; complete.  Reading the value of the converted value clears the COCO bit so we
; can start again. 
;/====================================*/
ADC_value
    sta     ADCSC1  ; Subroutine has already been passed a char. (chars are 8 bit, placed in A)
ADC_value_wait
    brclr   7,ADCSC1,ADC_value_wait
    ldhx    ADCR    ; Conversion produces 10 bit number. Therefore, must return as an integer.

    rts
