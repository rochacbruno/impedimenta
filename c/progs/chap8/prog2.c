/* prog2.c -- Jeremy Audet, Wed Oct 21 10:36:00 EDT 2009 */
/* play with the * in a scanf() and printf() statement. */


#include <stdio.h>

int main(void)
{
	int spaces;

	printf("Tell me how many spaces to use.\n");
	scanf("* %d", &spaces);
	printf("Spaces uses '%*d' spaces.\n", spaces, spaces);

	return 0;
}
