/* prog2.c -- program 2 for homework number 2 */
/* wrote a square() function and use it to print the squares of numbers 1 through 10 */
/*
hand the first number to square();
print out the return value;
hand the second number to square();
print out the return value;
... until 10 is handed & printed ...
END;
*/

#include <stdio.h>
int square(int seed);

int main(void)
{
	int num;
	for(num = 0; num <= 10; num++)		// runs the loop 10 times
		printf("The square of %d is %d.\n", num, square(num));

	return 0;
}

int square(int seed)
{
	int square;

	square = seed * seed;

	return square;				// return the square of the value passed to this function (that value being seed)
}
