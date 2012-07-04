;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; export symbols
            XDEF intitialize_i_o
            XDEF PWM0_init
            XDEF PWM0_dty
            XDEF ADC_init
            XDEF ADC_value
            
            ; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; variable/data section
MY_ZEROPAGE: SECTION  SHORT
; Insert here your data definition. For demonstration, temp_byte is used.
temp_byte:  DS.B   1
key         ds.b 1
; code section
MyCode:     SECTION
; this assembly routine is called the C/C++ application
asm_main:
            MOV    #1,temp_byte     ; just some demonstration code
            NOP                     ; Insert here your own code

            RTS                     ; return to caller

;Utilities is a file where we will store our assorted applications
;***************************************************************
;Initialize the io board.  Turn off COP and pullup all inputs
intitialize_i_o
   
     lda SOPT1
     and #%01111111
     sta SOPT1

; This code loads the nonvolatile trim value into the proper clock
; control registers.  Here is the squence that I understand
;
; BDM detects the internal FFL clock speed and indicates that
; speed in the command window as the chip is programmed
;
; The BDM loads values in the control register to give it about
; 8MHz 
;
; In run mode these values are NOT loaded and the device operates
; at a different speed than when in BDM mode. Therefore, these values must be
; loaded at startup to ensure a consistent ~ 8MHz value between BDM and regular 
; run mode.
;     
     LDA NV_FTRIM
     STA ICSSC
     LDA NV_ICSTRM
     STA ICSTRM
      
   ;/*pullup all inputs */         
      lda #$ff
      sta PTBPE
      lda #$ff                
      sta PTAPE
      rts

;**************************************************************
; PWM1_init(int) Initialize channel 1 on the PWM, pin 7.  The interger
; value sent sets the modulus value, TMPMOD.  The pulses are edge just-
; ified, no interrupt, and active high. The clock divider is set to 16
; which makes the clock duration
; 
; Tclock = (clock divide) / fclock =(16/5MHz)=3.2us
;
; PWM period = TPMMOD * Tclock
;
; To set the PWM duty cycle use the PWM_DTY(int) to place a value
; into TPMC1V
; 
; PWM duty cycle = TMPC1V / TPMMOD
;***************************************************************
PWM1_init
     sthx TPMMOD   ; //*Modulo value. Sets PWM period TPMMOD * Tclock */
     clrh
     clrx
     sthx TPMC1V   ; //*PWM duty cycle Time on= TPMC1V*Tclock. */
     mov #$28,TPMC1SC ; /* Edge-aligned PWM, High-true pulses, No Interrupt*/
     mov #$0c,TPMSC   ; //* clock source: internal bus, clock divide = see documentaion
     rts                 ;// 
PWM0_init
     sthx TPMMOD   ; //*Modulo value. Sets PWM period TPMMOD * Tclock */
     clrh
     clrx
     sthx TPMC0V   ; //*PWM duty cycle Time on= TPMC1V*Tclock. */
     mov #$28,TPMC0SC ; /* Edge-aligned PWM, High-true pulses, No Interrupt*/
     mov #$0c,TPMSC   ; //* clock source: internal bus, clock divide = see documentaion
     rts                         
;***************************************************************
; PWM_dty will upload the argument into TPMC1V which will determine
; the duty cycle.
;
; The pulse duration is TPMC1V x Tclock
;
; PWM dty cycle = TPMC1V / TPMMOD
;
; Be sure to note the value sent to the period value;
PWM1_dty 
    sthx TPMC1V
    rts
PWM0_dty 
    sthx TPMC0V
    rts
    
;***************************************************************    
; int ADC_init(void) initialize the ADC port 1.
; Single conversion, 10 bit, right justified.  

ADC_init
    ;mov #$00,ADCSC1
    mov #$00,ADCSC2
    mov #$08,ADCCFG
    rts
    
;***************************************************************    
; int ADC_value(char) operates by writing an ADC address value to ADCSC1
; which starts the ADC process of successive approximation. This 
; is the software trigger approach. The ADC is configured to be 
; non-continuous so we wait until the COCO or conversion complete 
; pin is set which means the conversion is complete.  Reading the 
; value of the converted value clears the COCO bit so we can start 
; again. 
;  


ADC_value  ;

     sta ADCSC1
wt2  brclr 7,ADCSC1,wt2
     ldhx ADCR
     rts

;***************************************************************
