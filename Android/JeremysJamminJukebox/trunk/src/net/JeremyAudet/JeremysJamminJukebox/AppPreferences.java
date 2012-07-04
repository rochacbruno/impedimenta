package net.JeremyAudet.JeremysJamminJukebox;

import android.content.Intent;
import android.os.Bundle;
import android.preference.Preference;
import android.preference.Preference.OnPreferenceChangeListener;
import android.preference.PreferenceActivity;
import android.util.Log;

import java.lang.Integer;

/**
This class is an extremely straightforward implementation of a PreferenceActivity.
Besides displaying an interface to the user, it checks to make sure that no
values given are inappropriate.
*/
public class AppPreferences extends PreferenceActivity {
    final static private String TAG = "AppPreferences";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.layout.preferences);

        Preference portPreference = findPreference("serverPort");
        portPreference.setOnPreferenceChangeListener(new OnPreferenceChangeListener() {
            /**
            This method is called whenever preferences are changed by the user.
            If this method returns true, the newly changed preference is kept.
            It it returns false, the old preference value is kept.
            */
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
        });
    } // onCreate

    /**
    Called whenever the user presses the physical 'back' button
    */
    @Override
    public void onBackPressed() {
        Intent returnIntent = new Intent();
        returnIntent.putExtra(JeremysJamminJukebox.RETURN_CODE, JeremysJamminJukebox.MODE_BACK);
        setResult(RESULT_OK, returnIntent);
        finish();
    }
}
