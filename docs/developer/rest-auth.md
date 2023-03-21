
# API Authentication


The following document explains how to authenticate with Run:ai APIs. 

Run:ai APIs are accessed using _bearer tokens_. A token can be obtained in several ways:

* When logging into the Run:ai user interface, you enter an email and password (or authenticated via single sign-on) which are used to obtain a token.
* When using the Run:ai command-line, you use a Kubernetes profile and are authenticated by pre-running `runai login` (or oc login with OpenShift). The command attachs a token to the profile and allows you access to Run:ai functionality.
* When using Run:ai APIs, you need to create an __Application__ through the Run:ai user interface. The Application is created with specific roles and contains a _secret_. Using the secret you can obtain a token and use it within subsequent API calls.


## Create a Client Application

* Open the Run:ai Run:ai User Interface.
* Go to `Settings | Application` and create a new Application. 
* Set the required roles:
    * Select `Researcher` to manipulate _Jobs_ using the [Cluster API](cluster-api/submit-rest.md). To provide access to a specific project, you will also need to go to `Application | Projects` and provide the Application with access to specific projects. 
    * Select `Editor` to manipulate _Projects_ and _Departments_ using the [Administrator REST API](admin-rest-api/overview.md). 
    * Select `Administrator` to manipulate _Users_, _Tenant Settings_ and _Clusters_ using the [Administrator REST API](admin-rest-api/overview.md).
* Copy the `<APPLICATION-NAME>` and `<CLIENT-SECRET>` to be used below
* Go to `Settings | General`, under `Researcher Authentication` copy `<REALM>`.

!!! Important Note
    Creating Client Application tokens is only available with SaaS installations where the tenant has been created post-January 2022 or any Self-hosted installation. If you are an administrator but do not see the `Settings | Application` area, please contact Run:ai customer support.  

## Request an API Token

Use the above parameters to get a temporary token to access Run:ai as follows. 

### Example command to get an API token 

Replace `<COMPANY-URL>` below with  `app.run.ai` for SaaS installations (not `<company>.run.ai`) or the Run:ai user interface URL for Self-hosted installations.

=== "cURL"
    ``` bash
    curl -X POST 'https://<COMPANY-URL>/auth/realms/<REALM>/protocol/openid-connect/token' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'grant_type=client_credentials' \
    --data-urlencode 'scope=openid' \
    --data-urlencode 'response_type=id_token' \
    --data-urlencode 'client_id=<APPLICATION-NAME>' \
    --data-urlencode 'client_secret=<CLIENT-SECRET>'
    ```

=== "Python"
    ``` python
    import http.client

    conn = http.client.HTTPSConnection("")
    payload = "grant_type=client_credentials&client_id=<APPLICATION-NAME>&client_secret=<CLIENT_SECRET>"
    headers = { 'content-type': "application/x-www-form-urlencoded" }
    conn.request("POST", "/<COMPANY-URL>/auth/realms/<REALM>/protocol/openid-connect/token", payload, headers)

    res = conn.getresponse()
    data = res.read()
    print(data.decode("utf-8"))
    ```

### Response 

The API response will look as follows: 

``` JSON title="API Response"
{
  "access_token": "...", // (1)
  "expires_in": 36000,
   ....
  "token_type": "bearer"
  "id_token": "..."
}
```

1. Use the `id_token` as the Bearer token below.


To call APIs, the application must pass the retrieved `access_token` as a Bearer token in the Authorization header of your HTTP request.

* To retrieve and manipulate Workloads, use the [Cluster API](cluster-api/workload-overview-dev.md). Researcher API works at the cluster level and you will have different endpoints for different clusters. 
* To retrieve and manipulate other metadata objects, use the [Administrator REST API](admin-rest-api/overview.md). Administrator API works at the control-plane level and you have a single endpoint for all clusters. 

