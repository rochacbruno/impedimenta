/**-===========================================================================/
TODO: implement preferences
BUG: cannot run aNumber.setLayoutParams(widthHeightSettings);
/============================================================================-*/
package net.JeremyAudet.TableTest;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import java.lang.Double;
import java.lang.Math;

public class Main extends Activity
{
    /**-=======================================================================/
    class-wide declarations
    /========================================================================-*/
    private int start = 0;
    private int end = 0;

    /**-=======================================================================/
    onCreate() -- Called when application is first started.
    /========================================================================-*/
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        setLimits(-3, 7);
        generateOutput();
    }

    /**-=======================================================================/
    generateOutput() -- Fill R.id.numberBox with bases and squares and cubes.
    Note that this method simply assumes that start >= end. This should always
    be the case, as setLimits() does this error checking.
    /========================================================================-*/
    private void generateOutput() {
        ViewGroup.LayoutParams widthHeightSettings = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        // I will later pass this object to TableRows (as they are created) to define their width and height.
        TableLayout numberContainer = (TableLayout) findViewById(R.id.numberBox);
        numberContainer.removeAllViews();
        int row, column;
        Context appContext = getApplicationContext();

        for(row = 0; row <= (end - start); row++) {
            // Create a TableRow row.
            TableRow aRow = new TableRow(appContext);
            aRow.setId(row);
            aRow.setLayoutParams(widthHeightSettings);
            numberContainer.addView(aRow);

            for(column = 0; column < 3; column++) {
                // Create a TextView column, and place it in the just-created TableRow row.
                TextView aNumber = new TextView(appContext);
                // aNumber.setLayoutParams(widthHeightSettings);
                // Fails. I don't know why.
                aNumber.setText(Double.toString(Math.pow(start + row, 1 + column)));
                ((TableRow) numberContainer.findViewById(row)).addView(aNumber);
            }
        }
    }

    /**-=======================================================================/
    setLimits() -- Used to set the starting and ending base numbers.
    /========================================================================-*/
    public boolean setLimits(int newStart, int newEnd) {
        if(newStart > newEnd) {
            return false;
        }

        start = newStart;
        end = newEnd;

        TextView numberDisplay = (TextView) findViewById(R.id.fromNumber);
        numberDisplay.setText(Integer.toString(start));
        numberDisplay = (TextView) findViewById(R.id.toNumber);
        numberDisplay.setText(Integer.toString(end));

        return true;
    }
}
