/*
This file defines the interface of class Dog. Dog is a descendant of class Pet.
*/
#ifndef DOG_H
#define ROCK_H

#include "Pet.h"

namespace Creature {
    class Dog : public Pet {
        public:
            // constructors
            Dog();
            Dog(std::string newName);
            Dog(std::string newName, int newAge, int newWeightKg);
            Dog(std::string newName, int newAge, int newWeightKg, std::string newBreed);

            // getters and setters
            std::string getBreed(void) const;
            void setBreed(std::string);

            // other functions
            std::string getLifespan(void) const;
        private:
            std::string breed;
    };
}

#endif // #ifndef DOG_H
