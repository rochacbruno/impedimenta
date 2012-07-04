/* prog1.c -- Jeremy Audet, Tue Oct 20 15:08:06 EDT 2009 */
/* Find the greater of two numbers entered. Modify listing 9.3 on page 312 */


#include <stdio.h>
int imax(int, int);

int main(void)
{
	int evil1, evil2;

	printf("Enter a pair of integers (q to quit):\n");
	while(scanf("%d %d", &evil1, &evil2) == 2)
	{
		printf("The greater of %d and %d is %d.\n", evil1, evil2, imax(evil1, evil2));
		printf("Enter a pair of integers (q to quit):\n");
	}
	printf("Bye.\n");

	return 0;
}

int imax(int x, int y)
{
	int max;

	if (x > y)
		max = x;
	else
		max = y;

	return max;
}
