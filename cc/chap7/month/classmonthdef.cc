#ifndef CLASSMONTHDEF_H
#define CLASSMONTHDEF_H

#include <iostream>
#include <cstdlib>
#include "classmonthdef.h"
using namespace std;

Month::Month() {
	month = 1;

	return;
}

Month::Month(int monthNumber) {
	if(monthNumber < 1 || monthNumber > 12) {
		cout << "Month must be between 1 and 12, inclusive.\n"
		     << monthNumber
		     << "is not a valid month. Exiting.\n";
		exit(1);
	} else {
		month = monthNumber;
	}

	return;
}

Month::Month(char ch1, char ch2, char ch3) {
	if(('j' == ch1) && ('a' == ch2) && ('n' == ch3)) {
		month = 1;
	} else if(('f' == ch1) && ('e' == ch2) && ('b' == ch3)) {
		month = 2;
	} else if(('m' == ch1) && ('a' == ch2) && ('r' == ch3)) {
		month = 3;
	} else if(('a' == ch1) && ('p' == ch2) && ('r' == ch3)) {
		month = 4;
	} else if(('m' == ch1) && ('a' == ch2) && ('y' == ch3)) {
		month = 5;
	} else if(('j' == ch1) && ('u' == ch2) && ('n' == ch3)) {
		month = 6;
	} else if(('j' == ch1) && ('u' == ch2) && ('l' == ch3)) {
		month = 7;
	} else if(('a' == ch1) && ('u' == ch2) && ('g' == ch3)) {
		month = 8;
	} else if(('s' == ch1) && ('e' == ch2) && ('p' == ch3)) {
		month = 9;
	} else if(('o' == ch1) && ('c' == ch2) && ('t' == ch3)) {
		month = 10;
	} else if(('n' == ch1) && ('o' == ch2) && ('v' == ch3)) {
		month = 11;
	} else if(('d' == ch1) && ('e' == ch2) && ('c' == ch3)) {
		month = 12;
	} else {
		cout << "Letters passed to Month(char, char, char) do not describe a valid month.\n"
		     << "Letters passed: "
		     << ch1
		     << " "
		     << ch2
		     << " "
		     << ch3
		     << endl;
		cout << "Exiting.\n";
		exit(1);
	}

	return;
}

void Month::setMonthInt(int monthNumber) {
	if(monthNumber < 1 || monthNumber > 12) {
		cout << "Month must be between 1 and 12, inclusive.\n"
		     << monthNumber
		     << "is not a valid month.\n";
	} else {
		month = monthNumber;
	}

	return;
}

void Month::setMonthChar(int ch1, int ch2, int ch3) {
	if(('j' == ch1) && ('a' == ch2) && ('n' == ch3)) {
		month = 1;
	} else if(('f' == ch1) && ('e' == ch2) && ('b' == ch3)) {
		month = 2;
	} else if(('m' == ch1) && ('a' == ch2) && ('r' == ch3)) {
		month = 3;
	} else if(('a' == ch1) && ('p' == ch2) && ('r' == ch3)) {
		month = 4;
	} else if(('m' == ch1) && ('a' == ch2) && ('y' == ch3)) {
		month = 5;
	} else if(('j' == ch1) && ('u' == ch2) && ('n' == ch3)) {
		month = 6;
	} else if(('j' == ch1) && ('u' == ch2) && ('l' == ch3)) {
		month = 7;
	} else if(('a' == ch1) && ('u' == ch2) && ('g' == ch3)) {
		month = 8;
	} else if(('s' == ch1) && ('e' == ch2) && ('p' == ch3)) {
		month = 9;
	} else if(('o' == ch1) && ('c' == ch2) && ('t' == ch3)) {
		month = 10;
	} else if(('n' == ch1) && ('o' == ch2) && ('v' == ch3)) {
		month = 11;
	} else if(('d' == ch1) && ('e' == ch2) && ('c' == ch3)) {
		month = 12;
	} else {
		cout << "Letters passed to Month(char, char, char) do not describe a valid month.\n"
		     << "Letters passed: "
		     << ch1
		     << " "
		     << ch2
		     << " "
		     << ch3
		     << endl;
	}

	return;
}

int Month::getMonthInt(void) {
	if(month < 1 || month > 12) {
		cout << "Month is not a valid value. Exiting.\n";
		exit(1);
	}

	return month;
}

void Month::getMonthChar(char& ch1, char& ch2, char& ch3) {
	if(1 == month) {
		ch1 = 'j';
		ch2 = 'a';
		ch3 = 'n';
	} else if(2 == month) {
		ch1 = 'f';
		ch2 = 'e';
		ch3 = 'b';
	} else if(3 == month) {
		ch1 = 'm';
		ch2 = 'a';
		ch3 = 'r';
	} else if(4 == month) {
		ch1 = 'a';
		ch2 = 'p';
		ch3 = 'r';
	} else if(5 == month) {
		ch1 = 'm';
		ch2 = 'a';
		ch3 = 'y';
	} else if(6 == month) {
		ch1 = 'j';
		ch2 = 'u';
		ch3 = 'n';
	} else if(7 == month) {
		ch1 = 'j';
		ch2 = 'u';
		ch3 = 'l';
	} else if(8 == month) {
		ch1 = 'a';
		ch2 = 'u';
		ch3 = 'g';
	} else if(9 == month) {
		ch1 = 's';
		ch2 = 'e';
		ch3 = 'p';
	} else if(10 == month) {
		ch1 = 'o';
		ch2 = 'c';
		ch3 = 't';
	} else if(11 == month) {
		ch1 = 'n';
		ch2 = 'o';
		ch3 = 'v';
	} else if(12 == month) {
		ch1 = 'd';
		ch2 = 'e';
		ch3 = 'c';
	} else {
		cout << "Error determining the current month. Exiting.\n";
		exit(1);
	}

	return;
}

#endif // CLASSMONTHDEF_H
