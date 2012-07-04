/*-============================================================================/
Jeremy Audet, for micro, taught by Matt Gallagher. Homework assignment 10.

Objective: create a sine wave using the PWM register. This will need to be done twice; once with C, and a second time using assembly. This file is the c implementation. See the sineWave.asm file for the assembly implementation. Note that I use pin PTA0 for pulse output.

The primary mechanics used in creating a sine wave are the sineWave array and the TPM function of this chip. I have set up the TPM function of this chip so that a single pulse is output over the course of 1 ms. This pulse is repeated, and its duty cycle can be changed. The duty cycle of the pulses output is a fraction between 0 and 1, determined as follows: dutyCycle = TPMC0V / TPMMOD. By placing values into the TPMC0V register at regular intervals, one can easily change the duty cycle of this chip.

The duty cycle cannot be greater than one. If the fraction TPMC0V / TPMMOD is >= 1, the duty cycle will be one. In this program TPMMOD is 1000. I've calculated values for TPMC0V and placed them in the sineWave array variable. You can see the script I used to create those values in the file calculatorScript. Run the command "bc -l calculatorScript" to get values. I ran this command on Arch Linux using the command-line utility bc.
/============================================================================-*/
#include <hidef.h>      // for EnableInterrupts macro
#include "derivative.h" // include peripheral declarations
#include "utilities.h"  // interface to some useful assembly modules

#define SINE_WAVE_RESOLUTION 20 // How many unique values will be used for the sine wave?

void main(void) {
    int i = 0;
    int sineWave [SINE_WAVE_RESOLUTION] = 
    {
        0, 24, 95, 206, 345, 500, 654, 794, 904, 975,
        1000, 975, 904, 794, 654, 500, 345, 206, 95, 24
    };

    EnableInterrupts;   // Some necessary macro... I'm not sure what it does.
    initializeIo();     // disable COP and pull up all inputs
    TPMMOD = 1000;      // count up to 1000. Will overflow at 1000 Hz (once every 1 ms).
    TPMC0V = 0;         // duty cycle default of 0. Will be varied in body of program to create actual sine wave
    TPMC0SC = 0b00101000;   // no hardware interrupts. Enable high-true left-aligned PWM output.
    TPMSC = 0b00001011; // disable interrupts. use internal clock (8MHz). Clock divisor of 8.

    while(1) {
        // repeatedly output a sine wave
        // 10 full waves will repeat before duty cycle is changed
        // 200 ms will pass for each full sine wave
        for(i = 0; i < SINE_WAVE_RESOLUTION; ++i) {
            TPMC0V = sineWave[i];
            DELAY_10MS();
        }
    }

    while(1) {
        ; // please make sure that you never leave main
    }
}