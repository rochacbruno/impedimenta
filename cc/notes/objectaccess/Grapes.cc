#include "Grapes.h"

Grapes::Grapes(void) {
	weight = 0;
}

void Grapes::incWeight(Grapes& someObject) {
	someObject.weight++;

	return;
}

int Grapes::getWeight(void) {
	return weight;
}
