
# Calling REST API

The following document explain how to get the credentials required to call the Run:AI REST API


## Create a Client Application

* Open the Run:AI Administrator User interface.
* Go to `Application | Settings`
* Create a new Application. 
* Set the required roles:
    * Select `Researcher` to manipulate _Jobs_ using the [Researcher REST API](researcher-rest-api/overview.md).
    * Select `Editor` to manipulate _Projects_ and _Departments_ using the [Administrator REST API](admin-rest-api/overview.md).
    * Select `Administrator` to manipulate _Users_, _Tenant Settings_ and _Clusters_ using the [Administrator REST API](admin-rest-api/overview.md).
* Copy the `<CLIENT-ID>` and `<CLIENT-SECRET>` to be used below
* Copy the domain of the web page to be used as `<COMPANY-URL>` below. This can be [app.run.ai](https://app.run.ai){target=_blank} for SaaS installation or a custom URL for Self-hosted installations

!!! Important Note
    Creating Client Application tokens is only available in Self-hosted installation and in SaaS installations where the tenant has been created post November 2021. If you do not see the `Settings | Application` area, please contact Run:AI customer suspport.  

## Request a Token

Use the above parameters to get a temporary token to access Run:AI. 

### Example POST to get token URL

=== "cURL"
    ```
    curl --request POST 'https://<COMPANY-URL>/auth/realms/runai/protocol/openid-connect/token' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'grant_type=client_credentials' \
    --data-urlencode 'scope=openid' \
    --data-urlencode 'response_type=id_token' \
    --data-urlencode 'client_id=<CLIENT-ID>' \
    --data-urlencode 'client_secret=<CLIENT-SECRET>'
    ```

=== "Python"
    ``` python
    import http.client

    conn = http.client.HTTPSConnection("")
    payload = "grant_type=client_credentials&client_id=<CLIENT_ID>&client_secret=<CLIENT_SECRET>"
    headers = { 'content-type': "application/x-www-form-urlencoded" }
    conn.request("POST", "/<COMPANY-URL>/oauth/token", payload, headers)

    res = conn.getresponse()
    data = res.read()
    print(data.decode("utf-8"))
    ```

### Response 

If all goes well, you'll receive an HTTP 200 response with a payload containing access_token, token_type, and expires_in values:

``` JSON
{
  "access_token": "AyPrg....frgfg",
  "expires_in": 36000,
   ....
  "token_type": "bearer"
}
```

## Call an API

To call your API from the M2M application, the application must pass the retrieved `access_token` as a Bearer token in the Authorization header of your HTTP request.

For example, if you have an Administrator role, you can get a list of clusters by running:

=== "cURL"
    ```
    curl 'https://<COMPANY-URL>/v1/k8s/clusters' \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer <ACCESS-TOKEN>' 
    ```

=== "Python"
    ``` python
    import http.client

    conn = http.client.HTTPSConnection("https://<COMPANY-URL>")
    headers = {
        'content-type': "application/json",
        'authorization': "Bearer <ACCESS-TOKEN>"
        }
    conn.request("GET", "/v1/k8s/clusters", headers=headers)

    res = conn.getresponse()
    data = res.read()

    print(data.decode("utf-8"))
    ```
(replace `<ACCESS-TOKEN>` with the bearer token from above).
