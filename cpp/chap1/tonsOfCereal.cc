#include <iostream>
using namespace std;

int main(void) {
	const double METRIC_TON = 35273.92;
	double ozOfCereal = 0.0;

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout.precision(2);

	cout << "How many ounces are in a box of cereal?\n> ";
	cin >> ozOfCereal;

	cout << "If a box of cereal weighs "
	     << ozOfCereal
	     << "oz then there are "
	     << (METRIC_TON / ozOfCereal)
	     << " boxes of cereal in a metric ton. ";
	cout << "Furthermore, one box of cereal weighs about "
	     << (ozOfCereal / METRIC_TON)
	     << " metric tons.\n";
	cout << "The size of your input variable was "
	     << length(ozOfCereal)
	     << endl;

	return 0;
}
//	tonsPerBox = (ozOfCereal / METRIC_TON);
