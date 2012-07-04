/* prog7.c -- The purpose of this program is to test the syntax for declaring various types of floats. */
#include <stdio.h>
#define CONST1 2.5654
#define CONST2 -3.2445e-4 //Only six sig digs. How to declare a const with more?
#define CONST3 -1.1221456324e-1L
#define CONST4 0xc.1e3p3 //The 0x prefix indicates hex notation following, the p signifies an exponent is following(instead of an e), and the 3 indicates 2^3

int main(void)
{
	float f_num1 = 1.534;
	double f_num2 = 2.524;
	double f_num3 = 3.4234;
	long double f_num4 = 4.5432;
	long double f_num5 = 5.5443; //Trying to declare a double float or long double float will not work
	const double f_num6 = -2.234e-3;

	printf("num1 = %f and %e\n", f_num1, f_num1);
	printf("num2 = %f\n", f_num2);
	printf("num3 = %f\n", f_num3);
	printf("num4 = %Lf\n", f_num4);
	printf("num5 = %Lf\n", f_num5);
	printf("num6 = %f and %e\n", f_num6, f_num6);
	printf("const1 = %f\n", CONST1);
	printf("const2 = %f\n", CONST2);
	printf("const3 = %Lf\n", CONST3);
	printf("const4 = %f and %e\n", CONST4, CONST4);

	return 0;
}
