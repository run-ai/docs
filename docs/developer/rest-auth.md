
# API Authentication

There are two equivalent methods for call Run:ai APIs:

* REST APIs
* Kubernetes APIs. Using `kubectl apply` on YAML files, or calling Kubernetes directly via code.

The following document explains how to get the credentials required to call Run:ai __REST APIs__. By contrast, Run:ai Kubernetes APIs, use the Kubernetes profile and are authenticated by pre-running `runai login` (or oc login with OpenShift).


## Create a Client Application

* Open the Run:ai Run:ai User Interface.
* Go to `Settings | Application`
* Create a new Application. 
* Set the required roles:
    * Select `Researcher` to manipulate _Jobs_ using the [Researcher REST API](researcher-rest-api/overview.md). To provide access to a specific project, you will also need to go to `Application | Projects` and provide the Application with access to specific projects. 
    * Select `Editor` to manipulate _Projects_ and _Departments_ using the [Administrator REST API](admin-rest-api/overview.md). 
    * Select `Administrator` to manipulate _Users_, _Tenant Settings_ and _Clusters_ using the [Administrator REST API](admin-rest-api/overview.md).
* Copy the `<APPLICATION-NAME>` and `<CLIENT-SECRET>` to be used below
* `<COMPANY-URL>` is `app.run.ai` for SaaS installations (not `<company>.run.ai`) or the Run:ai user interface URL for Self-hosted installations.
* Go to `Settings | General`, under `Researcher Authentication` copy `<REALM>`.

!!! Important Note
    Creating Client Application tokens is only available with SaaS installations where the tenant has been created post-January 2022 or any Self-hosted installation. If you are an administrator but do not see the `Settings | Application` area, please contact Run:ai customer support.  

## Request an API Token

Use the above parameters to get a temporary token to access Run:ai as follows. 

### Example command to get an API token 

=== "cURL"
    ```
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

``` JSON
{
  "access_token": "...",
  "expires_in": 36000,
   ....
  "token_type": "bearer"
}
```

## Call an API

To call APIs, the application must pass the retrieved `access_token` as a Bearer token in the Authorization header of your HTTP request.

* To retrieve and manipulate jobs, use the [Researcher REST API](researcher-rest-api/overview.md). Researcher API works at the cluster level and you will have different endpoints for different clusters. 
* To retrieve and manipulate other metadata objects, use the [Administrator REST API](admin-rest-api/overview.md). Administrator API works at the control-plane (backend) level and you have a single endpoint for all clusters. 

