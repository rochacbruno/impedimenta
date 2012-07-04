#ifndef UTILITIES_H
#define UTILITIES_H

#ifdef __cplusplus
  extern "C" { /* our assembly functions have C calling convention */
#endif

void DELAY_10US(void);
void DELAY_100US(void);
void DELAY_1MS(void);
void DELAY_10MS(void);
void DELAY_100MS(void);
void DELAY_1S(void);

#ifdef __cplusplus
  }
#endif

#endif // #ifndef UTILITIES_H