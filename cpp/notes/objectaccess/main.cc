#include <iostream>
#include "Grapes.h"
using namespace std;

int main(void)  {
	Grapes myVineyard, yourVineyard;

	cout << "My grapes: " << myVineyard.getWeight() << endl;
	cout << "Your grapes: " << yourVineyard.getWeight() << endl;

	myVineyard.incWeight(yourVineyard);
	yourVineyard.incWeight(myVineyard);
	cout << "My grapes: " << myVineyard.getWeight() << endl;
	cout << "Your grapes: " << yourVineyard.getWeight() << endl;

	myVineyard.incWeight(myVineyard);
	yourVineyard.incWeight(yourVineyard);
	cout << "My grapes: " << myVineyard.getWeight() << endl;
	cout << "Your grapes: " << yourVineyard.getWeight() << endl;

	return 0;
}
