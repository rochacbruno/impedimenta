/* prog5.c -- Try reading a string with escape characters embedded, then printing the result out. */
#include <stdio.h>

int main(void)
{
	char string[40];

	printf("Please input a string: ");
	scanf("%s", string);
	printf("You said: %s\n", string);

	return 0;
}
