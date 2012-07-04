package jeremyAudet.calculator_2;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class calculator_2 extends Activity {
    /*-========================================================================/
    Initial setup.
    /========================================================================-*/
    private TextView decimalDisplay;	// Typically used to show the contents
    // of register1.
    private TextView modeDisplay; // Used to show the current mode (+, -, /, *)
    private double register1; 	// Number that the user sees.
    private double register2; 	// Buffer for doing math.
    private boolean decimal;   	// When true, a decimal point has been entered.
    // Only modify when a) clear button is pressed b) sign is clicked c) dot
    // button is clicked d)equals button is clicked.
    private char mode;			// Mode is either +, -, *, /, or (blank).
    int power;              	// When decimal is true, the calculator
    // will need to lower any number entered to this magnitude. The first number
    // entered after decimal becomes true is raised to -1st magnitude, second 
    // number to the -2nd magnitude, etc. Only modify power when a) clear button
    // is pressed b) decimal is true and digit is entered c) equals button is
    // clicked d) a sign is clicked. Note that power is always positive!
    private boolean signClicked; // This variable is present to handle the case
    // of a user pressing a sign button (+, -, /, *) twice or more in a row. In
    // this case, a result should not be calculated. Instead, _only_ the mode
    // variable should be called. Whenever the signClicked method is called,
    // this variable is set to true. All other methods will set signClicked to
    // false.

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        register1 = 0.0;
        register2 = 0.0;
        decimal = false;
        mode = ' ';
        power = 1;
        signClicked = false;
        decimalDisplay = (TextView)findViewById(R.id.TextViewDecimal);
    	decimalDisplay.setText(Double.toString(register1));
    	modeDisplay = (TextView)findViewById(R.id.TextViewMode);
    	modeDisplay.setText(Character.toString(mode));
    }
    
    /*-========================================================================/
    Initial setup done, main methods are below.
    /========================================================================-*/
    /** Called whenever a numerical digit (0-9) is clicked. */
    public void digitClicked(View view) {
    	Button someButton = (Button)view;

    	if(false == decimal) {
        	// Take the working number (the number being modified, register1)
    		// and multiply it by ten. Then add the amount 0-9, dependent upon
    		// which button was pressed. someButton.getText().toString().trim()
    		// returns a string telling you which button was pressed. 
    		// Double.parseDouble converts a string to a double.
        	register1 = (register1 * 10) + Double.parseDouble(someButton.getText().toString().trim());
        	decimalDisplay.setText(Double.toString(register1));
    	} else {
    	    // The decimal button has been pressed. Therefore, the number just
    	    // entered should be lowered to a certain magnitude and added to
    	    // register1. To do this, simply multiply 10 by the current power,
    	    // and divide 
    	    register1 += Double.parseDouble(someButton.getText().toString().trim())/Math.pow(10.0,power);
            ++power;
            decimalDisplay.setText(Double.toString(register1));
    	}
    	
    	signClicked = false;
    }
    
    /** Called whenever a sign (+, -, *, /) is clicked. 
     * This method runs through a 5-step sequence of events. Firstly, read the
     * current mode (+, -, *, /, or (blank)). Secondly, calculate results and
     * place them in register2. Thirdly, change the current mode according to
     * what button was just pressed. Fourthly, cleanup variables. Lastly,
     * display register2 and the current mode. */
    public void signClicked(View view) {
    	Button someButton = (Button)view;

    	if(true == signClicked) {
    		; // do nothing but update mode display (below)
    	} else {
	    	// Act according to what the current mode is -- don't act based on which
	    	// button the user just pressed.
	    	switch (mode) {
	    		case '+': register2 += register1; break;
	    		case '-': register2 -= register1; break;
	    		case '*': register2 *= register1; break;
	    		case '/': register2 /= register1; break;
	    		default:  register2 = register1; break;
	    	}
	    	register1 = 0.0;
	    	
	    	// Step three. Change mode according to what button the user pressed.
	    	mode = someButton.getText().toString().trim().charAt(0);
	    	
	    	// Step four. Cleanup variables.
	    	decimal = false;
	    	power = 1;
	    	
	    	// Step five. Update number display. This is one of the few times in
	    	// which register1 is not displayed after performing an operation.
	        decimalDisplay.setText(Double.toString(register2));
    	}
    	
    	signClicked = true;
    	// Update mode display.
		mode = someButton.getText().toString().trim().charAt(0);
    	modeDisplay.setText(Character.toString(mode));
    }
    
    /** Called whenever the equals (=) button is clicked. 
     * This method runs through a 4-step sequence of events. First, mode is read
     * to determine what the current operation (+, -, *, /, or (blank)). Second,
     * the results of the operation are calculated and placed into register1. 
     * Thirdly, variables are cleaned up. Lastly, register1 is displayed. */
    public void equalsClicked(View view) {
    	// calculations
    	switch (mode) {
    		case '+': register1 = register2 + register1; break;
    		case '-': register1 = register2 - register1; break;
    		case '*': register1 = register2 * register1; break;
    		case '/': register1 = register2 / register1; break;
    		default: break; // if mode is ' ', then do nothing
    	}
        register2 = 0.0;
        
        // cleanup
        mode = ' ';
        power = 1;
        decimal = false;
        signClicked = false;
    
        // display results
        decimalDisplay.setText(Double.toString(register1));
    	modeDisplay.setText(Character.toString(mode));
    }
    
    /** Called whenever the dot (.) button is clicked. */
    public void dotClicked(View view) {
        decimal = true;
        // The dot could be clicked several times in a row. Therefore, do not
        // set power to 1.
        signClicked = false;
    }
    
    /** Called whenever the "Clear" button is clicked. */
    public void clearClicked(View view) {
    	// reset everything
    	register1 = 0.0;
    	register2 = 0.0;
    	power = 1;
    	decimal = false;
    	signClicked = false;
    	mode = ' ';
    	decimalDisplay.setText(Double.toString(register1));
    	modeDisplay.setText(Character.toString(mode));
    }
}