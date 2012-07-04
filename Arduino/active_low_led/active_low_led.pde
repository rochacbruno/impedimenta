// blink a pair of active low LEDs

const int TX_LED_PIN = 6;
const int RX_LED_PIN = 7;

void setup() {
    pinMode     (TX_LED_PIN, OUTPUT);
    digitalWrite(TX_LED_PIN, HIGH);
    pinMode     (RX_LED_PIN, OUTPUT);
    digitalWrite(RX_LED_PIN, HIGH);
}

void loop() {
    digitalWrite(TX_LED_PIN, LOW);
    digitalWrite(RX_LED_PIN, LOW);
    delay(500);
    digitalWrite(TX_LED_PIN, HIGH);
    digitalWrite(RX_LED_PIN, HIGH);
    delay(1000);
}