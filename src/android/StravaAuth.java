package com.cockpitmobile.stravaauth;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.net.Uri;
import android.content.Intent;

/**
 * This class echoes a string called from JavaScript.
 */
public class StravaAuth extends CordovaPlugin {
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("coolMethod")) {
            String message = args.getString(0);
            this.coolMethod(message, callbackContext);
            return true;
        } else if (action.equals("authorize")) {
            String state = args.getString(0);
            String callbackUri = args.getString(1);
            this.authorize(state, callbackUri, callbackContext);
            return true;
        }
        return false;
    }

    private void authorize(String state, String callbackUri, CallbackContext callbackContext) {
        Uri intentUri = Uri.parse("https://www.strava.com/oauth/mobile/authorize")
        .buildUpon()
        .appendQueryParameter("client_id", "45576")
        .appendQueryParameter("redirect_uri", callbackUri)
        .appendQueryParameter("response_type", "code")
        .appendQueryParameter("approval_prompt", "auto")
        .appendQueryParameter("scope", "read_all")
        .appendQueryParameter("state", state)
        .build();

        Intent intent = new Intent(Intent.ACTION_VIEW, intentUri);
        this.cordova.getActivity().startActivity(intent);

        callbackContext.success();
    }

    private void coolMethod(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}
