#include <iostream>
using namespace std;

int main(void) {
	int numOne = 0;
	int numTwo = 0;

	cout << "Please enter two whole numbers.\n";
	cin >> numOne >> numTwo;
	cout << numOne << "/" << numTwo << " = " << numOne/numTwo << " with a remainder of " << numOne%numTwo << endl;

	return 0;
}
