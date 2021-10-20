# Single Sign-On

Single sign-on (SSO) is an authentication scheme that allows a user to log in with a single ID and password to other, independent, software systems. SSO solves security issues involving multiple user/passwords data entry, multiple compliance schemes, etc. 

Run:AI supports SSO using one of two architectures: [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language){target=_blank} or [OAuth](https://en.wikipedia.org/wiki/OAuth){target=_blank}.

## Terminology

The term _Identity Provider_ (or IdP) below relates to the system which creates, maintains, and manages identity information. Example IdPs: Google, Keycloak, Salesforce, Auth0. 
## SAML

### Prerequisites 

 * You must have an XML Metadata file retrieved from your IdP. Upload the file to a web server such that you will have a URL to the file. The URL must have the _XML_ file extension. For example, to connect using Google, you must create a custom SAML App [here](https://admin.google.com/ac/apps/unified){target=_blank}, download the Metadata file, and upload it to a web server.
 * Configure your IdP to map several IdP attributes: 

 | IdP attribute | Run:AI required name | Description       | 
 |----------------|----------------------|--------------------|
 | user email     | email                | `e-mail` is the user identifier with Run:AI. Mandatory (usually already pre-set in IdP) | 
 | User roles     | Roles                | (Optional) If exists, allows assigning Run:AI roles via the IdP. See more below | 
 | Linux User ID  | UID                  | (Optional) If exists in IdP, allows Researcher containers to start with the Linux User `UID`. Used to map access to network resources such as file systems to users | 
 | Linux Group ID | GID                  | (Optional) If exists in IdP, allows Researcher containers to start with the Linux Group `GID`. | 
 | Linux Supplementary Groups | SupplementaryGroups      | (Optional) If exists in IdP, allows Researcher containers to start with the relevant Linux supplementary groups. | 
 
 

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

* Enable Researcher Authentication by following the instructions [here](researcher-authentication.md). Use the `SSO` flow within the document.
## OAuth

Please contact Run:AI customer support
## Test 

### Test Administration User Interface

* Using an incognito browser tab, go to [app.run.ai](https://app.run.ai){target=_blank} (or the equivalent URL for self-hosted installation).
* Select the `Login with SSO` button. 
* Use the previously entered _Administrator email_ to log in. 

### Test Commmand-line interface

* In the command-line, run `runai login`:
* You receive a link that you must copy and open in your browser. Post login you will receive a verification code which you must paste into the shell window.
* Verify successful login.

### Test UID/GID Mapping

Submit a job, for example:

``` bash
runai submit -i ubuntu --interactive  --attach -- bash
```
When a shell opens inside the container, run `id` and verify that UID, GID, and the supplementary groups are the same as in the user's profile in the organization's directory.


## Adding Users

You can add additional users, by manually adding roles for each user, or by Mapping roles to IdP groups. 

### Adding Roles for a User

* Go to [https://app.run.ai/permissions](https://app.run.ai/permissions){target=_blank}.
* Select the `Users` button. 
* Map users as explained [here](../../admin-ui-setup/admin-ui-users.md).

### Mapping Roles

* Go to [https://app.run.ai/permissions](https://app.run.ai/permissions){target=_blank}.
* Select the `Groups` button. 
* Assuming you have mapped IdP `Roles` attribute as described in the prerequisites section above, add a Role name and provide it Run:AI Roles. 

