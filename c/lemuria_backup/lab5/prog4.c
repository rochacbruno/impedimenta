/* prog4.c -- Jeremy Audet, Tue Sep 22 16:13:17 EDT 2009 */
/* prompt user for an int; if number != 13, prompt again; when number = 13, finish */
#include <stdio.h>

int main(void)
{
	int secret_code = 13;
	int code_entered = 0;

	printf("To enter the Triskadekaphobia Therapy Club, enter the secret code: ");
	scanf("%d", &code_entered);
	while(code_entered != secret_code)
	{
		printf("To enter the Triskadekaphobia Therapy Club, enter the secret code: ");
		scanf("%d", &code_entered);
	}
	printf("Congratulations, you are cured!\n");


	return 0;
}
