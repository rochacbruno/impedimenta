#include "User.h"

namespace {
	std::string username;
	bool isValid(void) {
		if(8 == username.length()) {
			return true;
		} else {
			return false;
		}
	}
}

namespace Authenticate {
	using std::cin;
	using std::cout;
	using std::endl;
	using std::string;

	void User::inputUserName() {
		do {
			cout << "Enter your username (exactly 8 letters)" << endl;
			while(!(cin >> username)) {
				cin.ignore(1000,'\n');

				cout << "Whoops -- bad input!\n";
				cout << "Enter your username (8 letters only)" << endl;
			}
			cin.ignore(1000,'\n');
		} while(!isValid());
	}

	string User::getUserName() {
		return username;
	}
}
