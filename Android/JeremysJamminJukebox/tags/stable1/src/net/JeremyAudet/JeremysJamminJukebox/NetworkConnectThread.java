package net.JeremyAudet.JeremysJamminJukebox;

import android.content.SharedPreferences;
import android.content.Context;
import android.preference.PreferenceManager;
import android.util.Log;

public class NetworkConnectThread extends Thread {
    public static final String TAG = "NetworkConnectThread";
    private ServerConnection serverConn = null;
    private Context prefsContext = null;

    /**-===============================/
    Constructor. Gets a copy of the singleton ServerConnection object.
    /================================-*/
    public NetworkConnectThread(Context givenContext) {
        prefsContext = givenContext;
        serverConn = ServerConnection.getServerConnection();
    }

    /**-===============================/
    This is the method that gets run when you start this class as a thread.
    It attempts to create a connection with an MPD server based on the user's
    shared preferences. This thread is destroyed if the connection succeeds
    or if an interrupt is received.
    /================================-*/
    public void run() {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(prefsContext);
        String host = prefs.getString("serverIP", "127.0.0.1");
        Integer port = Integer.valueOf(prefs.getString("serverPort", "6600"));

        Log.d(TAG, "server address: " + host);
        Log.d(TAG, "server port: " + port.toString());
        if(true == prefs.getBoolean("passwordRequired", false)) {
            String password = prefs.getString("serverPassword", "password");
            Log.d(TAG, "server password: " + password);

            Log.d(TAG, "calling ServerConnection.connect(host, port, password)");
            serverConn.connect(host, port, password);
        } else {
            Log.d(TAG, "calling ServerConnection.connect(host, port)");
            serverConn.connect(host, port);
        }
    } // method run()
} // class NetworkConnectThread
