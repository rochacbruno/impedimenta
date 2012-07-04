/* prog8.c -- scan an string from standard input. Use format specifiers to print out the string in several different ways. */

#include <stdio.h>
#include <string.h>

int main(void)
{
	char name[20];

	// Remember to use \" and strlen()
	printf("Please input your first name: ");
	scanf("%s", name);
	printf("\"%s\"\n", name);
	printf("\"%20s\"\n", name);
	printf("\"%-20s\"\n", name);
	printf("   %s\n", name);

	return 0;
}
