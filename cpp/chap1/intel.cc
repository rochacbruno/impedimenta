#include <iostream>
using namespace std;

int main() {
	int booksRead = 0;

	cout << "How many tom clancy books have you read?\n"
	     << ">";
	cin >> booksRead;
	if (booksRead == 0) {
		cout << "Aww, too bad\n";
	} else if (booksRead > 0 && booksRead < 3) {
		cout << "Hey, at least you know how to enjoy a good adventure.\n";
	} else {
		cout << "Wow, a real fan! Enjoy.\n";
	}

	return 0;
}
