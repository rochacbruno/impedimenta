/*=============================================================================/
This file implements all of the functions in class Player.

The Player class has the following member variables:
string name;
int jerseyNumber;
double battingAverage;
/=============================================================================*/
#include "Player.h"
#include <cstdlib>
#include <iostream>
using std::cerr;

/*=============================================================================/
Constructors
/=============================================================================*/
Player::Player() {
	name = "no player name set";
	jerseyNumber = -1;
	// sets battingAverage between 0.100 and 0.400
	battingAverage = static_cast<double>((std::rand() % 301) + 100) / 1000.0;

	return;
}

Player::Player(const string newName, const int newJerseyNumber) {
	name = newName;
	jerseyNumber = newJerseyNumber;
	// sets battingAverage between 0.100 and 0.400
	battingAverage = static_cast<double>((std::rand() % 301) + 100) / 1000.0;

	return;
}

/*=============================================================================/
Member Functions
/=============================================================================*/
string Player::getName(void) const {
	return name;
}

int Player::getJerseyNumber(void) const {
	return jerseyNumber;
}

double Player::getBattingAverage(void) const {
	return battingAverage;
}

void Player::setName(const string newName) {
	name = newName;

	return;
}

void Player::setJerseyNumber(const int newJerseyNumber) {
	jerseyNumber = newJerseyNumber;

	return;
}

void Player::setBattingAverage(const double newBattingAverage) {
	if(newBattingAverage > 1.00) {
		cerr << "New batting average is above 1.00. Too high. Exiting.\n";
		exit(1);
	} else if(newBattingAverage < 0.00) {
		cerr << "New batting average is below 0.00. Too low. Exiting.\n";
		exit(1);
	}

	battingAverage = newBattingAverage;

	return;
}
