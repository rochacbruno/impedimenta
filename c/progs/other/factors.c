/* factors.c -- a program for finding the factors of a given int */
#include <stdio.h>

int main(void)
{
	const int LENGTH = 16;			//Number of cells in factors[]
	int num = 0;				//This is the number that is being factored
	int divisor = 0;
	int modulo = 0;
	int cell = 0;				//Used to control which cell numbers are read into and out of factors[]
	int array_len = 0;			//Used to determine how many factors will be printed out. I would LOVE to see this replaced with something like strlen(factors[]) in line 37 instead of this.
	int factors[LENGTH];			//Stores the actual factors

	printf("Please enter an integer between 0 - 65535: ");
	scanf("%d", &num);
	while(num < 0 || num > 65535)
	{
		printf("Error: number entered is outside of acceptable range(0 - 65535).\n");
		printf("Please enter an integer: ");
		scanf("%d", &num);
	}
						//Factoring time!
	for(divisor = 2, cell = 0, array_len = 0; num > 1 || num < -1; divisor++)
	{
		modulo = num % divisor;
		if(modulo == 0)			//If the divisor evenly divides into num, then a factor has been found.
		{
			num /= divisor;
			factors[cell] = divisor;
			++cell;			//Next time a number is read into factors[], that number will be read into the next memory cell
			--divisor;		//Due to the fact that smaller factors are tried before larger factors, I know that the "next successful divisor" >= "current divisor". --divisor, in conjunction with the divisor++ inside for(), keeps divisor at current value. Basically, this says "try dividing by the current divisor value again." Helps cut down on interations necessary.
			++array_len;
		}
	}

	printf("Here are the factors.\n");
	for(cell = 0; cell < array_len; cell++)	//Assuming an array_len of 1, 1 factor will be printed because 0 < 1.
	{
		printf("Factor %2d: %d\n", cell + 1, factors[cell]);
	}

	return 0;
}
