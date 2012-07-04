#include <iostream>
using namespace std;

struct Date {
	int year;
	int month;
	int day;
};

struct CDAccount {
	double balance;
	double interestRate;
	Date maturity;
};

void getAccountData(CDAccount& theAccount);
void getDate(Date& theDate);

int main(void) {
	CDAccount someonesAccount;

	cout << "Time to get some info from the user.\n";
	getAccountData(someonesAccount);
	// Have gotten values for account balance and interest rate. Still need
	// to find date of maturity.
	getDate(someonesAccount.maturity);
	// Have found date of account maturity too. All variables filled.

	cout << "Your account has a balance of $"
	     << someonesAccount.balance
	     << endl
	     << "You have an interest rate of "
	     << someonesAccount.interestRate
	     << "%\n"
	     << "Your account will mature on "
	     << someonesAccount.maturity.month
	     << "/"
	     << someonesAccount.maturity.day
	     << "/"
	     << someonesAccount.maturity.year
	     << endl;

	return 0;
}

void getAccountData(CDAccount& theAccount) {
	cout << "Enter the account balance: $";
	cin >> theAccount.balance;
	cout << "Enter the interest rate: ";
	cin >> theAccount.interestRate;

	return;
}

void getDate(Date& theDate) {
	cout << "Enter the year of account maturity: ";
	cin >> theDate.year;
	cout << "Enter the month of account maturity: ";
	cin >> theDate.month;
	cout << "Enter the day of account maturity: ";
	cin >> theDate.day;

	return;
}
