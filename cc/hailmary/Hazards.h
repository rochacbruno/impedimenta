#ifndef HAZARDS_H
#define HAZARDS_H

#include <string>

namespace JeremyWumpus {
    class Hazards {
        public:
            virtual void Alert(void) const = 0;
            virtual std::string getType(void) const = 0;
        private:
    };
}

#endif // #ifndef HAZARDS_H
