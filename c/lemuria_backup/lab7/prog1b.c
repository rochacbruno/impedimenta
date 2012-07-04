/* prog1-1.c -- Jeremy Audet, Tue Oct  6 15:20:17 EDT 2009 */
/*

*/


#include <stdio.h>

int main(void)
{
	int i;
	char ch;

	for(i = 0, ch = 'A'; i < 4; i++, ch += 2 * i)
		printf("%c", ch);
	putchar('\n');

	return 0;
}
