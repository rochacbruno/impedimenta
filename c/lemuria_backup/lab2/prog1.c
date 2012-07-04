/* prog1.c -- prints out the value of x for four different statements. */
#include <stdio.h>

int main(void)
{
	int x = 0;
	int y = 0;

	x = (2+3)*6;
	printf("The value of x in part a is %d.\n", x);
	x = (12+6)/(2*3);
	printf("The value of x in part b is %d.\n", x);
	y = x = (2+3)/4;
	printf("The value of x and y in part c is %d and %d.\n", x, y);
	y = 3 + (2*(x = (7/2)));
	printf("The value of x and y in part d is %d and %d.\n", x, y);

	return 0;
}
