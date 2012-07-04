/* prog12.c -- scan the 22 from catch 33 */
#include <stdio.h>

int main(void)
{
	int var1 = 0;
	char var2[10];

	printf("input catch 22\n");
	scanf("%*s %d", &var1);
	printf("Input was %d.\n", var1);
	printf("Input catch 22 again.\n");
	scanf("%*s %s", &var2);
	printf("Input was %s.\n", var2);

	return 0;
}
