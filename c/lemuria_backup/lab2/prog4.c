/* progr.c -- listing 5.11 on page 146. shows the differences between prefixing vars and postfixing vars. */
#include <stdio.h>

int main(void)
{
	int a = 1, b = 1;
	int aplus; // = a++;
	int plusb; // = ++b;

	aplus = a++;
	plusb = ++b;
	printf("a   aplus   b   plusb \n");
	printf("%1d %5d %5d %5d\n", a, aplus, b, plusb);

	return 0;
}
