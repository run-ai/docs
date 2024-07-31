Single Sign-On (SSO) is an authentication scheme, allowing users to log-in with a single pair of credentials to multiple, independent software systems.

This article explains the procedure to configure SSO to Run:ai using the SAML 2.0 protocol.

## **Prerequisites**

Before starting, ensure you have the following available from your identity provider:

* SAML XML Metadata

## **Setup**

Follow the steps below to setup SSO with SAML.

### **Adding the identity provider**

1. Go to **Tools & Settings** → **General**  
1. Open the Security section and click **\+IDENTITY PROVIDER**  
1. Select **Custom SAML 2.0**  
1. Select either **From computer** or **From URL**  
   1. From computer \- click the Metadata XML file field, then select your file for upload  
   1. From URL \- in the Metadata XML URL field, enter the URL to the XML Metadata file  
1. Copy the Redirect URL and Entity ID to be used in your identity provider  
1. Optional: Enter the user attributes and their value in the identity provider (see the user attributes table below)  
1. Click **SAVE**  
   User attributes

| Attribute | Default value in Run:ai | Description |
| :---- | :---- | :---- |
| User role groups | GROUPS | If it exists in the IDP, it allows you to assign Run:ai role groups via the IDP. The IDP attribute must be a list of strings. |
| Linux User ID | UID | If it exists in the IDP, it allows Researcher containers to start with the Linux User UID. Used to map access to network resources such as file systems to users. The IDP attribute must be of type integer. |
| Linux Group ID | GID | If it exists in the IDP, it allows Researcher containers to start with the Linux Group GID. The IDP attribute must be of type integer. |
| Supplementary Groups | SUPPLEMENTARYGROUPS | If it exists in the IDP, it allows Researcher containers to start with the relevant Linux supplementary groups. The IDP attribute must be a list of integers. |
| Email | email | Defines the user attribute in the IDP holding the user's email address, which is the user identifier in Run:ai. |
| User first name | firstName | Used as the user’s first name appearing in the Run:ai platform. |
| User last name | lastName | Used as the user’s last name appearing in the Run:ai platform. |

### **Testing the setup**

1. Open the Run:ai platform as an admin  
1. Add Access Rules to an SSO user defined in the IDP  
1. Open the Run:ai platform in an incognito browser tab  
1. On the sign-in page click **CONTINUE WITH SSO.**  
    You are redirected to the identity provider sign in page  
1. In the identity provider sign-in page, log-in with the SSO user who you granted with access rules  
1. If you are unsuccessful signing-in to the identity provider, follow the Troubleshooting section below

### **Troubleshooting**

If testing the setup was unsuccessful, first validate the SAML Request to ensure the SAML flow works as expected. If it is working as expected, try the different troubleshooting scenarios according to the error message you received.

#### **Validating the SAML request**

The SAML login flow can be separated into two parts:

* Run:ai redirects to the IDP for log-ins using a SAML Request  
* On successful log-in, the IDP redirects back to Run:ai with a SAML Response

Validate the SAML Request to ensure the SAML flow works as expected:

