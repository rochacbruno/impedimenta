/* prog2c.c -- Jeremy Audet, Tue Oct  6 15:32:28 EDT 2009 */
/*
*/


#include <stdio.h>

int main(void)
{
	char ch;

	do{
		scanf("%c", &ch);
		printf("%c", ch);
	}while(ch != 'g');

	return 0;
}
