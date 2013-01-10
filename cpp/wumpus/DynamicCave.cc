#include "DynamicCave.h"
#include <cstdlib>
#include <vector>
#include <iostream>

namespace JeremyWumpus {
    /*-========================================================================/
    DynamicCave(int, bool, bool, bool, bool)
    /========================================================================-*/
    DynamicCave::DynamicCave(int newId, bool setHunter, bool setWumpus, bool setBat, bool setPit)
        : Cave(newId, setHunter, setWumpus, setBat, setPit)
    {
        for(int i = 0; i < NUM_OF_NEIGHBORS; i++) {
            neighbor[i] = NULL;
        }
    }

    /*-========================================================================/
    void moveWumpus(void)
    /========================================================================-*/
    DynamicCave* DynamicCave::moveWumpus(void) {
        using std::cerr;
        DynamicCave* choice = NULL;

        // Check to make sure that a wumpus actually is present.
        if(getWumpusPresent() == false) {
            return NULL;
        }

        // Assuming that NUM_OF_NEIGHBORS == 3, there is a one in four chance 
        // that the wumpus will not move. This if statement provides for that
        // possibility. Note that the getRandomNeighbor() function will _always_
        // choose a neighbor, and not itself.
        if(rand() % NUM_OF_NEIGHBORS == 0) {
            return this;
        }

        // And these two statements will make the wumpus move.
        choice = getRandomNeighbor();
        if(NULL == choice) {
            cerr << "This node/cave has not had its neighbors properly set. Cannot move hunter.\n";
            cerr << "Exiting due to error.\n";
            exit(1);
        }

        setWumpusPresent(false);
        choice->setWumpusPresent(true);
        return choice;
    }

    /*-========================================================================/
    void moveHunter(void)
    /========================================================================-*/
    DynamicCave* DynamicCave::moveHunter(void) {
        using std::cerr;
        DynamicCave* choice = NULL;
        int i = 0;

        // Some preliminary error checking. Make sure the calling object (this
        // object) does, in fact, contain a hunter. Also make sure that 
        // MOVE_HUNTER is set correctly.
        if(getHunterPresent() == false) {
            return NULL;
        }
        if(MOVE_HUNTER < 0) {
            cerr << "DynamicCave::moveHunter must at least be able to leave the hunter in place.\n";
            cerr << "Please increase the MOVE_HUNTER variable. Exiting due to error.\n";
            exit(1);
        }

        // Choose a cave to move the hunter to.
        choice = this;
        for(i = 0; i < MOVE_HUNTER; i++) {
            choice = choice->getRandomNeighbor();
            if(NULL == choice) {
                cerr << "This node/cave has not had its neighbors properly set. Cannot move hunter.\n";
                cerr << "Exiting due to error.\n";
                exit(1);
            }
        }

        setHunterPresent(false);
        choice->setHunterPresent(true);
        return choice;
    }

    /*-========================================================================/
    DynamicCave* moveHunter(int)
    /========================================================================-*/
    DynamicCave* DynamicCave::moveHunter(int whichNeighbor) {
        if(whichNeighbor >= NUM_OF_NEIGHBORS || whichNeighbor < 0) {
            return NULL;
        } else if(false == getHunterPresent()) {
            return NULL;
        }

        setHunterPresent(false);
        neighbor[whichNeighbor]->setHunterPresent(true);

        return neighbor[whichNeighbor];
    }

    /*-========================================================================/
    DynamicCave* find(int)
    /========================================================================-*/
/*
    DynamicCave* DynamicCave::find(int target) {
        using std::vector;
        using std::cerr;
        int i = 0;
        int j = 0;
        bool neighborVisited = false;
        DynamicCave* result = NULL;
        static vector<int> visited;

        using std::cout;    // DEBUG
        using std::endl;    // DEBUG
        cout << "find() is attempting to find " << target << endl;  // DEBUG
        cout << "find() is visiting node " << getID() << endl;      // DEBUG

        // if this node is the node we're looking for, then clear the list
        // of visited nodes (so the next search will work correctly) and return
        // a pointer to this current node.
        if(getID() == target) {
            visited.resize(0);
            return this;
        }

        // This node has not already been visited, and it is not the one we are
        // looking for. Therefore, add this node to the list of visited nodes
        // and check each of the neighboring nodes.
        // Technical details: i is used for cycling through neighbors, 
        // j is used for cycling through the list of visited nodes.
        visited.push_back(getID());
        for(i = 0; i < NUM_OF_NEIGHBORS; i++) {
            // Start by assuming that each neighbor[i] has NOT been visited.
            // Check neighbor[i] against the list of visited nodes (in the
            // variable 'visited'). If a match is found, then do not bother
            // going there.
            neighborVisited = false;
            for(j = 0; j < visited.size(); j++) {
                if(visited[j] == neighbor[i]->getID()) {
                    neighborVisited = true;
                }
            }

            if(false == neighborVisited) {
                // If neighbor[i] does NOT return null, then it must be the
                // one we're looking for! Return its address.
                result = neighbor[i]->find(target);
                if(NULL != result) {
                    return result;
                }
            }
        }

        // Neither this node nor any neighboring nodes are the one we're looking
        // for. Return NULL. Also, clear the list of visited nodes if they've
        // all been visited. The only other way for the list to clear is if
        // the correct one has been found (which obviously will not happen now).
        // CORRECTION: In c++, you can't return NULL. Whoops. I'll have to
        // correct for this elsewhere, and in a rather ugly fashion. DAMN!
        if(20 == visited.size()) {
            visited.resize(0);
        }

        cerr << "Node not found. Cannot return NULL. :( Exiting due to error.\n";
        exit(1);
    }
*/

    /*-========================================================================/
    DynamicCave* getRandomNeighbor(void) const
    /========================================================================-*/
    DynamicCave* DynamicCave::getRandomNeighbor(void) const {
        return neighbor[std::rand() % NUM_OF_NEIGHBORS];
    }

    /*-========================================================================/
    void setNeighbors(Cave*, Cave*, Cave*)
    /========================================================================-*/
    void DynamicCave::setNeighbors(DynamicCave* newNeighbor1, DynamicCave* newNeighbor2, DynamicCave* newNeighbor3)
    {
        neighbor[0] = newNeighbor1;
        neighbor[1] = newNeighbor2;
        neighbor[2] = newNeighbor3;
    }

    /*-========================================================================/
    DynamicCave* getNeighbor(int) const
    /========================================================================-*/
    DynamicCave* DynamicCave::getNeighbor(int choice) const {
        using std::cerr;

        if(choice >= NUM_OF_NEIGHBORS || choice < 0) {
            cerr << "getNeigbor() cannot return a valid address. Please check your arguments.\n"
                 << "Exiting due to error.\n";
            exit(1);
        }

        return neighbor[choice];
    }
}
