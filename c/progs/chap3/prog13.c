/* prog13.c -- takes an input number and uses it as an ASCII escape code */
#include <stdio.h>

int main(void)
{
	int num1 = 0;

	printf("Please enter a number between 0 and 127: ");
	scanf("%d", &num1);
	printf("The ASCII representation of what you entered is %c.\n", num1);

	return 0;
}
