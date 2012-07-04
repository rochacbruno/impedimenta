/**-===========================================================================/
Jeremy Audet
A simple MPD client for android.

Dedicated to the public domain, under the Creative Commons license (CC0 1.0).
/============================================================================-*/
package net.JeremyAudet.JeremysJamminJukebox;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MenuInflater;
import android.view.View.OnClickListener;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.Button;
import android.widget.Gallery;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.SeekBar;
import android.widget.TableLayout;
import android.widget.TableRow;

public class JeremysJamminJukebox extends Activity {
    /*-========================================================================/
    class-wide declarations, onX() methods
    /========================================================================-*/
    private LinearLayout mainViewGroup = null;
    final private Context defaultContext = this;
    final static private String TAG = "JeremysJamminJukebox";
    private ServerConnection serverConn = null;
    private TextView helpMessage = null;
    private Button connectionButton = null;
    private Thread newConnectionThread = null;

    /**-===============================/
    onCreate() -- called when the application is first started
    /================================-*/
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        serverConn = ServerConnection.getServerConnection();

        mainViewGroup = (LinearLayout) findViewById(R.id.mainViewGroup);
        ViewGroup.LayoutParams xyParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);

        connectionButton = new Button(defaultContext);
        connectionButton.setText("Connect");
        connectionButton.setLayoutParams(xyParams);
        connectionButton.setGravity(Gravity.CENTER);
        connectionButton.setOnClickListener(connectionButtonPressed);
        mainViewGroup.addView(connectionButton);

        helpMessage = new TextView(defaultContext);
        helpMessage.setText("To use this app, you must be connected to a MPD "
            + "server. To do so, first open the Preferences screen by pressing "
            + "the MENU button. Specify a server name (e.g. example.com or 192.168.0.5) "
            + "and, if necessary, a port number and password. Then return to "
            + " this screen and press the \"Connect\" button.");
        helpMessage.setLayoutParams(xyParams);
        helpMessage.setGravity(Gravity.LEFT);
        mainViewGroup.addView(helpMessage);
    }

    /**-===============================/
    prevent concurrent attempts at a network connection
    /================================-*/
    @Override
    public void onDestroy() {
        super.onDestroy();

        if(null != newConnectionThread) {
            newConnectionThread.interrupt();
        }
    }

    /*-========================================================================/
    other class methods
    /========================================================================-*/
    /**-===============================/
    onActivityResult() -- after an activity called using startActivityForResultForResult finishes, this activity will be called
    /================================-*/
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(false == serverConn.isConnected()) {
            Toast.makeText(defaultContext, "Connection lost.", Toast.LENGTH_SHORT).show();
            serverConn.nullify();
        } else if(RESULT_OK != resultCode) {
            // The user most likely hit the 'back' button from within the
            // previous activity. No malfunction.
            Log.d(TAG, "No return code given -- stay here.");
        } else {
            String returnCode = data.getStringExtra("NewMode");

            if(returnCode.equals("CONTROL")) {
                controlModeStarted();
            } else if(returnCode.equals("PLAYLIST")) {
                playlistModeStarted();
            } else if(returnCode.equals("LIBRARY")) {
                libraryModeStarted();
            } else {
                Log.e(TAG, "No return code given, despite resultCode == RESULT_OK. Not good.");
            }
        }
    } // onActivityResult()

    /**-===============================/
    controlModeStarted() -- The "Controls" button has been pressed.
    /================================-*/
    public void controlModeStarted(View callingView) {
        controlModeStarted();
    }
    public void controlModeStarted() {
        if(serverConn.isConnected()) {
            Intent intent = new Intent();
            intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.ControlMode");
            Log.d(TAG, "Starting activity ControlMode");
            startActivityForResult(intent, 0);
        }
    }

    /**-===============================/
    playlistModeStarted() -- The "Playlist" button has been pressed.
    /================================-*/
    public void playlistModeStarted(View callingView) {
        playlistModeStarted();
    }
    public void playlistModeStarted() {
        if(serverConn.isConnected()) {
            Intent intent = new Intent();
            intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.PlaylistMode");
            Log.d(TAG, "Starting activity PlaylistMode");
            startActivityForResult(intent, 0);
        }
    }

    /**-===============================/
    libraryModeStarted() -- The "Library" button has been pressed.
    /================================-*/
    public void libraryModeStarted(View callingView) {
        libraryModeStarted();
    }
    public void libraryModeStarted() {
        if(serverConn.isConnected()) {
            Intent intent = new Intent();
            intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.LibraryMode");
            Log.d(TAG, "Starting activity LibraryMode");
            startActivityForResult(intent, 0);
        }
    }

    /**-===============================/
    When the user hits the "Menu" button, this creates the newly visible interface.
    /================================-*/
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.layout.menu, menu);

        return true;
    }

    /**-===============================/
    This gets called after the user hits a button in the "Menu" interface.
    /================================-*/
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        Intent intent = new Intent();

        switch(item.getItemId()) {
            case R.id.preferencesButton:
                intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.AppPreferences");
                Log.d(TAG, "Starting the Preferences screen.");
                startActivityForResult(intent, 0);
                break;

            default:
                break;
        }

        return true;
    }

    /**-===============================/
    This method is called whenever the user presses the Connect/Disconnect button.
    /================================-*/
    private OnClickListener connectionButtonPressed = new OnClickListener() {
        public void onClick(View callingView) {
            // Short-circuit evaluation is crucial here!
            // The default value for newConnectionThread is null. Therefore,
            // only do the second check if a connection attempt has previously
            // been made (and newConnectionThread has been assigned a value).
            if((null != newConnectionThread) && (newConnectionThread.isAlive())) {
                Toast.makeText(defaultContext, "Connection attempt in progress, please wait a few seconds...", Toast.LENGTH_SHORT).show();
                return;
            }

            // Create a new thread that will attempt to connect to an MPD
            // server. This is threaded to avoid blocking the UI thread (this
            // thread).
            newConnectionThread = new NetworkConnectThread(defaultContext);
            newConnectionThread.start();
        }
    }; // private OnClickListener connectionButtonPressed
}
