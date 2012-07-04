/*-============================================================================/
includes, global declarations
/============================================================================-*/
#include <LiquidCrystal.h>

const int INPUT_PIN_1 = 5;
const int INPUT_PIN_2 = 4;
const int INPUT_PIN_MUTE = 3;
const int READ_THRESHHOLD = 300;    // On a 0-1023 scale, determines when button has been pressed.
const int WAVEFORM_MAX_SIZE = 370;  // Waveform cannot have too many samples, due to memory limitations.
const int WAVEFORM_MIN_SIZE = 4;    // How many samples, minimum, define a wave?

int waveform[WAVEFORM_MAX_SIZE];    // Holds a series of nums, between 0-255, that define a sine wave.
int waveformSize;                   // How many useful samples are in 'waveform'?
int i;                              // General-purpose counter.

// Frequency changes are exponential. 'SCALING' helps to mitigate the effect.
// Scaling _must_ be between, but not equal to, 0 and 1.
const float SCALING = 0.07;
float stepSize;     // This determines how quickly 'counter' goes from 1.000 to 2.000.
float newStepSize;  // Need to test a new stepSize before actually using it.
float counter;      // When creating a new sine wave, count from 1.000 to 2.000 using this var.

byte sound = B00000000;                     // The actual byte fed to PORTD.
LiquidCrystal lcd(13, 12, 11, 10, 9, 8);    // Communicate with the user.

/*-============================================================================/
functions
/============================================================================-*/
/*-===========/
void setup() -- The very first function run. Good for initializations.
/===========-*/
void setup() {
    waveformSize = 0;   // Prevent any wave from being output until wave is generated.
    stepSize = 0.005;   // Provides a default frequency.
    DDRD = B11111111;   // Set pins 0-7 as outputs for the D to A converter, and then speaker.

    lcd.begin(16, 2);
    lcd.print("Procedural Tone");
    lcd.setCursor(0, 1);
    lcd.print("Generator");
}

/*-===========/
void loop() -- the preordained main loop
/===========-*/
void loop() {
    // output a wave
    for(i = 0; i < waveformSize; i++) {
        PORTD = waveform[i];
    }
    for(i = waveformSize - 1; i >= 0; i--) {
        PORTD = waveform[i];
    }

    // check the pins
    if((analogRead(INPUT_PIN_1) < READ_THRESHHOLD) || (analogRead(INPUT_PIN_2) < READ_THRESHHOLD)) {
        // debounce delay
        delay(20);

        // Create a new, tentative stepSize.
        if(analogRead(INPUT_PIN_1) < READ_THRESHHOLD) {
            // Increase frequency.
            newStepSize = stepSize + (stepSize * SCALING);
        } else {
            // Decrease frequency.
            newStepSize = stepSize - (stepSize * SCALING);
            if(newStepSize <= 0) {
                newStepSize = stepSize;
            }
        }

        // Test the new stepSize to see if it makes a wave too long or short.
        for(counter = 1.000, i = 0; counter <= 2.000; counter += newStepSize, i++) {}
        if(i >= WAVEFORM_MIN_SIZE && i <= WAVEFORM_MAX_SIZE) {
            stepSize = newStepSize;
        }


        // Finally, create new wave and record it in waveform[].
        for(counter = 1.000, i = 0; counter <= 2.000; counter += stepSize, i++) {
            waveform[i] = (int)(((cos(3.14159 * counter) + 1.000) / 2.000) * 255);
        }
        waveformSize = i;

        lcd.clear();
        lcd.print("Frequency: ");
        lcd.setCursor(0, 1);
        lcd.print((100.0 - (100.0 * ((float)waveformSize / ((float)WAVEFORM_MAX_SIZE - (float)WAVEFORM_MIN_SIZE)))), 1);
        lcd.print("%");

        while((analogRead(INPUT_PIN_1) < READ_THRESHHOLD) || (analogRead(INPUT_PIN_2) < READ_THRESHHOLD)) {}
        // debounce delay
        delay(20);
    }

    if(analogRead(INPUT_PIN_MUTE) < READ_THRESHHOLD) {
        // User has pressed button to mute, debounce and wait for release.
        delay(20);
        lcd.clear();
        lcd.print("Mute");
        while(analogRead(INPUT_PIN_MUTE) < READ_THRESHHOLD) {};
        delay(20);

        // User has pressed button once, sit and keep arduino muted.
        while(analogRead(INPUT_PIN_MUTE) >= READ_THRESHHOLD) {};

        // User has pressed button to unmute, debounce and wait for release.
        delay(20);
        while(analogRead(INPUT_PIN_MUTE) < READ_THRESHHOLD) {};
        delay(20);

        lcd.clear();
        lcd.print("Frequency: ");
        lcd.setCursor(0, 1);
        lcd.print((100.0 - (100.0 * ((float)waveformSize / ((float)WAVEFORM_MAX_SIZE - (float)WAVEFORM_MIN_SIZE)))), 1);
        lcd.print("%");
    }
}
