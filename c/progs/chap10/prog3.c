/* simple program that returns the largest value in an array */

#include <stdio.h>
#define SIZE 5
double highfinder(const double * pCurrentValue);

int main(void)
{
	double pInterestLevels[SIZE] = {5.4, 9.8, -9.9, 8.1, 7.1};
	int num;

	puts("The array InterestLevels has the following values:");
	for(num = 0; num < SIZE; num++)
		printf("%4.2f  ", *(pInterestLevels + num));
	printf("\nThe largest value in the array InterestLevels is %4.2f.\n", highfinder(pInterestLevels));

	return 0;
}

double highfinder(const double * pCurrentValue)
{
	const double * pEndValue = pCurrentValue + SIZE;
	double HighValue;

	for(HighValue = *pCurrentValue; pCurrentValue < pEndValue; pCurrentValue++)
		if(HighValue < *pCurrentValue)
			HighValue = *pCurrentValue;

	return HighValue;
}
