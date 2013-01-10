#include "Player.h"

namespace JeremysCode {
    /*-=========================================================================/
    void Player::Player()
    /=========================================================================-*/
    Player::Player() {
        low = 0;
        high = 100;
    }

    /*-=========================================================================/
    int getHigh(void) const
    /=========================================================================-*/
    int Player::getHigh(void) const {
        return high;
    }

    /*-=========================================================================/
    int getLow(void) const
    /=========================================================================-*/
    int Player::getLow(void) const {
        return low;
    }

    /*-=========================================================================/
    void Player::givePlay(int, int)
    /=========================================================================-*/
    void Player::givePlay(int play, int result) {
        if(result < 0) {
            // guess was too low

            // if guess is < goal AND...
            // guess is >= upper limit THEN...
            // correct lower limit
            if(play >= low) {
                low = play + 1;
            }
        } else if(result > 0) {
            // guess was too high

            // if guess is > goal, AND...
            // guess is <= upper limit THEN...
            // correct my upper limit
            if(play <= high) {
                high = play - 1;
            }
        } else {
            ; // if result of previous play is 0, then someone has won. Do nothing.
        }
    } // end function definition

    void Player::resetLimits(void) {
        low = 0;
        high = 100;
    }
} // end namespace
