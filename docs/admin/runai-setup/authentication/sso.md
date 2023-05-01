# Single Sign-On

Single Sign-On (SSO) is an authentication scheme that allows a user to log in with a single ID to other, independent, software systems. SSO solves security issues involving multiple user/password data entries, multiple compliance schemes, etc.

Run:ai supports SSO using the [SAML 2.0](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language){target=_blank} protocol and Open ID Connect (OIDC).

!!! Caution
    Single sign-on is only available with SaaS installations where the tenant has been created post-January 2022 or any Self-hosted installation of release 2.0.58 or later. If you are using single sign-on with older versions of Run:ai, please contact Run:ai customer support

## Terminology

*Identity Provider (Idp)*&mdash; a system that creates, maintains, and manages identity information. Example IdPs: Google, Keycloak, Salesforce, Auth0.

## SAML Prerequisites

* **XML Metadata**&mdash;you must have an *XML Metadata file* retrieved from your IdP. Upload the file to a web server such that you will have a URL to the file. The URL must have the *XML* file extension. For example, to connect using Google, you must create a custom SAML App [here](https://admin.google.com/ac/apps/unified){target=_blank}, download the Metadata file, and upload it to a web server.
* **Organization Name**&mdash;you must have a Run:ai *Organization Name*. This is the name that appears on the top right of the Run:ai user interface.

## OIDC Prerequisites

* **Discovery URL**&mdash;the OpenID server where the content discovery information is published.
* **ClientID**&mdash;the ID used to identify the client with the Authorization Server.
* **Client Secret**&mdash;a secret password that only the Client and Authorization Server know.

### Additional attribute mappings

You can configure your IdP to map several IdP attributes:

| IdP attribute | Run:ai required name | Description |
|--|--|--|
| User email | email | **(Mandatory)**  `e-mail` is the user identifier with Run:ai. |
| User role groups | GROUPS | (Optional) If exists, allows assigning Run:ai role groups via the IdP. The IdP attribute must be of a type of list of strings. See more below |
| Linux User ID | UID (configurable) | (Optional) If exists in IdP, allows Researcher containers to start with the Linux User `UID`. Used to map access to network resources such as file systems to users. The IdP attribute must be of integer type. |
| Linux Group ID | GID (configurable) | (Optional) If exists in IdP, allows Researcher containers to start with the Linux Group `GID`. The IdP attribute must be of integer type. |
| Linux Supplementary Groups | SUPPLEMENTARYGROUPS (configurable) | (Optional) If exists in IdP, allows Researcher containers to start with the relevant Linux supplementary groups. The IdP attribute must be of a type of list of integers. |
| User first name | firstName (configurable)| (Optional) Used as the first name showing in the Run:ai user interface. |
| User last name | lastName (configurable)| (Optional) Used as the last name showing in the Run:ai user interface |

### Example attribute mapping for Google Suite

 If you are using Google Suite as your Identity provider, to map custom attributes follow the [Google support article](https://support.google.com/a/answer/6208725?hl=en&fl=1). Use the **Whole Number** attribute type. For *Supplementary Groups* use the *Multi-value* designation.

## Step 1: UI Configuration

1. Open the Administration User interface.
2. Go to `Settings | General`.
3. Turn on `Login with SSO`.
4. Enter the administrator email.
5. Select the SSO protocol. Choose `Saml 2` or `Open ID Connect`.

!!! Note
    Use your SAML response file to fill in the fields below.

For `Saml 2`:

   1. In the `Metadata XML Url` field, enter the URL to the XML Metadata file.
   2. In the `GID` field, enter the GID.
   3. In the `GROUPS` field, enter the groups.
   4. In the `SUPPLEMENTARYGROUPS` field, enter the supplementary groups.
   5. In the `UID` field, enter the UID.
   6. In the `Logout URI` field, enter the desired URL logout page. If left empty, you will be redirected to the Run:ai portal.
   7.  Press `Save`.

For `Open ID Connect`:

:octicons-versions-24: Version 2.10 and later.

   1. In the `Discovery Document URL` field, enter the URL to the discovery document.
   2. In the `Client ID` field, enter the client ID.
   3. In the `Client Secret` field, enter the client secret.
   4. In the `GID` field, enter the GID.
   5. In the `GROUPS` field, enter the groups.
   6. In the `SUPPLEMENTARYGROUPS` field, enter the supplementary groups.
   7. In the `UID` field, enter the UID.
   8. In the `Logout URI` field, enter the desired URL logout page. If left empty, you will be redirected to the Run:ai portal.
   9.  Press `Save`.

Once you press `Save` you will receive a `Redirect URI` and an `Entity ID`. Both values must be set on the IdP side.

!!! Important Note
    Upon pressing `Save`, all existing users will be rendered non-functional, and the only valid user will be the *Administrator email* entered above. You can always revert by disabling *Login via SSO*.

### Test

Test Connectivity to Administration User Interface:

* Using an incognito browser tab and open the Run:ai user interface.
* Select the `Login with SSO` button.
* Provide the `Organization name` obtained above.
* You will be redirected to the IdP login page. Use the previously entered *Administrator* email* to log in.

### Troubleshooting

The SSO log in can be separated into two parts:

1. Run:ai redirects to the IdP (for example, Google) for login using a *SAML Request*.
2. Upon successful login, IdP redirects back to Run:ai with a *SAML Response*.

You can follow that by following the URL changes from [app.run.ai](https://app.run.ai) to the IdP provider (for example, [accounts.google.com](https://accounts.google.com)) and back to [app.run.ai](https://app.run.ai):

* If there is an issue on the IdP site (for example, `app_is_not_configred` error in Google), the problem is likely to be in the SAML Request.
* If the user is redirected back to Run:ai and something goes wrong, the problem is most likely in the SAML Response.

#### Troubleshooting SAML Request

* When logging in, have the Chrome network inspector open (Open by `Right-Click | Inspect` on the page, then open the network tab).
* After the IdP login screen shows, search in the network tab for an HTTP request showing the SAML Request. Depending on the IdP this would be a request to the IdP domain name. For example, accounts.google.com/idp?1234.
* When found, go to the "Payload" tab and copy the value of the SAML Request.
* Paste the value into a [SAML decoder](https://www.samltool.com/decode.php){target=_blank}. A typical response should look like this:

``` XML hl_lines="5 10"
<?xml version="1.0"?>
<samlp:AuthnRequest xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol" 
	xmlns="urn:oasis:names:tc:SAML:2.0:assertion" 
	xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion" 
		AssertionConsumerServiceURL="https://.../auth/realms/runai/broker/saml/endpoint" 
		Destination="https://accounts.google.com/o/saml2/idp?idpid=...." 
		ForceAuthn="false" ID="ID_66da617d-b862-4cca-9ei5-b727a920f3cb" 
		IssueInstant="2022-01-12T12:54:22.907Z" 
		ProtocolBinding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Version="2.0">
  <saml:Issuer>runai-jtqee5v8ob</saml:Issuer>
  <samlp:NameIDPolicy AllowCreate="true" Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"/>
</samlp:AuthnRequest>
```

Check in the above that:

* The content of the `<saml:Issuer>` tag is the same as `Entity ID` defined above.
* `AssertionConsumerServiceURL` is the same as the `Redirect URI`.

#### Troubleshooting SAML Response

* When logging in, have the Chrome network inspector open (Open by `Right-Click | Inspect` on the page, then open the network tab).
* Search for "endpoint".
* When found, go to the "Payload" tab and copy the value of the SAML Response.
* Paste the value into a [SAML decoder](https://www.samltool.com/decode.php){target=_blank}. A typical response should look like this:

``` XML hl_lines="3 36 46 50"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<saml2p:Response
	xmlns:saml2p="urn:oasis:names:tc:SAML:2.0:protocol" Destination="https://.../auth/realms/runai/broker/saml/endpoint" ID="_2d085ed4f45a7ab221a49e6c02e30cac" InResponseTo="ID_295f2723-79f5-4410-99b2-5f4acb2d4f8e" IssueInstant="2022-01-12T12:06:31.175Z" Version="2.0">
	<saml2:Issuer
		xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion">https://accounts.google.com/o/saml2?idpid=....
	</saml2:Issuer>
	<saml2p:Status>
		<saml2p:StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success"/>
	</saml2p:Status>
	<saml2:Assertion
		xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion" ID="_befe8441fa06594b365c516558dc5636" IssueInstant="2022-01-12T12:06:31.175Z" Version="2.0">
		<saml2:Issuer>https://accounts.google.com/o/saml2?idpid=...</saml2:Issuer>
		<ds:Signature
			xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
			<ds:SignedInfo>
				<ds:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
				<ds:SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"/>
				<ds:Reference URI="#_befe8441fa06594b365c516558dc5636">
					<ds:Transforms>
						<ds:Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
						<ds:Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/>
					</ds:Transforms>
					<ds:DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
					<ds:DigestValue>QxNCjtz9Gomv2qaz8Rb4X8cQJOSGkK+87CrHDkBPidM=</ds:DigestValue>
				</ds:Reference>
			</ds:SignedInfo>
			<ds:SignatureValue>...</ds:SignatureValue>
			<ds:KeyInfo>
				<ds:X509Data>
					<ds:X509SubjectName>ST=California,C=US,OU=Google For Work,CN=Google,L=Mountain View,O=Google Inc.</ds:X509SubjectName>
					<ds:X509Certificate>...</ds:X509Certificate>
				</ds:X509Data>
			</ds:KeyInfo>
		</ds:Signature>
		<saml2:Subject>
			<saml2:NameID Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent">john@example.com</saml2:NameID>
			<saml2:SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:bearer">
				<saml2:SubjectConfirmationData 
					InResponseTo="ID_295f2723-79f5-4410-99b2-5f4acb2d4f8e" 
					NotOnOrAfter="2022-01-12T12:11:31.175Z" 
					Recipient="https://.../auth/realms/runai/broker/saml/endpoint"/>
			</saml2:SubjectConfirmation>
		</saml2:Subject>
		<saml2:Conditions NotBefore="2022-01-12T12:01:31.175Z" NotOnOrAfter="2022-01-12T12:11:31.175Z">
			<saml2:AudienceRestriction>
				<saml2:Audience>runai-jtqee5v8ob</saml2:Audience>
			</saml2:AudienceRestriction>
		</saml2:Conditions>
		<saml2:AttributeStatement>
			<saml2:Attribute Name="email">
				<saml2:AttributeValue
					xmlns:xs="http://www.w3.org/2001/XMLSchema"
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="xs:anyType">john@example.com
				</saml2:AttributeValue>
			</saml2:Attribute>
			<saml2:Attribute Name="GID">
				<saml2:AttributeValue
					xmlns:xs="http://www.w3.org/2001/XMLSchema"
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="xs:anyType">8765
				</saml2:AttributeValue>
			</saml2:Attribute>
			<saml2:Attribute Name="SUPPLEMENTARYGROUPS">
				<saml2:AttributeValue
					xmlns:xs="http://www.w3.org/2001/XMLSchema"
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="xs:anyType">200
				</saml2:AttributeValue>
				<saml2:AttributeValue
					xmlns:xs="http://www.w3.org/2001/XMLSchema"
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="xs:anyType">300
				</saml2:AttributeValue>
				<saml2:AttributeValue
					xmlns:xs="http://www.w3.org/2001/XMLSchema"
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="xs:anyType">400
				</saml2:AttributeValue>
				<saml2:AttributeValue
					xmlns:xs="http://www.w3.org/2001/XMLSchema"
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="xs:anyType">100
				</saml2:AttributeValue>
			</saml2:Attribute>
			<saml2:Attribute Name="UID">
				<saml2:AttributeValue
					xmlns:xs="http://www.w3.org/2001/XMLSchema"
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="xs:anyType">4321
				</saml2:AttributeValue>
			</saml2:Attribute>
		</saml2:AttributeStatement>
		<saml2:AuthnStatement AuthnInstant="2022-01-12T12:06:30.000Z" SessionIndex="_befe8441fa06594b365c516558dc5636">
			<saml2:AuthnContext>
				<saml2:AuthnContextClassRef>urn:oasis:names:tc:SAML:2.0:ac:classes:unspecified</saml2:AuthnContextClassRef>
			</saml2:AuthnContext>
		</saml2:AuthnStatement>
	</saml2:Assertion>
</saml2p:Response>

```

Check in the above that:

* The content of the `<saml2:Audience>` tag is the same as `Entity ID` defined above.
* The `Destination` at the top is the same as the `Redirect URI`.
* The user email under the `<saml2:Subject>` tag is the same as the logged-in user.
* Make sure that under the `<saml2:AttributeStatement>` tag, there is an Attribute named `email` (lowercase). This attribute is mandatory.
* If other, optional attributes (such as UID, GID) are mapped, make sure they exist under `<saml2:AttributeStatement>` along with their respective values.

## Step 2: Cluster Authentication

Researchers should be authenticated when accessing the Run:ai GPU Cluster. To perform that, the Kubernetes cluster and the user's Kubernetes profile must be aware of the IdP. Follow the instructions [here](researcher-authentication.md). If you have followed these instructions in the past, you must **do so again** and replace the client-side and server-side configuration values with the new values as provided by on `General | Settings | Researcher Authentication`.

### Connectivity test

Test connectivity to Run:ai command-line interface:

* In the command-line, run `runai login`.
* You will receive a link that you must copy and open in your browser. Post login you will receive a verification code which you must paste into the shell window.
* Verify successful login.

## Step 3: UID/GID Mapping

Configure the IdP to add UID, GID, and Supplementary groups in the IdP.

### Mapping test

Test the mapping of UID/GID to within the container:

Submit a job with the flag `--run-as-user`, for example:

``` bash
runai submit -i ubuntu --interactive --run-as-user --attach -- bash
```

When a shell opens inside the container, run `id` and verify that UID, GID, and the supplementary groups are the same as in the user's profile in the organization's directory.

## Step 4: Adding Users

You can add additional users, by either:

1. Manually adding roles for each user.
2. Mapping roles to IdP groups.

The latter option is easier to maintain.

### Adding Roles for a User

* Go to `Settings | Users`.
* Select the `Users` button at the top.
* Map users as explained [here](../../admin-ui-setup/admin-ui-users.md).

### Mapping Role Groups

* Go to `Settings | Users`.
* Select the `Groups` button.
* Assuming you have mapped the IdP `Groups` attribute as described in the prerequisites section above, add a name of a group that has been created in the directory and create an equivalent Run:ai Group.
* If the role group contains the `Researcher` role, you can assign this group to a Run:ai Project. All members of the group will have access to the cluster.

!!! Note
    This feature also works in OpenShift. If you create a group in Run:ai with the same name as an OpenShift Group, the associated permissions will be applied to all users in the group.

## Logout URL

It is possible to configure the redirect URL when the session ends. If left empty, you will be redirected to the Run:ai portal. To perform this configuration please contact Run:ai customer support.

## Implementation Notes

Run:ai SSO does not support single logout. As such, logging out from Run:ai will not log you out from other systems.
