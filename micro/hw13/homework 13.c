/*-============================================================================/
Jeremy Audet, for Micro, taught by Matt Gallagher. Homework 13.

This program is pretty simple. It has a simple looping structure, and will repeatedly check the four switches on our board for being pressed. If any of the four buttons are pressed, a message will be displayed on the screen. A different unique message will be displayed for each of the four buttons.

The program structure is pretty straightforward. The body of the program uses an infinite while(1) loop. Every time this loop runs once, each of the four buttons on the board are checked for being pressed. If any one of the buttons is pressed, a message will be displayed saying so. The program will wait after the message is displayed, until the user releases the button. If the user never releases the button they pushed, the while(1) loop will not be able to finish.

The file my_lcd.c MUST be #included from this file to use the LCD screen. The file my_lcd.c MUST NOT be listed in the 'Includes' or 'Sources' files in Codewarrior. Doing so will cause debugging to mysteriously fail.

The following functions are made available by #including my_lcd.c:
void LCD_init(char mode1, char mode2);
void LCD_pos_xy(char x, char y);
void LCD_write_char(char c);
void LCD_write_string (char *c);
void LCD_display_on(void);
void LCD_display_off(void);
void LCD_cursor_on(void);
void LCD_cursor_off(void);
void LCD_cursor_blink_on(void);
void LCD_cursor_blink_off(void);
/============================================================================-*/

#include <hidef.h>      // for EnableInterrupts macro
#include <stdio.h> 
#include "derivative.h" 
#include "main_asm.h" 

#define BUS_CLOCK 8000  // these two lines needed for the LCD routines to work
#include "my_lcd.c"             

/******* Prototype Function declarations ******/

/******* Global variables *********************/

/**********************************************/

void main(void) {
/* Variable declarations go here */ 

/* Your initial settings go here*/ 
      
    EnableInterrupts;
    intitialize_i_o();
    PTADD = PTADD & 0b11010001;
    PTAPE = PTAPE & 0b00101110; 
    LCD_init(DISPLAY_8X5|_2_LINES,DISPLAY_ON|CURSOR_OFF|CURSOR_BLINK);
         
    LCD_write_char('\f');   // clear screen before starting main loop
    while(1) {
        // check button 1
        if(0 == (PTAD & 0x08)) {
            LCD_write_string("Button 1 (PTAD3) pushed.");
            
            while(0 == (PTAD & 0x08)) {
                ; // while button 1 still pushed, do nothing
            }
            LCD_write_char('\f'); // Only show message while button is pressed.
        }

        // check button 2
        if(0 == (PTAD & 0x04)) {
            LCD_write_string("Button 2 (PTAD2) pushed.");
            
            while(0 == (PTAD & 0x04)) {
                ; // while button 2 still pushed, do nothing
            }
            LCD_write_char('\f');
        }

        // check button 3
        if(0 == (PTAD & 0x02)) {
            LCD_write_string("Button 3 (PTAD1) pushed.");
            
            while(0 == (PTAD & 0x02)) {
                ; // while button 3 still pushed, do nothing
            }
            LCD_write_char('\f');
        }

        // check button 4
        if(0 == (PTAD & 0x20)) {
            LCD_write_string("Button 4 (PTAD5) pushed.");
            
            while(0 == (PTAD & 0x20)) {
                ; // while button 4 still pushed, do nothing
            }
            LCD_write_char('\f');
        }
    } // while(1)
} // Please never leave main()
