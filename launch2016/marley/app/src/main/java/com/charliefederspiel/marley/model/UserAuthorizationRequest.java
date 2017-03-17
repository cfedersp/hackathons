package com.charliefederspiel.marley.model;

/**
 * Created by charliefederspiel on 2/28/16.
 */
public class UserAuthorizationRequest extends AuthorizationParams {
    protected String user;
    public UserAuthorizationRequest(AuthorizationParams params, String user) {
        this.user = user;
        super.redirectUri = params.redirectUri;
        super.clientId = params.clientId;
        super.scope = params.scope;
        super.responseType =  params.responseType;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "UserAuthorizationRequest{" +
                "user='" + user + '\'' +
                super.toString() +
                '}';
    }
}
