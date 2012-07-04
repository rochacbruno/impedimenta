#include <hidef.h>      // for EnableInterrupts macro
#include "derivative.h" // include peripheral declarations

#include "utilities.h"  // interface to some useful assembly modules

void main(void) {
    int i = 0;

    EnableInterrupts;
    initializeIo();         // disable COP and pull up all inputs
    PTADD = 0b00101110;     // setup PTA (switches) as ouptput

/*    while(1) {
        PTAD = 0b00000000;
        DELAY_1MS();

        PTAD = 0b00000011;
        DELAY_1MS();

        PTAD = 0b00000111;
        DELAY_1MS();

        PTAD = 0b00001011;
        DELAY_1MS();

        PTAD = 0b00001111;
        DELAY_1MS();
    }
*/

/*    while(1) {
        PTAD = 0;

        for(i = 0; i < 0x0f; ++i) {
            DELAY_1MS();
            PTAD++;
            DELAY_1MS();
        }
    }
*/

    while(1) {
        ; // please make sure that you never leave main
    }
}
