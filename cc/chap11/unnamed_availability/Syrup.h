#ifndef SYRUP_H
#define SYRUP_H

#include <iostream>

namespace JeremySampleData {
    class Syrup {
        public:
            Syrup();
            int getWeight(void) const;
            char getGrade(void) const;
            void setWeight(const int);
            void setGrade(const char);
        private:
            int weight;
            char grade;
    };
}

#endif // #ifndef SYRUP_H
