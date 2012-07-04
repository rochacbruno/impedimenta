#include <iostream>
using namespace std;

int main(void) {
	enum RestrictAnswer_t {
		YES=1,
		NO=0
	};
	RestrictAnswer_t restrictedVariable = YES;

	cout	<< "YES = "
		<< YES
		<< "\nNO = "
		<< NO
		<< "\nrestrictedVariable = "
		<< restrictedVariable
		<< "\n";

	return 0;
}
