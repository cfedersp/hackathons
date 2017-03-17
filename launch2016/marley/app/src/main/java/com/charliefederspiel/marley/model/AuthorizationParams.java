package com.charliefederspiel.marley.model;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

/**
 * Created by charliefederspiel on 2/27/16.
 */
public class AuthorizationParams implements Serializable {
    protected List<String> scope;
    protected String redirectUri;
    protected String clientId;
    protected String responseType="code";

    public AuthorizationParams() {

    }

    public List<String> getScope() {
        return scope;
    }

    public void setScope(List<String> scope) {
        this.scope = scope;
    }

    public String getRedirectUri() {
        return redirectUri;
    }

    public void setRedirectUri(String redirectUri) {
        this.redirectUri = redirectUri;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getResponseType() {
        return responseType;
    }

    public void setResponseType(String responseType) {
        this.responseType = responseType;
    }

    @Override
    public String toString() {
        return "AuthorizationParams{" +
                ", scope=" + scope +
                ", redirectUri='" + redirectUri + '\'' +
                ", clientId='" + clientId + '\'' +
                ", responseType='" + responseType + '\'' +
                '}';
    }
}
