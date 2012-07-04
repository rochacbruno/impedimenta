;/*----------------------------------------------------------------------------/
; Jeremy Audet
; Micro -- Matt Gallagher
; This is a standard code template.
;
; This code is meant to be used with the MC9S08QG8 chip. On my board, switches
; and LEDs are connected to the registers as shown here:
; LED3 = PTBD:3
; LED4 = PTBD:2
; LED5 = PTBD:1
; LED6 = PTBD:0
; SW1 = PTAD:3
; SW2 = PTAD:2
; SW3 = PTAD:1
; SW4 = PTAD:5
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

state:      ds.b    1   ; current state of Finite State Machine
timer:      ds.b    1   ; timer used in transitions between certain states
old_state   ds.b    1   ; stores the state the FSM was in before the obstructed state

obstructed          equ %00000000   ; active low, all LEDs on
open                equ %00000111   ; 7
closing             equ %00001011   ; 11
closed              equ %00001101   ; 13
opening             equ %00001110   ; 14

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

            lda #$ff                ; make all parallel inputs
            sta PTAPE               ; pull up  
            sta PTBPE

;*******************************************************************************
; END STANDARD CODE
;*******************************************************************************

;/*============================================================================/
; Initialize Registers, initial settings
;/============================================================================*/
; disable COP
    lda     #%01010010
    sta     SOPT1

; enable all four LEDs as output
    lda     PTBDD
    ora     #%00001111
    sta     PTBDD

; turn off LEDs for consistent starting point
    lda     PTBD
    ora     #%00001111  ; active low, inactive high
    sta     PTBD

; enable sw 1 and sw4 as input (PTA:3 and PTA:5, respectively)
    lda     PTAD
    and     #%11010111  ; 0 means input, 1 means output
    sta     PTAD

; give initial state to Finite State Machine
    lda     #closed
    sta     state
; also give timer value of 0. When in opening state, advance timer from
; 0 to 255. When in closing state, decrement timer from 255 to 0.
    lda     #0
    sta     timer

; turn on RTI, once every 32 ms
    lda #%00010010
    sta SRTISC

; IRQ will be turned only in the opening or closing states

;/*============================================================================/
; Main Loop
;/============================================================================*/

Start: 



end:    BRA    end

;/*============================================================================/
; Subroutine Definitions
; Each subroutine corresponds with a state in a finite state machine.
;/============================================================================*/
;/*-===================================/
; OPEN subroutine
;/===================================-*/
OPEN
    ; display the current state
    lda     #open
    sta     PTBD

    ; check for button push
    lda     PTAD
    bit     #%00001000
    bne     OPEN_END    ; if no button pushed, end
    lda     #closing    ; if button pushed, change to next state
    sta     state

OPEN_END
    rts

;/*-===================================/
; CLOSING subroutine
;/===================================-*/
CLOSING:
    ; display the current state
    lda     #closing
    sta     PTBD

    lda     timer
    cmp     #$00
    beq     CLOSING_NEXTSTATE   ; if timer has reached 0, change state and exit

    dec     timer               ; if timer has not reached 0, decrement, delay, and exit
    ; delay will occur due to RTI only occuring once every 32 milliseconds. separate delay is not needed
    rts

CLOSING_NEXTSTATE
    lda     #closed
    sta     state
    rts

;/*-===================================/
; CLOSED subroutine
;/===================================-*/
CLOSED:
    ; display the current state
    lda     #closed
    sta     PTBD

    ; check for button push
    lda     PTAD
    bit     #%00001000  ; bit 5 corresponds to SW4
    bne     CLOSED_END  ; if not button pushed, end
    lda     #opening    ; if button pushed, advance to next state
    sta     state

CLOSED_END
    rts

;/*-===================================/
; OPENING subroutine
;/===================================-*/
OPENING:
    ; display the current state
    lda     #opening
    sta     PTBD

    lda     timer
    cmp     #50
    beq     OPENING_NEXTSTATE   ; if timer has reached 50, change state and exit

    inc     timer               ; if timer has not reached 50, increment, delay, and exit
    ; delay will occur due to RTI only occuring once every 32 milliseconds. separate delay is not needed
    rts

OPENING_NEXTSTATE
    lda     #open
    sta     state
    rts

;/*-===================================/
; OBSTRUCTED subroutine
;/===================================-*/
OBSTRUCTED:
    lda     #obstructed
    sta     PTBD

    ; do not proceed until a button has been pushed
OBSTRUCTED_WAIT
    lda     PTAD
    bit     #%00001000
    bne     OBSTRUCTED_WAIT ; if s1 not pushed, wait

    lda     old_state
    cmp     #opening     ; if old state was opening...
    beq     OBSTRUCTED_NEWSTATE_CLOSING ; set the new state to closing.

    ; if the old state was closing, set the new state to opening and end
    lda     #opening
    sta     state
    rts

OBSTRUCTED_NEWSTATE_CLOSING
    lda     #closing
    sta     state
    rts

;/*-===================================/
; RTI definition
;/===================================-*/
RTI_SR
    lda     state

;/===== the five states (start) ========
    cmp     #obstructed
    bne     RTI_SR_CMP2 ; if state is not obstructed, jump to second check
    jsr     OBSTRUCTED
    bra     RTI_SR_END

RTI_SR_CMP2
    cmp     #open       ; check if state is open
    bne     RTI_SR_CMP3 ; if state is not open, jump to next check
    lda     #%00000000  ; if state is open, disable IRQs
    sta     IRQSC
    jsr     OPEN        ; and then jump to the open state
    bra     RTI_SR_END  ; and end

RTI_SR_CMP3
    cmp     #closing    ; check if state is closing
    bne     RTI_SR_CMP4 ; if state is not closing, jump to next ceck
    lda     #%01010010  ; if state is closing, enable IRQs (on falling edge only)
    sta     IRQSC
    jsr     CLOSING     ; and then do whatever the closing state does
    bra     RTI_SR_END

RTI_SR_CMP4
    cmp     #closed
    bne     RTI_SR_CMP5
    lda     #%00000000  ; if state is closed, disable IRQs
    sta     IRQSC
    jsr     CLOSED
    bra     RTI_SR_END

RTI_SR_CMP5
    cmp     #opening
    bne     RTI_SR_DEFAULT
    lda     #%01010010  ; if state is opening, enable IRQs (on falling edge only)
    sta     IRQSC
    jsr     OPENING
    bra     RTI_SR_END
;/===== the five states (end) ==========

RTI_SR_DEFAULT
    lda     #closed
    sta     state
    lda     #%00000000  ; if state is closed, disable IRQs
    sta     IRQSC
    jsr     CLOSED

RTI_SR_END
    lda     SRTISC
    ora     #%01000000  ; RTIACK
    sta     SRTISC
    rti

;/*-===================================/
; IRQ definition
;/===================================-*/
IRQ_SR
    ; store the current state
    lda     state
    sta     old_state

    ; set the new state
    lda     #obstructed
    sta     state

    ; make sure that you do not re-enter an IRQ (or else old_state will be set to obstructed)
    lda     #$00
    sta     IRQSC

    ; and exit. that's it.
    lda     IRQSC
    ora     #%00000100  ; clear I flag in CCR (write 1 to IRQACK)
    sta     IRQSC
    rti

;/*============================================================================/
; Includes
;/============================================================================*/
    INCLUDE 'utilities.inc'     ; includes a number of delay utilities

;/*============================================================================/
; Vector Interrupt Table Definitions
;/============================================================================*/

    org     $FFD0
    dc.w    RTI_SR
    
    org     $FFFA
    dc.w    IRQ_SR