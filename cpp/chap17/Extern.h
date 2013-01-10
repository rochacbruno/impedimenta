#ifndef EXTERN_H
#define EXTERN_H

#include "CharNode.h"

namespace {
    using JeremysCode::CharNodePtr;
    using JeremysCode::CharNode;
}

namespace ExternalCode {
    class Extern {
        public:
            void test(void);
            CharNodePtr test2(void);
        private:
    };
}

#endif
