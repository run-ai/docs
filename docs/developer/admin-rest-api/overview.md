---
title: Administrator REST API Overview
---
# Administrator REST API

The purpose of the Administrator REST API is to provide an easy-to-use programming interface for administrative tasks.


## Endpoint URL for API


The domain used for Administrator REST APIs is the same domain used to browse for the Run:ai User Interface. Either `<company>.run.ai`, or `app.run.ai` for older tenants or a custom URL used for Self-hosted installations.


## Authentication

* Create a _Client Application_ to make API requests. Use the client application and secret, to obtain a time-bound bearer token (`<ACCESS-TOKEN>`). For details, see [Calling REST APIs](../rest-auth.md).
* Use the token for subsequent API calls. 


## Example Usage 

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


For an additional example, see the [following](https://github.com/run-ai/docs/blob/master/examples/create-user-and-project.py){target=_blank} code. It is an example of how to use the Run:ai Administrator REST API to create a User and a Project and set the User to the Project.  


## Administrator API Documentation

The Administrator API provides the developer interfaces for getting and manipulating the Run:ai metadata objects such as Projects, Departments, Clusters, and Users.


Detailed API documentation can be found under [https://app.run.ai/api/docs](https://app.run.ai/api/docs){target=_blank}. The document uses the [Open API specification](https://swagger.io/specification/) to describe the API. You can test the API within the document after creating a token.


[Administrator API Documentation](https://app.run.ai/api/docs){target=_blank .md-button .md-button--primary }
