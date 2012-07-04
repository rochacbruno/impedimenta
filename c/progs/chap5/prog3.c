/* prog3.c -- programming exercise 2, page 167. */
/* input integer; print int + 1 ... print int + 10; end */
#include <stdio.h>

int main(void)
{
	int num = 0, numplus = 0;

	printf("Please input an integer: ");
	scanf("%d", &num);
	numplus = num + 10;
	while(num <= numplus)
	{
		printf("%d\n", num);
		num++;
	}
	printf("bye\n");

	return 0;
}
