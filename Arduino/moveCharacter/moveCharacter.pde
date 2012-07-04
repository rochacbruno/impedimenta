/*
  LiquidCrystal Library - Hello World
 
 Demonstrates the use a 16x2 LCD display.  The LiquidCrystal
 library works with all LCD displays that are compatible with the 
 Hitachi HD44780 driver. There are many of them out there, and you
 can usually tell them by the 16-pin interface.
 
 This sketch prints "Hello World!" to the LCD
 and shows the time.
 
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
*/
/*-============================================================================/
includes, global declarations
/============================================================================-*/
#include <LiquidCrystal.h>

const int CUSTOM_CHAR = 0;  // up to 8 custom characters (0 - 7) can be created
const int IN1 = 6;
const int IN2 = 7;
const int BACKLIGHT_PIN = 10;
const int START_DELAY = 20;
const int END_DELAY = 200;
// Used for writeChar()
const int FAR_LEFT = 0;
const int LEFT = 1;
const int RIGHT = 2;
const int FAR_RIGHT = 3;

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
int column, row; 
/*-============================================================================/
functions
/============================================================================-*/
/*-===========/
void setup() -- the first function run
/===========-*/
void setup() {
    // lcd has arg0 columns, arg1 rows
    lcd.begin(16, 2);

    byte customCharBlueprint[8] = {
        B00100,
        B01110,
        B00100,
        B11111,
        B00100,
        B00100,
        B01010,
        B01010
    };
    lcd.createChar(CUSTOM_CHAR, customCharBlueprint);

    column = 0;
    row = 0;
    writeChar(FAR_LEFT);

    pinMode(BACKLIGHT_PIN, OUTPUT);
    analogWrite(BACKLIGHT_PIN, 0);
}

/*-===========/
void loop() -- the preordained main loop
/===========-*/
void loop() {
    if(LOW == digitalRead(IN1)) {
        delay(START_DELAY);                 // debounce delay
        writeChar(RIGHT);
        delay(END_DELAY);                   // debounce delay
    }

    if(LOW == digitalRead(IN2)) {
        delay(START_DELAY);
        writeChar(LEFT);
        delay(END_DELAY);
    }

    analogWrite(BACKLIGHT_PIN, (16*(column + 1)) - 1);
}

/*-===========/
void writeChar() -- move the custom character. Do not move beyond edge of screen.
/===========-*/
void writeChar(int direction) {
    lcd.setCursor(column, row);
    lcd.print(' ');

    switch(direction) {
        case FAR_LEFT:
            column = 0;
            break;

        case LEFT:
            // do not go past left edge of screen
            if(column > 0) {
                column--;
            }
            break;

        case RIGHT:
            // do not go past right edge of screen
            if(column < 9) {
                column++;
            }
            break;

        case FAR_RIGHT:
            column = 9;
            break;

        default:
            break;
    }

    lcd.setCursor(column, row);
    lcd.write(CUSTOM_CHAR);

//    lcd.setCursor(0, 1);
//    lcd.print("                ");
//    lcd.setCursor(0, 1);
//    lcd.print("col ");
//    lcd.print(column);
//    lcd.print(" row ");
//    lcd.print(row);
}
