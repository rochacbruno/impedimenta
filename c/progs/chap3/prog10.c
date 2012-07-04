/* prog10.c -- answer to chapter 3 review question. see answers.txt. */
/* Assign a carraige return to char ch using four different methods: escape sequence, decimal value, octal character constant, and hex character constant */
#include <stdio.h>

int main(void)
{
	char ch;

	ch = '\n';
	printf("1**%c**\n", ch);
	ch = 10;
	printf("2**%c**\n", ch);
	ch = '\xa';
	printf("3**%c**\n", ch);
	ch = '\012';
	printf("4**%c**\n", ch);

	return 0;
}
