/*-============================================================================/
This is the header file for class HumanPlayer, descended from class Player.

Pretty boring, really. A very simple constructor is defined, and the virtual function getGuess() is defined.
/============================================================================-*/
#ifndef HUMANPLAYER_H
#define HUMANPLAYER_H

#include "Player.h"

namespace JeremysCode {
    class HumanPlayer : public Player {
        public:
            // Calls the constructor for class Player
            HumanPlayer();

            // Read in input from the keyboard. Check to make sure that the input is a valid integer. Return that integer.
            virtual int getGuess(void) const;   
        private:
    };
}

#endif // #ifndef HUMANPLAYER_H
