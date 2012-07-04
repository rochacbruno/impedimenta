/* prog5.c -- listing 5.12 on p. 148. Subtracts 1 from var count every single time the while loop is run. */
#include <stdio.h>
#define MAX 100

int main(void)
{
	int count = MAX + 1;

	while (--count > 0)
	{
		printf("%d bottles of spring water on the wall, %d bottles of spring water!\n", count, count);
		printf("Take one down and pass it around, \n");
		printf("%d bottles of spring water!\n\n", count - 1);
	}

	return 0;
}
