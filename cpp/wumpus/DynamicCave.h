/*-============================================================================/
This is the header file for the DynamicCave class, which inherits from class Cave.

The purpose of this class is to add location state information and location-related functions to the class Cave. This includes keeping track of each DynamicCave's neighbors, finding an object with a particular ID number, and moving the Wumpus and Hunter, among a few other functions. Perhaps the most complicated function present is the find() function. It uses a modestly efficient spanning-tree algorithm to find a DynamicCave object, given a certain ID number. 

Also of note are the two constant integers listed right after the namespace declaration. The first influences the operation of moveHunter, and the second helps eliminate a lot of magic numbers. In particular, study the first.
/============================================================================-*/
#ifndef DYNAMICCAVE_H
#define DYNAMICCAVE_H

#include "Cave.h"

namespace JeremyWumpus {
    // A bat will always move the hunter across a random path through the 
    // cave. This variable determines how far the hunter will be moved. If 
    // this variable is 0, the hunter will stay in place.
    // If this variable is a relatively large value, such as 50, then the 
    // hunter will be moved 50 times (therefore, placed seemingly randomly in
    // the cave).
    // DO NOT set this value to less than 0.
    const int MOVE_HUNTER = 50;
    // How many neighbors does each cave have? Currently, 3 is the only
    // acceptable value.
    const int NUM_OF_NEIGHBORS = 3;

    class DynamicCave : public Cave {
        public:
            // Constructor requres no arguments. I suggest at least assigning
            // an ID numbet to each object when it is created.
            DynamicCave(int newID = ' ', bool setHunter = false, bool setWumpus = false, bool setBat = false, bool setPit = false);

            // Precondition: The calling cave/node/object should have a 
            // wumpus present. If the calling object does not contain a wumpus,
            // NULL will be returned.
            // Postcondition: The wumpus has a 75% chance of moving to a random
            // neighbor, and a 25% chance of staying in place. Returns a pointer
            // to the cave the wumpus travels to.
            DynamicCave* moveWumpus(void);

            // Precondition: The calling cave/node/object should have a 
            // hunter present. If the calling object does not contain a hunter,
            // NULL will be returned.
            // Postcondition: The hunter will be randomly moved to a cave.
            // Useful for when the hunter gets picked up by a bat. Returns
            // a pointer to the cave the hunter is moved to.
            DynamicCave* moveHunter(void);

            // Precondition: The calling cave/node/object should have a 
            // hunter present. If the calling object does not contain a hunter,
            // NULL will be returned. The argument passed specifies which
            // value in neighbor[] to use when moving the hunter.
            // Postcondition: The hunter will be moved to that noce. A pointer
            // will be returned pointing to the node that now holds the hunter.
            DynamicCave* moveHunter(int);

            // Precondition: Pass valid pointers to three DynamicCave objects.
            // Postcondition: The neighbor[] variable will be set appropriately.
            // This function has no way of making sure that the pointer passed
            // is valid or not, so be careful!
            void setNeighbors(DynamicCave*, DynamicCave*, DynamicCave*);

            // Precondition: the argument is the ID number of the Cave to find.
            // Postcondition: If match found, return a pointer to the correct
            // cave. If no match found, return NULL.
//            DynamicCave* find(int);

            // Precondition: none
            // Postcondition: One of the values in private variable neighbor[]
            // will be returned.
            DynamicCave* getRandomNeighbor(void) const;

            // Precondition: Pass an int, where (0 <= int < NUM_OF_NEIGHBORS)
            // Postcondition: A pointer to one of this node's neighbors will be
            // returned. If you sucessively call this function and pass all
            // possible arguments, all neighbors will be returned.
            DynamicCave* getNeighbor(int) const;
        private:
            // A list of pointers to all neighboring caves.
            DynamicCave* neighbor[NUM_OF_NEIGHBORS];
    };

    typedef DynamicCave* DynamicCavePtr;
}

#endif // #ifndef DYNAMICCAVE_H
