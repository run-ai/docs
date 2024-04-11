
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

* Set the required roles:
    * Select `Researcher` to manipulate *Jobs* using the [Cluster API](cluster-api/submit-rest.md). To provide access to a specific project, you will also need to go to `Application | Projects` and provide the Application with access to specific projects.
    * Select `Editor` to manipulate *Projects* and *Departments* using the [Administrator REST API](admin-rest-api/overview.md).
    * Select `Administrator` to manipulate *Users*, *Tenant Settings* and *Clusters* using the [Administrator REST API](admin-rest-api/overview.md).

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

To call APIs, the application must pass the retrieved `accessToken` as a *Bearer token* in the Authorization header of your HTTP request.

* To retrieve and manipulate Workloads, use the [Cluster API](cluster-api/workload-overview-dev.md). Researcher API works at the cluster level and you will have different endpoints for different clusters.
* To retrieve and manipulate other metadata objects, use the [Administrator REST API](admin-rest-api/overview.md). Administrator API works at the control-plane level and you have a single endpoint for all clusters.
