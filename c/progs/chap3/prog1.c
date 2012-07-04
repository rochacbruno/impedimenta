#include <stdio.h>

int main(void)
{
	int num; //Number is a constant, and will be printed out later.

	num = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2; //Fifteen 2's give 32767, this is more than fifteen.
	printf("%d\n", num);

	return 0;
}
