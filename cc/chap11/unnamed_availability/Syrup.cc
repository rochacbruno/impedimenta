/*-============================================================================/
This file implements the Syrup.cc interface. Here's a condensed repeat of the interface definition:
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
/============================================================================-*/

#include "Syrup.h"

namespace {
    using std::cout;

    void syrupMessage(void) {
        cout << "Hello from Syrup.cc's unnamed namespace\n";

        return;
    }
}

namespace JeremySampleData {
    Syrup::Syrup() {
        weight = 0;
        grade = ' ';    // Syrup is usually classified as grade A - D.
    }

    int Syrup::getWeight(void) const {
        return weight;
    }

    char Syrup::getGrade(void) const {
        return grade;
    }

    void Syrup::setWeight(const int newWeight) {
        weight = newWeight;

        return;
    }

    void Syrup::setGrade(const char newGrade) {
        grade = newGrade;

        return;
    }
}
