package com.charliefederspiel.marley;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;

/**
 * Created by charliefederspiel on 2/28/16.
 */
public class WebViewActivity extends Activity {

    private WebView webView;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.fullscreeenwebview);

        webView = (WebView) findViewById(R.id.oauthwebview);
        webView.setWebViewClient(new MyWebViewClient());

        webView.getSettings().setJavaScriptEnabled(true);

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            String initialUrl = extras.getString("INITIAL_URL");
            if(initialUrl != null) {
                webView.loadUrl(initialUrl);
            }
        }


    }

    private class MyWebViewClient extends WebViewClient {
        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
            view.loadUrl(url);
            return true;
        }
    }
}
