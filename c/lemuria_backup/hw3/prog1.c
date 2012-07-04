/* prog1.c -- Jeremy Audet */
/* compare two strings and indicate if they are equal or not */

#include <stdio.h>
#include <strings.h>

int main(void)
{
	char string1[20] = "I Love Isograms";
	char string2[20] = "I Love Isograms";

	if(strcmp(string1, string2))
		printf("The strings \"%s\" and \"%s\" are not the same.\n", string1, string2);
	else
		printf("The strings \"%s\" and \"%s\" are the same.\n", string1, string2);

	return 0;
}
