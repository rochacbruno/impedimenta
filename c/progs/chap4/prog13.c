/* prog13.c -- answer to question 7 in chapter 4 review */
/* Takes input miles and gallons, and uses those two values to find several other measurements, such as mpg and kpl. */
#include <stdio.h>
const float mile_km = 1.609; //Constant for converting from miles to kilometers
const float gallon_liter = 3.875; //Constant for converting from gallons to liters

int main(void)
{
	float miles = 0, gallons = 0; //Use just these two variables to find all other measurements.
	float kilometers = 0, liters = 0;
	float mpg = 0, lpk = 0; //Miles per gallon, liters per kilometer

	printf("Enter miles traveled and gallons used, separated only by whitespace.\n");
	scanf("%f%f", &miles, &gallons);

	mpg = miles / gallons;
	kilometers = miles * mile_km;
	liters = gallons * gallon_liter;
	lpk = liters / kilometers;
	
	printf("%.2f miles traveled, using %.2f gallons of fuel.\n", miles, gallons);
	printf("Fuel efficency was %.2f mpg.\n", mpg);
	printf("%.2f kilometers traveled, using %.2f liters of fuel.\n", kilometers, liters);
	printf("Fuel efficency was %.2f liters per 100 kilometers.(%.2f lpk)\n", lpk * 100, lpk);

	return 0;
}
