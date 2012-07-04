/*-============================================================================/
This file holds the declaration of class Player. Note that this class is purely virtual, due to the existence of the pure virtual function getGuess().
/============================================================================-*/
#ifndef PLAYER_H
#define PLAYER_H

namespace JeremysCode {
    class Player {
        public:
            // constructor. Sets variables "low" and "high" to 0 and 100, respectively.
            Player();

            // getLow and getHigh return the value of variables "low" and "high", respectively.
            int getLow(void) const;
            int getHigh(void) const;
            // Precondition: none.
            // Postcondition: return the player's guess at what the random number is.
            virtual int getGuess(void) const = 0;
            // Precondition: The first arg should be an int between 0 and 100 inclusive, and the second arg should be an int between -1 and 1, inclusive. The first argument is the player's last guess,  and the second argument describes whether the guess was too high, correct, or too low. A positive number means that the player's guess was too high, a 0 means that the player's guess was correct, and a positive number means that the player's guess was too low.
            // Postcondition: The variables "low" and "high" are updated accordingly. For example, if the player guessed 68 and the guess was too low, then "low" should be set to 69 (the random number must be at least 69, inclusive). One would then call this function with the arguments of 68 and -1.
            void givePlay(int play, int result);
            // set "low" and "high" to 0 and 100, respectively.
            void resetLimits(void);
        private:
            int low;
            int high;
    };
}

#endif // #ifndef PLAYER_H
