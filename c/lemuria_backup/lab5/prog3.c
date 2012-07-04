/* prog3.c -- Jeremy Audet, Tue Sep 22 16:07:57 EDT 2009 */
/* example of a do while loop */
#include <stdio.h>

int main(void)
{
	int secret_code = 13;
	int code_entered = 0;

	do
	{
		printf("To enter the Triskadekaphobia Therapy Club, enter the secret code number: ");
		scanf("%d", &code_entered);
	} while (code_entered != secret_code);

	printf("Congratulations! You are cured!\n");

	return 0;
}
