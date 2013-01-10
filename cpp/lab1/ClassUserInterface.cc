/*-----------------------------------------------------------------------------/
This file defines functions declared in class UserInterface.
/-----------------------------------------------------------------------------*/
#include <iostream>
#include "ClassUserInterface.h"
#include "ClassCavernParameters.h"
#include "ClassCavewideAction.h"
#include <cstdlib>
using namespace std;

void UserInterface::mainMenu(void) {
	NUMBER_OF_CAVERNS = 20;
	NUMBER_OF_BATS = 2;
	NUMBER_OF_PITS = 2;
	NUMBER_OF_NEIGHBORS = 3;
	NUMBER_OF_ARROWS = 5;

	CavernParameters cavern[NUMBER_OF_CAVERNS];
	char menuChoice = ' ';

	/*---------------------------------------------------------------------/
	See cavemap.png to view the map that has been constructed here. When I issue cavern[0].setNeighborCaverns(1,4,5), then the neighbors of cavern[0] are cavern[1], cavern[4], and cavern[5]. You may wish to increment this number when telling the user which cave they are in. ex. "You are in cavern 1, and can move to cavern 2, 5, or 6." You may use this section of code to define your own maps.
	/---------------------------------------------------------------------*/
	cavern[0].setNeighborCaverns(1,4,5);
	cavern[1].setNeighborCaverns(0,2,7);
	cavern[2].setNeighborCaverns(1,3,9);
	cavern[3].setNeighborCaverns(2,4,11);
	cavern[4].setNeighborCaverns(0,3,13);
	cavern[5].setNeighborCaverns(0,6,14);
	cavern[6].setNeighborCaverns(5,7,15);
	cavern[7].setNeighborCaverns(1,6,8);
	cavern[8].setNeighborCaverns(7,9,16);
	cavern[9].setNeighborCaverns(2,8,10);
	cavern[10].setNeighborCaverns(9,11,17);
	cavern[11].setNeighborCaverns(3,10,12);
	cavern[12].setNeighborCaverns(11,13,18);
	cavern[13].setNeighborCaverns(4,12,14);
	cavern[14].setNeighborCaverns(5,13,19);
	cavern[15].setNeighborCaverns(6,16,19);
	cavern[16].setNeighborCaverns(8,15,17);
	cavern[17].setNeighborCaverns(10,16,18);
	cavern[18].setNeighborCaverns(12,17,19);
	cavern[19].setNeighborCaverns(14,15,18);

	/*---------------------------------------------------------------------/
	Main menu.
	/---------------------------------------------------------------------*/
	do {
		clearScreen();
		cout << "                         d`````````````````b\n"
		     << "                         | HUNT THE WUMPUS |\n"
		     << "                         q.................p\n\n";
		 do {
			cout << "Welcome to the Hunt the Wumpus game. What would you like to do?\n"
			     << endl
			     << "Play (p) View Help (h) Quit (q)\n"
			     << "> ";
			cin >> menuChoice;
			cout << endl;
			cin.ignore(1000,'\n');
			if(menuChoice != 'p' && menuChoice != 'h' && menuChoice != 'q') {
				clearScreen();
				cout << "                         d`````````````````b\n"
				     << "                         | HUNT THE WUMPUS |\n"
				     << "                         q.................p\n\n";
				cout << "I'll need you to enter a 'p', an 'h', or a 'q'!\n";
			}
		} while(menuChoice != 'p' && menuChoice != 'h' && menuChoice != 'q');

		if(menuChoice == 'p') {
			playGame(cavern);
		} else if(menuChoice == 'h') {
			viewHelp();
		} else if(menuChoice == 'q') {
			; // do nothing
		} else {
			cout << "There has been an error choosing a menu option. Exiting.\n";
			exit(1);
		}
	} while(menuChoice != 'q');
}