1. Log-in to the Run:ai platform  
2. Open the Chrome Network inspector: Right-click → Inspect on the page → Network tab  
3. After the IDP log-in screen appears, search for an HTTP request showing the SAML Request. Depending on the IDP, this would be a request to the IDP domain name. For example, `accounts.google.com/idp?1234`.  
4. When found, go to the Payload tab and copy the value of the SAML Request  
5. Paste the value into a SAML decoder (e.g. [https://www.samltool.com/decode.php](https://www.samltool.com/decode.php))  
6. Validate the request:  
    * The content of the `<saml:Issuer>` tag is the same as `Entity ID` given when adding the identity provider  
    * The content of the `AssertionConsumerServiceURL` is the same as the `Redirect URI` given when adding the identity provider

#### **Troubleshooting scenarios**

1. **Error:** “Invalid signature in response from identity provider” in the Run:ai log-in page after trying to log in.  
   **Mitigation:**  
    a. Go to the Tools & Settings menu  
    b. Click **General**  
    c. Open the Security section  
    d. In the identity provider box, check if you see a "Certificate expired” error  
    e. If so, update the SAML metadata file to include a valid certificate  
2. **Error:** “401 unauthenticated” in the Run:ai log-in page after trying to log-in.  
   **Mitigation:**  
  a. Log-in to the Run:ai platform  
  b. Open the Chrome Network Inspector:  
       Right-click → Inspect on the page → Network tab  
  c. Open the request with error code 401  
  d. Go to Headers → Request Headers → Authorization and copy its value  
  e. Paste in [https://jwt.io/](https://jwt.io/)  
  f. Under the Payload section validate the following:  
       - The `tenant_id` claim exists  
       - The `email` claim contains the logged-in user email  
       - The `sub` claim contains the logged-in user email  

    g. If one of them is incorrect, validate the SAML Response to make sure that the user attributes mapping defined when adding the identity provider matches the attributes in the SAML Response:

      - Log-in to the system  
      - Open the Chrome Network inspector: Right-click → Inspect on the page → Network tab  
      - Search for "endpoint"  
      - When found, go to the Payload tab and copy the value of the SAML Response  
      - Paste the value into a SAML decoder (e.g. [https://www.samltool.com/decode.php](https://www.samltool.com/decode.php))  
      - Validate the response:  
        * The user email under the `<saml2:Subject>` tag is the same as the logged-in user  
        * Make sure that under the `<saml2:AttributeStatement>` tag, there is an Attribute named `email` (lowercase). This attribute is mandatory.  
        * If other, optional user attributes are mapped, make sure they also exist under `<saml2:AttributeStatement>` along with their respective values.
         
3. **Error:** “403 unauthorized” in the Run:ai login page after trying to log-in.  
   **Mitigation:**  
   a. Ensure the user was assigned access rules and try to log-in again  
   b. If groups are used to assign access rules, check that the JWT includes the group claim  
   c. Log-in to the system  
   d. Open the Chrome Network inspector:  
      Right-click → Inspect on the page → Network tab  
   e. Open the request with error code 403  
   f. Go to Headers → Request Headers → Authorization and and copy its value  
   g. Paste in [https://jwt.io/](https://jwt.io/)  
   h. Under the Payload section validate that the `groups` claim exists, with the relevant group you assigned with permissions  
   i. If it isn’t correct, validate the SAML Response to make sure that the group attribute mapping defined when adding the identity provider matches the attribute in the SAML Response:  
      - When logging in, open the Chrome Network inspector by Right-Click → Inspect on the page → Network tab  
      - Search for "endpoint"  
      - When found, go to the Payload tab and copy the value of the SAML Response  
      - Paste the value into a SAML decoder (e.g. [https://www.samltool.com/decode.php](https://www.samltool.com/decode.php))  
      - Ensure that the `groups` attribute exists under `<saml2:AttributeStatement>` along with its respective values

### **Editing the identity provider**

You can view the identity provider details and edit its configuration:

1. Go **Tools & Settings** → **General**  
1. Open the Security section  
1. On the identity provider box, click **Edit identity provider**  
1. You can edit either the metadata file or the user attributes  
1. You can view the identity provider URL, identity provider entity ID, and the certificate expiration date

### **Removing the identity provider**

You can remove the identity provider configuration:

1. Go to **Tools & Settings** → **General**  
1. Open the Security section  
1. On the identity provider card, click **Remove identity provider**  
1. In the dialog, click **REMOVE** to confirm the action

!!!Note
    To avoid losing access, removing the identity provider must be carried out by a local user.

### **Downloading the XML metadata file**

You can download the XML file to view the identity provider settings:

1. Go to **Tools & Settings** → **General**  
1. Open the Security section  
1. On the identity provider card, click **Download metadata XML file**

