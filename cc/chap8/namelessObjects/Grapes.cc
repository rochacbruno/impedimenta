#include <iostream>
#include <cstdlib>
#include "Grapes.h"
using namespace std;

/*=============================================================================/
Constructors
/=============================================================================*/
Grapes::Grapes() {
	grapesPerVine = 0;
	Vines = 0;

	return;
}

Grapes::Grapes(int numOfVines) {
	if(numOfVines < 0) {
		cerr << "There cannot be less than 0 grape vines present. Exiting.\n";
		exit(1);
	}

	Vines = numOfVines;
	grapesPerVine = 0;

	return;
}

Grapes::Grapes(int numOfVines, int numOfGrapes) {
	if(numOfVines < 0) {
		cerr << "There cannot be less than 0 grape vines present. Exiting.\n";
		exit(1);
	}
	if(numOfGrapes < 0) {
		cerr << "There cannot be less than 0 grapes on a vine. Exiting.\n";
		exit(1);
	}

	Vines = numOfVines;
	grapesPerVine = numOfGrapes;

	return;
}

/*=============================================================================/
Member Functions
/=============================================================================*/
void Grapes::getAll(void) {
	cout << "Vines: " << Vines << endl;
	cout << "Grapes per vine: " << grapesPerVine << endl;

	return;
}

void Grapes::increment(void) {
	++Vines;
	++grapesPerVine;

	return;
}

Grapes Grapes::returnObject(Grapes& theObject) {
	return theObject;
};	
