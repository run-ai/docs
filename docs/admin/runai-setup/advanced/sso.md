# Single Sign-On

Single sign-on (SSO) is an authentication scheme that allows a user to log in with a single ID and password to other, independent, software systems. SSO solves security issues involving multiple user/passwords data entry, multiple compliance schemes, etc. 

Run:AI supports integration with two SSO architectures: [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language){target=_blank} and [OAuth](https://en.wikipedia.org/wiki/OAuth){target=_blank}.

Both architectures require the organization to extract data from the Organization's identification provider (IdP) and upload it to the Administration User Interface. 
## SAML

### Prerequisites 

 You must have an XML Metadata file retrieved from your IdP. Upload the file to a web server such that you will have a URL to the file. The URL must have the _XML_ file extension. 
 
 For example, to connect using Google, you must create a custom SAML App [here](https://admin.google.com/ac/apps/unified){target=_blank} and download the Metadata file.

### Configuration

* Open the Administration User interface (app.run.ai or similar in Self-Hosted installations)
* Go to [Settings | General](https://app.run.ai/general-settings){target=_blank}
* Turn on `Login with SSO`. 
* Go to the `SAML` tab.
* Under `Metadata XML Url` enter the URL to the XML Metadata file.
* Under Administrator email, enter the first administrator user.
* Press `Save`

Once you press `Save` you will receive a `Redirect URI` and an `Entity ID`. Both values must be set on the IdP side.

!!! Important Note
    Upon pressing `Save`, all existing users will be rendered non-functional, and the only valid user will be the _Administrator email_ entered above. You can always revert by disabling _Login via SSO_. 

### Test

* Using an incognito browser tab, go to [app.run.ai](https://app.run.ai){target=_blank}.
* Select the `Login with SSO` button. 
* Use the previously entered _Administrator email_ to log in.  

## OAuth

## Special mapping: UID & GID, Supplementary Groups.


## Mapping Roles to LDAP Groups