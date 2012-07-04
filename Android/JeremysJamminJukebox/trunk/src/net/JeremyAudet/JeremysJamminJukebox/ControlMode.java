package net.JeremyAudet.JeremysJamminJukebox;

// Java imports
import java.lang.Thread;

// Android imports
import android.app.Activity;
//--
import android.content.Context;
import android.content.Intent;
//--
import android.os.Bundle;
import android.os.Handler;
//--
import android.util.Log;
//--
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
//--
import android.widget.Gallery;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.SeekBar;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

// JavaMPD imports
import org.bff.javampd.MPD;
import org.bff.javampd.MPDPlayer;
import org.bff.javampd.MPDPlayer.PlayerStatus;
//--
import org.bff.javampd.events.PlayerBasicChangeEvent;
import org.bff.javampd.events.PlayerBasicChangeListener;
import org.bff.javampd.events.PlaylistBasicChangeEvent;
import org.bff.javampd.events.PlaylistBasicChangeListener;
//--
import org.bff.javampd.exception.MPDException;
import org.bff.javampd.exception.MPDConnectionException;
import org.bff.javampd.exception.MPDPlayerException;
import org.bff.javampd.exception.MPDResponseException;
//--
import org.bff.javampd.objects.MPDSong;
//--
import org.bff.javampd.monitor.MPDStandAloneMonitor;

