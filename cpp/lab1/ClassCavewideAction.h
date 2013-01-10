/*-----------------------------------------------------------------------------/
Gives you functions to modify the entire cave at once. For example, while you can set bats in a single cave using CavernParameters::setBatIsPresent(), you can randomly set any num of bats in the cave using CaveSetup::setBats(). Relies upon functions in the CavernParameters class.
/-----------------------------------------------------------------------------*/
#ifndef CLASSCAVEWIDEACTION_H
#define CLASSCAVEWIDEACTION_H

#include "ClassCavernParameters.h"

class CavewideAction {
	public:
		void clearCave(int, CavernParameters*);
		/*-------------------------------------------------------------/
		Precondition: int refers to the number of caverns in cave. CavernParameters* is the name of a CavernParameters object. (e.g. if you declared CavernParameters cavern[20], then pass cavern)
		Postcondition: Bats, Pits, Hunter, and Wumpus removed.
		/-------------------------------------------------------------*/

		int setBats(int, CavernParameters*, int = 2);
		int setPits(int, CavernParameters*, int = 2);
		/*-------------------------------------------------------------/
		Precondition: First arg is number of caverns in cave. CavernParameters* is the name of a CavernParameters object. (e.g. if you declared CavernParameters cavern[20], then pass cavern) Third arg is number of items to place.
		Postcondition: Will not place an item where a bat, pit, hunter, or wumpus is already located. If not enough caverns available to place specified number of items, will exit with non-zero return code and not place any items. By default, will place 2 items.
		/-------------------------------------------------------------*/

		int setWumpus(int, CavernParameters*);
		int setHunter(int, CavernParameters*);
		/*-------------------------------------------------------------/
		Precondition: First int is number of caverns in cave. CavernParameters* is the name of a CavernParameters object. (e.g. if you declared CavernParameters cavern[20], then pass cavern)
		Postcondition: Will not place an item where a bat, pit, hunter, or wumpus is already located. If not enough caverns available to place specified number of items, will exit with non-zero return code and not place any items.
		/-------------------------------------------------------------*/

		int getHunterLocation(int, CavernParameters*);
		int getWumpusLocation(int, CavernParameters*);
		/*-------------------------------------------------------------/
		Precondition: First int is number of caverns in cave. CavernParameters* is the name of a CavernParameters object. (e.g. if you declared CavernParameters cavern[20], then pass cavern)
		Postcondition: Will return index number of cave where item is located. Cannot handle a setup where more than one item is present.
		/-------------------------------------------------------------*/
	private:
};
#endif	// #ifndef CLASSCAVEWIDEACTION_H
