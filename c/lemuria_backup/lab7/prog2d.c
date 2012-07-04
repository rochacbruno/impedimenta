/* prog2d.c -- Jeremy Audet, Tue Oct  6 15:35:18 EDT 2009 */
/* 
*/


#include <stdio.h>

int main(void)
{
	char ch;

	scanf("%c", &ch);
	for(ch = '$'; ch != 'g'; scanf("%c", &ch))
		putchar(ch);

	return 0;
}

