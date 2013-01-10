/*-----------------------------------------------------------------------------/
Define functions used in class CavernParameters
/-----------------------------------------------------------------------------*/
#include "ClassCavernParameters.h"

void CavernParameters::setNeighborCaverns(int neighbor1, int neighbor2, int neighbor3) {
	neighborCavern1 = neighbor1;
	neighborCavern2 = neighbor2;
	neighborCavern3 = neighbor3;

	return;
}

void CavernParameters::getNeighborCaverns(int* neighborArray) {
	neighborArray[0] = neighborCavern1;
	neighborArray[1] = neighborCavern2;
	neighborArray[2] = neighborCavern3;

	return;
}

void CavernParameters::setBatIsPresent(bool setValue) {
	if (0 == setValue) {
		bat = 0;
	} else {
		bat = 1;
	}

	return;
}

void CavernParameters::setPitIsPresent(bool setValue) {
	if (0 == setValue) {
		pit = 0;
	} else {
		pit = 1;
	}

	return;
}

void CavernParameters::setHunterIsPresent(bool setValue) {
	if (0 == setValue) {
		hunter = 0;
	} else {
		hunter = 1;
	}

	return;
}

void CavernParameters::setWumpusIsPresent(bool setValue) {
	if (0 == setValue) {
		wumpus = 0;
	} else {
		wumpus = 1;
	}

	return;
}

bool CavernParameters::getBatIsPresent(void) {
	return bat;
}

bool CavernParameters::getPitIsPresent(void) {
	return pit;
}

bool CavernParameters::getHunterIsPresent(void) {
	return hunter;
}

bool CavernParameters::getWumpusIsPresent(void) {
	return wumpus;
}

bool CavernParameters::getThreatIsPresent(void) {
	if(bat || pit || wumpus) {
		return 1;
	} else {
		return 0;
	}
}

bool CavernParameters::getAnythingIsPresent(void) {
	if(bat || pit || hunter || wumpus) {
		return 1;
	} else {
		return 0;
	}
}
