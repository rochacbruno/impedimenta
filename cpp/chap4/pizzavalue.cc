#include <iostream>
using namespace std;

double valueCalculator(double, double);
/*------------------------------------------------------------------------------
Due to the overlap of variables and the incredibly simple function performed, this might well be the most unnecessary function I have ever written.
------------------------------------------------------------------------------*/

int main(void) {
	double diameterOfPizzaIn = 0;
	double priceOfPizza = 0;

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout.precision(4);

	cout << "Please enter the diameter of your pizza, in inches: ";
	cin >> diameterOfPizzaIn;
	cout << "Please enter the cost of your pizza, in dollars: ";
	cin >> priceOfPizza;
	cout << "Your pizza will cost $"
	     << valueCalculator(diameterOfPizzaIn, priceOfPizza)
	     << "/sq.Inch\n";

	return 0;
}

double valueCalculator(double diameterOfPizzaIn, double priceOfPizza) {
	cout << (3.14159 * (diameterOfPizzaIn / 2) * (diameterOfPizzaIn / 2))
	     << " sq inches in the pizza.\n";
	return (priceOfPizza / (3.14159 * (diameterOfPizzaIn / 2) * (diameterOfPizzaIn / 2)));
}
