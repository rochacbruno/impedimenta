#include <iostream>
using namespace std;

void callByTest(int& internalName);

int main(void) {
	int externalName = 1;

	cout << "My variable is "
	     << externalName
	     << " before calling the function.\n";
	callByTest(externalName);
	cout << "My variable is "
	     << externalName
	     << " after calling the function.\n";

	return 0;
}

void callByTest(int& internalName) {
	cout << "My variable is "
	     << internalName
	     << " inside the function, before mod.\n";
	internalName = 3;
	cout << "My variable is "
	     << internalName
	     << " inside the function, after mod.\n";

	return;
}
