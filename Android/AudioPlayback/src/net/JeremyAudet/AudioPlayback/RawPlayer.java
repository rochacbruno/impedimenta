package net.JeremyAudet.AudioPlayback;

import java.io.IOException;
import java.lang.String;

import android.content.Context;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnCompletionListener;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class RawPlayer implements OnCompletionListener {
    /*-====================================================================/
    class-wide declarations and constructor(s)
    /====================================================================-*/
    /**-==========/
    class-wide declarations
    /===========-*/
    private final static String TAG = "RawPlayer";
    private boolean playing;
    final private Button playPauseButton;
    final private Button stopButton;
    private MediaPlayer mediaPlayer;

    /**-==========/
    constructor
    /===========-*/
    public RawPlayer(Context theContext, Button thePlayPauseButton, Button theStopButton) {
        super();
        Log.d(TAG, "constructor called");

        playing = false;
        playPauseButton = thePlayPauseButton;
        stopButton =      theStopButton;
        mediaPlayer = MediaPlayer.create(theContext, R.raw.pow);
        mediaPlayer.setOnCompletionListener(this);
        // mediaPlayer = MediaPlayer.create(theContext, R.raw.pow2);
        // Does not work! Need to call Uri.fromFile(File file) or somesuch
        // mediaPlayer = MediaPlayer.create(theContext, "file://sdcard/on_the_rocks.mp3");

        /**-==========/
        Implementation of interface OnClickListener for Button playPauseButton
        /===========-*/
        playPauseButton.setOnClickListener(new OnClickListener() {
            public void onClick(View view) {

                if(true == playing) {
                    // if already playing, pause and set text appropriately
                    mediaPlayer.pause();
                    ((Button) view).setText("Play ");
                } else {
                    // if not playing, play and set text appropriately
                    mediaPlayer.start();
                    ((Button) view).setText("Pause");
                }
                playing = !playing;
            }
        });

        /**-==========/
        Implementation of interface OnClickListener for Button stopButton
        /===========-*/
        stopButton.setOnClickListener(new OnClickListener() {
            public void onClick(View view) {
                Log.d(TAG, "method onClick() called for stopButton");
                resetClass();
            }
        });
    } // InternalPlayer() constructor

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
} // class InternalPlayer
