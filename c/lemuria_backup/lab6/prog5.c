/* prog5.c -- Jeremy Audet, Tue Sep 29 16:12:07 EDT 2009 */
/* Function to find the minimum value in an array. Array values are predetermined. */

#include <stdio.h>

int minimum(int values[], int numberofelements);
int main(void)
{
	int array1[5] = { 157, -28, -37, 26, 10};	// array1 initialized
	int array2[7] = { 12, 45, 1, 10, 5, 3, 22};	// array2 initialized

	printf("array1 minimum: %i\n", minimum(array1, 5));
	printf("array2 minimum: %i\n", minimum(array2, 7));

	return 0;
}



int minimum(int values[], int numberofelements)		// values[] initialized, numberofelements initialized
{
	int minvalue;
	int i;

	minvalue = values[0];				// minvalue initialized
	for(i = 1; i < numberofelements; i++) 		// i initialized
	{
		if(values[i] < minvalue)
		{
			minvalue = values[i];
		}
	}

	return minvalue;
}
