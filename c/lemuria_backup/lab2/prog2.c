/* prog2.c -- prints out the value of x through four different expressions */
#include <stdio.h>

int main(void)
{
	int x = 0;

	x = 3.8 + 3.3;
	printf("The value of x in part a is %d.\n", x);
	x = (2+3)*10.5;
	printf("The value of x in part b is %d.\n", x);
	x = (3/5)*22;
	printf("The value of x in part c is %d.\n", x);
	x = (22*3)/5;
	printf("The value of x in part d is %d.\n", x);

	return 0;
}
