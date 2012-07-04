#ifndef _MAIN_ASM_H
#define _MAIN_ASM_H

#ifdef __cplusplus
  extern "C" { /* our assembly functions have C calling convention */
#endif

void asm_main(void);
void initializeIo(void);
void keyInit(void);
char anyKey(void);          // has any key been pressed?
char getKey(void);          // get whatever key is being pressed
void blinkLeds(void);       // breifly blink LEDs

#ifdef __cplusplus
  }
#endif

#endif /* _MAIN_ASM_H */