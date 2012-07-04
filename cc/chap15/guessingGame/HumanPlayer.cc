#include "HumanPlayer.h"
#include <iostream>

namespace JeremysCode {
    /*-===========================================================================/
    HumanPlayer()
    /===========================================================================-*/ 
    HumanPlayer::HumanPlayer()
        : Player()
    {
        ; // intentionally empty
    }

    /*-===========================================================================/
    virtual int getGuess(void) const
    /===========================================================================-*/ 
    int HumanPlayer::getGuess(void) const {
        using std::cout;
        using std::endl;
        using std::cin;

        int input;

        cout << "Guess: ";
        while(!(cin >> input)) {
            cout << "Oops -- that's not a number. Try again!\n";
            cin.clear();
            cin.ignore(1000, '\n');
            cout << "Guess: ";
        }
        cin.ignore(1000, '\n');
        // Input has been gotten, trailing input cleaned up.

        return input;
    }
}
