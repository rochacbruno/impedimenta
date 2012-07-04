package jeremyAudet.project;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class calculator_1 extends Activity {
    private TextView binaryDisplay;
    private TextView decimalDisplay;
    long numValue = 0;
	
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        binaryDisplay = (TextView)findViewById(R.id.TextViewBinary);
        decimalDisplay = (TextView)findViewById(R.id.TextViewDecimal);
    }
    
    /** Called whenever the user clicks the button labeled "0" */
    public void zeroClick(View view) {
    	binaryDisplay.setText(binaryDisplay.getText().toString()+"0");
    	numValue = numValue * 2;
    	decimalDisplay.setText(String.valueOf(numValue));
    }
    
    /** Called whenever the user clicks the button labeled "1" */
    public void oneClick(View view) {
    	binaryDisplay.setText(binaryDisplay.getText().toString()+"1");
    	numValue = (numValue * 2) + 1;
    	decimalDisplay.setText(String.valueOf(numValue));
    }
    
    /** Called whenever the user clicks the button labeled "Clear" */
    public void clearClick(View view) {
    	numValue = 0;
    	binaryDisplay.setText("0");
    	decimalDisplay.setText("0");
    }
}