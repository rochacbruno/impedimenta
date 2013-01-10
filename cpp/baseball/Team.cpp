/*-============================================================================/
This file implements all of the functions in class Team.

The Team class has the following member variables:
string teamName;
double battingAverage;
vector<Player> roster;
/============================================================================-*/
#include "Team.h"
#include <cstdlib>
#include <iostream>
using std::cerr;

/*-============================================================================/
Constructors
/============================================================================-*/
Team::Team() {
	teamName = "no team name set"; 
	roster.resize(0);
	battingAverage = 0.00;
	// No need to call calcBattingAverage(), as size of roster is 0. Call would be redundant.

	return;
}


Team::Team(string newTeamName, vector<Player>& newRoster) {
	int i = 0;

	roster.resize(newRoster.size());
	for(i = 0; i < newRoster.size(); ++i) {
		roster[i].setName(newRoster[i].getName());
		roster[i].setJerseyNumber(newRoster[i].getJerseyNumber());
		roster[i].setBattingAverage(newRoster[i].getBattingAverage());
	}
	teamName = newTeamName;
	calcBattingAverage();

	return;
}

/*-============================================================================/
Member Functions
/============================================================================-*/
string Team::getTeamName(void) const {
	return teamName;
}

double Team::getBattingAverage(void) const {
	return battingAverage;
}


string Team::getName(int playerNumber) const {
	if(playerNumber + 1 > roster.size()) {
		cerr << "Team::getName error: attempting to access non-existent player number. Exiting.\n";
		exit(1);
	} else if(playerNumber < 0) {
		cerr << "Team::getName error: player number must be at least 0. Exiting.\n";
		exit(1);
	}

	return roster[playerNumber].getName();
}

int Team::getJerseyNumber(int playerNumber) const {
	if(playerNumber + 1 > roster.size()) {
		cerr << "Team::getName error: attempting to access non-existent player number. Exiting.\n";
		exit(1);
	} else if(playerNumber < 0) {
		cerr << "Team::getName error: player number must be at least 0. Exiting.\n";
		exit(1);
	}

	return roster[playerNumber].getJerseyNumber();
}

double Team::getBattingAverage(int playerNumber) const {
	if(playerNumber + 1 > roster.size()) {
		cerr << "Team::getName error: attempting to access non-existent player number. Exiting.\n";
		exit(1);
	} else if(playerNumber < 0) {
		cerr << "Team::getName error: player number must be at least 0. Exiting.\n";
		exit(1);
	}

	return roster[playerNumber].getBattingAverage();
}

void Team::calcBattingAverage(void) {
	int counter = 0;
	double newBattingAverage = 0.00;
	vector<Player>::iterator iter;

	for(iter = roster.begin(); iter != roster.end(); ++iter) {
		newBattingAverage += (*iter).getBattingAverage();
		++counter;
	}

	newBattingAverage /= static_cast<double>(counter);
	battingAverage = newBattingAverage;

	return;
}
