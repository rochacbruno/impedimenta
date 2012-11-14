//#include <msp430.h>
//#include <thin_usr.h>
#include <msp430x26x.h>

void initTimer(void);
void stopTimer(void);
void startTimer(int);

void main(void) {
    WDTCTL = WDTPW + WDTHOLD;
    initTimer();

    //P1REN |= 0x01;
    P1IE  &= ~0x01;
    P1SEL &= ~0x01;
    //P1SEL2 = 0;
    P1DIR |= 0x01;

    startTimer(10);

    _BIS_SR(LPM3_bits + GIE);           // Enter LPM3 w/ interrupt

    while(1) {;}
}

#pragma vector=TIMERA0_VECTOR
__interrupt void Timer_A (void) {
    P1OUT ^= 0x01;

    return;
}

void initTimer(void) {
                                        // TACTL: Timer_A Control Register
    TACTL   &= ~(1<<4);                 // MC is bits 5+4 in TACTL. It determines whether and how TAR is counting.
    TACTL   &= ~(1<<5);                 // MC can have values of: 0 (stop), 1 (count up), 2 (continuous count), 3 (count up/down)

    TACTL   |=  TACLR;                  // Set TACLR to reset TAR, clock divider, and count direction.

    TACTL   |=  (1<<8);                 // TASSEL is bits 9+8 in TACTL. It controls the clock source for TAR.
    TACTL   &= ~(1<<9);                 // TASSEL can have values of: 0 (TACLK), 1 (ACLK), 2 (SMCLK), 3 (INCLK), ACLK frequency is 32768 Hz.

    TACTL   |=  (1<<6);                 // ID is bits 7+6 in TACTL. It controls the clock divider for TAR.
    TACTL   |=  (1<<7);                 // ID values of 0-3 result in divider values of 1, 2, 4, and 8 respectively.

                                        // TACCTLx: Timer_A Capture/Compare Control Register x (x is 0 or 1)
    TACCTL0 &= ~CCIE;                   // Clear CCIE to disable capture/compare interrupts (capture or compare determined
                                        // by TACCTLx:CAP). Interrupt flag automatically reset when interrupt is serviced.

    TACCTL0 &= ~CAP;                    // Clear CAP to put timer in compare mode (as opposed to capture mode).

    return;
}

void startTimer(int milliseconds) {
    if(16000 <= milliseconds) milliseconds = 16000;
    if(0     >= milliseconds) milliseconds = 1;

    TAR     = 0;                        // Make sure timer starts counting from 0.

                                        // TACCRx: Timer_A Capture/Compare Register x
    TACCR0  = milliseconds * 4;         // If (MC = 1) and (TASSEL = 1), then TAR repeatedly counts from 0 to TACCR0.
                                        // Further, the values of TACCR1 and TACCR2 are ignored.
                                        // Further, an interrupt at vector TIMERA0_VECTOR is generated whenever (TAR == TACCR0).

    TACCTL0 |= CCIE;                    // Enable capture/compare interrupts.

    TACTL   |=  (1<<4);                 // Give MC value of 1. Put timer into count up mode.
    TACTL   &= ~(1<<5);

    return;
}

void stopTimer(void) {
    TACTL   &= ~(1<<4);                 // Stop TAR (Timer_A counter).
    TACTL   &= ~(1<<5);

    return;
}
