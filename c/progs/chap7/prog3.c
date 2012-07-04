/* prog3.c -- Jeremy Audet, Tue Sep 29 21:51:20 EDT 2009 */
#include <stdio.h>

int main(void)
{
	if(100 > 3 && 'a' > 'c')
		printf("True\n");
	else
		printf("False\n");
	if(100 > 3 || 'a' > 'c')
		printf("True\n");
	else
		printf("False\n");
	if( !(100 > 3) )
		printf("True\n");
	else
		printf("False\n");

	return 0;
}
