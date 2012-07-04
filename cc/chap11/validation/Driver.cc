#include <iostream>
#include "User.h"
#include "Password.h"

int main(void) {
	using std::cout;
	using std::endl;
	using namespace Authenticate;
//	The following two lines can be used in place of 'using namespace Authenticate;'
//	using Authenticate::User;
//	using Authenticate::Password;

	User someones;
	Password data;

	someones.inputUserName();
	data.inputPassword();
	cout << "Your username is "
	     << someones.getUserName()
	     << " and your password is "
	     << data.getPassword()
	     << endl;

	return 0;
}
