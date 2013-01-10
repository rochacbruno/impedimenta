// enumTest.cc
#include <iostream>
using namespace std;

int main(void) {
	enum MyType_t {
		ZERO, ONE, TWO, THREE
	};
	const int CONSTANT_INT = 3;
	MyType_t ENUM_VAR = TWO;

	cout << "Value of CONSTANT_INT == " << CONSTANT_INT << endl;
	cout << "Value of ENUM_VAR == " << ENUM_VAR << endl;

	if(ENUM_VAR == 2) {
		cout << "Enumerated types can be cast as ints before comparisons.\n";
	} else {
		cout << "Enumerated types cannot be cast as ints before comparisons.\n";
	}

//	ENUM_VAR = 3;
	cout << "Ints cannot be cast as an enumerated type.\n";

	return 0;
}
