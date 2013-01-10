/*-----------------------------------------------------------------------------/
HuntTheWumpus.cc
Jeremy Audet

My implementation of the Hunt the Wumpus game uses cavern objects. Each cavern/objects keeps track of its contents through the use of flags. There is a flag to identify whether a bat, pit, hunter, or wumpus is present. It is possible, though nonsensical, for all of these flags to set at once. Each neighboring cavern is kept track of within the object, too. A list of each of the neighboring caverns is kept in each object as a set of ints. Caverns are defined in ClassCavernParameters, and options for them are set in ClassUserInterface.h.

This setup is ripe for abuse, but it also allows for great flexibility. For example, what if cavern 0 says that cavern 1 is its neighbor, but cavern 1 does not list cavern 0 as a neighbor? Now you have a one-way passage, from cavern 0 to 1! Want multiple wumpuses? Tweak the code a little bit, and make it happen! Not all of these features will be available right away. My first priority is to get Wumpus working properly. If I want, I'll go back later and implement some of the more awesome features. In the meantime, I'll list what you can and cannot do here.

VARIABLE # OF WUMPUSES: 		NO
VARIABLE # OF HUNTERS:			NO
MORE/LESS THAN 3 NEIGHBOR CAVERNS: 	NO, FUTURE POSSIBILITY
ONE WAY PASSAGES: 			NO, FUTURE POSSIBILITY
VARIABLE # OF PITS: 			YES
VARIABLE # OF BATS: 			YES
VARIABLE # OF CAVERNS:			YES (NOT TESTED)
/-----------------------------------------------------------------------------*/
#include <cstdlib>
#include <ctime>
#include "ClassUserInterface.h"
using namespace std;

int main(void) {
	srand(time(NULL));		// Needed for rand()
	UserInterface menuOption;

	menuOption.mainMenu();

	return 0;
}

/*-----------------------------------------------------------------------------/
CHANGELOG

Rev 0.0
09/10/2010
Created program layout. Created HuntTheWumpus.cc, stdhuntthewumpus.h, ClassCavernParametersDefs.cc, and ClassCavernSetupDefs.cc. Created default map for game. Fleshed out stdhuntthewumpus.h and ClassCavernParametersDefs.cc to make them useful. Have yet to fully work out ClassCavernSetupDefs.cc.

Rev 0.1
09/12/2010
Figured out how to pass a class object to a function. Added thorough commenting to source code.

Rev 0.2
09/12/2010
Updated commenting. Added srand(time(NULL)) to main. Added CavernParameters::getAnythingIsPresent(). Reworked arguments to CaveSetup functions. Implemented CaveSetup::setBats.

Rev 0.3
09/13/2010
Implemented CaveSetup::setPits, CaveSetup::setHunter, and CaveSetup::setWumpus.

Rev 0.4
09/14/2010
Changed order of arguments used in CaveSetup::setPits and CaveSetup::setBats, and gave default arguments to them.

Rev 0.5
09/15/2010
Split stdhuntthewumpus.h into separate header files. There is now one header file for each class definition. Moved changelog to bottom of file. Added two classes: UserInterface and UserAction. There are now a total of four classes: the two just mentioned, CavernParameters, and CaveSetup. Added error checking to initial cave setup in HuntTheWumpus.cc

Rev 0.6
09/16/2010
Wrote main menu. Added and wrote UserInterface::clearScreen. Wrote UserInterface::viewHelp.

Rev 0.6
09/16/2010
Moved entire UI and cave construction process into ClassUserInterface.h & ClassUserInterface.cc. The big advantage of this is being able to share NUMBER_OF_CAVERNS, NUMBER_OF_BATS, and NUMBER_OF_PITS. That's three less arguments that I'll need to repeatedly pass to functions. Plus, I can pass caverns[] directly to functions. Removed ClassCaveAction and merged its functions with ClassCaveSetup. Renamed CaveSetup to CavewideAction::. Worked heavily on ClassUserInterface::PlayGame

Rev 0.6
09/17/2010
Fleshed out and bugtested UI. Added logic to make UI work correctly. Realized that most of the logic and many of the variables present in ClassUserInterface might have been placed in ClassCavewideAction instead. Too late. This program is 90% working, and I'd rather not expend all the effort for a theoretical benefit. One task remains: implement the shooting mechanic in the game. May also create a constructor for ClassCavernParameters. I'll figure it out.

Rev 1.0
09/18/2010
Implemented shooting mechanic. Reworked end-of-game messages to be more entertaining and interactive. Make several small improvements to UI. Removed debugging information. It is currently 00:46. Note the revision number above. Huzzah!

Rev 1.1
09/18/2010
Fixed a bug that would prevent user from correctly changing the number of bats or pits in the game. Changed the Super Bat transportation system to more randomly place the hunter. It is currently 01:08. Hot damn. I'm happy with the program as is. I think I'm done.
/-----------------------------------------------------------------------------*/
