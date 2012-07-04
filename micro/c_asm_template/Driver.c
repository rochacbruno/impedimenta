/*-============================================================================/
Jeremy Audet, for micro, taught by Matt Gallagher.
/============================================================================-*/
#include <hidef.h>      // for EnableInterrupts macro
#include "derivative.h" // include peripheral declarations
#include "utilities.h"  // interface to some useful assembly modules

void main(void) {
    EnableInterrupts;   // Some macro... I'm not sure what it does.
    initializeIo();     // disable COP and pull up all inputs

    while(1) {
        ; // please make sure that you never leave main
    }
}
