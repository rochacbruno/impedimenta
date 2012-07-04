/* prog2.c -- Jeremy Audet, Tue Sep 29 15:27:10 EDT 2009 */
/*
print 1 through 20;
print 20 through 1;
print 2 - 20, evens;
END;
*/

#include <stdio.h>

int main(void)
{
	int adjust;

	for(adjust = 0; adjust < 20; adjust++)		// Adjust will be 19 on last loop
		printf("%d ", 1 + adjust);
	printf("\n");
	for(adjust = 0; adjust < 20; adjust++)		// Adjust will be 19 on last loop
		printf("%d ", 20 - adjust);
	printf("\n");
	for(adjust = 0; adjust < 20; adjust += 2)	// Adjust will be 18 on last loop
		printf("%d ", 2 + adjust);
	printf("\n");

	return 0;
}
