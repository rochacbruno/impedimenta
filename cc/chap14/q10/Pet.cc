/*
This file defines the implementation of class Pet.

Here's a condensed version of the class declaration for quick reference.
class Pet {
    public:
        // constructors
        Pet();
        Pet(std::string newName);
        Pet(std::string newName, int newAge, int newWeightKg);

        // getters and setters
        std::string getName(void) const;
        int getAge(void) const;
        int getWeightKg(void) const;
        void setName(std::string);
        void setAge(int);
        void setWeightKg(int);

        // other functions
        std::string getLifespan(void) const;
    private:
        std::string name;
        int age;
        int weightKg;
};
*/
#include "Pet.h"
#include <iostream>

namespace Creature {
    /*-========================================================================/
    Constructors
    /========================================================================-*/
    Pet::Pet() {
        name = "no name yet";
        age = 0;
        weightKg = 0;
    }

    Pet::Pet(std::string newName)
        : name(newName)
    {
        age = 0;
        weightKg = 0;
    }

    Pet::Pet(std::string newName, int newAge, int newWeightKg)
        : name(newName), age(newAge), weightKg(newWeightKg)
    {
        using std::cerr;

        if(age < 0) {
            cerr << "A pet cannot be created with an age less than zero. Setting age to 0.\n";
            age = 0;
        }
        if(weightKg < 0) {
            cerr << "A pet cannot be created with a weight less than zero. Setting weightKg to 0.\n";
            weightKg = 0;
        }
    }

    /*-========================================================================/
    Getters
    /========================================================================-*/
    std::string Pet::getName(void) const {
        return name;
    }

    int Pet::getAge(void) const {
        return age;
    }

    int Pet::getWeightKg(void) const {
        return weightKg;
    }

    /*-========================================================================/
    Setters
    /========================================================================-*/
    void Pet::setName(std::string newName)
    {
        name = newName;

        return;
    }

    void Pet::setAge(int newAge)
    {
        using std::cerr;

        if(newAge < 0) {
            cerr << "A pet object cannot have an age less than zero. Setting age to 0 instead.\n";
            age = 0;
        } else {
            age = newAge;
        }

        return;
    }

    void Pet::setWeightKg(int newWeightKg)
    {
        using std::cerr;

        if(newWeightKg < 0) {
            cerr << "A pet object cannot have a weight less than zero. Setting weightKg to 0 instead.\n";
            weightKg = 0;
        } else {
            weightKg = newWeightKg;
        }

        return;
    }

    /*-========================================================================/
    function getLifespan(void)
    /========================================================================-*/
    std::string Pet::getLifespan(void) const {
        return "unknown lifespan";
    }
} // namespace Creature
