/* prog3.c -- exercise 3 for lab 2, listing 5.13 on p. 152 */
#include <stdio.h>

int main(void)
{
	int count =0;
	int sum = 0;

	while (count++ < 20)
	{
		sum = sum + count;
		printf("sum = %d.\n", sum);
	}

	return 0;
}
