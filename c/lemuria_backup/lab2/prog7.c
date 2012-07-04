/* prog7.c -- exercise 5 p. 165. prints out a numbver which has been modified in several different ways. */
#include <stdio.h>
#define FORMAT "%s! C is cool!\n"

int main(void)
{
	int num = 10;

	printf(FORMAT, FORMAT);
	printf("%d\n", ++num);
	printf("%d\n", num++);
	printf("%d\n", num--);
	printf("%d\n", num);

	return 0;
}
