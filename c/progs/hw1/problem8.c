/* problem8.c -- Jeremy Audet, Tue Sep 15 22:23:06 EDT 2009 */
/* declare num and initialize; check to see if it is less than 65; if so, increment by 1 and print out the occasional message; else, end program */
#include <stdio.h>

int main(void)
{
	int age = 20;

	while(age++ <= 65)
	{
		if((age % 20) == 0)
			printf("Congratulations, you are %d! Here's a raise.\n", age);
		if(age == 65)
			printf("You are %d. Here is your gold watch.\n", age);
	}

	return 0;
}
