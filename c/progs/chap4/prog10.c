/* prog10.c -- testing out various conversion specifications. */
#include <stdio.h>

int main(void)
{
	int var1 = 12345;
	float var2 = 0;
	char var3[40] = ("Test string, called var3. Yeaaa!");

	printf("Decimal int field width equal to no. of digits: %d.\n", var1);
	printf("Hex int with field width 4 in form 8A: %4X.\n", var1);
	printf("Floating point number with decimal and field width 10: %10f.\n", var2);
	printf("Floating point number in scientific form, field width 12: %12e.\n", var2);
	printf("String, left-justified, field width 30: %-30s\n", var3);

	return 0;
}
