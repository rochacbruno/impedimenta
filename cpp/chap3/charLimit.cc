#include <iostream>
using namespace std;

int main(void) {
	char testString[5] = {""};

	cout << "Please enter some text, no more than four characters including the \\0.\n";
	cin >> testString;
	cout << "Your input was: " << testString << endl;

	return 0;
}
