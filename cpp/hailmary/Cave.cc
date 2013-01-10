#include "Cave.h"
#include <cstdlib>
#include "Pit.h"
#include "Wumpus.h"
#include "Bat.h"

namespace JeremyWumpus {
    /*-========================================================================/
    constructor
    /========================================================================-*/
    Cave::Cave(void) {
        hazardList.resize(0);
    }

    /*-========================================================================/
    Output a message for each of the hazards at this cave.
    /========================================================================-*/
    void Cave::showAlerts(void) const {
        for(int i = 0; i < hazardList.size(); i++) {
            hazardList[i]->Alert();
        }

        return;
    }

    /*-========================================================================/
    Add a hazard of the specified type, where type is either "wumpus", "pit",
    or "bat". If hazard is already present, do nothing.
    /========================================================================-*/
    void Cave::addHazard(std::string target) {
        using std::tr1::shared_ptr;
        using JeremyWumpus::Pit;
        using JeremyWumpus::Bat;
        using JeremyWumpus::Wumpus;
        bool alreadyPresent = false;

        // First check the hazards already present.
        for(int i = 0; i < hazardList.size(); i++) {
            // If the asked-for type of threat has already been added...
            if(hazardList[i]->getType() == target) {
                // note such, and don't actually add it.
                alreadyPresent = true;
            }
        }

        // If this function has been asked to add a pit, then...
        if("pit" == target) {
            // ...only add a pit if one is not already present.
            if(false == alreadyPresent) {
                hazardList.push_back(shared_ptr<Hazards>(new Pit));
            }
        } else if("bat" == target) {
            if(false == alreadyPresent) {
                hazardList.push_back(shared_ptr<Hazards>(new Bat));
            }
        } else if("wumpus" == target) {
            if(false == alreadyPresent) {
                hazardList.push_back(shared_ptr<Hazards>(new Wumpus));
            }
        } 
        // If the target type of hazard is not found, dont' do anything.

        return;
    }

    /*-========================================================================/
    Remove a hazard of the specified type, where type is either "wumpus", "pit",
    or "bat". If hazard not present, do nothing.
    /========================================================================-*/
    void Cave::delHazard(std::string target) {
        // Iterate through all of the threats present.
        for(int i = 0; i < hazardList.size(); i++) {
            // If a hazard of the target type is found...
            if(hazardList[i]->getType() == target) {
                // ... delete that hazard from the hazardList vector (the
                // shared_ptr will take care of deleting the object)...
                hazardList.erase(hazardList.begin() + i);
                // ... and decrement the counter, as there is now one fewer
                // element in the vector of hazards.
                i--;
            }
        }

        return;
    }

    /*-========================================================================/
    Check to see if a hazard of the specified type is present, where type is
    either "wumpus", "pit", or "bat". Return true if present, false if not.
    /========================================================================-*/
    bool Cave::getHazard(std::string target) const {
        for(int i = 0; i < hazardList.size(); i++) {
            if(hazardList[i]->getType() == target) {
                return true;
            }
        }

        return false;
    }
}
