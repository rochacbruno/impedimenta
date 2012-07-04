/* prog1.c -- Homework #2 problem #1 */
/* Write a program that sums the elements of array int, where int a[] = {1, 2, 3, 4, 5, 6} */
/*
declare values for int;

set the current total to zero;
read the first element and add it to zero;
read the second element and add it to zero;
...;
display the total;
END;
*/

#include <stdio.h>

int main(void)
{
	int a[] = {1, 2, 3, 4, 5, 6};
	int num, total;

	for(num = 0, total = 0; num <=5; num++)			// Loop runs 5 times total
	{
		printf("First element: %d.\n", a[num]);		// Prints out the current element being added to the total
		total += a[num];				// Adds the current element to the total
	}
	printf("The total is %d.\n", total);

	return 0;
}
