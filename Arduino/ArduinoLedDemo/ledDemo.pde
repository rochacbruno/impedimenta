/*-===========/
Jeremy Audet 

Demonstrates the use a 16x2 LCD display.  The LiquidCrystal
library works with all LCD displays that are compatible with the 
Hitachi HD44780 driver. There are many of them out there, and you
can usually tell them by the 16-pin interface.

The circuit:
* LCD RS pin to digital pin 12
* LCD Enable pin to digital pin 11
* LCD D4 pin to digital pin 5
* LCD D5 pin to digital pin 4
* LCD D6 pin to digital pin 3
* LCD D7 pin to digital pin 2
* LCD R/W pin to ground
* 10K resistor:
* ends to +5V and ground
* wiper to LCD VO pin (pin 3)
/===========-*/
/*-============================================================================/
includes, global declarations
/============================================================================-*/
#include <LiquidCrystal.h>

const int IN1 = 7;
const int IN2 = 6;
const int OUT1 = 0;
const int OUT2 = 1;

/*-============================================================================/
functions
/============================================================================-*/
/*-===========/
void setup() -- the first function run
/===========-*/
void setup() {
    pinMode(OUT1, OUTPUT);
    digitalWrite(OUT1, LOW);
    pinMode(OUT2, OUTPUT);
    digitalWrite(OUT2, LOW);

    pinMode(IN1, INPUT);
    pinMode(IN2, INPUT);
}

/*-===========/
void loop() -- the preordained main loop
/===========-*/
void loop() {
    if(LOW == digitalRead(IN1)) {
        // debounce delay
        delay(10);

        digitalWrite(OUT1, HIGH);
        digitalWrite(OUT2, HIGH);
        while(LOW == digitalRead(IN1)) {
            ; // delay while user is still pressing button
        }

        // debounce delay
        delay(10);
    }

    if(LOW == digitalRead(IN2)) {
        // debounce delay
        delay(10);

        digitalWrite(OUT1, LOW);
        digitalWrite(OUT2, !digitalRead(OUT2));
        while(LOW == digitalRead(IN2)) {
            ; // delay while user is still pressing button
        }

        // debounce delay
        delay(10);
    }
}
