/*-============================================================================/
Jeremy Audet, for micro, taught by Matt Gallagher. Homework 11.

This program reads the state of a potentiometer and adjusts LEDs accordingly.

This program reads input from potentiometer R11. R11 is attached to pin 16 on the chip I am using. In order to read from R11, you first need to write a value to ADCH (part of the ADSC1 register). Depending upon the bits written to ADCH, the chip will examine a different pin and perform an analog to digital conversion. The table used to choose a value to write to ADCH is on page 117 of the manual.

In my program, I always pass the value 0. This is because I want to read from pin PTA0. After receiving a value from the converter, I use it to adjust the LEDs. Here's the association:
value <= 200    all LEDs off
value <= 500    LED 3 on
value <= 700    LED 3,4 on
value <= 900    LED 3-5 on
value > 900     all LEDs on

And that's all this program does. Fetch a value, adjust LEDs.

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
/============================================================================-*/
#include <hidef.h>      // for EnableInterrupts macro
#include "derivative.h" // include peripheral declarations
#include "utilities.h"  // interface to some useful assembly modules

void main(void) {
    int value = 0;      // holds the result of the ADC

    EnableInterrupts;   // Some macro... I'm not sure what it does.
    initializeIo();     // disable COP and pull up all inputs, plus some extras
    ADC_init();         // enable analog to digital converter, port 1
    PTBDD |= 0b00001111;// enable output on all LEDs by setting the appropriate data direction bits high

    while(1) {
        value = ADC_value(0);

        if(value <= 200) {
            PTBD |= 0b00001111;   // turn off all LEDs (active low)
        } else if(value <= 500) {
            PTBD |= 0b00000111;   // turn off LED 4-6
            PTBD &= 0b11110111;   // turn on LED 3
        } else if(value <= 700) {
            PTBD |= 0b00000011;   // turn off LED 5,6
            PTBD &= 0b11110011;   // turn on LED 3,4
        } else if(value <= 900) {
            PTBD |= 0b00000001;   // turn off LED 6
            PTBD &= 0b11110001;   // turn on LED 3-5
        } else {
            PTBD &= 0b11110000; // turn on all LEDs
        }
    }
} // main (please never leave main; behaviour is undefined)