/*-----------------------------------------------------------------------------/
Jeremy Audet
C++ Programming -- Michael Soulia
Quiz Bonus Question

Rev 0.0
08/07/2010
Added code template, coded MPG().

Rev 0.1
08/08/2010
Moved const double LITERS_PER_GALLON into MPG().
Coded guts of main().
Realized that LITERS_PER_GALLON is a lie! Renamed to GALLONS_PER_LITER.
/-----------------------------------------------------------------------------*/
#include <iostream>
using namespace std;

double MPG(double litersUsed, double milesTravelled);
/* Precondition: pass MPG two doubles, one for liters of gas used, and the second for the number of miles travelled.
Postcondition: MPG() will return the efficiency of the vehicle, in MPG */

int main(void) {
	double litersOfGas = 0;
	double milesTravelled = 0;
	double MilesPerGallon = 0;

	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout.precision(2);

	cout << "This program calculates the efficiency of your vehicle, in MPG.\n";
	cout << "Enter the number of liters of gas you have used: ";
	while(!(cin >> litersOfGas)) {
		cout << "I'll need you to enter a number like 35.2\n"
		     << "Make sure not to include a word like \"liters\"\n"
		     << "Enter the number of liters of has you have used: ";
		cin.clear();
		cin.ignore(1000,'\n');
	}
	cin.ignore(1000,'\n');	// cin leaves \n in input buffer. Potentially harmful. Good form to remove trailing crap, no matter what.
	cout << "Enter the number of miles you have travelled: ";
	while(!(cin>> milesTravelled)) {
		cout << "I need you to enter a number like 350.\n"
		     << "Make sure not to include a word like \"miles\"\n"
		     << "Enter the number of miles you have travelled: ";
		cin.clear();
		cin.ignore(1000,'\n');
	}
	cin.ignore(1000,'\n');

	MilesPerGallon = MPG(litersOfGas, milesTravelled);
	cout << "Your car has an efficiency of "
	     << MilesPerGallon
	     << " Miles per Gallon.\n";

	return 0;
}

double MPG(double litersUsed, double milesTravelled) {
	const double GALLONS_PER_LITER = 0.264179;
	double gallonsUsed = (litersUsed * GALLONS_PER_LITER);

	return (milesTravelled / gallonsUsed);	// MPG = expression
}
