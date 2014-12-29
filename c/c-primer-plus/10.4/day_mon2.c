/* Demonstrate some simple array manipulations.
 *
 * Demonstrate the following:
 *
 * * How to declare an automatically sized array and initialize it all at once.
 * * How to use the `sizeof` keyword in a useful manner.
 */
#include <stdio.h>

/* Print the number of days in each month. */
int main(void) {
    const int days[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31};  // oops!
    int i;
    for(i = 0; i < sizeof days / sizeof days[0]; i++) {
        printf("Month %2d has %d days.\n", i + 1, days[i]);
    }
    return 0;
}