void UserInterface::viewHelp() {
	clearScreen();
	cout << "The Wumpus lives in a cave of "
	     << NUMBER_OF_CAVERNS
	     << " caverns. Each cavern has 3 tunnels leading off to other rooms.\n";
	cout << endl;
	cout << "HAZARDS\n"
	     << NUMBER_OF_PITS << " caverns have Bottomless Pits in them. If you go there, you fall to your death!\n"
	     << NUMBER_OF_BATS << " caverns have Super Bats in them. If you stumble upon a bat, it will pick you\n"
	     << "up and randomly transport you to another cavern. This could be troublesome,\n"
	     << "depending upon where you land.\n";
	cout << endl;
	cout << "WUMPUS\n"
	     << "The wumpus is not bothered by the hazards of the cave. He has sucker feet and is\n"
	     << "too big for the bats to lift! Usually he is asleep. Two things will wake him up:\n"
	     << "you entering his room or your shooting an arrow. If the wumpus wakes up, there\n"
	     << "is a 75% chance he will move to an adjacent room and a 25% chance he will stay.\n"
	     << "If you and him end up in the same cavern -- he eats you up!\n";
	cout << endl;
	cout << "More (enter)\n"
	     << "> ";
	cin;
	cin.ignore(1000,'\n');

	clearScreen();
	cout << "YOU\n"
	     << "Each turn you may move or shoot an arrow. If you move, just select a\n"
	     << "neighboring cavern and you'll trudge on down. When shooting, you choose how far\n"
	     << "you want your arrow to go (it can curve). If your arrow cannot fly to a\n"
	     << "specified location (ex. cavern 15 cannot actually be reached from cavern 12)\n"
	     << "then the arrow will randomly fly to another room. If you arrow hits the wumpus\n"
	     << "you win. If the arrow hits you, you lose.\n";
	cout << endl;
	cout << "WARNINGS\n"
	     << "You'll be warned if a hazard is nearby.\n"
	     << "Wumpus -- You smell a wumpus\n"
	     << "Bat -- You hear flapping\n"
	     << "Pit -- You feel a draft\n";
	cout << endl;
	cout << "Main Menu (enter)\n"
	     << "> ";
	cin;
	cin.ignore(1000,'\n');

	return;
}

