/*-============================================================================/
Jeremy Audet for Micro, taught by Matt Gallagher
Homework 9

Read input from a keypad. Start reading input at the beginning of the buffer whenever 20 characters have been read. Whenever key 0 has been pressed, blink LEDs showing that input has been read.
/============================================================================-*/
#include <hidef.h>      // for EnableInterrupts macro
#include "derivative.h" // include peripheral declarations
#include "main_asm.h"   // interface to the assembly module
#include "utilities.h"  // allows access to some delay functions

void main(void) {
    char i = 0;
    char buffer[20];

    EnableInterrupts;
    initializeIo();
    keyInit();

    i = 0;
    while(1) {
        if(anyKey()) {
            buffer[i] = getKey();
            if('0' == buffer[i]) {
                blinkLeds();
            }
            ++i;
        }

        // buffer should never overflow
        if(i >= 21) {
            i = 0;
        }
    }
} // please make sure that you never leave main
