#include <stdio.h>
#include "prog7.h"

double raise(double orig_num, int power)
{
	double temp;
	_Bool positive = TRUE;			// I'll assume that the number is positive unless found to be otherwise.

	if(orig_num == 0.000000)
		return 0.000000;
	if(power == 0)
		return 1.000000;
	if(power < 0)			// If power is negative, note this fact and make power positive.
	{
		positive = FALSE;
		power *= -1;
	}
	temp *= orig_num;		// Raise by a power, and...
	if(--power >= 1)		// ...there's one less power to use
		temp = raise(orig_num, power);
	if(positive == TRUE)
		temp = 1 / temp;

	return temp;
}
