Single Sign-On (SSO) is an authentication scheme, allowing users to log-in with a single pair of credentials to multiple, independent software systems.

This article explains the procedure to configure single sign-on to Run:ai using the OpenID Connect protocol in OpenShift V4.

## **Prerequisites**

Before starting, make sure you have the following available from your OpenShift cluster:

* OpenShift OAuth client \- see [Registering an additional OAuth client](https://docs.openshift.com/container-platform/4.16/authentication/configuring-oauth-clients.html\#oauth-register-additional-client\_configuring-oauth-clients)  
    * ClientID \- the ID used to identify the client with the Authorization Server.  
    * Client Secret \- a secret password that only the Client and Authorization Server know.  
* Base URL \- the OpenShift API Server endpoint (example: [https://api.\<cluster-url\>:6443](https://api.noa-ocp.runailabs.com:6443/))

## **Setup**

Follow the steps below to setup SSO with OpenShift.

### **Adding the identity provider**

1. Go to **Tools & Settings** → **General**  
1. Open the Security section and click **\+IDENTITY PROVIDER**  
1. Select **OpenShift V4**  
1. Enter the **Base URL**, Client ID, and **Client Secret** from your OpenShift OAuth client.  
1. Copy the Redirect URL to be used in your OpenShift OAuth client  
1. Optional: Enter the user attributes and their value in the identity provider (see the user attributes table below)  
1. Click **SAVE**  
   User attributes

| Attribute | Default value in Run:ai | Description |
| :---- | :---- | :---- |
| User role groups | GROUPS | If it exists in the IDP, it allows you to assign Run:ai role groups via the IDP. The IDP attribute must be a list of strings. |
| Linux User ID | UID | If it exists in the IDP, it allows Researcher containers to start with the Linux User UID. Used to map access to network resources such as file systems to users. The IDP attribute must be of type integer. |
| Linux Group ID | GID | If it exists in the IDP, it allows Researcher containers to start with the Linux Group GID. The IDP attribute must be of type integer. |
| Supplementary Groups | SUPPLEMENTARYGROUPS | If it exists in the IDP, it allows Researcher containers to start with the relevant Linux supplementary groups. The IDP attribute must be a list of integers. |
| Email | email | Defines the user attribute in the IDP holding the user's email address, which is the user identifier in Run:ai |
| User first name | firstName | Used as the user’s first name appearing in the Run:ai user interface |
| User last name | lastName | Used as the user’s last name appearing in the Run:ai user interface |

### **Testing the setup**

1. Open the Run:ai platform as an admin  
1. Add Access Rules to an SSO user defined in the IDP  
1. Open the Run:ai platform in an incognito browser tab  
1. On the sign-in page click **CONTINUE WITH SSO.** You are redirected to the OpenShift IDP sign-in page  
1. In the identity provider sign-in page, log-in with the SSO user who you granted with access rules.  
1. If you are unsuccessful signing-in to the identity provider, follow the Troubleshooting section below

### **Troubleshooting**

If testing the setup was unsuccessful, try the different troubleshooting scenarios according to the error you received.

#### **Troubleshooting scenarios**

**Error:** “403 \- Sorry, we can’t let you see this page. Something about permissions…”  
![](img/openid-403.png)

**Description:** The authenticated user is missing permissions  
**Mitigation**:  
- Validate either the user or its related group/s are assigned with access rules.
- Validate groups attribute is available in the configured OIDC Scopes  
- Validate the user’s groups attribute is mapped correctly  
**Advanced:**  
- Open the Chrome DevTools: Right-click on page → Inspect → Console tab  
- Run the following command to retrieve the user’s token: `localStorage.token;`  
- Paste in [https://jwt.io](https://jwt.io/)  
- Under the Payload section validate the value of the user’s attributes  

**Error:** “We’re having trouble identifying your account because your email is incorrect or can’t be found.”

![](img/openid-imageincorrect.png)

**Description:** Authentication failed because email attribute was not found.  
**Mitigation**:  
- Validate email attribute is available in the configured OIDC Scopes  
- Validate the user’s email attribute is mapped correctly  

**Error:** “Unexpected error when authenticating with identity provider”  

![](img/openshift-identityerror.png)

**Description:** User authentication failed  
**Mitigation**:  
Validate the configured OIDC Scopes exist and match the Identity Provider’s available scopes 
**Advanced:**  
Look for the specific error message in the URL address  


**Error:** “Unexpected error when authenticating with identity provider” (SSO sign-in is not available)  

![](img/openshift-identityerror-ssonotavail.png)

**Description:** User authentication failed  
**Mitigation**:  
- Validate the configured OIDC scope exists in the Identity Provider  
- Validate the configured Client Secret match the Client Secret value in the OAuthclient Kubernetes object.  
**Advanced:**  
Look for the specific error message in the URL address  

**Error:** “Client not found”  
    <!-- TBD \- OpenShift screenshot   -->
**Description:** OIDC Client ID was not found in the OpenShift IDP  
**Mitigation**:  
Validate the configured Client ID matches the value in the OAuthclient Kubernetes object.

### **Editing the identity provider**

You can view the identity provider details and edit its configuration:

1. Go to **Tools & Settings** → **General**  
1. Open the Security section  
1. On the identity provider box, click **Edit identity provider**  
1. You can edit either the **Base URL**, **Client ID**, **Client Secret**, or the **User attributes**

### **Removing the identity provider**

You can remove the identity provider configuration:

1. Go to **Tools & Settings** → **General**  
1. Open the Security section  
1. On the identity provider card, click **Remove identity provider**  
1. In the dialog, click **REMOVE** to confirm the action

!!!Note
    To avoid losing access, removing the identity provider must be carried out by a local user.

