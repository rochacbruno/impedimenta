#include <iostream>
using namespace std;

const int CONSTINT1 = 5;

int testFunction(void);

int main(void) {
	const int CONSTINT2 = 10;

	cout << "Main function here.\n";
	cout << "CONSTINT1: " << CONSTINT1 << endl;
	cout << "CONSTINT2: " << CONSTINT2 << endl;
	cout << "End main function output.\n\n";

	if (0 == testFunction()) {
		cout << "Test function executed properly\n";
	} else {
		cout << "Test function failed to execute properly.\n";
	}

	return 0;
}

int testFunction(void) {
	cout << "testFunction here.\n";
	cout << "CONSTINT1: " << CONSTINT1 << endl;
//	cout << "CONSTINT2: " << CONSTINT2 << endl;
	cout << "End testFunction output.\n\n";

	return 0;
}
