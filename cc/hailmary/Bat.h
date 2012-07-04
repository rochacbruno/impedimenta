#ifndef BAT_H
#define BAT_H

#include "Hazards.h"

namespace JeremyWumpus {
    class Bat : public Hazards {
        public:
            virtual void Alert(void) const;
            virtual std::string getType(void) const;
        private:
    };
}

#endif // #ifndef BAT_H
