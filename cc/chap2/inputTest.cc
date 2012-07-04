#include <iostream>
using namespace std;

int main(void) {
	int inputNumber = 0;

	cout << "Before getting any input, here's our number...\n"
	     << "***"
	     << inputNumber
	     << "***\n";
	cout << "Now, please, enter an integer: ";
	cin >> inputNumber;
	cout << "After getting input, here's our number...\n"
	     << "***"
	     << inputNumber
	     << "***\n";
	cout << "Thank you.\n";

	return 0;
}
