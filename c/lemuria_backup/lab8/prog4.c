/* prog4.c -- Jeremy Audet, Tue Oct 20 16:57:09 EDT 2009 */
/* takes input, averages input, returns value based upon average */
/* david nueve */


#include <stdio.h>

int main(void)
{
	int grade;
	int average = 0;
	int loops = 0;
	int gpa;

	printf("Please enter a grade to be averaged (q to quit):\n");
	while(scanf("%d", &grade) == 1)
	{
		average = (average * loops + grade) / (loops + 1);
		++loops;
		printf("Current average is %d.\n", average);
		printf("Please enter a grade to be averaged(q to quit):\n");
	}
	printf("The average is %d.\n", average);
	if

	return 0;
}
