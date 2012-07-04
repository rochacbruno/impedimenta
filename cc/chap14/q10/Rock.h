/*
This file defines the interface of class Rock. Rock is a descendant of class Pet.
*/
#ifndef ROCK_H
#define ROCK_H

#include "Pet.h"

namespace Creature {
    class Rock : public Pet {
        public:
            // constructors
            Rock();
            Rock(std::string newName);
            Rock(std::string newName, int newAge, int newWeightKg);

            // no additional getters or setters needed, as no new private variables are created

            // other functions
            std::string getLifespan(void) const;
        private:
    };
}

#endif // #ifndef ROCK_H
