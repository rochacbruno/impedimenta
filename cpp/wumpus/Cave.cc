#include <cstdlib>
#include "Cave.h"

namespace JeremyWumpus {
    /*-========================================================================/
    Cave constructor
    /========================================================================-*/
    Cave::Cave(int newID, bool setHunter, bool setWumpus, bool setBat, bool setPit)
        : ID(newID), hunter(setHunter), wumpus(setWumpus), bat(setBat), pit(setPit)
    {
        ; // intentionally empty
    }

    /*-========================================================================/
    getters
    /========================================================================-*/
    int Cave::getID(void) const {
        return ID;
    }

    bool Cave::getHunterPresent(void) const {
        return hunter;
    }

    bool Cave::getWumpusPresent(void) const {
        return wumpus;
    }

    bool Cave::getBatPresent(void) const {
        return bat;
    }

    bool Cave::getPitPresent(void) const {
        return pit;
    }

    bool Cave::getCreaturePresent(void) const {
        if(hunter || wumpus || bat || pit) {
            return true;
        }

        return false;
    }

    /*-========================================================================/
    setters
    /========================================================================-*/
    void Cave::setID(int newID)
    {
        ID = newID;
    }

    void Cave::setHunterPresent(bool setHunter)
    {
        hunter = setHunter;
    }

    void Cave::setWumpusPresent(bool setWumpus) 
    {
        wumpus = setWumpus;
    }

    void Cave::setBatPresent(bool setBat) 
    {
        bat = setBat;
    }

    void Cave::setPitPresent(bool setPit)
    {
        pit = setPit;
    }

    void Cave::clearCreatures(void) {
        hunter = false;
        wumpus = false;
        bat = false;
        pit = false;

        return;
    }
}
