#include <iostream>
using namespace std;

int main(void) {
	int yearsBuyingPencils = 0;
	double rateOfInflation = 0.0;
	double costOfPencils = 0.0;
	int count = 0;

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout.precision(2);

	cout << "What is the current cost of 200 pencils?\n";
	cin >> costOfPencils;
	cout << "How many years will you be buying pencils for?\n";
	cin >> yearsBuyingPencils;
	cout << "What is the annual rate of inflation, as a percent?\n";
	cin >> rateOfInflation;
	rateOfInflation /= 100.0;

	cout << endl;
	for(count = 0; count <= yearsBuyingPencils; count++) {
		if(count == 0) {
			/* do not display price for this year's pencils */ ;
		} else {
			costOfPencils = costOfPencils * (rateOfInflation + 1);
			cout << "The cost of pencils during year "
			     << count
			     << " will be "
			     << costOfPencils
			     << endl;
		}
	}

	return 0;
}
