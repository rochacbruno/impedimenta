package net.JeremyAudet.JeremysJamminJukebox;

// java imports
import java.lang.Object;
//--
import java.net.UnknownHostException;

// android imports
import android.util.Log;

// javampd imports
import org.bff.javampd.MPD;
import org.bff.javampd.MPDPlayer;
import org.bff.javampd.exception.MPDConnectionException;
import org.bff.javampd.exception.MPDResponseException;
import org.bff.javampd.exception.MPDPlayerException;

/**
Singleton class used to hold a copy of several MPD-communication-related
variables. <p />

The variables mpd, mpdPlayer, etc are intentionally left public. The classes
ControlMode, LibraryMode, and PlaylistMode benefit greatly from being able
to directly manipulate these variables.
*/
public class ServerConnection {
    /*-========================================================================/
    class-wide declarations, constructor
    /========================================================================-*/
    private static final String TAG = "ServerConnection";
    private static ServerConnection reference;
    public static final int DEFAULT_PORT = 6600;
    public MPD mpd;
    public MPDPlayer mpdPlayer;

    /**
    This constructor is private -- call getServerConnection() instead.
    */
    private ServerConnection() {
        // reference is not given a value until getServerConnection() is called.
        reference = null;
        // These are not given a value until connect() is called.
        mpd = null;
        mpdPlayer = null;
    }

    /*-========================================================================/
    other class methods
    /========================================================================-*/
    /**
    Returns a ServerConnection object, therefore acting as the constructor for
    this class. 
    */
    public static ServerConnection getServerConnection() {
        if(null == reference) {
            reference = new ServerConnection();
        }

        return reference;
    }

    /**
    Prevent cloning, helps enforce the singleton model of this class.
    */
    @Override
    public Object clone() throws CloneNotSupportedException {
        throw new CloneNotSupportedException();
    }

    /**
    clear mpd-related variables, in a potentially disastrous fashion
    */
    public void nullify() {
        Log.d(TAG, "ServerConnection.nullify() called");
        mpd = null;
        mpdPlayer = null;
    }

    /**
    True if connected to MPD server, false otherwise.
    */
    public boolean isConnected() {
        if(null == mpd) {
            return false;
        }
        // Attempting to evaluate this statement while mpd == null will crash program.
        if(false == mpd.isConnected()) {
            return false;
        }

        return true;
    }

    /**
    Connect to a server, give values to mpd and mpdPlayer variables.
    */
    public boolean connect(String address) {
        return this.connect(address, DEFAULT_PORT);
    }

    /**
    Connect to a server, give values to mpd and mpdPlayer variables.
    */
    public boolean connect(String address, int port) {
        try {
            Log.d(TAG, "Attempting to connect to MPD server.");
            mpd = new MPD(address, port);
            Log.d(TAG, "Connected to MPD server.");

            // Only give mpdPlayer a value if mpd was sucessfully given a value.
            if(null != mpd) {
                mpdPlayer = mpd.getMPDPlayer();
            }
        } catch(MPDConnectionException e) {
            Log.e(TAG, "Error connecting: " + e.getMessage());
            return false;
        } catch(UnknownHostException e) {
            Log.e(TAG, "Unknown host: " + e.getMessage());
            return false;
        }

        return true;
    } // connect(String, int)

    /**
    Connect to a server, give values to mpd and mpdPlayer variables.
    */
    public boolean connect(String address, int port, String password) {
        try {
            Log.d(TAG, "Attempting to connect to MPD server.");
            mpd = new MPD(address, port, password);
            mpdPlayer = mpd.getMPDPlayer();
        } catch(MPDConnectionException e) {
            Log.e(TAG, "Error connecting: " + e.getMessage());
            nullify();

            return false;
        } catch(UnknownHostException e) {
            Log.e(TAG, "Unknown host: " + e.getMessage());
            nullify();

            return false;
        }

        return true;
    } // connect(String, int, String)
}
