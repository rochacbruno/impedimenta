#include <iostream>
using namespace std;

int main(void) {
	double c = 20;
	double f = 0;

	f = (9/5) * c + 32.0;
	cout << "Fahrenheit = " << f << endl;

	f = (9.0/5.0) * c + 32.0;
	cout << "Fahrenheit = " << f << endl;

	return 0;
}
