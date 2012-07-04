#include <iostream>
#include <cstring>
using namespace std;

int main(void) {
	const int STRING_SIZE = 1000;
	char myString[STRING_SIZE];
	int i = 0;

	cout << "Enter a couple words. Don't enter more than " << STRING_SIZE << " characters. The result could be disastrous. This is a proof of concept.\n";
	cout << "(any)> ";
	cin >> myString;
	cout << "You entered: '"
	     << myString
	     << '\''
	     << endl;

	cout << "(any)> ";
	cin >> myString;
	cout << "You entered: '"
	     << myString
	     << '\''
	     << endl;

	for(i = 0; i < 10; i++) {
		cout << "Next char: '";
		cout.put(cin.get());
		cout << '\''
		     << endl;
	}

	cout << "As you can see, the >> operator completely ignores whitespace. This is a simple case study showing why it is good to cin.clear(1000, '\\n'); after every single attempt to get input from a user. You leave the input stream clear for whoever is going to use that input stream after you.\n";

	return 0;
}
