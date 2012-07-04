/*-============================================================================/
Header file for class ComputerPlayer, descended from class Player. 

Pretty boring. This class implements a constructor and the virtual function getGuess().
/============================================================================-*/
#ifndef COMPUTERPLAYER_H
#define COMPUTERPLAYER_H

#include "Player.h"

namespace JeremysCode {
    class ComputerPlayer : public Player {
        public:
            // constructor. Simply calls constructor for class Player.
            ComputerPlayer();

            // Implments the guessing routine for the AI. No arguments. Function returns the AI's guess.
            virtual int getGuess(void) const;
        private:
    };
}

#endif // #ifndef COMPUTERPLAYER_H
