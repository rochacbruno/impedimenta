#ifndef FIGURE_H
#define FIGURE_H

namespace JeremyFigure {
    class Figure {
        public:
            virtual void erase(void) const;
            virtual void draw(void) const = 0;
            void center(void) const;  // calls erase() and draw()
        private:
    };
}

#endif // #ifndef FIGURE_H
