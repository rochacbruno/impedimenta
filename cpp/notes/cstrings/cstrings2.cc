#include <iostream>
using namespace std;

int main(int argc, char *argv[]) {
	int i = 0;

	// you'll always have at least one argument
	cout << "Number of arguments: "
	     << argc
	     << endl;
	for(i = 0; i < argc; i++) {
		cout << "Argument "
		     << i
		     << ": "
		     << argv[i]
		     << endl;
	}

	return 0;
}
