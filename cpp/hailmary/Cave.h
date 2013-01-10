#ifndef CAVE_H
#define CAVE_H

#include "Hazards.h"
#include <vector>
#include <string>
#include <tr1/memory>

namespace JeremyWumpus {
    class Cave {
        public:
            Cave(void);
            void showAlerts(void) const;
            void addHazard(std::string);
            void delHazard(std::string);
            bool getHazard(std::string) const;
        private:
            std::vector<std::tr1::shared_ptr<Hazards> > hazardList;
    };
}

#endif // #ifndef CAVE_H
