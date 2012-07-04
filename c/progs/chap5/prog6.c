/* prog6.c -- review question 1, p. 213 */
/* define int quack, and print its value; modify its value using an abbreviated form and print out its value; repeat; end */
#include <stdio.h>

int main(void)
{
	int quack = 2;

	printf("quack = %d.\n", quack);
	printf("quack = %d.\n", quack += 5);
	printf("quack = %d.\n", quack *= 10);
	printf("quack = %d.\n", quack -= 6);
	printf("quack = %d.\n", quack /= 8);	//quack = quack / 8
	printf("quack = %d.\n", quack %= 3);	// quack = quack % 3

	return 0;
}