/**
This class provides a set of controls to the user, which can be used to 
control playback on the connected MPD server. Specifically, the user can:<br />
    + play/pause<br />
    + skip forward/back<br />
    + increase/decrease volume<br />
    + turn shuffle on/off<br />
    + turn loop on/off<p />

Though not implemented yet, the user should also be able to:<br />
    + change song progress<p />

The following should also be displayed to the user:<br />
    + current song tags, such as artist, track, album name, and album artwork<br />
    + current song progress<br />
Currently, only track name is displayed. The javampd, to the best of my 
knowledge, does not provide any methods for fetching artist and album name.<p />

Note that threading is integral to the functioning of this class. Threading 
is used to update the UI in a timely, non-blocking fashion. See onStart() and
onStop() for details.
*/
public class ControlMode extends Activity 
        // onStartTrackingTouch, onProgressChanged, onStopTrackingTouch
        implements SeekBar.OnSeekBarChangeListener,
        // onPlayerBasicChange
        PlayerBasicChangeListener,
        // onPlaylistBasicChange
        PlaylistBasicChangeListener
    {
    /*-========================================================================/
    Class-wide declarations, onX() methods
    /========================================================================-*/
    final static private String TAG = "ControlMode";
    final private Context defaultContext = this;
    final static private int STATUS_POLL_DELAY = 1000;
    final static private long SHUFF_LOOP_POLL_DELAY = 2000;

    // This object was created according to the singleton model. It has copies
    // of the MPD and MPDPlayer objects as member variables.
    private ServerConnection serverConn;

    // These are used to monitor the MPD server and update the interface.
    private Thread monitorThread;   // allows MPDStandAloneMonitor to run in the background
    private Thread monitorThread2;  // allows monitorShuffleLoop to run in the background
    private Handler threadMessageBoard;
    private PlayerBasicChangeEvent playerBasicChange;
    private PlaylistBasicChangeEvent playlistBasicChange;
    private boolean isPlaying;
    private boolean isShuffle;
    private boolean isRepeat;

    // These variables are used to build the user interface. mainViewGroup is
    // previously defined in XML. It is a VewGroup that contains all the other
    // UI elements created here.
    private LinearLayout mainViewGroup;
    private TextView     statusRow1;
    private TextView     statusRow2;
    private ImageView    volumeUpButton;
    private ImageView    volumeDownButton;
    private ImageView    shuffleButton;
    private ImageView    loopButton;
    private ImageView    prevButton;
    private ImageView    playPauseButton;
    private ImageView    nextButton;

    // These private variables exist soley for the sake of efficiency.
    // Create them once when the object is constructed, rather than repeatedly
    // througout the object's lifetime.
    private int currentVolume;
    private MPDSong currentSong;

    /**
    Called when this activity is first created. Activity may be created multiple
    times during the lifetime of an application.
    */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        serverConn = ServerConnection.getServerConnection();
        threadMessageBoard = new Handler();

        // Place the layout (about to be created) inside this ViewGroup.
        mainViewGroup = (LinearLayout) findViewById(R.id.mainViewGroup);
        mainViewGroup.setGravity(android.view.Gravity.BOTTOM);
        // Add album art.
        ImageView albumArt = new ImageView(defaultContext);
        albumArt.setImageResource(R.drawable.musicnote);
        albumArt.setLayoutParams(new Gallery.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
        mainViewGroup.addView(albumArt);
        // AAAAH NO METHOD TO FETCH ALBUM ART. :(
        // Add the song title, artist, album, and all that.
        ViewGroup.LayoutParams xyParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        statusRow1 = new TextView(defaultContext);
        statusRow1.setGravity(Gravity.CENTER);
        statusRow1.setLayoutParams(xyParams);
        statusRow2 = new TextView(defaultContext);
        statusRow2.setGravity(Gravity.CENTER);
        statusRow2.setLayoutParams(xyParams);
        try {
            currentSong = serverConn.mpdPlayer.getCurrentSong();
        } catch(MPDConnectionException e) {
            Log.e(TAG, "Connection error encountered: " + e.getMessage());
            Log.e(TAG, "Finishing activity.");
            finish();
        } catch(MPDPlayerException e) {
            Log.e(TAG, "MPD player responded with an error: " + e.getMessage());
            Log.e(TAG, "Finishing activity.");
            finish();
        }
        try {
            statusRow1.setText(currentSong.getTitle());
            statusRow2.setText("no f'n method for this");
        } catch(Exception e) {
            statusRow1.setText("Stopped");
            statusRow2.setText("");
        }
        mainViewGroup.addView(statusRow1);
        mainViewGroup.addView(statusRow2);
        // ... and a seekbar
        SeekBar songProgress = new SeekBar(defaultContext);
        songProgress.setOnSeekBarChangeListener(this);
        mainViewGroup.addView(songProgress);
        // add a TableLayout
        TableLayout controlsViewGroup1 = new TableLayout(defaultContext);
        TableLayout controlsViewGroup2 = new TableLayout(defaultContext);
        controlsViewGroup1.setStretchAllColumns(true);
        controlsViewGroup2.setStretchAllColumns(true);
        mainViewGroup.addView(controlsViewGroup1);
        mainViewGroup.addView(controlsViewGroup2);
        // put two TableRow in the TableLayout
        TableRow controlRow1 = new TableRow(defaultContext);
        TableRow controlRow2 = new TableRow(defaultContext);
        controlsViewGroup1.addView(controlRow1);
        controlsViewGroup2.addView(controlRow2);
        // Make the eight buttons.
        volumeUpButton =     new ImageView(defaultContext);
        volumeDownButton =   new ImageView(defaultContext);
        shuffleButton =      new ImageView(defaultContext);
        loopButton =         new ImageView(defaultContext);
        prevButton =         new ImageView(defaultContext);
        playPauseButton =    new ImageView(defaultContext);
        nextButton =         new ImageView(defaultContext);
        // ------------------------
        volumeUpButton.setImageResource(R.drawable.volupbutton);
        volumeDownButton.setImageResource(R.drawable.voldownbutton);
        prevButton.setImageResource(R.drawable.prevbutton);
        nextButton.setImageResource(R.drawable.nextbutton);
        try {
            if(serverConn.mpdPlayer.isRandom()) {
                shuffleButton.setImageResource(R.drawable.shufflebutton);
                isShuffle = true;
            } else {
                shuffleButton.setImageResource(R.drawable.noshufflebutton);
                isShuffle = false;
            }

            if(serverConn.mpdPlayer.isRepeat()) {
                loopButton.setImageResource(R.drawable.loopbutton);
                isRepeat = true;
            } else {
                loopButton.setImageResource(R.drawable.noloopbutton);
                isRepeat = false;
            }

            if(MPDPlayer.PlayerStatus.STATUS_PLAYING == serverConn.mpdPlayer.getStatus()) {
                playPauseButton.setImageResource(R.drawable.pausebutton);
                isPlaying = true;
            } else {
                playPauseButton.setImageResource(R.drawable.playbutton);
                isPlaying = false;
            }
        } catch(MPDException e) {
            Log.e(TAG, "MPDException encountered while getting player status: " + e.getMessage());
            Log.e(TAG, "Finishing activity.");
            finish();
        }
        // Image resources (set just above) should scale uniformly, and no clipping should occur.
        volumeDownButton.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        prevButton.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        loopButton.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        playPauseButton.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        volumeUpButton.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        nextButton.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        shuffleButton.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        // Background resources will go underneath image resources.
        volumeDownButton.setBackgroundResource(R.drawable.whitepixel);
        prevButton.setBackgroundResource(R.drawable.whitepixel);
        loopButton.setBackgroundResource(R.drawable.whitepixel);
        volumeUpButton.setBackgroundResource(R.drawable.whitepixel);
        nextButton.setBackgroundResource(R.drawable.whitepixel);
        shuffleButton.setBackgroundResource(R.drawable.whitepixel);
        playPauseButton.setBackgroundResource(R.drawable.whitepixel);
        // ------------------------
        playPauseButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    if(isPlaying) {
                        serverConn.mpdPlayer.pause();
                    } else {
                        serverConn.mpdPlayer.play();
                    }
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.pause(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.pause(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                }
            }
        });

        volumeUpButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    currentVolume = serverConn.mpdPlayer.getVolume();
                    if(currentVolume + 5 >= 100) {
                        serverConn.mpdPlayer.setVolume(100);
                    } else {
                        serverConn.mpdPlayer.setVolume(currentVolume + 5);
                    }
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while getting/setting volume: " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error while getting/setting volume" + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                }
            }
        });

        volumeDownButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    currentVolume = serverConn.mpdPlayer.getVolume();
                    if(currentVolume - 5 <= 0) {
                        serverConn.mpdPlayer.setVolume(0);
                    } else {
                        serverConn.mpdPlayer.setVolume(currentVolume - 5);
                    }
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while getting/setting volume: " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error while getting/setting volume" + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                }
            }
        });

        prevButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    serverConn.mpdPlayer.playPrev();
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.playPrev(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.playPrev(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                }
            }
        });

        nextButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    serverConn.mpdPlayer.playNext();
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.playNext(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.playNext(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                }
            }
        });

        shuffleButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    if(isShuffle) {
                        serverConn.mpdPlayer.setRandom(false);
                    } else {
                        serverConn.mpdPlayer.setRandom(true);
                    }
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.playNext(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.playNext(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                }
            }
        });

        loopButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View callingView) {
                try {
                    if(isRepeat) {
                        serverConn.mpdPlayer.setRepeat(false);
                    } else {
                        serverConn.mpdPlayer.setRepeat(true);
                    }
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered while calling MPDPlayer.playNext(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with an error after calling MPDPlayer.playNext(): " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                }
            }
        });
        // ------------------------
        controlRow1.addView(volumeDownButton);
        controlRow1.addView(shuffleButton);
        controlRow1.addView(loopButton);
        controlRow1.addView(volumeUpButton);
        controlRow2.addView(prevButton);
        controlRow2.addView(playPauseButton);
        controlRow2.addView(nextButton);
    }

    /**
    Called both after onCreate, and when activity comes into view after being 
    hidden. <p />

    This method starts a set of threads that poll the connected MPD server at
    fixed intervals. The polling checks for things such as play/pause,
    shuffle/unshuffle, loop/unloop, and playlist change events. <p />

    Importantly, these threads are started _after_ the UI is created by
    onCreate(). This means that the threads started here will not attempt to
    update UI elements that do not exist.
    */
    @Override
    public void onStart() {
        super.onStart();

        // Wait until the interface is fully constructed before adding
        // monitors. Else, the methods called could try to change a
        // view that does not exist!
        MPDStandAloneMonitor mpdStandAloneMonitor = new MPDStandAloneMonitor(serverConn.mpd, STATUS_POLL_DELAY);
        mpdStandAloneMonitor.addPlayerChangeListener(this);
        mpdStandAloneMonitor.addPlaylistChangeListener(this);
        monitorThread = new Thread(mpdStandAloneMonitor);
        monitorThread.start();

        monitorThread2 = new Thread(monitorShuffleLoop);
        monitorThread2.start();
    }

    /**
    Called when this activity is no longer visible. <p />

    This method stops the polling threads created by onStart().
    */
    @Override
    public void onStop() {
        super.onStop();

        monitorThread.interrupt();
        monitorThread2.interrupt();
    }

    /**
    Called when the physical 'back' button is pressed.
    */
    @Override
    public void onBackPressed() {
        Intent returnIntent = new Intent();
        returnIntent.putExtra(JeremysJamminJukebox.RETURN_CODE, JeremysJamminJukebox.MODE_BACK);
        setResult(RESULT_OK, returnIntent);
        finish();
    }

    /*-========================================================================/
    Interface Implementations
    /========================================================================-*/
    /**
    Called when the user presses the seekbar.
    */
    @Override
    public void onStartTrackingTouch(SeekBar seekBar) {
        // Stop updating the location of the trackbar while the user has pressed down their finger?
        Log.d(TAG, "User pressed seekbar.");
    }

    /**
    Called when the user moves the seekbar.
    */
    @Override
    public void onProgressChanged(SeekBar seekBar, int progress, boolean fromTouch) {
        // Do nothing. I don't care that the user is moving the trackbar.
    }

    /**
    Called when the user releases the seekbar.
    */
    @Override
    public void onStopTrackingTouch(SeekBar seekBar) {
        Log.d(TAG, "User released seekbar. Please change song progress on server.");
    }

    /**
    Called whenever the threaded MPDStandAloneMonitor fires a
    PlayerBasicChangeEvent. Calls a method to handle the
    PlayerBasicChangeEvent via a class-wide Handler.
    */
    @Override
    public void playerBasicChange(PlayerBasicChangeEvent event) {
        playerBasicChange = event;
        threadMessageBoard.post(showPlayerBasicChange);
    }
        
    /**
    Called whenever the threaded MPDStandAloneMonitor fires a 
    PlaylistBasicChangeEvent. Calls a method to handle the
    PlayerBasicChangeEvent via a class-wide handler.
    */
    @Override
    public void playlistBasicChange(PlaylistBasicChangeEvent event) {
        playlistBasicChange = event;
        threadMessageBoard.post(showPlaylistBasicChange);
    }

    /*-========================================================================/
    other class methods
    /========================================================================-*/
    /**
    Called when the "Controls" button is pressed. Does nothing, as the
    ControlMode Activity is already visible.
    */
    public void controlModeStarted(View callingView) {
        ;
    }

    /**
    Called when the "Playlist" button is pressed. Finishes this activity and
    requests that the PlaylistMode activity be started. The request is
    performed by creating an intent with an extra attached; the extra will be
    read by JeremysJamminJukebox when this activity finishes.
    */
    public void playlistModeStarted(View callingView) {
        Intent returnIntent = new Intent();
        returnIntent.putExtra(JeremysJamminJukebox.RETURN_CODE, JeremysJamminJukebox.MODE_PLAYLIST);
        setResult(RESULT_OK, returnIntent);
        finish();
    }

    /**
    Called when the "Library" button is pressed. Finishes this activity and
    requests that the LibraryMode activity be started. The request is performed
    by creating an intent with an extra attached; the extra will be read
    by JeremysJamminJukebox when this activity finishes.
    */
    public void libraryModeStarted(View callingView) {
        Intent returnIntent = new Intent();
        returnIntent.putExtra(JeremysJamminJukebox.RETURN_CODE, JeremysJamminJukebox.MODE_LIBRARY);
        setResult(RESULT_OK, returnIntent);
        finish();
    }

    /**
    Updates the UI when a PlayerBasicChange event is fired by
    MPDStandAloneMonitor. Called from the playerBasicChange method.
    */
    private Runnable showPlayerBasicChange = new Runnable() {
        public void run() {
            switch(playerBasicChange.getId()) {
                case PlayerBasicChangeEvent.PLAYER_STARTED:
                    isPlaying = true;
                    playPauseButton.setImageResource(R.drawable.pausebutton);
                    break;

                case PlayerBasicChangeEvent.PLAYER_STOPPED:
                    isPlaying = false;
                    statusRow1.setText("Stopped");
                    statusRow2.setText("");
                    playPauseButton.setImageResource(R.drawable.playbutton);
                    break;

                case PlayerBasicChangeEvent.PLAYER_PAUSED:
                    isPlaying = false;
                    playPauseButton.setImageResource(R.drawable.playbutton);
                    break;

                case PlayerBasicChangeEvent.PLAYER_UNPAUSED:
                    isPlaying = true;
                    playPauseButton.setImageResource(R.drawable.pausebutton);
                    break;

                case PlayerBasicChangeEvent.PLAYER_BITRATE_CHANGE:
                    // ignore bitrate changes; nothing in my UI handles 'em
                    break;

                default:
                    Log.e(TAG, "Unknown PlayerBasicChangeEvent: " + playerBasicChange.getMsg());
            }
        }
    };

    /**
    Updates the UI when a PlaylistBasicChange event is fired by
    MPDStandAloneMonitor. Called from the playlistBasicChange method.
    */
    private Runnable showPlaylistBasicChange = new Runnable() {
        public void run() {
            switch(playlistBasicChange.getId()) {
                case PlaylistBasicChangeEvent.PLAYLIST_CHANGED:
                    // intentionally do nothing
                    break;

                case PlaylistBasicChangeEvent.PLAYLIST_ENDED:
                    statusRow1.setText("Stopped");
                    statusRow2.setText("");
                    break;

                case PlaylistBasicChangeEvent.SONG_ADDED:
                    // intentionally do nothing
                    break;

                case PlaylistBasicChangeEvent.SONG_CHANGED:
                    try {
                        currentSong = serverConn.mpdPlayer.getCurrentSong();
                    } catch(MPDConnectionException e) {
                        Log.e(TAG, "Connection error encountered: " + e.getMessage());
                        Log.e(TAG, "Finishing activity.");
                        finish();
                    } catch(MPDPlayerException e) {
                        Log.e(TAG, "MPD player responded with an error: " + e.getMessage());
                        Log.e(TAG, "Finishing activity.");
                        finish();
                    }
                    try {
                        statusRow1.setText(currentSong.getTitle());
                        statusRow2.setText("no f'n method for this");
                    } catch(Exception e) {
                        statusRow1.setText("Stopped");
                        statusRow2.setText("");
                    }
                    break;

                case PlaylistBasicChangeEvent.SONG_DELETED:
                    // intentionally do nothing
                    break;

                default:
                    Log.e(TAG, "Unknown PlaylistBasicChangeEvent: " + playlistBasicChange.getMsg());
            }
        }
    };

    /**
    Monitors the loop/shuffle status of the connected MPD server, and calls an
    appropriate method to update the UI whenever a change is detected. <p />

    MPDStandAloneMonitor does not monitor the status of loop and shuffle.
    Therefore, this thread fills in that gap and polls the server at fixed
    intervals to check on the status of loop and shuffle. <p />

    Not as good as patching MPDStandAloneServer with extra functionality or
    fixing MPDEventRelayer, but this is a simple (if inefficient) workaround. <p />

    This is run as a background thread. Whenever it discovers that either
    shuffle or loop has changed, it posts a message to the handler
    threadMessageBoard, and that handler calls showSuffleLoop.
    */
    private Runnable monitorShuffleLoop = new Runnable() {
        public void run() {
            while(true) {
                try {
                    // Poll server only at fixed delays. Do not poll server and
                    // update UI uncontrollably.
                    Thread.sleep(SHUFF_LOOP_POLL_DELAY);
                } catch (InterruptedException e) {
                    // If interrupted, end this thread.
                    return;
                }

                try {
                    // Only update UI if isRandom or isRepeat has changed.
                    if(serverConn.mpdPlayer.isRandom() != isShuffle) {
                        isShuffle = !isShuffle;
                        threadMessageBoard.post(showShuffleLoop);
                    }
                    if(serverConn.mpdPlayer.isRepeat() != isRepeat) {
                        isRepeat = !isRepeat;
                        threadMessageBoard.post(showShuffleLoop);
                    }
                } catch(MPDConnectionException e) {
                    Log.e(TAG, "Connection error encountered: " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                } catch(MPDPlayerException e) {
                    Log.e(TAG, "MPD player responded with error: " + e.getMessage());
                    Log.e(TAG, "Finishing activity.");
                    finish();
                }
            }
        }
    };

    /**
    This Runnable is called by monitorShuffleLoop whenever isShuffle or
    isRepeats has been updated. This Runnable will update the images on
    shuffleButton and/or loopButton based on the values of isShuffle and
    isRepeat.
    */
    private Runnable showShuffleLoop = new Runnable() {
        public void run() {
            if(isShuffle) {
                shuffleButton.setImageResource(R.drawable.shufflebutton);
            } else {
                shuffleButton.setImageResource(R.drawable.noshufflebutton);
            }
            if(isRepeat) {
                loopButton.setImageResource(R.drawable.loopbutton);
            } else {
                loopButton.setImageResource(R.drawable.noloopbutton);
            }

            return;
        }
    };
}
