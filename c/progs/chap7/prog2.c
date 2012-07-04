/* prog2.c -- test a while loop utilizing a scanf() function */
#include <stdio.h>

int main(void)
{
	int num = 0;

	while(scanf("%d", &num) == 1)
		printf("%d\n", num);
	printf("Done!\n");

	return 0;
}
