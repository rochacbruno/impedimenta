/* prog1.c -- Jeremy Audet, Sun Oct  4 10:23:58 EDT 2009 */
/* ...need to run a debugger on this program. */


#include <stdio.h>

int main(void)
{
	int ch;

	while((ch = getchar()) != EOF)
		putchar(ch);

	return 0;
}
