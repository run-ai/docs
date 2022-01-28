---
title: Administrator REST API Overview
---
# Administrator REST API

The purpose of the Administrator REST API is to provide an easy-to-use programming interface for administrative tasks.


## Endpoint URL for API

The endpoint URL for APIs is `<COMPANY-URL>` as described in [calling REST APIs](../rest-auth.md#create-a-client-application).

## Authentication

See [calling REST APIs](../rest-auth.md) on how to get an `access token`.



## Example Usage (Python)



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


For an additional example, see the [following](https://github.com/run-ai/docs/blob/master/examples/create-user-and-project.py){target=_blank} code. It is an example of how to use the Run:AI Administrator REST API to create a User and a Project and set the User to the Project.  


## Administrator API Documentation

The Researcher API provides the developer interfaces for getting and manipulating the Run:AI metadata objects such as Projects, Departments, Clusters, and Users.


Detailed API documentation can be found under [https://app.run.ai/api/docs](https://app.run.ai/api/docs){target=_blank}. The document uses the [Open API specification](https://swagger.io/specification/) to describe the API. You can test the API within the document after creating a token.


[Administrator API Documentation](https://app.run.ai/api/docs){target=_blank .md-button .md-button--primary }
