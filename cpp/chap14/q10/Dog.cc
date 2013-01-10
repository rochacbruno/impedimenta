/*
This file defines the implementation of class Dog. Dog is a descendant of class Pet.

Here's a condensed repeat of class Dog, for quick reference.
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
        std::string getLifespan(void);
    private:
        std::string breed;
};
*/
#include "Dog.h"

namespace Creature {
    /*-========================================================================/
    Constructors
    /========================================================================-*/
    Dog::Dog(void)
        : Pet(), breed("no breed yet")
    {
        ; // intentionally empty
    }

    Dog::Dog(std::string newName)
        : Pet(newName), breed("no breed yet")
    {
        ; // intentionally empty
    }

    Dog::Dog(std::string newName, int newAge, int newWeightKg)
        : Pet(newName, newAge, newWeightKg), breed("no breed yet")
    {
        ; // intentionally empty
    }

    Dog::Dog(std::string newName, int newAge, int newWeightKg, std::string newBreed)
        : Pet(newName, newAge, newWeightKg), breed(newBreed)
    {
        ; // intentionally empty
    }

    /*-========================================================================/
    Getters
    /========================================================================-*/
    std::string Dog::getBreed(void) const {
        return breed;
    }

    /*-========================================================================/
    Setters
    /========================================================================-*/
    void Dog::setBreed(std::string newBreed) {
        breed = newBreed;

        return;
    }

    /*-========================================================================/
    function getLifespan(void)
    /========================================================================-*/
    std::string Dog::getLifespan(void) const {
        if(getWeightKg() >= 45.4) {   // 45.4 kilograms == 100 pounds
            return "approximately 7 years";
        } else {
            return "approximately 13 years";
        }
    }

} // namespace Creature
