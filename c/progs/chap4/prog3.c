/* prog3.c -- prints out a single string, and inserts some values with some formatting options. */
#include <stdio.h>

int main(void)
{
	const char NAME[40] = "Johnson";
	const float money = 200.499;

	printf("The %s family may just be $%5.2f richer!\n", NAME, money);

	return 0;
}
