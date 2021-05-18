# Integrate Run:AI with the Organization's Directory. 

By default Run:AI uses an internal user directory. Assuming your organization uses a directory to manage users, it is possible to integrate the directory with Run:AI such that a subset of the organization's users will become Run:AI users.

The document below provides step-by-step instructions on how to perform this integration. The integration assumes a protocol called __LDAP__.

## Prerequisites 

The instructions below assume that you have obtained an `<TICKET-NUMBER>` from Run:AI Customer support

## Integration

* Install the [Auth0 LDAP connector](https://auth0.com/docs/extensions/ad-ldap-connector/install-configure-ad-ldap-connector){target=_blank}, as part of the configuration you will need to provide it with the `<TICKET-NUMBER>` and connect it to the organization's directory.

* Browse to [https://app.run.ai/general-settings](https://app.run.ai/general-settings){target=)blank}. Enable _LDAP Integration_. 

* Configure [Researcher Authentication](researcher-authentication.md). When creating a Kubernetes profile (called _Client Side_), use the following instead:

``` YAML
        auth-flow: remote-browser
        idp-issuer-url: https://app.run.ai/auth
```


## Test

* Run a CLI command.
* You will be redirected to a browser page that asks for credentials. Enter the username and password from LDAP. If you are using a machine without a browser, you will be prompted with a URL to run elsewhere and return a resulting token. 

## Limitations

* Run:AI does not yet support single sign-on.
* While Users are retrieved from the Organization's directory. Roles must still be defined in [Run:AI Administrator UI](https://app.run.ai/users){target=_blank}.


