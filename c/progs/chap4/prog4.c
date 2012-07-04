/* prog4.c -- Scans input in several different ways. Experiments with whitespaces in scanf() function */
#include <stdio.h>

int main(void)
{
	int a = 0, b = 0, c = 0;
	char d[40];

	printf("Input three ints.\n");
	scanf("%d%d %d %s", &a, &b, &c, d);
	printf("values: %d, %d, %d, and %s.\n", a, b, c, d);
	printf("Input three ints, again.\n");
	scanf("%d", &a);
	scanf("%d", &b);
	scanf("%d", &c);
	scanf("%s", d);
	printf("Values: %d, %d, %d, and %s.\n", a, b, c, d);
	

	return 0;
}
