/* problem7.c -- takes user input; uses if, else if, else statement to decide what type of character counter to increment; keep reading input until # is given; print out results. */
/* Jeremy Audet -- Tue Sep 15 21:58:41 EDT 2009 */
#include <stdio.h>
#include <ctype.h>

int main(void)
{
	char ch;		// Used to read characters from standard input.
	int lc_count = 0;	// Lower case character count
	int uc_count = 0;	// Upper case character count
	int oc_count = 0;	// Other character count

	printf("Enter input (# to quit):\n");
	while((ch = getchar()) != '#')
	{
		if(ch >= 'a' && ch <= 'z')
			lc_count++;
		else if(ch >= 'A' && ch <= 'Z')
			uc_count++;
		else
			oc_count++;
	}
	printf("  uc  lc  oc\n");
	printf("%4d%4d%4d\n", uc_count, lc_count, oc_count);

	return 0;
}
