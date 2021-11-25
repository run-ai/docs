# Single Sign-On

Single sign-on (SSO) is an authentication scheme that allows a user to log in with a single ID to other, independent, software systems. SSO solves security issues involving multiple user/passwords data entry, multiple compliance schemes, etc. 

Run:AI supports SSO using the [SAML 2.0](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language){target=_blank} protocol. When SSO is configured, the system is accessible via single-sign on __only__.


!!! Important Note
    Single sign-on is only available with SaaS installations where the tenant has been created post-November 2021 or any Self-hosted installation.

## Terminology

The term _Identity Provider_ (or IdP) below relates to the system which creates, maintains, and manages identity information. Example IdPs: Google, Keycloak, Salesforce, Auth0. 

## Prerequisites 

 * __XML Metadata__: You must have an _XML Metadata file_ retrieved from your IdP. Upload the file to a web server such that you will have a URL to the file. The URL must have the _XML_ file extension. For example, to connect using Google, you must create a custom SAML App [here](https://admin.google.com/ac/apps/unified){target=_blank}, download the Metadata file, and upload it to a web server.
 * __Organization Name__: You must have a Run:AI _Organization Name_. This is the name that appears on the top right of the Run:AI user interface at [app.run.ai](https://app.run.ai){target=_blank} (or the equivalent URL for self-hosted installation).
 * __Additional attribute mapping__: Configure your IdP to map several IdP attributes: 

 | IdP attribute  | Run:AI required name | Description       | 
 |----------------|----------------------|--------------------|
 | User email     | email                | `e-mail` is the user identifier with Run:AI. Mandatory (usually already pre-set in the IdP) | 
 | User roles     | Roles                | (Optional) If exists, allows assigning Run:AI roles via the IdP. See more below | 
 | Linux User ID  | UID                  | (Optional) If exists in IdP, allows Researcher containers to start with the Linux User `UID`. Used to map access to network resources such as file systems to users | 
 | Linux Group ID | GID                  | (Optional) If exists in IdP, allows Researcher containers to start with the Linux Group `GID`. | 
 | Linux Supplementary Groups | SUPPLEMENTARYGROUPS      | (Optional) If exists in IdP, allows Researcher containers to start with the relevant Linux supplementary groups. Groups at the IdP should be separated by __##__. For example: __1234##212##654__ | 
 
 

## Step 1: UI Configuration

* Open the Administration User interface (app.run.ai or similar in Self-Hosted installations)
* Go to [Settings | General](https://app.run.ai/general-settings){target=_blank}
* Turn on `Login with SSO`. 
* Under `Metadata XML Url` enter the URL to the XML Metadata file obtained above.
* Under Administrator email, enter the first administrator user.
* Press `Save`

Once you press `Save` you will receive a `Redirect URI` and an `Entity ID`. Both values must be set on the IdP side.

!!! Important Note
    Upon pressing `Save`, all existing users will be rendered non-functional, and the only valid user will be the _Administrator email_ entered above. You can always revert by disabling _Login via SSO_. 


### Test 

Test Connectivity to Administration User Interface:

* Using an incognito browser tab, go to [app.run.ai](https://app.run.ai){target=_blank} (or the equivalent URL for self-hosted installation).
* Select the `Login with SSO` button. 
* Provide the `Organization name` obtained above. 
* You will be redirected to the IdP login page. Use the previously entered _Administrator email_ to log in. 

## Step 2: Cluster Authentication 

Researchers should be authenticated when accessing the Run:AI GPU Cluster. To perform that, the Kubernetes cluster and the user's Kubernetes profile must be aware of the IdP. Follow the instructions [here](researcher-authentication.md). Use the `SSO` flow within the document.


### Test 

Test connectivity to Run:AI command-line interface:

* In the command-line, run `runai login`:
* You receive a link that you must copy and open in your browser. Post login you will receive a verification code which you must paste into the shell window.
* Verify successful login.


## Step 3: UID/GID Mapping

Configure the IdP to add UID, GID, and Supplementary groups in the IdP.
### Test 

Test the mapping of UID/GID to within the container:

Submit a job with the flag `--run-as-user`, for example:

``` bash
runai submit -i ubuntu --interactive --run-as-user  --attach -- bash
```
When a shell opens inside the container, run `id` and verify that UID, GID, and the supplementary groups are the same as in the user's profile in the organization's directory.


## Step 4: Adding Users

You can add additional users, by:

1. Manually adding roles for each user, or by
2. Mapping roles to IdP groups. 

The latter option is easier to maintain. 

### Adding Roles for a User

* Go to [https://app.run.ai/permissions](https://app.run.ai/permissions){target=_blank}.
* Select the `Users` button. 
* Map users as explained [here](../../admin-ui-setup/admin-ui-users.md).

### Mapping Roles

* Go to [https://app.run.ai/permissions](https://app.run.ai/permissions){target=_blank}.
* Select the `Groups` button. 
* Assuming you have mapped IdP `Roles` attribute as described in the prerequisites section above, add a Role name and provide it Run:AI Roles. 


## Implementation Notes

Run:AI SSO does not support single logout. As such, logging out from Run:AI will not log you out from other systems.


