/*
This file defines the interface for the class Pet. 

I have chosen not to place the statement "using std::string" inside this header file, despite the fact that type string is used many times over. Any time a statement like that is used, it is placed inside the implementation of a single function. This allows me to be explicit about data types in function declarations, and also write clean-looking and encapsulated code inside function definitions.
*/
#ifndef PET_H
#define PET_H

#include <string>

namespace Creature {
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

            // precondition: none
            // postcondition: Returns "unknown lifespan" or a similar string. Derived classes should redefine this function.
            std::string getLifespan(void) const;
        private:
            std::string name;
            int age;
            int weightKg;
    };
}

#endif // #ifndef PET_H
