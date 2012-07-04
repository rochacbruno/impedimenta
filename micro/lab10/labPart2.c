#include <hidef.h>      // for EnableInterrupts macro
#include "derivative.h" // include peripheral declarations
#include "utilities.h"  // interface to some useful assembly modules

void main(void) {
    int i = 0;
    int sineTable[10]={0,30,200,600,1000,600,200,30,0,10};

    EnableInterrupts;       // macro from hidef.h
    initializeIo();         // disable COP and pull up all inputs
    TPMMOD = 1000;          // reset the counter after getting to 1000
    TPMSC = 0b00001011;     // Disable clock interrupts. When in PWM mode, make left-aligned pulses. Use the bus on the chip as a clock source (4 MHz). Use a clock divisor of 8.
    TPMC0SC = 0b00101000;   // Enable channel 0 as an interrupt.
    TPMC0V = 100;

    while(1) {
      for(i=0; i<10; i++) {
          TPMC0V = SineTable[i];
          delay_100ms();
      }
    }

    while(1) {
        ; // please make sure that you never leave main
    }
}
