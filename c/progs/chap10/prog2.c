/* prog2.c -- derived from exercise 2, in the chapter 10 review (p.397) */

#include <stdio.h>
#define SIZE 25
void copy_arr(const double source[], double destination[]);
void copy_ptr(const double * source, double * destination);		// double source[] and double * source are the same statement
void print_arr(const double * source);

int main(void)
{
	double original[SIZE];
	double copy1[SIZE];
	double copy2[SIZE];
	int num;

//----fill original with values
	for(num = 0; num < SIZE; num++)
		*(original + num) = (double)(num + 1) * 1.01;
//----show original arrays
	puts("        Original Arrays");
	puts("Original:");
	print_arr(original);
	puts("Copy 1:");
	print_arr(copy1);
	puts("Copy 2:");
	print_arr(copy2);
//----make copies
	copy_arr(original, copy1);
	copy_ptr(original, copy2);
//----show modified arrays
	puts("        Modified Arrays");
	puts("Original:");
	print_arr(original);
	puts("Copy 1:");
	print_arr(copy1);
	puts("Copy 2:");
	print_arr(copy2);

	return 0;
}

void copy_arr(const double source[], double destination[])
{
	int num;

	for(num = 0; num < SIZE; num++)
		destination[num] = source[num];
}

void copy_ptr(const double * source, double * destination)
{
	const double * source_end = source + SIZE;

	while(source < source_end)
		*(destination++) = *(source++);
}

void print_arr(const double * source)
{
	int num;

	for(num = 0; num < SIZE; num++)
	{
		printf("%6.2f ", *(source + num));
		if((num + 1) % 10 == 0)
			putchar('\n');
	}
	putchar('\n');
}
