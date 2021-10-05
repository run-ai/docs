# Single Sign-On

Single sign-on (SSO) is an authentication scheme that allows a user to log in with a single ID and password to other, independent, software systems. SSO solves security issues involving multiple user/passwords data entry, multiple compliance schemes, etc. 

Run:AI supports integration with two SSO architectures: [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language){target=_blank} and [OAuth](https://en.wikipedia.org/wiki/OAuth){target=_blank}.

Both architectures require the organization to extract data from the Organization's identification provider and upload it to the Administration User Interface. 
## SAML

* Open the Administration User interface (app.run.ai or similar in Self-Hosted installations)
* Go to [Settings | General](https://app.run.ai/general-settings){target=_blank}
* Turn on __Login with SSO__. Go to the `SAML` tab.
* Under `Metadata XML Url` enter a __URL__ to an XML Metadata file retrieved from the identification provider.
* Under Administrator email, enter the first Administrator user.
* Press `Save`

Once you press `Save` all existing users will be rendered non-functional, and the only valid user will be the _Administrator email_ entered above. You can always revert by disabling _Login via SSO_. 


## OAuth

## Special mapping: UID & GID, Supplementary Groups.


## Mapping Roles to LDAP Groups