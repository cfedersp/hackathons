package com.charliefederspiel.marley;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.Switch;

import com.charliefederspiel.marley.model.AuthorizationParams;
import com.google.android.gms.appindexing.Action;
import com.google.android.gms.appindexing.AppIndex;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.auth.oauth2.BearerToken;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpExecuteInterceptor;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MainActivity extends ActionBarActivity {

    /**
     * ATTENTION: This was auto-generated to implement the App Indexing API.
     * See https://g.co/AppIndexing/AndroidStudio for more information.
     */
    private GoogleApiClient client;

    protected AuthorizationCodeFlow uberFlow;

    protected Map<String, AuthorizationParams> paramTemplates = new HashMap<String, AuthorizationParams>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        final Context context = this;
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Capture our controls from layout
        Button uberButton = (Button) findViewById(R.id.uberConnect);
        uberButton.setOnClickListener(new Button.OnClickListener() {
            public void onClick(View view) {
                try {
                    Credential cred = uberFlow.loadCredential("cfedersp");
                    if(cred == null) {
                        String authorizationUrl = getAuthorizeUrlForService("uber.com");
                        Log.d("MyActivity", authorizationUrl);
                        // use my web activity..
                        Intent intent = new Intent(context, WebViewActivity.class);
                        intent.putExtra("INITIAL_URL", authorizationUrl);

                        // use the OS's browser..
                        //Uri uri = Uri.parse(authorizationUrl);
                        //Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                        startActivity(intent);

                        // myWebView.loadUrl(authorizationUrl);
                    } else {
                        Log.d("MyActivity", "Found Existing Credential: " + cred);
                    }
                } catch (Exception e) {
                    Log.e("MyActivity", e.toString());
                }
            }
        });
        Switch onOffSwitch = (Switch) findViewById(R.id.switch1);
        onOffSwitch.setTextOff("Personal");
        onOffSwitch.setTextOn("Business");
        turnBusinessOff(findViewById(R.id.activity_main));
        // Register the onClick listener with the implementation above
        onOffSwitch.setOnCheckedChangeListener(bizPersonalSwitchListener);
        // YourView.setBackgroundColor(Color.argb(255, 255, 255, 255));

        String appName = "marley";
        String userId = "cfedersp";

        String uberClientId = "qYQoKZR4PBGuoe--bExO_YMsNVdPEIMQ";
        String uberSecret = "0L7qTgtb7VVA0bSDlXpjdmckpS4iiC-TE8g_9T_O";
        String serverToken = "rPE8N1EobmmvDgTI5LN-q02MFHHa2RuT4fVFpMUl";
        List<String> uberScopes = new ArrayList<String>();
        uberScopes.add("profile");
        uberScopes.add("places");
        //uberScopes.add("request"); // requires special permission from uber

        AuthorizationParams uberPa = new AuthorizationParams();
        uberPa.setScope(uberScopes);
        uberPa.setRedirectUri("https://localhost/uber/redirect");
        uberPa.setClientId(uberClientId);
        uberPa.setResponseType("code");
        paramTemplates.put("uber.com", uberPa);


        AuthorizationCodeFlow.Builder b = new AuthorizationCodeFlow.Builder(BearerToken.authorizationHeaderAccessMethod(), new NetHttpTransport(), GsonFactory.getDefaultInstance(),
                new GenericUrl("https://login.uber.com/oauth/v2/token"), uberClientSigner, uberClientId, "https://login.uber.com/oauth/v2/authorize");
        b.setScopes(uberScopes);

        uberFlow = b.build();
        // ATTENTION: This was auto-generated to implement the App Indexing API.
        // See https://g.co/AppIndexing/AndroidStudio for more information.
        client = new GoogleApiClient.Builder(this).addApi(AppIndex.API).build();
    }

    protected String getAuthorizeUrlForService(String service) throws NoSuchAlgorithmException {
        AuthorizationParams p = paramTemplates.get(service);
        return uberFlow.newAuthorizationUrl().toString()+"&redirect_uri="+p.getRedirectUri()+"&state="+ MessageDigest.getInstance("MD5").digest(p.toString().getBytes());
    }
    // Create an anonymous implementation of OnClickListener
    protected CompoundButton.OnCheckedChangeListener bizPersonalSwitchListener = new CompoundButton.OnCheckedChangeListener() {
        public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

            // Toast.makeText(this, "The Switch is " + (isChecked ? "on" : "off"), Toast.LENGTH_SHORT).show();
            View layout = findViewById(R.id.activity_main);
            if (isChecked) {
                turnBusinessOn(layout);

            } else {
                turnBusinessOff(layout);
            }
        }
    };

    protected HttpExecuteInterceptor uberClientSigner = new HttpExecuteInterceptor() {
        public void intercept(HttpRequest request) throws IOException {
            // extract the code and request an access token?
        }
    };

    protected void turnBusinessOn(View layout) {
        Log.d("MyActivity", "Business");
        //layout.setBackgroundColor(Color.rgb(255, 255, 255));
        // AccessMethod, HttpTransport, JsonFactory, tokenUrl, httpInterceptor, clientId, authorizationUrl)

    }

    protected void turnBusinessOff(View layout) {
        Log.d("MyActivity", "Personal");
        //layout.setBackgroundColor(Color.rgb(255, 255, 255));

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);


        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onStart() {
        super.onStart();

        // ATTENTION: This was auto-generated to implement the App Indexing API.
        // See https://g.co/AppIndexing/AndroidStudio for more information.
        client.connect();
        Action viewAction = Action.newAction(
                Action.TYPE_VIEW, // TODO: choose an action type.
                "Main Page", // TODO: Define a title for the content shown.
                // TODO: If you have web page content that matches this app activity's content,
                // make sure this auto-generated web page URL is correct.
                // Otherwise, set the URL to null.
                Uri.parse("http://host/path"),
                // TODO: Make sure this auto-generated app deep link URI is correct.
                Uri.parse("android-app://com.charliefederspiel.marley/http/host/path")
        );
        AppIndex.AppIndexApi.start(client, viewAction);
    }

    @Override
    public void onStop() {
        super.onStop();

        // ATTENTION: This was auto-generated to implement the App Indexing API.
        // See https://g.co/AppIndexing/AndroidStudio for more information.
        Action viewAction = Action.newAction(
                Action.TYPE_VIEW, // TODO: choose an action type.
                "Main Page", // TODO: Define a title for the content shown.
                // TODO: If you have web page content that matches this app activity's content,
                // make sure this auto-generated web page URL is correct.
                // Otherwise, set the URL to null.
                Uri.parse("http://host/path"),
                // TODO: Make sure this auto-generated app deep link URI is correct.
                Uri.parse("android-app://com.charliefederspiel.marley/http/host/path")
        );
        AppIndex.AppIndexApi.end(client, viewAction);
        client.disconnect();
    }
}
