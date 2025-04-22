# User Applications

This article explains the procedure to create your own user applications.

Applications are used for API integrations with Run:ai. An application contains a client ID and a client secret. With the client credentials, you can obtain a token as detailed in [API authentication](../developer/rest-auth.md) and use it within subsequent API calls.

!!!Note
    * All clusters in the tenant must be version 2.20 and onward.
    * The token obtained through user applications assumes the roles and permissions of the user.

## Creating Applications

To create an application:

1. Click the user icon, then select Settings
2. Click **+APPLICATION**  
3. Enter the application’s **name**  
4. Click **CREATE**  
5. Copy the **Client ID** and **Client secret** and store securely
6. Click **DONE**

You can create up to 20 user applications.

!!!Note
    The client secret is visible only at the time of creation. It cannot be recovered but can be regenerated.


## Regenerating client secret

To regenerate a client secret:

1. Locate the application you want to regenerate its client secret 
2. Click **Regenerate client secret**  
3. Click **REGENERATE**  
4. Copy the **New client secret** and store it securely
5. Click **DONE**

!!!Warning
    Regenerating a client secret revokes the previous one.

## Deleting an application

1. Locate the application you want to delete  
2. Click on the trash icon  
3. On the dialog, click **DELETE** to confirm 

## Using API

Go to the [User Applications](https://api-docs.run.ai/#tag/User-Applications) API reference to view the available actions


