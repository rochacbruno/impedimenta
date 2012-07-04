/*-============================================================================/
Jeremy Audet, for micro, taught by Matt Gallagher. Exam 2, take home problem.

This program reads input from a keypad, one key at a time, and then uses that input to vary the duty cycle of a pulse width modulator output. The keypad has 14 keys, numbered 0 through 9 and then A through D. These 14 keys will cause the pulse width to vary from 0% to 100%. 0 corresponds to a 0% pulse width, and D corresponds to a 100% pulse width. The keys # and * are ignored.

The function keypadInit() is used to set up the keypad for input. It sets four chip pins high and four low, which is necessary to detect whether a key is being pressed. ANYKEY() returns a 1 if a key is being pressed and a 0 if no key is being pressed. GETKEY() fetches whatever key is being pressed and returns that key as a char; if no key is pressed, ' ' (whitespace) is returned. My program uses ANYKEY to determine whether a user is pressing any keys. If a user is pressing a key, it will grab the input using GETKEY. The input is stored in variable "input".

Once input has been gotten from the keypad, PWM1_duty() is used to set the ouptut of PWM channel 1. The ideal relationship between character fetched, duty cycle percentage, and microsecond duration is listed here. Note that the PWM period is about 50ms.
0 0 0
1 7.6 3800
2 15.2 7600
3 22.8 11400
4 30.4 15200
5 38.0 19000
6 45.6 22800
7 53.2 26600
8 60.8 30400
9 68.4 34200
A 76.0 38000
B 83.6 41800
C 91.2 45600
D 100.0 50000
I generated the numbers here using the script "calculatorScript.txt". You can run this script using the command-line utility bc (available on most unix-like OSs). Just type the command "bc calculatorScript.txt".

This code is meant to be used with the MC9S08QG8 chip. On my board, switches
and LEDs are connected to the registers as shown here:
LED3 = PTBD:3
LED4 = PTBD:2
LED5 = PTBD:1
LED6 = PTBD:0
S1 = PTAD:3
S2 = PTAD:2
S3 = PTAD:1
S4 = PTAD:5

Look at the keypad from behind. Connect the pins as shown below:
 1  2  3  4  5  6  7  8     pins on keypad, as viewed from behind
16 15 14 13 12 11 10  9     pins on qg8 processor
c0 c1 c2 c3 r0 r1 r2 r3     keypad rows and columns

     c3  c2  c1  c0
   +---+---+---+---+
r3 | 1 | 2 | 3 | A |
   +---+---+---+---+
r2 | 4 | 5 | 6 | B |
   +---+---+---+---+
r1 | 7 | 8 | 9 | C |
   +---+---+---+---+
r0 | * | 0 | # | D |
   +---+---+---+---+
/============================================================================-*/
#include <hidef.h>      // for EnableInterrupts macro
#include "derivative.h" // include peripheral declarations
#include "utilities.h"  // interface to some useful assembly modules

void main(void) {
    char input = ' ';

    EnableInterrupts;   // Some macro... I'm not sure what it does.
    initializeIo();     // disable COP and pull up all inputs
    keypadInit();       // setup keypad so button presses can be detected
    PWM1_init(50000);   // pulse width of 50,000us (50ms)

    while(1) {
        if(ANYKEY()) {
            // grab input from the keypad and...
            input = GETKEY();
        
            // set a new PWM duty cycle
            switch(input) {
                case '0':
                    PWM1_duty(0);
                    break;
                case '1':
                    PWM1_duty(3800);
                    break;
                case '2':
                    PWM1_duty(7600);
                    break;
                case '3':
                    PWM1_duty(11400);
                    break;
                case '4':
                    PWM1_duty(15200);
                    break;
                case '5':
                    PWM1_duty(19000);
                    break;
                case '6':
                    PWM1_duty(22800);
                    break;
                case '7':
                    PWM1_duty(26600);
                    break;
                case '8':
                    PWM1_duty(30400);
                    break;
                case '9':
                    PWM1_duty(34200);
                    break;
                case 'A':
                    PWM1_duty(38000);
                    break;
                case 'B':
                    PWM1_duty(41800);
                    break;
                case 'C':
                    PWM1_duty(45600);
                    break;
                case 'D':
                    PWM1_duty(50000);
                    break;
                default:
                    break;
            }
        }
    } // while(1)
} // main()
