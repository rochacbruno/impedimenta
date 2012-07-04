#include <stdio.h>

int main(void)
{
	int ten = 10;
	int two = 2;

	printf("Doing it right: ");
	printf("%d minus %d is %d.\n", ten, 2, ten - two); //Will break if you substitute 2.0 for 2
	/*printf("Doing it wrong: ");
	printf("%d minus %d is %d.\n", ten); */ //gcc will catch this error!

	return 0;
}
