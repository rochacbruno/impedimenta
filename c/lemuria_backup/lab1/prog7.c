/* prog7.c -- Asks for first name and last name, then prints them  out in format _last, first_. */

#include <stdio.h>

int main(void)
{
	char fname[20];
	char lname[20];

	printf("Please enter your first name: ");
	scanf("%s", fname);
	printf("And your last name too: ");
	scanf("%s", lname);
	printf("Your name in the format _last, first_ is _%s, %s_.\n", lname, fname);

	return 0;
}
