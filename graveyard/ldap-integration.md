# Integrate Run:AI with the Organization's Directory. 

By default Run:AI uses an internal user directory. Assuming your organization uses a directory to manage users, it is possible to integrate the directory with Run:AI such that a subset of the organization's users will become Run:AI users.

The document below provides step-by-step instructions on how to perform this integration. The integration assumes a protocol called __LDAP__.

The process should be performed together with Run:AI Customer support in an online-session. 

## Prerequisites 

The instructions below assume that you have obtained the following from Run:AI Customer support:

* A `<TICKET-NUMBER>`, used by the Auth0 LDAP connector.
* A `<TENANT-NAME>`, which is the prefix for all users when logging in.

## Steps

* Log in as an Administrator to [https://app.run.ai](https://app.run.ai){target=_blank}. use the old, non-LDAP user. You should remain logged in throughout the entire process.

* Install the [Auth0 LDAP connector](https://auth0.com/docs/extensions/ad-ldap-connector/install-configure-ad-ldap-connector){target=_blank}, as part of the configuration you will need to provide it with the aforementioned `<TICKET-NUMBER>`. Connect to the organization's directory.

* Browse to [https://app.run.ai/general-settings](https://app.run.ai/general-settings){target=)blank}. Enable _LDAP Integration_. 

* Browse to [https://app.run.ai/users](https://app.run.ai/users){target=)blank}. Add roles to one or more LDAP users. 

* Configure [Researcher Authentication](researcher-authentication.md). When creating a Kubernetes profile (called _Client Side_), use the following instead:

``` YAML
        auth-flow: remote-browser
        redirect-uri: https://app.run.ai/auth
```

## Test

### Run:AI User Interface

* On an incognito browser, go to [https://app.run.ai/login](https://app.run.ai/login){target=_blank}.
* Log in using the LDAP user. Use the format `<TENANT-NAME>/<LDAP-USER-NAME>`.


### Run:AI Command-Line Interface

* Run a CLI command.
* You will be redirected to a browser page that asks for credentials. Enter the username and password from LDAP. If you are using a machine without a browser, you will be prompted with a URL to run elsewhere and return a resulting token. 

## Limitations

* Run:AI does not yet support single sign-on.
* While Users are retrieved from the Organization's directory. Roles must still be defined in [Run:AI Administrator UI](https://app.run.ai/users){target=_blank}.


