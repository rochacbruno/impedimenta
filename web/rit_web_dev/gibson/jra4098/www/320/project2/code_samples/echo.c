/*-==========================================================================-*\
Author(s):
Jeremy Audet

First Created: 10/25/2011
License: Creative Commons BY-SA         http://creativecommons.org/licenses/by-sa/3.0/

Thanks to:
* Beej's Guide to C                     http://beej.us/guide/bgc/output/html/multipage/putc.html
I had forgotten how easy it is to write out characters using putchar().

\*-==========================================================================-*/

#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char input;                         // For buffering input.

    printf("Type something, press 'enter', and it will be echoed back.\n"
           "Press CTRL-D or CTRL-C to quit.\n");
    while((input = getchar()) != EOF) {
        putchar(input);
    }
    putchar('\n');

    return 0;
}
