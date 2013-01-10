#include <iostream>
using namespace std;

struct CDAccountV1 {
	double balance;
	double interestRate;
	int monthsLeft;
};

void getData(CDAccountV1& accountGiven);

int main(void) {
	CDAccountV1 account;
	double rateFraction;	// rate of 1.2% would be expressed as 0.012
	double interest;

	getData(account);
	rateFraction = account.interestRate/100.0;
	interest = account.balance * (rateFraction * (account.monthsLeft / 12.0));
	account.balance = account.balance + interest;

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout.precision(2);
	cout << "When your CD matures in "
	     << account.monthsLeft
	     << " months,\n"
	     << "it will have a balance of $"
	     << account.balance
	     << endl;

	return 0;
}

void getData(CDAccountV1& accountGiven) {
	cout << "Enter account balance: $";
	cin >> accountGiven.balance;
	cout << "Enter account interest rate: ";
	cin >> accountGiven.interestRate;
	cout << "Enter the number of months until maturity: ";
	cin >> accountGiven.monthsLeft;

	return;
}
