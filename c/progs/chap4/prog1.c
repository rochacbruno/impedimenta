// prog1.c -- Prints out a character, 'x', and two character strings, then counts out the length of each array and the number of characters in each.
#include <stdio.h>
#include <string.h>

int main(void)
{
	char test1 = 'x';
	char test2[10] = "x";
	char test3[50] = "The first x is a char, the 2nd is a string.";

	int array_size;
	int string_len;

	printf("1) %c\n",
		test1);
	printf("2) %s\n",
		test2);
	printf("3) %s\n\n",
		test3);

	/*array_size = sizeof test1;
	string_len = strlen(test1);
	printf("Line 1 has an array of %d bytes holding %d characters.\n",
		array_size, string_len);*/
	array_size = sizeof test2;
	string_len = strlen(test2);
	printf("Line 2 has an array of %d bytes holding %d characters.\n",
		array_size, string_len);
	array_size = sizeof test3;
	string_len = strlen(test3);
	printf("Line 3 has an array of %d bytes holding %d characters.\n",
		array_size, string_len);

	return 0;
}
