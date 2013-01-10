/*-----------------------------------------------------------------------------/
This class gives you functions that allow you to interface with the user.
/-----------------------------------------------------------------------------*/
#ifndef CLASSUSERINTERFACE_H
#define CLASSUSERINTERFACE_H

#include "ClassCavernParameters.h"

class UserInterface {
	public:
		void mainMenu(void);
		void viewHelp(void);
		void playGame(CavernParameters*);
		void clearScreen(void);
	private:
		int NUMBER_OF_CAVERNS;
		int NUMBER_OF_BATS;
		int NUMBER_OF_PITS;
		int NUMBER_OF_NEIGHBORS;
		int NUMBER_OF_ARROWS;
};
#endif	// #ifndef CLASSUSERINTERFACE_H
