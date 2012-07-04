/* prog3.c -- problem 3 for homework number 2 */
/* write a program that simulates coin tossing. */
/*
call flip();
if return % 2 == 1,
	print heads;
	headcount++;
else
	print tails
	tailcount++;
print totals;
END;
*/

#include <stdio.h>
int flip(void);

int main(void)
{
	int headcount = 0;
	int tailcount = 0;
	int num;

	for(num = 1; num <= 100; num++)
	{
		if((flip() % 2) == 1)		// All of the results flip() can return are divided into two camps: those that can be divided by 2, and those that cannot.
		{
			headcount++;		// One of the two possible results of flip() % 2 increments headcount...
			printf("Test %3d: Heads     ", num);
		}
		else
		{
			tailcount++;		// The other possible result of flip() % 2 increments tailcount.
			printf("Test %3d: Tails     ", num);
		}
		if(num % 4 == 0)		// Simply places a newline every time 4 results have been printed. Makes the results easier to read, while ensuring the results are still small enough to fit inside a standard terminal.
			putchar('\n');
	}
	printf("Heads: %d\n", headcount);
	printf("Tails: %d\n", tailcount);

	return 0;
}

int flip(void)
{
	return rand();
}
