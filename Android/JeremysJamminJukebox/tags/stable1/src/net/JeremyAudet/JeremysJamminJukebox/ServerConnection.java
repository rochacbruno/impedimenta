/*-============================================================================/
Class follows singleton pattern.

The variables mpd, mpdPlayer, etc are intentionally left public. The classes
ControlMode, LibraryMode, and PlaylistMode benefit greatly from being able
to directly manipulate these variables.

Perhaps make them protected and make the xMode classes children?
/============================================================================-*/
package net.JeremyAudet.JeremysJamminJukebox;

import java.lang.Object;
import java.net.UnknownHostException;

import android.util.Log;

import org.bff.javampd.MPD;
import org.bff.javampd.MPDPlayer;
import org.bff.javampd.exception.MPDConnectionException;
import org.bff.javampd.exception.MPDResponseException;
import org.bff.javampd.exception.MPDPlayerException;

public class ServerConnection {
    /*-========================================================================/
    class-wide declarations, constructor
    /========================================================================-*/
    private static ServerConnection reference;
    private static final String TAG = "ServerConnection";
    public MPD mpd = null;
    public MPDPlayer mpdPlayer = null;

    /**-===============================/
    ServerConnection() -- default constructor
    /================================-*/
    private ServerConnection() {
        reference = null;
    }

    /*-========================================================================/
    other class methods
    /========================================================================-*/
    /**-===============================/
    getServerConnection() -- Returns a ServerConnection object.
    Only creates a new ServerConnection object if one doesn't already exist.
    /================================-*/
    public static ServerConnection getServerConnection() {
        if(null == reference) {
            reference = new ServerConnection();
        }

        return reference;
    }

    /**-===============================/
    clone() -- Prevent cloning, help enforce the singleton model of this class.
    /================================-*/
    public Object clone() throws CloneNotSupportedException {
        throw new CloneNotSupportedException();
    }

    /**-===============================/
    clear mpd-related variables, in a potentially disastrous fashion
    /================================-*/
    public void nullify() {
        Log.d(TAG, "ServerConnection.nullify() called");
        mpd = null;
        mpdPlayer = null;
    }

    public boolean isConnected() {
        if(null == mpd) {
            return false;
        }
        if(false == mpd.isConnected()) {
            return false;
        }

        return true;
    }

    /**-===============================/
    connect() -- connect to a server, get MPDPlayer handles and such
    /================================-*/
    public boolean connect(String address) {
        try {
            Log.d(TAG, "Attempting to connect to MPD server.");
            mpd = new MPD(address);
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
    } // connect(String)

    /**-===============================/
    connect() -- connect to a server, get MPDPlayer handles and such
    /================================-*/
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

    /**-===============================/
    connect() -- connect to a server, get MPDPlayer handles and such
    /================================-*/
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
