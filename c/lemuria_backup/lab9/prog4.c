/* prog4.c -- Jeremy Audet, Tue Oct 27 16:11:35 EDT 2009 */
/*
print out various pointer values
*/

#include <stdio.h>
int data[2] = {100, 200};
int moredata[2] = {300, 400};

int main(void)
{
	int * p1, * p2, * p3;

	p1 = p2 = data;
	p3 = moredata;
	printf("*p1 = %d, *p2 = %d, *p3 = %d\n", *p1, *p2, *p3);
	printf("*p1++ = %d, *++p2 = %d, (*p3)++ = %d\n", *p1++, *++p2, (*p3)++);
	printf("*p1 = %d, *p2 = %d, *p3 = %d\n", *p1, *p2, *p3);

	return 0;
}

