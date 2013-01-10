/*
This file defines the implementation of class Rock. Rock is a descendant of class Pet.

Here's a condensed version of the Pet class, for quick reference.
class Rock : public Pet {
    public:
        // constructors
        Rock();
        Rock(std::string newName);
        Rock(std::string newName, int newAge, int newWeightKg);

        // other functions
        std::string getLifespan(void) const;
    private:
};
*/
#include "Rock.h"
#include <iostream>

namespace Creature {
    /*-========================================================================/
    Constructors
    /========================================================================-*/
    Rock::Rock()
        : Pet()
    {
        ; // intentionally empty
    }

    Rock::Rock(std::string newName)
        : Pet(newName)
    {
        ; // intentionally empty
    }

    Rock::Rock(std::string newName, int newAge, int newWeightKg)
        : Pet(newName, newAge, newWeightKg)
    {
        ; // intentionally empty
    }

    /*-========================================================================/
    function getLifespan(void)
    /========================================================================-*/
    std::string Rock::getLifespan(void) const {
        return "thousands of years";
    }
} // namespace Creature
