#include "Grapes.h"
#include <iostream>

namespace {
	using std::cout;

	void hiddenMessage(void) {
		cout << "You can't see me.\n";

		return;
	}
}

namespace JeremyGrapes {
	int Grapes::getWeight(void) {
		hiddenMessage();

		return weight;
	}
}
