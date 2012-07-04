/*-==========================================================================-*\
Author(s):
Jeremy Audet

First Created: 10/25/2011
License: Creative Commons BY-SA         http://creativecommons.org/licenses/by-sa/3.0/

Thanks to:
* C++ Primer Plus, by Stephen Prata     ISBN: 0131388207, 9780131388208
This is the book that taught me how to use C++. Highly recommended.

\*-==========================================================================-*/

#include <iostream>

int main(void) {
    using namespace std;                // Limit the scope of namespace std to just this function.

    char ch;                            // For buffering input.

    cout << "Type something, press 'enter', and it will be echoed back." << endl
         << "Press CTRL-D or CTRL-C to quit." << endl;
    cin.get(ch);
    while(false == cin.fail()) {        // If EOF has been read, cin.fail() will return true.
        cout << ch;

        cin.get(ch);
    }
    cout << endl;

    return 0;
}
