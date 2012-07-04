#ifndef _MAIN_ASM_H
#define _MAIN_ASM_H

#ifdef __cplusplus
  extern "C" { /* our assembly functions have C calling convention */
#endif

void intitialize_i_o(void);
void PWM0_init(int);
void PWM0_dty(int);
void ADC_init(void);
int ADC_value(char);

#ifdef __cplusplus
  }
#endif

#endif /* _MAIN_ASM_H */
