
# API Authentication

The following document explains how to authenticate with Run:ai APIs.

Run:ai APIs are accessed using *bearer tokens*. A token can be obtained in several ways:

* When logging into the Run:ai user interface, you enter an email and password (or authenticated via single sign-on) which are used to obtain a token.
* When using the Run:ai command-line, you use a Kubernetes profile and are authenticated by pre-running `runai login` (or oc login with OpenShift). The command attaches a token to the profile and allows you access to Run:ai functionality.
* When using Run:ai APIs, you need to create an **Application** through the Run:ai user interface. The Application is created with specific roles and contains a *secret*. Using the secret you can obtain a token and use it within subsequent API calls.

## Create a Client Application

* Open the Run:ai Run:ai User Interface.
* Go to `Settings & Tools`, `Application` and create a new Application.
* Copy the `<APPLICATION>` and `<SECRET KEY>` to be used below


### Access rules for the Application

For you API requests to be accepted, you will need to set access rules for the application.
To assign roles to an application, see [Create or Delete rules](../admin/authentication/accessrules.md).

Use the [Roles](../admin/authentication/roles.md#roles-in-runai) table to assign the correct roles to the application.

## Request an API Token

Use the above parameters to get a temporary token to access Run:ai as follows.

### Example command to get an API token

Replace `<COMPANY-URL>` below with:

  * For SaaS installations use `<company>.run.ai`

  * For self-hosted use the Run:ai user interface URL.

=== "cURL"
    ``` bash
        curl  -X POST \
          'https://<runai_url>/api/v1/token' \
          --header 'Accept: */*' \
          --header 'Content-Type: application/json' \
          --data-raw '{
          "grantType":"app_token",
          "AppId":"<APPLICATION NAME>",
          "AppSecret" : "<SECRET KEY>"
        }'
    ```

=== "Python"
    ``` python
        import requests
        import json
        reqUrl = "https://cp-590d-run-13764-kc-upgrade.runailabs.com/api/v1/token"
        headersList = {
         "Accept": "*/*",
         "Content-Type": "application/json"
        }
        payload = json.dumps({
          "grantType":"app_token",
          "AppId":"<APPLICATION NAME>",
          "AppSecret" : "<SECRET KEY>"
        })
        response = requests.request("POST", reqUrl, data=payload,  headers=headersList)
        print(response.text)
    ```

### Response

The API response will look as follows:

``` JSON title="API Response"
{
  "accessToken": "<TOKEN>", 
}
```

To call Run:ai REST APIs, the application must pass the retrieved `accessToken` as a *Bearer token* in the Authorization header of your HTTP request.


