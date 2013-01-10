/*-----------------------------------------------------------------------------/
Define functions used in class CavewideAction
/-----------------------------------------------------------------------------*/
#include "ClassCavewideAction.h"
#include <cstdlib>

void CavewideAction::clearCave(int numberOfCaverns, CavernParameters* someCavern) {
	int i = 0;

	for(i = 0; i < numberOfCaverns; i++) {
		someCavern[i].setBatIsPresent(0);
		someCavern[i].setPitIsPresent(0);
		someCavern[i].setHunterIsPresent(0);
		someCavern[i].setWumpusIsPresent(0);
	}

	return;
}

int CavewideAction::setBats(int numberOfCaverns, CavernParameters* someCavern, int numberOfBats) {
	int i = 0;
	int freeCaverns = 0;
	int batsPlaced = 0;

	for(i = 0; i < numberOfCaverns; i++) {
		if(!(someCavern[i].getAnythingIsPresent())) {
			freeCaverns++;
		}
	}
	if(freeCaverns < numberOfBats) {
		return 1;
	}

	while(batsPlaced < numberOfBats) {
		i = rand() % numberOfCaverns;
		if(!(someCavern[i].getAnythingIsPresent())) { // if nothing here
			someCavern[i].setBatIsPresent(1);
			batsPlaced++;
		}
	}

	return 0;
}

int CavewideAction::setPits(int numberOfCaverns, CavernParameters* someCavern, int numberOfPits) {
	int i = 0;
	int freeCaverns = 0;
	int pitsPlaced = 0;

	for(i = 0; i < numberOfCaverns; i++) {
		if(!(someCavern[i].getAnythingIsPresent())) {
			freeCaverns++;
		}
	}
	if(freeCaverns < numberOfPits) {
		return 1;
	}

	while(pitsPlaced < numberOfPits) {
		i = rand() % numberOfCaverns;
		if(!(someCavern[i].getAnythingIsPresent())) {
			someCavern[i].setPitIsPresent(1);
			pitsPlaced++;
		}
	}

	return 0;
}

int CavewideAction::setHunter(int numberOfCaverns, CavernParameters* someCavern) {
	int i = 0;
	int freeCaverns = 0;
	int huntersPlaced = 0;
	int numberOfHunters = 1;	// Only 1 hunter should be placed.

	for(i = 0; i < numberOfCaverns; i++) {
		if(!(someCavern[i].getAnythingIsPresent())) {
			freeCaverns++;
		}
	}
	if(freeCaverns < numberOfHunters) {
		return 1;
	}

	while(huntersPlaced < numberOfHunters) {
		i = rand() % numberOfCaverns;
		if(!(someCavern[i].getAnythingIsPresent())) {
			someCavern[i].setHunterIsPresent(1);
			huntersPlaced++;
		}
	}

	return 0;
}

int CavewideAction::setWumpus(int numberOfCaverns, CavernParameters* someCavern) {
	int i = 0;
	int freeCaverns = 0;
	int wumpusesPlaced = 0;
	int numberOfWumpuses = 1;	// Only 1 wumpus should be placed

	for(i = 0; i < numberOfCaverns; i++) {
		if(!(someCavern[i].getAnythingIsPresent())) {
			freeCaverns++;
		}
	}
	if(freeCaverns < numberOfWumpuses) {
		return 1;
	}

	while(wumpusesPlaced < numberOfWumpuses) {
		i = rand() % numberOfCaverns;
		if(!(someCavern[i].getAnythingIsPresent())) {
			someCavern[i].setWumpusIsPresent(1);
			wumpusesPlaced++;
		}
	}

	return 0;
}

int CavewideAction::getHunterLocation(int numberOfCaverns, CavernParameters* someCavern) {
	int i = 0;
	int hunterLocation = -1;

	for(i = 0; i < numberOfCaverns; i++) {
		if(someCavern[i].getHunterIsPresent()) {
			hunterLocation = i;
		}
	}

	return hunterLocation;
}

int CavewideAction::getWumpusLocation(int numberOfCaverns, CavernParameters* someCavern) {
	int i = 0;
	int wumpusLocation = -1;

	for(i = 0; i < numberOfCaverns; i++) {
		if(someCavern[i].getWumpusIsPresent()) {
			wumpusLocation = i;
		}
	}

	return wumpusLocation;
}
