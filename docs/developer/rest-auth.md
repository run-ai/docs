
# API Authentication


The following document explains how to authenticate with Run:ai APIs. 

Run:ai APIs are accessed using _bearer tokens_. A token can be obtained in several ways:

* When logging into the Run:ai user interface, you enter an email and password (or authenticated via single sign-on) which are used to obtain a token.
* When using the Run:ai command-line, you use a Kubernetes profile and are authenticated by pre-running `runai login` (or oc login with OpenShift). The command attaches a token to the profile and allows you access to Run:ai functionality.
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
    import requests
    import json

    COMPANY_URL = "app.run.ai"
    COMPANY_REALM = "acme"
    APPLICATION_NAME = "app-name"
    CLIENT_SECRET = "secret"

    def  runai_authenticate():    
        url = "https://" + COMPANY_URL + "/auth/realms/" +  \
            COMPANY_REALM + "/protocol/openid-connect/token"

        payload = 'grant_type=client_credentials&scope=openid&response_type=id_token&client_id=' + \
            APPLICATION_NAME + '&client_secret=' + CLIENT_SECRET
        headers = {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
        
        response = requests.request("POST", url, headers=headers, data=payload)
        if response.status_code //100 == 2:
            j = json.loads(response.text)
            return j["access_token"]
        else:
            print(json.dumps(json.loads(response.text), sort_keys=True, indent=4, separators=(",", ": ")))
            return
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

