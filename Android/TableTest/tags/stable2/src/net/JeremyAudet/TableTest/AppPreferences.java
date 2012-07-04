package net.JeremyAudet.TableTest;

import android.os.Bundle;
import android.preference.PreferenceActivity;
import android.util.Log;

public class AppPreferences extends PreferenceActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        Log.i("PREFS", "onCreate called");
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.layout.preferences);
    }
}
