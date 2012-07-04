#ifndef UTILITIES_H
#define UTILITIES_H

#ifdef __cplusplus
  extern "C" { /* our assembly functions have C calling convention */
#endif

void asm_main(void);        // invert two LEDs. junk program
void initializeIo(void);    // pull up inputs
void DELAY_10US(void);
void DELAY_100US(void);
void DELAY_1MS(void);
void DELAY_10MS(void);
void DELAY_100MS(void);
void DELAY_1S(void);
char ANYKEY(void);          // returns 1 if key pressed, 0 if not
char GETKEY(void);          // returns which key pressed, if any
void keypadInit(void);      // initializes the keypad for use
void PWM1_init(int);        // set the PWM period in us
void PWM1_duty(int);        // set the PWM duty cycle in us

#ifdef __cplusplus
  }
#endif

#endif // #ifndef UTILITIES_H
