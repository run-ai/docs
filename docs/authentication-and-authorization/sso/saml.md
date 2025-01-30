
# Set up SSO with SAML

Single Sign-On (SSO) is an authentication scheme, allowing users to log-in with a single pair of credentials to multiple, independent software systems.

This article explains the procedure to [configure SSO to Run:ai](../authentication-overview.md) using the SAML 2.0 protocol.

## Prerequisites

Before starting, ensure you have the following available from your identity provider:

* SAML XML Metadata

## Setup

Follow the steps below to setup SSO with SAML.

### Adding the identity provider

1. Go to **General settings**  
2. Open the Security section and click **+IDENTITY PROVIDER**  
3. Select **Custom SAML 2.0**  
4. Select either **From computer** or **From URL**  
      * From computer - click the Metadata XML file field, then select your file for upload  
      * From URL - in the Metadata XML URL field, enter the URL to the XML Metadata file  
5. Copy the Redirect URL and Entity ID to be used in your identity provider  
6. Optional: Enter the user attributes and their value in the identity provider (see the user attributes table below)  

| Attribute | Default value in Run:ai | Description |
| :---- | :---- | :---- |
| User role groups | GROUPS | If it exists in the IDP, it allows you to assign Run:ai role groups via the IDP. The IDP attribute must be a list of strings. |
| Linux User ID | UID | If it exists in the IDP, it allows Researcher containers to start with the Linux User UID. Used to map access to network resources such as file systems to users. The IDP attribute must be of type integer. |
| Linux Group ID | GID | If it exists in the IDP, it allows Researcher containers to start with the Linux Group GID. The IDP attribute must be of type integer. |
| Supplementary Groups | SUPPLEMENTARYGROUPS | If it exists in the IDP, it allows Researcher containers to start with the relevant Linux supplementary groups. The IDP attribute must be a list of integers. |
| Email | email | Defines the user attribute in the IDP holding the user's email address, which is the user identifier in Run:ai. |
| User first name | firstName | Used as the user’s first name appearing in the Run:ai platform. |
| User last name | lastName | Used as the user’s last name appearing in the Run:ai platform. |

7. Click **SAVE**  


### Testing the setup

1. Open the Run:ai platform as an admin  
1. Add [Access Rules](../accessrules.md) to an SSO user defined in the IDP  
1. Open the Run:ai platform in an incognito browser tab  
1. On the sign-in page click **CONTINUE WITH SSO.**  
    You are redirected to the identity provider sign in page  
1. In the identity provider sign-in page, log-in with the SSO user who you granted with access rules  
1. If you are unsuccessful signing-in to the identity provider, follow the Troubleshooting section below

### Editing the identity provider

You can view the identity provider details and edit its configuration:

1. Go **General settings** 
2. Open the Security section  
3. On the identity provider box, click **Edit identity provider**  
4. You can edit either the metadata file or the user attributes  
5. You can view the identity provider URL, identity provider entity ID, and the certificate expiration date

### Removing the identity provider

You can remove the identity provider configuration:

1. Go to **General settings** 
1. Open the Security section  
1. On the identity provider card, click **Remove identity provider**  
1. In the dialog, click **REMOVE** to confirm the action

!!! Note
      To avoid losing access, removing the identity provider must be carried out by a local user.

## Downloading the XML metadata file

You can download the XML file to view the identity provider settings:

1. Go to **General settings**
1. Open the Security section  
1. On the identity provider card, click **Download metadata XML file**

## Troubleshooting

If testing the setup was unsuccessful, try the different troubleshooting scenarios according to the error you received. If an error still occurs, check the advanced troubleshooting section.

### Troubleshooting scenarios

??? "Invalid signature in response from identity provider"
      **Description**: After trying to log-in, the following message is received in the RunLai log-in page.
      **Mitigation:**
      1. Go to **General settings**  
      2. Open the Security section  
      3. In the identity provider box, check for a "Certificate expired” error  
      4. If it is expired, update the SAML metadata file to include a valid certificate

??? "401 - We’re having trouble identifying your account because your email is incorrect or can’t be found."
      **Description:** Authentication failed because email attribute was not found.

      **Mitigation**:

      1. Validate the user’s email attribute is mapped correctly

??? "403 - Sorry, we can’t let you see this page. Something about permissions…"

      **Description:** The authenticated user is missing permissions

      **Mitigation**:

      1. Validate either the user or its related group/s are assigned with [access rules](../accessrules.md)  
      2. Validate the user’s groups attribute is mapped correctly

      **Advanced:**

      1. Open the Chrome DevTools: Right-click on page → Inspect → Console tab  
      2. Run the following command to retrieve and paste the user’s token: `localStorage.token;`  
      3. Paste in [https://jwt.io](https://jwt.io)  
      4. Under the Payload section validate the values of the user’s attributes

### Advanced Troubleshooting

??? "Validating the SAML request"

      The SAML login flow can be separated into two parts:

      * Run:ai redirects to the IDP for log-ins using a SAML Request  
      * On successful log-in, the IDP redirects back to Run:ai with a SAML Response

      Validate the SAML Request to ensure the SAML flow works as expected:

      1. Go to the Run:ai login screen  
      2. Open the Chrome Network inspector: Right-click → Inspect on the page → Network tab  
      3. On the sign-in page click CONTINUE WITH SSO.  
      4. Once redirected to the Identity Provider, search in the Chrome network inspector for an HTTP request showing the SAML Request. Depending on the IDP url, this would be a request to the IDP domain name. For example, `accounts.google.com/idp?1234`.  
      5. When found, go to the Payload tab and copy the value of the SAML Request  
      6. Paste the value into a SAML decoder (e.g. [https://www.samltool.com/decode.php](https://www.samltool.com/decode.php))  
      7. Validate the request:  
         * The content of the `<saml:Issuer>` tag is the same as `Entity ID` given when adding the identity provider  
         * The content of the `AssertionConsumerServiceURL` is the same as the `Redirect URI` given when adding the identity provider  
      8. Validate the response:  
         * The user email under the `<saml2:Subject>` tag is the same as the logged-in user  
         * Make sure that under the `<saml2:AttributeStatement>` tag, there is an Attribute named `email` (lowercase). This attribute is mandatory.  
         * If other, optional user attributes (`groups`, `firstName`, `lastName`, `uid`, `gid`) are mapped make sure they also exist under `<saml2:AttributeStatement>` along with their respective values.

