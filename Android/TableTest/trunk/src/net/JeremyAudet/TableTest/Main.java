/**-===========================================================================/
TODO: implement preferences
BUG: cannot run aNumber.setLayoutParams(widthHeightSettings);
/============================================================================-*/
package net.JeremyAudet.TableTest;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;
import java.lang.Double;
import java.lang.Math;
import java.lang.NumberFormatException;

public class Main extends Activity
{
    /**-=======================================================================/
    class-wide declarations and onX() methods
    /========================================================================-*/
    /**-=========================================/
    class-wide declarations
    /==========================================-*/
    // none

    /**-=========================================/
    onCreate() -- Called when application is first started.
    /==========================================-*/
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
    }

    /**-=========================================/
    onStart() -- called upon startup, and when the preferences dialogue is exited
    /==========================================-*/
    @Override
    protected void onStart() {
        super.onStart();
        SharedPreferences appPrefs = PreferenceManager.getDefaultSharedPreferences(getBaseContext());
        SharedPreferences.Editor appPrefsEditor = appPrefs.edit();
        Boolean useBothValues = appPrefs.getBoolean("rangeCheckBox", true);
        int start = 0;
        int end = 0;

        // Check for errors when turning From into an integer.
        try {
            start = Integer.parseInt(appPrefs.getString("startNumber", "0"));
        } catch(NumberFormatException NumberFormatException) {
            Toast.makeText(
                getBaseContext(),
                "\"" + appPrefs.getString("startNumber", "0") + "\" is not a valid value for From.",
                Toast.LENGTH_LONG
            ).show();

            updateDisplay(0, 0);
            generateOutput(0, 0);
            return;
        }

        // Check to make sure no number is too large.
        if(start > 100) {
            start = 100;
            appPrefsEditor.putString("startNumber", "100");
            appPrefsEditor.commit();
        } else if(start < -100) {
            start = -100;
            appPrefsEditor.putString("startNumber", "-100");
            appPrefsEditor.commit();
        }

        // Based on user preferences, what numbers should be displayed?
        if(false == useBothValues) {
            // Just display the "From" value.
            updateDisplay(start, start);
            generateOutput(start, start);
            Toast.makeText(getBaseContext(), "Success", Toast.LENGTH_SHORT).show();
        } else {
            // Check for errors when turning To into an integer.
            try {
                end = Integer.parseInt(appPrefs.getString("endNumber", "0"));
            } catch(NumberFormatException NumberFormatException) {
                Toast.makeText(
                    getBaseContext(), 
                    "\"" + appPrefs.getString("endNumber", "0") + "\" is not a valid value for To.",
                    Toast.LENGTH_LONG
                ).show();

                updateDisplay(0, 0);
                generateOutput(0, 0);
                return;
            }

            // Check to make sure no number is too large.
            if(end > 100) {
                end = 100;
                appPrefsEditor.putString("endNumber", "100");
                appPrefsEditor.commit();
            } else if(end < -100) {
                end = -100;
                appPrefsEditor.putString("endNumber", "-100");
                appPrefsEditor.commit();
            }

            // Values given are valid and in a reasonable range. Is start <= end?
            if(start <= end) {
                // If so, commit.
                updateDisplay(start, end);
                generateOutput(start, end);
                Toast.makeText(getBaseContext(), "Success", Toast.LENGTH_SHORT).show();
            } else {
                // If not, give default values.
                Toast.makeText(
                    getBaseContext(), 
                    "Start of range (" + start + ") cannot be greater than end of range (" + end + ").",
                    Toast.LENGTH_LONG
                ).show();

                updateDisplay(0, 0);
                generateOutput(0, 0);
            }
        }
    }

    /**-=======================================================================/
    other class methods
    /========================================================================-*/
    /**-=========================================/
    editPreferences() -- calls an activity used to edit app preferences
    /==========================================-*/
    public void editPreferences(View callingView) {
        Intent prefsIntent = new Intent();
        prefsIntent.setClassName("net.JeremyAudet.TableTest", "net.JeremyAudet.TableTest.AppPreferences");
        startActivity(prefsIntent);
    }

    /**-=========================================/
    updateDisplay() -- Used to set the starting and ending base numbers.
    /==========================================-*/
    private boolean updateDisplay(int newStart, int newEnd) {
        TextView numberDisplay = (TextView) findViewById(R.id.fromNumber);
        numberDisplay.setText(Integer.toString(newStart));

        numberDisplay = (TextView) findViewById(R.id.toNumber);
        numberDisplay.setText(Integer.toString(newEnd));

        return true;
    }

    /**-=========================================/
    generateOutput() -- Fill R.id.numberBox with bases and squares and cubes.
    Note that this method simply assumes that start >= end. This should always
    be the case, as setLimits() does this error checking.
    /==========================================-*/
    private void generateOutput(int start, int end) {
        ViewGroup.LayoutParams widthHeightSettings = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
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
}
