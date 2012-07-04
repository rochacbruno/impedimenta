package net.JeremyAudet.ContactGrabber;

import java.lang.String;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TableRow;
import android.widget.TableLayout;
import android.widget.TextView;

public class Main extends Activity {
    /*-========================================================================/
    class-wide declarations and onX() methods
    /========================================================================-*/
    /**-===============================/
    class-wide declarations
    /================================-*/
    private final static String TAG = "ContactGrabber";

    /**-===============================/
    onCreate() -- Called when application is first started.
    /================================-*/
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
        fillDisplay();
    }

    /*-========================================================================/
    main class methods
    /========================================================================-*/
    /**-===============================/
    fillDisplay() -- fill contactContainer will all sorts of info from the contact book
    /================================-*/
    private void fillDisplay() {
        /*-===========================/
        method declarations
        /===========================-*/
        Context appContext = this;
        SharedPreferences appPrefs = PreferenceManager.getDefaultSharedPreferences(appContext);
        TableLayout contactContainer = (TableLayout) findViewById(R.id.contactContainer);
        ContentResolver resolver = getContentResolver();
        String[] dbColumns = new String[] {
            Phone.DISPLAY_NAME,
            Phone.NUMBER,
            Phone.TYPE,
        };
        Cursor cursor = resolver.query(
            Phone.CONTENT_URI,              // which database?
            dbColumns,                      // make these columns available for reading
            null,                           // return which rows? (all rows/contacts)
            null,                           // selection arguments... wtf does that mean?
            Phone.DISPLAY_NAME + " ASC"     // sort results by name, in ascending order
        );
        int nameColumn =        cursor.getColumnIndex(Phone.DISPLAY_NAME);
        int numberColumn =      cursor.getColumnIndex(Phone.NUMBER);
        int numberTypeColumn =  cursor.getColumnIndex(Phone.TYPE);

        /*-===========================/
        method logic
        /===========================-*/
        contactContainer.removeAllViews();
        if(cursor.moveToFirst()) {
            // if any contacts were returned, show that info
            // Create the top row...
            TableRow topRow = new TableRow(appContext);
            contactContainer.addView(topRow);

            // ...and fill it with some labels
            addTextViewToTableRow(appContext, topRow, "Name");
            addTextViewToTableRow(appContext, topRow, "Number");
            addTextViewToTableRow(appContext, topRow, "Type");

            do {
                switch (cursor.getInt(numberTypeColumn)) {
                    case Phone.TYPE_HOME:
                        if(true == appPrefs.getBoolean("showHomeNumber", true)) {
                            TableRow aRow = new TableRow(appContext);
                            contactContainer.addView(aRow);
                            addTextViewToTableRow(appContext, aRow, cursor.getString(nameColumn));
                            addTextViewToTableRow(appContext, aRow, cursor.getString(numberColumn));
                            addTextViewToTableRow(appContext, aRow, "Home");
                        }
                        break;

                    case Phone.TYPE_MOBILE:
                        if(true == appPrefs.getBoolean("showMobileNumber", true)) {
                            TableRow aRow = new TableRow(appContext);
                            contactContainer.addView(aRow);
                            addTextViewToTableRow(appContext, aRow, cursor.getString(nameColumn));
                            addTextViewToTableRow(appContext, aRow, cursor.getString(numberColumn));
                            addTextViewToTableRow(appContext, aRow, "Mobile");
                        }
                        break;

                    case Phone.TYPE_WORK:
                        if(true == appPrefs.getBoolean("showWorkNumber", true)) {
                            TableRow aRow = new TableRow(appContext);
                            contactContainer.addView(aRow);
                            addTextViewToTableRow(appContext, aRow, cursor.getString(nameColumn));
                            addTextViewToTableRow(appContext, aRow, cursor.getString(numberColumn));
                            addTextViewToTableRow(appContext, aRow, "Work");
                        }
                        break;

                    case Phone.TYPE_MAIN:
                        if(true == appPrefs.getBoolean("showMainNumber", true)) {
                            TableRow aRow = new TableRow(appContext);
                            contactContainer.addView(aRow);
                            addTextViewToTableRow(appContext, aRow, cursor.getString(nameColumn));
                            addTextViewToTableRow(appContext, aRow, cursor.getString(numberColumn));
                            addTextViewToTableRow(appContext, aRow, "Main");
                        }
                        break;

                    case Phone.TYPE_CUSTOM:
                        if(true == appPrefs.getBoolean("showCustomNumber", true)) {
                            TableRow aRow = new TableRow(appContext);
                            contactContainer.addView(aRow);
                            addTextViewToTableRow(appContext, aRow, cursor.getString(nameColumn));
                            addTextViewToTableRow(appContext, aRow, cursor.getString(numberColumn));
                            addTextViewToTableRow(appContext, aRow, "Custom");
                        }
                        break;

                    default:
                        if(true == appPrefs.getBoolean("showOtherNumber", true)) {
                            TableRow aRow = new TableRow(appContext);
                            contactContainer.addView(aRow);
                            addTextViewToTableRow(appContext, aRow, cursor.getString(nameColumn));
                            addTextViewToTableRow(appContext, aRow, cursor.getString(numberColumn));
                            addTextViewToTableRow(appContext, aRow, "Other");
                        }
                        break;
                }
            } while(cursor.moveToNext());   // cycle through rows
        } else {
            // if no contacts were returned, print out a short error message
            TableRow aRow = new TableRow(appContext);
            contactContainer.addView(aRow);
            addTextViewToTableRow(appContext, aRow, "No contacts to display.");
        } // end displaying contact info
    } // fillDisplay()

    /**-===============================/
    addTextViewToTableRow() -- add some data to a row
    /================================-*/
    private void addTextViewToTableRow(Context theContext, TableRow theRow, String contents) {
        TextView cell = new TextView(theContext);
        cell.setText(contents);
        theRow.addView(cell);
    }

    /**-===============================/
    launchPreferences() -- used to launch the preferences activity
    /================================-*/
    public void launchPreferences(View callingView) {
        Intent prefsIntent = new Intent();
        prefsIntent.setClassName("net.JeremyAudet.ContactGrabber", "net.JeremyAudet.ContactGrabber.AppPreferences");
        startActivity(prefsIntent);
    }
} // Main()
