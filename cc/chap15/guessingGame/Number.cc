#include "Number.h"
#include <cstdlib>
#include <iostream>

namespace JeremysCode {
    /*-===========================================================================/
    Number()
    /===========================================================================-*/
    Number::Number() {
        number = rand() % 100;
    }

    /*-===========================================================================/
    Number(int)
    /===========================================================================-*/
    Number::Number(int newNumber) {
        using std::cerr;

        // Error checking. Is new number valid?
        if(newNumber < 0) {
            cerr << "Number cannot be less than 0. Exiting due to error\n";
            exit(1);
        } else if(newNumber > 100) {
            cerr << "Number cannot be greater than 100. Exiting due to error.\n";
            exit(1);
        }

        number = newNumber;
    }

    /*-===========================================================================/
    int getNumber(void) const;
    /===========================================================================-*/
    int Number::getNumber(void) const {
        return number;
    }

    /*-===========================================================================/
    void setNumber(void)
    /===========================================================================-*/
    void Number::setNumber(void) {
        number = rand() % 100;

        return;
    }

    /*-===========================================================================/
    int compareNumber(int) const    
    /===========================================================================-*/
    int Number::compareNumber(int comparitor) const {
        if(comparitor > number)         {return 1;} 
        else if(comparitor == number)   {return 0;} 
        else                            {return -1;}
    }
}
