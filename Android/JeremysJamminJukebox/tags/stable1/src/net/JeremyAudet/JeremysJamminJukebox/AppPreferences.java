package net.JeremyAudet.JeremysJamminJukebox;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.preference.Preference;
import android.preference.Preference.OnPreferenceChangeListener;
import android.preference.PreferenceActivity;

import java.lang.Integer;

public class AppPreferences extends PreferenceActivity {
    final static private String TAG = "AppPreferences";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.layout.preferences);

        Preference portPreference = findPreference("serverPort");
        portPreference.setOnPreferenceChangeListener(new OnPreferenceChangeListener() {
            @Override
            public boolean onPreferenceChange(Preference preference, Object newValue) {
                int portNumber = 0;

                try {
                    portNumber = Integer.parseInt(((String) newValue));
                } catch(NumberFormatException e) {
                    return false;
                }
                if(0 > portNumber || 65535 < portNumber) {
                    return false;
                }

                return true;
            }
        }); // portPreference.setOnPreferenceChangeListener
    } // onCreate
}
