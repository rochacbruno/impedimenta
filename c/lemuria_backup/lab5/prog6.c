/* prog6.c -- Jeremy Audet, Tue Sep 22 16:29:34 EDT 2009 */
/* have user enter x integers and read the values into an array of the same size; print out the values in the array one at a time; add each value to 
a sum and average the sum; print out the average */
#include <stdio.h>

#define SIZE 10
#define PAR 72
int main(void)
{
	int index, score[SIZE];
	int sum = 0;		//Keeps track of how many times a loop has been completed
	float average = 0;

	printf("Please enter your %d golf scores:\n", SIZE);
	for(index = 0; index < SIZE; index++)
		scanf("%d", &score[index]);
	printf("The scores are as follows: \n");
	for(index = 0; index < SIZE; index++)
		printf("%5d", score[index]);
	printf("\n");
	for(index = 0; index < SIZE; index++)
		sum +=score[index];
	average = sum / SIZE;

	printf("Sum of scores: %d, average: %.2f\n", sum, average);
	printf("That's a handicap of %d.\n", sum - PAR);

	return 0;
}
