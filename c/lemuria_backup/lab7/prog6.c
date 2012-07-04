/* prog6.c -- Jeremy Audet, Tue Oct  6 16:10:02 EDT 2009 */
/*
find the maximum value in each array given;
print out the results;
--------------------------------------------
define an array;
define a second array;
hand off first array and number of values in array to function,
	set maxvalue to first value of array;
	set count to 0;
	as long as count is less than number of values in array;
		if second/etc value of array is greater than first,
			set maxvalue to second/etc value;
	return maxvalue;
print out maxvalue;
repeat for the second array;
END;
*/

#include <stdio.h>
int maximum(int values[], int numberofelements);

int main(void)
{
	int array1[5] = {1742, -28, -37, 145, 10};
	int array2[7] = {12, 45, 1, 10, 176, 3, 22};

	printf("array1 maximum: %i\n", maximum(array1, 5));
	printf("array2 maximum: %i\n", maximum(array2, 7));

	return 0;
}

int maximum(int values[], int numberofelements)
{
	int maxvalue, i;

	maxvalue = values[0];
	for(i = 1; i < numberofelements; i++)
	{
		if(values[i] > maxvalue)
			maxvalue = values[i];
	}

	return maxvalue;
}
