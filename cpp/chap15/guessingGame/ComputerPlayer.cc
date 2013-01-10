#include "ComputerPlayer.h"
#include <cstdlib>

namespace JeremysCode {
    /*-===========================================================================/
    ComputerPlayer()
    /===========================================================================-*/
    ComputerPlayer::ComputerPlayer()
        : Player()
    {
        ; // deliberately empty
    }

    /*-===========================================================================/
    virtual int getGuess(void) const
    /===========================================================================-*/
    int ComputerPlayer::getGuess(void) const {
        return (getHigh() + getLow()) / 2;
    }   
}
