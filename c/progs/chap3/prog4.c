/* This program attempts to both scan and print out decimal, octal, and hexidecimal integers numbers using the scanf() and printf() functions. */
#include <stdio.h>

int main(void)
{
	int i_num1 = 11;

	printf("i_num1 is equal to %d, %#o, and %#x.\n", i_num1, i_num1, i_num1); // This line simply tests whether i_num1 has been initialized and whether my format specifiers are in order.

	printf("Please give a number to be scanned as a decimal integer: ");
	scanf("%d", &i_num1);
	printf("Your number is %d, %#o, and %#x.\n", i_num1, i_num1, i_num1);
	printf("Please give a number to be scanned as an octal integer: ");
	scanf("%o", &i_num1);
	printf("Your number is %d, %#o, and %#x.\n", i_num1, i_num1, i_num1);
	printf("Please give a number to be scanned as a hex integer: ");
	scanf("%x", &i_num1);
	printf("Your number is %d, %#o, and %#x.\n", i_num1, i_num1, i_num1);
	/* printf("Please give a number to be scaned as a hex integer with a lower case prefix: ");
	scanf("%#x", &i_num1);
	printf("Your number is %d, %#o, and %#x.\n", i_num1, i_num1, i_num1); */ //Doesn't work. The # is probably only valid for printf(), not scanf().

	return 0;
}
