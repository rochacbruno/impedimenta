/* prog11.c -- answer to question 7 in chapter 4 review. more experimentation with conversion specifications. */
#include <stdio.h>

int main(void)
{
	unsigned long var1 = 12345;
	int var2 = 12345;
	float var3 = 1234.6789012;
	char var4[40] = "Test string for prog11.c wo0o.";

	printf("unsigned long, field width 15: %15lu\n", var1);
	printf("hex int in form 0x8a, field width 4: %#4x\n", var2);
	printf("float, 2.33E+02 notation, left-justified, field-width 12: %-12E\n", var3);
	printf("float, form +232.346, field width 10: %+10f\n", var3);
	printf("string, 8 chars: %.8s\n", var4);

	return 0;
}
