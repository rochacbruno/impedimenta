/* prog2.c -- Jeremy Audet, Tue Oct 20 15:15:40 EDT 2009 */
/* program takes three floating-point values, passes them to a function, and returns the smallest value */
/*
main function:
ask for input;
scan for input;
while three floats are given for input,
	call minvalue function;
	print results;
	ask for input;
	run again;
END;

minvalue function:
store the three passed floats;
set min to lowest float;
return min;
END;
*/


#include <stdio.h>
double minvalue(double x, double y, double z);

int main(void)
{
	double var1, var2, var3;

	printf("Please enter three floats (q to quit):\n");
	while(scanf("%lf %lf %lf", &var1, &var2, &var3) == 3)
	{
		printf("The least of %.3f, %.3f, and %.3f is %.3f.\n", var1, var2, var3, minvalue(var1, var2, var3));
		printf("Please enter three floats (q to quit):\n");
	}
	printf("Bye.\n");

	return 0;
}


double minvalue(double x, double y, double z)
{
	double min;

	if(x > y)
		min = y;
	else if(x > z)
		min = z;
	else
		min = x;

	return min;
}
