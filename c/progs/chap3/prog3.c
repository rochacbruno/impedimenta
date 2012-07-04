// prog3.c -- Prints out a single int value in seven different formats.
#include <stdio.h>

int main(void)
{
	int num = 153; //This is the number to be printed out in the different formats.

	printf("Decimal: %d Octal: %o Hex: %x\n", num, num, num);
	printf("Decimal: %d Octal+prefix: %#o Hex+prefix: %#x Hex+bigprefix: %#X\n", num, num, num, num);

	return 0;
}
