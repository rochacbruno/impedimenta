/* prog2.c -- programming exercise 1, page 167, chapter 5. */
/* accept input (input is int, represents seconds); if 0 is input, prompt again; print out value in minutes and seconds */
#include <stdio.h>

int main(void)
{
	const int SEC_MIN = 60; // 60 seconds per minute. value is same as 1 min/60 sec
	int seconds = 0;

	printf("Please input the number of seconds: ");
	scanf("%d", &seconds);
	while(seconds == 0)
	{
		printf("Input not valid. Input time other than 0: ");
		scanf("%d", &seconds);
	}
	printf("Time is equal to %d minutes and %d seconds.\n", seconds / SEC_MIN, seconds % SEC_MIN);

	return 0;
}
