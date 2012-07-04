package net.JeremyAudet.JeremysJamminJukebox;

// android imports
import android.app.Activity;
//--
import android.content.Context;
import android.content.Intent;
//--
import android.os.Bundle;
//--
import android.util.Log;
//--
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MenuInflater;
import android.view.View.OnClickListener;
//--
import android.widget.Button;
import android.widget.Gallery;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

/**
This is the first activity shown to the user on app startup. This activity
serves as a "home base" for all other operations. From here, the user can:<br />
+ read a short help message<br />
+ connect to an MPD server<br />
+ go to the preferences menu (via the physical "menu" button<br />
+ enter any of the control modes: controls, playlist, and library
*/
public class JeremysJamminJukebox extends Activity {
    /*-========================================================================/
    class-wide declarations, onX() methods
    /========================================================================-*/
    private LinearLayout mainViewGroup = null;
    final static private String TAG = "JeremysJamminJukebox";
    private ServerConnection serverConn = null;
    private ScrollView helpMessageContainer = null;
    private TextView helpMessage = null;
    private Button connectionButton = null;
    private Thread newConnectionThread = null;

    // When an activity finishes, it should attach an extra specifying the
    // reason it finished.
    public final static String RETURN_CODE = "RETURN_CODE";
    public final static int MODE_CONTROL = 0;
    public final static int MODE_PLAYLIST = 1;
    public final static int MODE_LIBRARY = 2;
    public final static int MODE_BACK = 3;
    public final static int MODE_ERROR = 4;

    /**
    Called when the application is first started. Creates the connect button,
    displays a help message to the user, and gets a copy of the
    ServeConnection object.
    */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        serverConn = ServerConnection.getServerConnection();

        mainViewGroup = (LinearLayout) findViewById(R.id.mainViewGroup);
        ViewGroup.LayoutParams xyParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);

        connectionButton = new Button(this);
        connectionButton.setText("Connect");
        connectionButton.setLayoutParams(xyParams);
        connectionButton.setGravity(Gravity.CENTER);
        connectionButton.setOnClickListener(connectionButtonPressed);
        mainViewGroup.addView(connectionButton);

        helpMessageContainer = new ScrollView(this);
        helpMessageContainer.setLayoutParams(xyParams);
        mainViewGroup.addView(helpMessageContainer);

        helpMessage = new TextView(this);
        helpMessage.setText(getString(R.string.help_message));
        helpMessage.setLayoutParams(xyParams);
        helpMessage.setGravity(Gravity.LEFT);
        helpMessageContainer.addView(helpMessage);
    }

    /**
    Stop all network connection attempts when this app exits.
    */
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
    /**
    Whenever an activity finishes, this method will be called. This method
    facilitates transitions between Activities.
    */
    protected void onActivityResult(int requestCode, int resultStatus, Intent data) {
        if(RESULT_OK != resultStatus) {
            Toast.makeText(this, "Connection to server, if any, killed.", Toast.LENGTH_SHORT).show();
            serverConn.nullify();
        } else {
            int returnCode = data.getIntExtra(this.RETURN_CODE, MODE_ERROR);

            if(this.MODE_CONTROL == returnCode) {
                controlModeStarted();
            } else if(this.MODE_PLAYLIST == returnCode) {
                playlistModeStarted();
            } else if(this.MODE_LIBRARY == returnCode) {
                libraryModeStarted();
            } else if(this.MODE_BACK == returnCode) {
                Log.d(TAG, "User pressed back button. Do nothing.");
            } else {
                Log.e(TAG, "Unhandled RETURN_CODE: " + returnCode);
            }
        }
    } // onActivityResult()

    /**
    The "Controls" button has been pressed. Calls controlModeStarted(void).
    */
    public void controlModeStarted(View callingView) {
        controlModeStarted();
    }

    /**
    Starts the ControlMode Activity.
    */
    public void controlModeStarted() {
        if(serverConn.isConnected()) {
            Intent intent = new Intent();
            intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.ControlMode");
            Log.d(TAG, "Starting activity ControlMode");
            startActivityForResult(intent, 0);
        }
    }

    /**
    The "Playlist" button has been pressed. Calls playlistModeStarted(void).
    */
    public void playlistModeStarted(View callingView) {
        playlistModeStarted();
    }

    /**
    Starts the PlaylistMode Activity.
    */
    public void playlistModeStarted() {
        if(serverConn.isConnected()) {
            Intent intent = new Intent();
            intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.PlaylistMode");
            Log.d(TAG, "Starting activity PlaylistMode");
            startActivityForResult(intent, 0);
        }
    }

    /**
    The "Library" button has been pressed. Calls libraryModeStarted(void).
    */
    public void libraryModeStarted(View callingView) {
        libraryModeStarted();
    }

    /**
    Starts the LibraryMode Activity.
    */
    public void libraryModeStarted() {
        if(serverConn.isConnected()) {
            Intent intent = new Intent();
            intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.LibraryMode");
            Log.d(TAG, "Starting activity LibraryMode");
            startActivityForResult(intent, 0);
        }
    }

    /**
    When the user hits the "Menu" button, this creates the set of popup buttons.
    */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.layout.menu, menu);

        return true;
    }

    /**
    This gets called after the user hits one of the popup "Menu" buttons.
    */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        Intent intent = new Intent();

        switch(item.getItemId()) {
            case R.id.preferencesButton:
                intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.AppPreferences");
                Log.d(TAG, "Starting the Preferences activity.");
                startActivityForResult(intent, 0);
                break;

            case R.id.aboutButton:
                intent.setClassName("net.JeremyAudet.JeremysJamminJukebox", "net.JeremyAudet.JeremysJamminJukebox.About");
                Log.d(TAG, "Starting the About activity.");
                startActivityForResult(intent, 0);
                break;

            default:
                break;
        }

        return true;
    }

    /**
    This method is called whenever the user presses the Connect/Disconnect
    button. If no connection attempt is in progress, a new one will be started.
    If a connection attempt is in progress, it will notify the user.

    @TODO Notify the user when a connection attempt succeeds.
    */
    private OnClickListener connectionButtonPressed = new OnClickListener() {
        public void onClick(View callingView) {
            // Short-circuit evaluation is crucial here!
            // The default value for newConnectionThread is null. Therefore,
            // only do the second check if a connection attempt has previously
            // been made (and newConnectionThread has been assigned a value).
            if((null != newConnectionThread) && (newConnectionThread.isAlive())) {
                Toast.makeText(getApplicationContext(), "Connection attempt in progress, please wait a few seconds...", Toast.LENGTH_SHORT).show();
                return;
            }

            // Create a new thread that will attempt to connect to an MPD
            // server. This is threaded to avoid blocking the UI thread (this
            // thread).
            newConnectionThread = new NetworkConnectThread(getApplicationContext());
            newConnectionThread.start();
        }
    }; // private OnClickListener connectionButtonPressed
}
