#include <iostream>
#include <cstdlib>
using namespace std;

int main(void) {
	int seed = 0;

	cout << "Please enter a number to use as a seed.\n";
	while(!(cin >> seed)) {
		cout << "\"" << seed << "\" is not valid. Please enter a whole number.\n";
		cin.clear();
		cin.ignore(1000,'\n');
	}
	cin.ignore(1000,'\n');
	srand(seed);

	cout << "Random number, method one: " << ((rand() % 11) / 10.0) << endl;
	cout << "Random number, method two: " << (RAND_MAX - rand()) / static_cast<double>(RAND_MAX) << endl;

	return 0;
}
