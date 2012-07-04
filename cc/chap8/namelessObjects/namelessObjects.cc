#include <iostream>
#include "Grapes.h"
using namespace std;

int main(void) {
	Grapes myVineyard;
	Grapes yourVineyard(5, 30);
	cout << "After initialization of objects: " << endl;
	myVineyard.getAll();
	yourVineyard.getAll();

	myVineyard = Grapes(2, 20);
	yourVineyard.increment();
	cout << "After calling constructor and member function: " << endl;
	myVineyard.getAll();
	yourVineyard.getAll();

	myVineyard = Grapes::returnObject(myVineyard);
	yourVineyard = Grapes::returnObject(yourVineyard);
	cout << "After calling Grapes::returnObject(): " << endl;
	myVineyard.getAll();
	yourVineyard.getAll();

	cout << "Spitting out info on anonymous objects: " << endl;
	Grapes(12, 345).getAll();

	cout << "Incrementing a returned object: " << endl;
	Grapes(12, 345).increment();

	return 0;
}
