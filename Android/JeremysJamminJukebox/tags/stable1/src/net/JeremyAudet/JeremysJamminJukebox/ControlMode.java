package net.JeremyAudet.JeremysJamminJukebox;

import org.bff.javampd.MPD;
import org.bff.javampd.MPDPlayer;
import org.bff.javampd.exception.MPDConnectionException;
import org.bff.javampd.exception.MPDResponseException;
import org.bff.javampd.exception.MPDPlayerException;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Gallery;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.SeekBar;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

public class ControlMode extends Activity {
    /*-========================================================================/
    class-wide declarations, onX() methods
    /========================================================================-*/
    private LinearLayout mainViewGroup;
    final private Context defaultContext = this;
    final static private String TAG = "ControlMode";
    private ServerConnection serverConn = null;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        serverConn = ServerConnection.getServerConnection();

        // Place the layout (about to be created) inside this ViewGroup.
        mainViewGroup = (LinearLayout) findViewById(R.id.mainViewGroup);
        // Add album art.
        ImageView albumArt = new ImageView(defaultContext);
        albumArt.setImageResource(R.drawable.musicnote);
        albumArt.setLayoutParams(new Gallery.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
        mainViewGroup.addView(albumArt);
        // Add the song title...
        ViewGroup.LayoutParams xyParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        TextView statusRow1 = new TextView(defaultContext);
        statusRow1.setText("Song Name");
        statusRow1.setGravity(Gravity.CENTER);
        statusRow1.setLayoutParams(xyParams);
        mainViewGroup.addView(statusRow1);
        // ... the artist and album...
        TextView statusRow2 = new TextView(defaultContext);
        statusRow2.setText("Artist Name + Album Name");
        statusRow2.setGravity(Gravity.CENTER);
        statusRow2.setLayoutParams(xyParams);
        mainViewGroup.addView(statusRow2);
        // ... and a seekbar
        SeekBar songProgress = new SeekBar(defaultContext);
        mainViewGroup.addView(songProgress);
        // add a TableLayout
        TableLayout controlsViewGroup = new TableLayout(defaultContext);
        controlsViewGroup.setStretchAllColumns(true);
        mainViewGroup.addView(controlsViewGroup);
        // put two TableRow in the TableLayout
        TableRow controlRow1 = new TableRow(defaultContext);
        controlsViewGroup.addView(controlRow1 );
        TableRow controlRow2 = new TableRow(defaultContext);
        controlsViewGroup.addView(controlRow2 );
        // Make the eight buttons.
        Button stopButton =         new Button(defaultContext);
        Button volumeDownButton =   new Button(defaultContext);
        Button prevButton =         new Button(defaultContext);
        Button loopButton =         new Button(defaultContext);
        Button playPauseButton =    new Button(defaultContext);
        Button volumeUpButton =     new Button(defaultContext);
        Button nextButton =         new Button(defaultContext);
        Button shuffleButton =      new Button(defaultContext);
        // ------------------------
        stopButton.setText("Stop");
        volumeDownButton.setText("Vol-");
        prevButton.setText("Prev");
        loopButton.setText("Loop");
        playPauseButton.setText("Play");
        volumeUpButton.setText("Vol+");
        nextButton.setText("Next");
        shuffleButton.setText("Shuf");
        // ------------------------
        playPauseButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    serverConn.mpdPlayer.play();
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.pause(): " + e.getMessage());
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.pause(): " + e.getMessage());
                }
            }
        });
        stopButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    serverConn.mpdPlayer.stop();
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.stop(): " + e.getMessage());
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.pause(): " + e.getMessage());
                }
            }
        });
        volumeUpButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
            }
        });
        volumeDownButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
            }
        });
        prevButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    serverConn.mpdPlayer.playPrev();
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.playPrev(): " + e.getMessage());
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.playPrev(): " + e.getMessage());
                }
            }
        });
        nextButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    serverConn.mpdPlayer.playNext();
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.playNext(): " + e.getMessage());
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.playNext(): " + e.getMessage());
                }
            }
        });
        shuffleButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
            }
        });
        loopButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
            }
        });
        // ------------------------
        controlRow1.addView(volumeDownButton);
        controlRow1.addView(shuffleButton);
        controlRow1.addView(loopButton);
        controlRow1.addView(volumeUpButton);
        controlRow2.addView(prevButton);
        controlRow2.addView(playPauseButton);
        controlRow2.addView(stopButton);
        controlRow2.addView(nextButton);
    }

    /*-========================================================================/
    other class methods
    /========================================================================-*/
    /**-===============================/
    controlModeStarted() -- The "Controls" button has been pressed.
    /================================-*/
    public void controlModeStarted(View callingView) {
        ;   // do nothing; you're already in this mode
    }

    /**-===============================/
    playlistModeStarted() -- The "Playlist" button has been pressed.
    /================================-*/
    public void playlistModeStarted(View callingView) {
        Intent returnIntent = new Intent();
        returnIntent.putExtra("NewMode", "PLAYLIST");
        setResult(RESULT_OK, returnIntent);
        finish();
    }

    /**-===============================/
    libraryModeStarted() -- The "Library" button has been pressed.
    /================================-*/
    public void libraryModeStarted(View callingView) {
        Intent returnIntent = new Intent();
        returnIntent.putExtra("NewMode", "LIBRARY");
        setResult(RESULT_OK, returnIntent);
        finish();
    }
}
