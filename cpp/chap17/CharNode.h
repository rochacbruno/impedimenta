#ifndef CHARNODE_H
#define CHARNODE_H

namespace JeremysCode {
    class CharNode {
        public:
            // I have intentionally left out the constructor CharNode()
            CharNode(CharNode* nextNode, char newCh = ' ');

            CharNode* getLink() const;
            char getCh() const;
            void setLink(CharNode* newLink);
            void setCh(char newCh);
        private:
            char ch;
            CharNode *link;
    };

    typedef CharNode* CharNodePtr;
}

#endif // #ifndef CHARNODE_H
