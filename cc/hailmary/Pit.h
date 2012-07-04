#ifndef PIT_H
#define PIT_H

#include "Hazards.h"

namespace JeremyWumpus {
    class Pit : public Hazards {
        public:
            virtual void Alert(void) const;
            virtual std::string getType(void) const;
        private:
    };
}

#endif // #ifndef PIT_H
