#include <stdio.h>
#include "prog6.h"

double power(double orig_num, int power)
{
	double temp;
	_Bool negative = FALSE;			// I'll assume that the number is positive unless found to be otherwise.

	if(orig_num == 0.000000)
		return 0.000000;
	if(power == 0)
		return 1.000000;
	if(power < 0)			// If power is negative, note this fact and make power positive.
	{
		negative = TRUE;
		power *= -1;
	}
	for(temp = 1.000000; power >= 1; power--)		// This statement raises the number to the specified power
		temp *= orig_num;
	if(negative == TRUE)
		temp = 1 / temp;

	return temp;
}
