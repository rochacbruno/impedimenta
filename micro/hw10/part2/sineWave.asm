;/*-===========================================================================/
; Jeremy Audet
; Micro -- Matt Gallagher
; Homework 10
;
; Objective: create a sine wave using the PWM register. This will need to be done twice; once with C, and a second time using assembly. This file is the assembly implementation. See the sineWave.c file for the c implementation. Note that I use pin PTA0 for pulse output.
;
; The primary mechanics used in creating a sine wave are the sineWave array and the TPM function of this chip. I have set up the TPM function of this chip so that a single pulse is output over the course of 1 ms. This pulse is repeated, and its duty cycle can be changed. The duty cycle of the pulses output is a fraction between 0 and 1, determined as follows: dutyCycle = TPMC0V / TPMMOD. By placing values into the TPMC0V register at regular intervals, one can easily change the duty cycle of this chip.
;
; The duty cycle cannot be greater than one. If the fraction TPMC0V / TPMMOD is >= 1, the duty cycle will be one. In this program TPMMOD is 1000. I've calculated values for TPMC0V and placed them in the sineWave array variable. You can see the script I used to create those values in the file calculatorScript. Run the command "bc -l calculatorScript" to get values. I ran this command on Arch Linux using the command-line utility bc.
;
; The process used for getting the elements of sineWave into the TPMC0V variable are really, really ass-backwards and almost idiotic. See, you can't address an element of an array by saying "load hx with the address of variable sineWave and then fetch element n". No, you need to hardcode in a value. I can say write a command such as "lda 0,x" or "lda 15,x". But I cannot write "lda counter,x". That means that I cannot sucessively fetch elements of sineWave and then place them in TPMC0V. My solution, instead, is to shift the entire contents of sineWave over. So I'll instead repeatedly fetch element 0, place the value in TPMC0V, and then shift the _entire array_ over to the right (and place the last element of the array back at the beginning of that array). It's ass-backwards, but at least somewhat procedural. The other possibility was to write a program that would simply write 20 values into TPMC0V, but... that feels even sillier.
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
;/===========================================================================-*/

;/*-===========================================================================/
; START STANDARD CODE TEMPLATE
;/===========================================================================-*/
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            INCLUDE 'utilities.inc'

; export symbols
            XDEF _Startup, main
            ; we export both '_Startup' and 'main' as symbols. Either can
            ; be referenced in the linker .prm file or from C/C++ later on
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack

; variable/data section
MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition

;/*-===================================/
;  RAM variables here 
;/===================================-*/
temp        ds.b    1
; holds 20 values used to create a sine wave
sineWave    ds.b    20

DEFAULT_ROM			SECTION

;/*-===================================/
;  ROM variables here
;/===================================-*/

;/*-===================================/
; code section
;/===================================-*/
MyCode:     SECTION
          
main:
_Startup:
    LDHX   #__SEG_END_SSTACK    ; initialize the stack pointer
    jsr     initializeIo        ; disable COP, pull up all inputs

;/*-===================================/
; END STANDARD CODE TEMPLATE
;/===================================-*/
; Phew! Time to get to some actual code.

;/*-===========================================================================/
; Initialize Registers
;/===========================================================================-*/
    ; fill variable sineWave with values
    jsr     FILL_SINE_WAVE

    ; count up to 250. Will overflow once every 1 ms (at 1000 Hz).
    lda     #250
    sta     TPMMODL
    lda     #0
    sta     TPMMODH

    ; duty cycle default of 0. Will be varied in body of program to create actual sine wave
    lda     #0
    sta     TPMC0VH
    sta     TPMC0VL

    ; no hardware interrupts. Enable high-true left-aligned PWM output.
    lda     #%00101000
    sta     TPMC0SC

    ; disable interrupts. use internal clock (4MHz). Clock divisor of 16.
    lda     #%00001100
    sta     TPMSC

;/*-===========================================================================/
; Main Loop
;/===========================================================================-*/
Start:
    ; update the duty cycle of the output pulse
    ldhx    #sineWave
    lda     0,x
    sta     TPMC0VL

    ; wait while 10 pulses output
    jsr     DELAY_10MS

    ; suffle the sineWave array around so that the next value to be used is in element 0.
    jsr     SHIFT_SINE_WAVE

; Start over
end
    bra    Start

;/*-===========================================================================/
; Subroutine Definitions
;/===========================================================================-*/
; This subroutine shifts all of the elements of variable sineWave one element to
; the right. The rightmost element is then placed back at the beginning of the
; array. This subroutine basically plays a game of musical chairs with the
; elements of sineWave.
SHIFT_SINE_WAVE:
    psha
    pshh
    pshx

    ldhx    #sineWave
    lda     19,x
    sta     temp

    lda     18,x
    sta     19,x

    lda     17,x
    sta     18,x

    lda     16,x
    sta     17,x

    lda     15,x
    sta     16,x

    lda     14,x
    sta     15,x

    lda     13,x
    sta     14,x

    lda     12,x
    sta     13,x

    lda     11,x
    sta     12,x

    lda     10,x
    sta     11,x

    lda     9,x
    sta     10,x

    lda     8,x
    sta     9,x

    lda     7,x
    sta     8,x

    lda     6,x
    sta     7,x

    lda     5,x
    sta     6,x

    lda     4,x
    sta     5,x

    lda     3,x
    sta     4,x

    lda     2,x
    sta     3,x

    lda     1,x
    sta     2,x

    lda     0,x
    sta     1,x

    lda     temp
    sta     0,x

    pulx
    pulh
    pula
    rts

; Here is a list of the numbers placed into the sineWave variable.
; 0, 6, 24, 52, 86, 125, 164, 198, 226, 244, 250, 244, 226, 198, 164, 125, 86, 52, 24, 6
; In this subroutine, I assume that the sineWave variable is 20 elements in length
FILL_SINE_WAVE:
    psha
    pshh
    pshx

    ldhx    #sineWave
    lda     #0
    sta     0,x

    lda     #6
    sta     1,x

    lda     #24
    sta     2,x

    lda     #52
    sta     3,x

    lda     #86
    sta     4,x

    lda     #125
    sta     5,x

    lda     #164
    sta     6,x

    lda     #198
    sta     7,x

    lda     #226
    sta     8,x

    lda     #244
    sta     9,x

    lda     #250
    sta     10,x

    lda     #244
    sta     11,x

    lda     #226
    sta     12,x

    lda     #198
    sta     13,x

    lda     #164
    sta     14,x

    lda     #125
    sta     15,x

    lda     #86
    sta     16,x

    lda     #52
    sta     17,x

    lda     #24
    sta     18,x

    lda     #6
    sta     19,x

    pulx
    pulh
    pula
    rts

;/*-===========================================================================/
; Vector Interrupt Table Definitions
;/===========================================================================-*/