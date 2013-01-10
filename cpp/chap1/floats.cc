#include <iostream>
using namespace std;

int main(void) {
	double numOne = 3.14159;
	double numTwo = 1549.0;

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);

	cout.precision(2);
	cout << "Number one: " << numOne << endl;
	cout << "Number two: " << numTwo << endl;

	cout.precision(3);
	cout << "Num one, precision 3: " << numOne << endl;
	cout << "Num two, precision 3: " << numTwo << endl;

	// This block of code...
	cout.precision(1);
	cout << "Num one (" << numOne;
	cout.precision(2);
	cout << ") is different from numTwo (" << numTwo << ")\n";

	// is the same as this block of code. Different format, same meaning.
	cout.precision(1);
	cout << "Num one (";
	cout << numOne;
	cout.precision(2);
	cout << ") is different from numTwo (";
	cout << numTwo;
	cout << ")\n";

	return 0;
}
