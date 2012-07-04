/*-============================================================================/
Header file for the class Number.

Pretty straightforward class. Holds a number betwee 0 and 100, inclusive. Let's you manage the number in a couple simple ways. Perhaps the only interesting function is compareNumber... meh.
/============================================================================-*/
#ifndef NUMBER_H
#define NUMBER_H

namespace JeremysCode {
    class Number {
        public:
            // constructor. Number will be initialized between 0-100, inclusive.
            Number();
            // constructor. Number will be initialized to argument. Argument must be 0-100, inclusive.
            Number(int); 

            // returns the variable "number"
            int getNumber(void) const;
            // randomly sets a new value for variable "number". Should overload this function to take an integer argument.
            void setNumber(void);
            // Precondition: pass an integer.
            // Postcondition: returns 0 if argument is same as variable "number". Return 1 if argument is greater, and -1 if argument is lesser.
            int compareNumber(int) const;
        private:
            int number;
    };
}

#endif // #ifndef NUMBER_H
