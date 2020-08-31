# Use OpenID Connect, LDAP or SAML for Authentication and Authorization

## Introduction

Run:AI uses its a mechanism for authentication and authorization which is based on a third-party (<a href="https://auth0.com/" target="_self">auth0</a>). This is good as a baseline, but for enterprises, such a scheme is not scalable. For an enterprise, keeping separate Users and Roles systems requires manual work, is error-prone, and increases the attack vector.

As such, organizations typically use an organizational directory to store users and roles, allowing a single point of change for multiple systems

Run:AI uses the _OpenID Connect_ protocol to allow organizations to integrate their authentication & authorization system with Run:AI. With such a connector, Run:AI no longer has a standalone login page. instead, it differs to the organization's directory for authenticating users and for retrieving their roles (authorization)

OpenID provides simple wrappers for LDAP and SAML. LDAP and SAML are similar protocols. Most notably, LDAP which is the underlying protocol for Microsoft Active Directory as well as other directories.

## OpenID Connect Configuration

With Run:AI OpenID Connect you synchronize:

*   Users
*   Users' groups

The Run:AI login page is app.run.ai and is the point of access to all Run:AI customers using the default login mechanism. When enabling the Run:AI OpenID connector, your company will be allocated a subdomain e.g. _company.app.run.ai._

When the user is not yet authenticated, company.app.run.ai will automatically redirect to your generic company's authentication page. Post authentication, the user will be redirected back to company.app.run.ai and can start working.

### Installation and Configuration

Your company will need to create an OpenID Connect provider. We recommend <a href="https://github.com/dexidp/dex" style="background-color: #ffffff; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif; font-size: 15px;" target="_self">dex.</a>

After installing dex, you will want to create a _client_ and perform the following configuration:

*   Enter a _redirect URL_ which has been provided to you by Run:AI
*   Generate a unique _secret_. The secret should be sent to Run:AI
*   If you are using LDAP or SAML, configure the relevant connector for dex
*   Locate the authentication _redirection URL_. The redirection URL should to be sent to Run:AI
*   Create a _public key_ in order for Run:AI to be able validate OAuth tokens. The public key should be sent to Run:AI

### Users and Roles

Now, go to the authorization page on Run:AI app and configure the required authorization using either specific users or groups in your organization.

 