/**
Jeremy Audet
Dedicated to the public domain, using the Creative Commons CC0 1.0 license.
http://creativecommons.org/publicdomain/zero/1.0/

To implement a seekbar for this program, check out this guide: http://united-coders.com/nico-heid/an-android-seekbar-for-your-mediaplayer
Might help.
*/
package net.JeremyAudet.AudioPlayback;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class AudioPlayback extends Activity
{
    /*-========================================================================/
    class-wide declarations and constructors (onX() methods)
    /========================================================================-*/
    final static private String TAG = "AudioPlayback";

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        RawPlayer rawPlayer = new RawPlayer (
            getApplicationContext(),
            (Button) findViewById(R.id.internal_playpause_button), 
            (Button) findViewById(R.id.internal_stop_button)
        );
        ExternalPlayer externalPlayer = new ExternalPlayer (
            getApplicationContext(),
            (Button) findViewById(R.id.external_playpause_button),
            (Button) findViewById(R.id.external_stop_button)
        );
    } // onCreate
} // class AudioPlayback
