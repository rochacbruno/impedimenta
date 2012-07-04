#include "gradesUtilities.h"
#include <iostream>
#include <cstdlib>
using namespace std;

const int Utilities::MAX_BAR_LENGTH = 74;
const int Utilities::MAX_NUMBER = 9999;

void Utilities::printStars(int numberOfStars) {
	int i = 0;

	if(numberOfStars < 0) {
		cout << "Cannot print "
		     << numberOfStars
		     << " stars. Need a number >= 0. Exiting.\n";
		exit(1);
	}

	for(i = 0; i < MAX_BAR_LENGTH; ++i) {
		if(i < numberOfStars) {
			cout << '*';
		} else {
			cout << ' ';
		}
	}

	return;
}

void Utilities::printNumber(int num) {
	if(num > MAX_NUMBER) {
		cout << "Number is too large to print. Must be less than or equal to "
		     << MAX_NUMBER
		     << ". Exiting.\n";
		exit(1);
	}

	cout << num;
	if(num < 10) {
		cout << "   ";
	} else if(num < 100) {
		cout << "  ";
	} else if(num < 1000) {
		cout << ' ';
	}
}
