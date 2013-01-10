#include <iostream>
#include <cstring>
using namespace std;

int main(void) {
	const int STRING_SIZE = 5;
	char testString[STRING_SIZE] = "";
	char testString2[STRING_SIZE] = "Make";
	// try leaving out the "" sometime. You'll find that no \0 is appended to testString, even after using strncpy.
	// when << is later called, the program doesn't really know when to stop spitting out data

	cout << "strlen(): " << strlen(testString) << endl;
	strncpy(testString, "MakeDamnSure", STRING_SIZE - 1);
	cout << "After using strncpy(): " << testString << endl;
	cout << "strlen(): " << strlen(testString) << endl;
	cout << endl;

	// try commenting out the above block of code
	strncat(testString, "zoobadat", STRING_SIZE - strlen(testString) - 1);
	cout << "After using strncat(): " << testString << endl;
	cout << "If you want different results, try editing the source code a bit.\n";
	cout << endl;

	cout << "(any)> ";
	cin.getline(testString, STRING_SIZE);
	cout << "testString == " << testString << endl;
	cout << "testString2 == " << testString2 << endl;
	cout << "strncmp(): " << strncmp(testString, testString2, strlen(testString)) << endl;
}