/*-----------------------------------------------------------------------------/
UserInterface::playGame() is the god of all members in this program.
/-----------------------------------------------------------------------------*/
void UserInterface::playGame(CavernParameters* someCavern) {
	CavewideAction cave;	// Gain access to cave wide functions.
	CavernParameters backupCavern[NUMBER_OF_CAVERNS];
	int neighborCaverns[NUMBER_OF_NEIGHBORS];	// Used to hold index numbers of neighboring caverns
	int arrowPath[NUMBER_OF_ARROWS];
	int arrows = NUMBER_OF_ARROWS;
	int arrowDistance = 0;
	int userInputInt = 0;
	int i = 0;
	int j = 0;
	int turnCount = 1;
	bool batNearby = 0;
	bool pitNearby = 0;
	bool wumpusNearby = 0;
	bool matchFound = 0;
	char userInputChar = ' ';

	// Setup cave with dangers and make a backup of cave setup.
	cave.clearCave(NUMBER_OF_CAVERNS, someCavern);
	if(1 == cave.setWumpus(NUMBER_OF_CAVERNS, someCavern)) {
		cout << "Error placing wumpus in cave. Exiting.\n";
		exit(1);
	}
	if(1 == cave.setHunter(NUMBER_OF_CAVERNS, someCavern)) {
		cout << "Error placing hunter in cave. Exiting.\n";
		exit(1);
	}
	if(1 == cave.setPits(NUMBER_OF_CAVERNS, someCavern, NUMBER_OF_PITS)) {
		cout << "Error placing pit(s) in cave. Exiting.\n";
		exit(1);
	}
	if(1 == cave.setBats(NUMBER_OF_CAVERNS, someCavern, NUMBER_OF_BATS)) {
		cout << "Error placing bat(s) in cave. Exiting.\n";
		exit(1);
	}
	for(i = 0; i < NUMBER_OF_CAVERNS; i++) {
		backupCavern[i] = someCavern[i];
	}

	/*---------------------------------------------------------------------/
	One game, including restarts, is defined in the loop below.
	/---------------------------------------------------------------------*/
	turnCount = 1;
	do {
		arrows = NUMBER_OF_ARROWS;
		clearScreen();

		/*-------------------------------------------------------------/
		One game, without restarts, is defined in the loop below.
		/-------------------------------------------------------------*/
		do {
			/*-----------------------------------------------------/
			Warn user of nearby threats.
			/-----------------------------------------------------*/
			batNearby = 0;
			pitNearby = 0;
			wumpusNearby = 0;
			cout << "      Turn "
			     << turnCount
			     << endl
			     << "    ----===----\n";
			someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].getNeighborCaverns(neighborCaverns);
			for(i = 0; i < NUMBER_OF_NEIGHBORS; i++) {
				if(someCavern[neighborCaverns[i]].getBatIsPresent()) {
					batNearby = 1;
				}
				if(someCavern[neighborCaverns[i]].getPitIsPresent()) {
					pitNearby = 1;
				}
				if(someCavern[neighborCaverns[i]].getWumpusIsPresent()) {
					wumpusNearby = 1;
				}
			}
			if(batNearby) {
				cout << "You hear flapping\n";
			}
			if(pitNearby) {
				cout << "You feel a draft\n";
			}
			if(wumpusNearby) {
				cout << "You smell a wumpus\n";
			}

			/*-----------------------------------------------------/
			Tell user how many arrows he has left and where he is.
			/-----------------------------------------------------*/
			cout << "Arrows left: "
			     << arrows
			     << endl;
			cout << "You are in cavern "
			     << cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)
			     << endl;
			cout << "Tunnels lead to caverns:";
			for(i = 0; i < NUMBER_OF_NEIGHBORS; i++) {
				cout << " "
				     << neighborCaverns[i];
			}
			cout << endl
			     << endl;

			/*-----------------------------------------------------/
			Shoot or move?
			/-----------------------------------------------------*/
			do {
				cout << "Shoot (s) or move (m)?\n"
				     << "> ";
				cin >> userInputChar;
				cin.ignore(1000,'\n');
				if('s' != userInputChar && 'm' != userInputChar) {
					cout << "What does "
					     << userInputChar
					     << " mean? I need either 's' or 'm'.\n";
				}
			} while('s' != userInputChar && 'm' != userInputChar);

			/*-----------------------------------------------------/
			If user decides to shoot, do the following...
			/-----------------------------------------------------*/
			if('s' == userInputChar) {
				for(i = 0; i < NUMBER_OF_ARROWS; i++) {
					arrowPath[i] = -1;
				}
				arrowDistance = 0;

				// How far will the user shoot?
				do {
					cout << "How far do you want to shoot? (your arrow can curve)\n"
					     << "A warning -- if your aim is off, the arrow can come back and hit you.\n"
					     << "(1) (2) (3) (4) (5)\n"
					     << "> ";

					if(!(cin >> userInputInt) || userInputInt < 1 || userInputInt > 5) {
						cout << "No, no, you can't shoot that far.\n";
						userInputInt = -1;
						cin.clear();
					}
					cin.ignore(1000,'\n');
				} while(-1 == userInputInt);
				arrowDistance = userInputInt;

				// Where does the user want the arrow to go?
				cout << "You are in cavern "
				     << cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)
				     << endl;
				for(i = 0; i < arrowDistance; i++) {
					do {
						cout << "Where should the arrow go? ("
						     << i + 1
						     << " of "
						     << arrowDistance
						     << ")\n"
						     << "> ";

						if(!(cin >> userInputInt) || userInputInt < 0 || userInputInt >= NUMBER_OF_CAVERNS) {
							cin.clear();
							userInputInt = -1;
							cout << "Where is that?\n";
						}
						cin.ignore(1000,'\n');
					} while(-1 == userInputInt);
					arrowPath[i] = userInputInt;
				}
				cout << endl;

				// Where will the arrow actually go? (first segment of path)
				matchFound = 0;
				someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].getNeighborCaverns(neighborCaverns);
				for(i = 0; i < NUMBER_OF_NEIGHBORS; i++) {
					if(arrowPath[0] == neighborCaverns[i]) {
						matchFound = 1;
					}
				}
				if(0 == matchFound) {
					arrowPath[0] = neighborCaverns[rand() % 3];
				}

				// Where will the arrow actually go? (rest of path)
				for(i = 1; i < arrowDistance; i++) {
					// get a list of caverns neighboring the arrow
					someCavern[arrowPath[i - 1]].getNeighborCaverns(neighborCaverns);
					// assume that none of the neighboring caverns match what the user specified
					matchFound = 0;
					// cycle through all of the caverns neighboring the arrow
					for(j = 0; j < NUMBER_OF_NEIGHBORS; j++) {
						// If this neighbor cavern actually matches what the user specified...
						if(neighborCaverns[j] == arrowPath[i]) {
							// ... make a note that the arrow should continue as directed.
							matchFound = 1;
						}
					}
					if(0 == matchFound) {
						arrowPath[i] = neighborCaverns[rand() % 3];
					}
				}

				// Will the arrow hit anything? (arrow stops if it does)
				matchFound = 0;
				for(i = 0; i < arrowDistance && 0 == matchFound; i++) {
					if(someCavern[arrowPath[i]].getHunterIsPresent()) {
						matchFound = 1;
						someCavern[arrowPath[i]].setHunterIsPresent(0);

						cout << "What sort of hunter does that? You shot yourself!\n"
						     << "Better work on your map-making abilities next time.\n"
						     << "(enter)\n"
						     << "> ";
						cin;
						cin.ignore(1000,'\n');
					}
					if(someCavern[arrowPath[i]].getWumpusIsPresent()) {
						matchFound = 1;
						someCavern[arrowPath[i]].setWumpusIsPresent(0);

						cout << "Congratulations! You've sucessfully hunted the wumpus! Songs of great renound\n"
						     << "will be sung about you for generations to come. Its' meat will feed your tribe\n"
						     << "for many moons, and its pelt will make a wonderful and rather strange rug.\n"
						     << "(enter)\n"
						     << "> ";
						cin;
						cin.ignore(1000,'\n');
					}
				}

				// If the arrow did not hit anything, then the wumpus will stir.
				// (if the arrow hit you, it would still move, but don't bother the user with this info)
				if(0 == matchFound) {
					someCavern[cave.getWumpusLocation(NUMBER_OF_CAVERNS, someCavern)].getNeighborCaverns(neighborCaverns);
					i = rand() % (NUMBER_OF_NEIGHBORS + 1);
					if(i == NUMBER_OF_NEIGHBORS) {
						;	// Wumpus stays put
					} else {
						someCavern[cave.getWumpusLocation(NUMBER_OF_CAVERNS, someCavern)].setWumpusIsPresent(0);
						someCavern[neighborCaverns[i]].setWumpusIsPresent(1);
						cout << "The wumpus stirs...";
						cin;
						cin.ignore(1000,'\n');
						cout << endl;

						if(cave.getWumpusLocation(NUMBER_OF_CAVERNS, someCavern) == cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)) {
							someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].setHunterIsPresent(0);

							cout << "Faaah-WUMP! SCHLOMP!";
							cin;
							cin.ignore(1000,'\n');

							cout << "NOM NOM NOM! CRUNCH, SCHLEPP, SLOBBER, GLUP, BURP!\n"
							     << "The stinky, smelly, horrible wumpus has EATEN YOU UP!\n"
							     << "(enter)\n"
							     << "> ";
							cin;
							cin.ignore(1000,'\n');
							cout << endl;
						}
					}
				}

				// If you've run out of arrows and wumpus is still alive...
				arrows--;
				if(0 == arrows && cave.getWumpusLocation(NUMBER_OF_CAVERNS, someCavern) >= 0) {
					someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].setHunterIsPresent(0);
					cout << "Oh no, you've run out of arrows! Game OVER for you.\n"
					     << "(enter)\n"
					     << "> ";
					cin;
					cin.ignore(1000,'\n');
					cout << endl;
				}
			}
			/*-----------------------------------------------------/
			...else if user decides to move, do the following...
			/-----------------------------------------------------*/
			else if('m' == userInputChar) {
				// do until valid number has been entered
				do {
					cout << "Where to?\n";
					for(i = 0; i < NUMBER_OF_NEIGHBORS; i++) {
						cout << "(" << neighborCaverns[i] << ") ";
					}
					cout << endl
					     << "> ";

					if(!(cin >> userInputInt)) {
						cout << "That won't work! There are no sub-space portals to that room, silly.\n";
						userInputInt = -1;	// Ensure that input does not match entry in neighborCaverns[].
						cin.clear();
					}
					cin.ignore(1000,'\n');

					matchFound = 0;
					for(i = 0; i < NUMBER_OF_NEIGHBORS; i++) {
						if(userInputInt == neighborCaverns[i]) {
							matchFound = 1;
						}
					}
				} while(matchFound == 0);
				cout << endl;
				someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].setHunterIsPresent(0);
				someCavern[userInputInt].setHunterIsPresent(1);

				while(cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern) >= 0 && someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].getThreatIsPresent()) {
					if(someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].getWumpusIsPresent()) {
						someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].setHunterIsPresent(0);
						cout << "You step on something squishy.";

						cin;
						cin.ignore(1000,'\n');
						cout << "...";

						cin;
						cin.ignore(1000,'\n');
						cout << "...";

						cin;
						cin.ignore(1000,'\n');
						cout << "NOM NOM NOM! CRUNCH, SCHLEPP, SLOBBER, GLUP, BURP!\n"
						     << "The stinky, smelly, horrible wumpus has EATEN YOU UP!\n"
						     << "(enter)\n"
						     << "> ";
						cin;
						cin.ignore(1000,'\n');
						cout << endl;
					} else if(someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].getBatIsPresent()) {
						someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].setHunterIsPresent(0);
						someCavern[rand() % NUMBER_OF_CAVERNS].setHunterIsPresent(1);
						cout << "Wheee!\n"
						     << "Thank you for using the batty transportation system. Please come again.\n"
						     << "(enter)\n"
						     << "> ";
						cin;
						cin.ignore(1000,'\n');
						cout << endl;
					} else if(someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].getPitIsPresent()) {
						someCavern[cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern)].setHunterIsPresent(0);
						cout << "Aaaaiiieee! You've fallen into a pit! (the worms will have a feast tonight)\n"
						     << "(enter)\n"
						     << "> ";
						cin;
						cin.ignore(1000,'\n');
					}
				}
			} else {
				cout << "Error choosing whether to shoot or move. Exiting.\n";
				exit(1);
			}
			/*-----------------------------------------------------/
			The shoot-move portion of a turn is over. Check for errors.
			/-----------------------------------------------------*/
			if(cave.getWumpusLocation(NUMBER_OF_CAVERNS, someCavern) <= 0 && cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern) <= 0) {
				cout << "Well, that's a mess. Blood all over the walls, flaccid sucker feet, and both of\n"
				     << "you dead. I'm not sure how that happened. The game has encountered an error, and\n"
				     << "as is usual with errors, I'm going to abort the program.\n";
				exit(1);
			}
			turnCount++;
		/*-------------------------------------------------------------/
		One turn is complete. Exit loop if either hunter or wumpus is dead.
		/-------------------------------------------------------------*/
		} while(cave.getHunterLocation(NUMBER_OF_CAVERNS, someCavern) >= 0 && cave.getWumpusLocation(NUMBER_OF_CAVERNS, someCavern) >= 0);

		clearScreen();
		do {
			cout << "Play again with the same setup?\n"
			     << endl
			     << "Yes (y) No (n)\n"
			     << "> ";
			cin >> userInputChar;
			cin.ignore(1000,'\n');
			if('y' != userInputChar && 'n' != userInputChar) {
				clearScreen();
				cout << "I'll need you to enter a 'y' or an 'n'!\n";
			}
		} while('y' != userInputChar && 'n' != userInputChar);

		if('y' == userInputChar) {
			for(i = 0; i < NUMBER_OF_CAVERNS; i++) {
				someCavern[i] = backupCavern[i];
			}
		}
	} while('n' != userInputChar);
	/*---------------------------------------------------------------------/
	End definition of one game, including restarts.
	/---------------------------------------------------------------------*/

	return;
}
/*-----------------------------------------------------------------------------/
End mothership definition.
/-----------------------------------------------------------------------------*/

void UserInterface::clearScreen(void) {
	int i;

	for(i = 0; i < 100; i++) {
		cout << endl;
	}

	return;
}
