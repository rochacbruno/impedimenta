/* prog9.c -- anser to chapter 4 review question 5. see answers.txt. prints out a particular statement. */
#include <stdio.h>
#define BOOK "War and Peace"

int main(void)
{
	float cost = 12.99, percent = 80.0;

	printf("This copy of %s sells for $%.2f.\n", BOOK, cost);
	printf("This is %.0f%% of list.\n", percent);

	return 0;
}
