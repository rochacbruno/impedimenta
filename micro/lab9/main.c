/*-============================================================================/
Jeremy Audet for Micro, taught by Matt Gallagher
Lab 9

Read input from a keypad ad infinitum. WARNING: this code WILL overflow the buffer which holds input.
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
    while(1) {      // do this forever
        if(anyKey()) {  // if a key has been pressed
            buffer[i] = getKey();
            ++i;    // fragile code, will overflow
        }
    }
} // please make sure that you never leave main
