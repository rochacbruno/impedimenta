// Slave code used for testing the I2C protocol with the MSP430.
// SDA is analog 4, SCL is analog 5
#include <Wire.h>
#include <LiquidCrystal.h>

const int TX_LED_PIN = 6;
const int RX_LED_PIN = 7;
const int TX_BUFFER_SIZE = 256;

LiquidCrystal lcd(13, 12, 11, 10, 9, 8);
byte firstByteReceived;
byte txBuffer[TX_BUFFER_SIZE];
int i;                                  // better to declare it here than make a new copy for every function that needs one

void setup() {
    pinMode     (TX_LED_PIN, OUTPUT);
    pinMode     (RX_LED_PIN, OUTPUT);
    digitalWrite(TX_LED_PIN, LOW);
    digitalWrite(RX_LED_PIN, LOW);
    lcd.begin(16, 2);
    lcd.print("initializing");

    firstByteReceived = 0;
    Wire.begin(10);                     // Join I2C bus as slave with address 10.
    Wire.onRequest(requestEvent);       // Argument gets called when master reads from this (slave) device.
    Wire.onReceive(receiveEvent);       // Argument gets called when master reads to this (slave) device.
    randomSeed(analogRead(0));
    for(i = 0; i < TX_BUFFER_SIZE; i++) {
        txBuffer[i] = (byte)random(256);  // byte can have values ranging from 0-255 (txBuffer is an array of bytes)
    }

    delay(1000);
    lcd.clear();
    lcd.print("ready");
    digitalWrite(TX_LED_PIN, HIGH);
    digitalWrite(RX_LED_PIN, HIGH);
}

void loop() {
    // all actions are handled by interrupts (I think arduino calls them events)
}

// function executes whenever data is requested by master
// function is registered as an event, see setup()
void requestEvent() {
    digitalWrite(TX_LED_PIN, LOW);

    Wire.send(&txBuffer[0], firstByteReceived);
    lcd.clear();
    lcd.print("num tx'd: ");
    lcd.print(firstByteReceived, HEX);

    lcd.setCursor(0, 1);
    for(i = 0; i < 4; i++) {            // do not print full buffer, only as many elements as can fit on the screen
        lcd.print(txBuffer[i], HEX);
        lcd.print(":");
    }
    lcd.print("...");

    digitalWrite(TX_LED_PIN, HIGH);
}

// function executes whenever data is sent from master to (this) slave
// function is registered as an event/interrupt, see setup()
void receiveEvent(int bytesReceived) {
    digitalWrite(RX_LED_PIN, LOW);

    i = 0;
    lcd.clear();
    lcd.setCursor(0, 1);
    while(0 < Wire.available()) {
        switch(i++) {
            case 0:
                lcd.print(firstByteReceived = Wire.receive(), HEX);
                lcd.print(":");
                break;
            case 1:
            case 2:
                lcd.print(Wire.receive(), HEX);
                lcd.print(":");
                break;
            case 3:
                lcd.print(Wire.receive(), HEX);
                lcd.print(":");
                lcd.print("...");
                break;
            default:
                Wire.receive();
                break;
        }
    }

    lcd.setCursor(0, 0);
    lcd.print("num rx'd: ");
    lcd.print(i);

    digitalWrite(RX_LED_PIN, HIGH);
}