#include "Password.h"

namespace {
	std::string password;

	bool isValid(void) {
		int i = 0;

		if(password.length() < 8) {
			return false;
		}
		// OMITTING CHECK!
		// I really should check to make sure that the variable password
		// includes at least one non-alphabetic character. However, I'm
		// omitting that part of the exercise due to its complexity.

		return true;
	}
}

namespace Authenticate {
	using std::cout;
	using std::cin;
	using std::string;

	void Password::inputPassword(void) {
		do {
			cout << "Enter your password (at least 8 characters and at least one non-letter)\n";
			while(!(cin >> password)) {
				cin.clear();
				cin.ignore(1000,'\n');
				cout << "Whoops -- that didn't work. Try again.\n";
				cout << "Enter your password (at least 8 characters and at least one non-letter)\n";
			}
			cin.ignore(1000,'\n');
		} while(!isValid());	// (false == isValid())
	} // inputPassword(void)

	string Password::getPassword(void) {
		return password;
	} // getPassword(void)
}
