/*-============================================================================/
Jeremy Audet, for Micro, taught by Matt Gallagher

This program allows the user to 
1) Grab input from an external potentiometer
2) Translate that input into a digital value
3) Use that digital value to control a servo motor.

The external potentiometer must be attached to pin PTA1 of the chip. It should
be a 10K pot. The function used to actually get a value from the pot is
ADC_value(). The function used to drive the servo motor is PWM0_dty(). The servo
should be attached to pin PTA0 on the chip. In this program, I assume that the
servo takes an input pulse of 2.0ms, and that the duty cycle should be somewhere
between 50% (1 ms) and 100% (2 ms) in length.
/============================================================================-*/



#include <hidef.h> /* for EnableInterrupts macro */
#include <stdio.h> 
#include "derivative.h" /* include peripheral declarations */
#include "main_asm.h" /* interface to the assembly module */

void main(void) {
    EnableInterrupts;   // a macro that is for some unknown reason necessary in c/asm projects
    intitialize_i_o();  // ...
    PWM0_init(20000);   // 20 ms per pulse
    PWM0_dty(x);        // give the PWM a starting duty cycle
    ADC_init();         // allow the chip to grab input

    while(1) {
        PWM0_dty(ADC_value(1) + 1000);
        // ADC_value() allows you to read an input voltage from one of the chip
        // pins, and convert that input voltage into a number. The converter has
        // a 10 bit resolution, meaning that the output number will have some
        // value between 0 and 1023. The number '1' is passed to this function
        // so that pin PTA1 will be read for input. If a different number had
        // been passed (say, a 0) then a different pin would have been read
        // (say, PTA0). PWM0_dty() takes a value between 1000 and 2000 and uses
        // that number to drive the attached servo. If the value is 1500, the
        // motor will stay still. A value of 1000 and 2000 will cause the motor
        // to turn at full speed in opposite directions.
        // The +1000 in this expression scales the value returned by ADC_value()
        // from 0-1000 to 1000-2000. 
    }
} // please never leave main
