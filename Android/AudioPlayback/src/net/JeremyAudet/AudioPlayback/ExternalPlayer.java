package net.JeremyAudet.AudioPlayback;

import java.io.IOException;
import java.lang.String;

import android.content.Context;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnCompletionListener;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class ExternalPlayer implements OnCompletionListener {
    /*-====================================================================/
    class-wide declarations and constructor(s)
    /====================================================================-*/
    /**-==========/
    class-wide declarations
    /===========-*/
    private final static String TAG = "ExternalPlayer";
    private boolean playing;
    final private Button playPauseButton;
    final private Button stopButton;
    private MediaPlayer mediaPlayer;

    /**-==========/
    constructor
    /===========-*/
    public ExternalPlayer(Context theContext, Button thePlayPauseButton, Button theStopButton) {
        super();
        Log.d(TAG, "constructor called");

        playing = false;
        playPauseButton = thePlayPauseButton;
        stopButton =      theStopButton;
        mediaPlayer = new MediaPlayer();
        mediaPlayer.setOnCompletionListener(this);

        Log.d(TAG, "setting data source for mediaPlayer");
        try {
            mediaPlayer.setDataSource(Environment.getExternalStorageDirectory().getAbsolutePath() + "/on_the_rocks.mp3");
            mediaPlayer.prepare();
        } catch(IOException e) {
            Log.e(TAG, e.getMessage());
        }

        /*
        Log.d(TAG, "setting data source for mediaPlayer");
        Log.d(TAG, "calling mediaPlayer.reset()");
        mediaPlayer.reset();
        try {
            mediaPlayer.setDataSource(Environment.getExternalStorageDirectory().getAbsolutePath() + "/ratatat.mp3");
            mediaPlayer.prepare();
        } catch(IOException e) {
            Log.e(TAG, e.getMessage());
        }
        */

        /**-==========/
        Implementation of interface OnClickListener
        /===========-*/
        playPauseButton.setOnClickListener(new OnClickListener() {
            public void onClick(View view) {
                Log.d(TAG, "method onClick() called for playPauseButton");

                // if already playing, pause and set text appropriately
                if(true == playing) {
                    mediaPlayer.pause();
                    ((Button) view).setText("Play ");
                // if not playing, play and set text appropriately
                } else {
                    mediaPlayer.start();
                    ((Button) view).setText("Pause");
                }
                playing = !playing;
            }
        });

        /**-==========/
        Implementation of interface OnClickListener
        /===========-*/
        stopButton.setOnClickListener(new OnClickListener() {
            public void onClick(View view) {
                Log.d(TAG, "method onClick() called for stopButton");
                resetClass();
            }
        });
    } // ExternalPlayer() constructor

    /*-====================================================================/
    class methods
    /====================================================================-*/
    /**-==========/
    onCompletion() -- called when a MediaPlayer reaches end of stream
    /===========-*/
    public void onCompletion(MediaPlayer mp) {
        Log.d(TAG, "method onCompletion() called");
        resetClass();
    }

    /**-==========/
    resetClass() -- called when the mediaPlayer finishes a stream, or the user presses stopButton
    /===========-*/
    private void resetClass() {
        Log.d(TAG, "method resetClass() called");

        mediaPlayer.stop();
        playing = false;
        playPauseButton.setText("Play ");

        try {
            mediaPlayer.prepare();
        } catch(IOException e) {
            Log.e(TAG, e.getMessage());
        }
        mediaPlayer.seekTo(0);
    }
} // class ExternalPlayer
