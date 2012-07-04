#ifndef WUMPUS_H
#define WUMPUS_H

#include "Hazards.h"

namespace JeremyWumpus {
    class Wumpus : public Hazards {
        public:
            virtual void Alert(void) const;
            virtual std::string getType(void) const;
        private:
    };
}

#endif // #ifndef WUMPUS_H
