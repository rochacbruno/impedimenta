#include "Grapes.h"
#include <iostream>

int main(void) {
	using std::cout;
	using std::endl;

	JeremyGrapes::Grapes myVineyard;

	cout << "main called.\n";
	cout << "Weight of my vineyard: "
	     << myVineyard.getWeight()
	     << endl;
//	myVineyard.hiddenMessage();
// 	will not work
}
