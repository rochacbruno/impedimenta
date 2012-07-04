package net.JeremyAudet.JeremysJamminJukebox;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.TextView;

public class PlaylistMode extends Activity {
    /*-========================================================================/
    class-wide declarations, onX() methods
    /========================================================================-*/
    private LinearLayout mainViewGroup;
    final private Context defaultContext = this;
    final static private String TAG = "PlaylistMode";
    private ServerConnection serverConn = null;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        serverConn = ServerConnection.getServerConnection();

        mainViewGroup = (LinearLayout) findViewById(R.id.mainViewGroup);
        ViewGroup.LayoutParams xyParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        TextView statusRow1 = new TextView(defaultContext);
        statusRow1.setText("PlaylistMode");
        statusRow1.setGravity(Gravity.CENTER);
        statusRow1.setLayoutParams(xyParams);
        mainViewGroup.addView(statusRow1);
    }

    /**
    called whenever the user presses the physical 'back' button
    */
    @Override
    public void onBackPressed() {
        Intent returnIntent = new Intent();
        returnIntent.putExtra(JeremysJamminJukebox.RETURN_CODE, JeremysJamminJukebox.MODE_BACK);
        setResult(RESULT_OK, returnIntent);
        finish();
    }

    /*-========================================================================/
    other class methods
    /========================================================================-*/
    /**
    The "Controls" button has been pressed.
    */
    public void controlModeStarted(View callingView) {
        Intent returnIntent = new Intent();
        returnIntent.putExtra(JeremysJamminJukebox.RETURN_CODE, JeremysJamminJukebox.MODE_CONTROL);
        setResult(RESULT_OK, returnIntent);
        finish();
    }

    /**
    playlistModeStarted() -- The "Playlist" button has been pressed.
    */
    public void playlistModeStarted(View callingView) {
        ;   // do nothing; you're already in playlist mode
    }

    /**
    The "Library" button has been pressed.
    */
    public void libraryModeStarted(View callingView) {
        Intent returnIntent = new Intent();
        returnIntent.putExtra(JeremysJamminJukebox.RETURN_CODE, JeremysJamminJukebox.MODE_LIBRARY);
        setResult(RESULT_OK, returnIntent);
        finish();
    }
}
