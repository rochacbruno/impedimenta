/**
 * Author(s):
 * Jeremy Audet
 *
 * First Created: 11/09/2011
 * License: Creative Commons BY-SA      http://creativecommons.org/licenses/by-sa/3.0/
 */

package net.JeremyAudet.HelloWorld;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class HelloWorld extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        TextView message = new TextView(this);
        message.setText("Hello, world!");

        setContentView(message);
    }
}
