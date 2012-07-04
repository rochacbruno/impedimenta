/* prog8.c -- exercise 7 on page 165. prints out several numbers all in a row, with no new lines. */
#include <stdio.h>
#define TEN 10

int main(void)
{
	int n = 0;

	while (n++ < TEN)
	{
		printf("%5d", n);
	}
	printf("\n");

	return 0;
}
