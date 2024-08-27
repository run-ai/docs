# Run:ai REST API

The purpose of the Run:ai REST API is to provide an easy-to-use programming interface for administrative tasks.

## Endpoint URL for API

The domain used for Run:ai REST APIs is the same domain used to browse for the Run:ai User Interface. Either `<company>.run.ai`, or `app.run.ai` for older tenants or a custom URL used for Self-hosted installations.

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

For an additional example, see the [following](https://github.com/run-ai/docs/blob/master/examples/create-user-and-project.py){target=_blank} code. It is an example of how to use the Run:ai REST API to create a User and a Project and set the User to the Project.  

## Run:ai REST API Documentation

The Run:ai REST API offers developers a robust interface for interacting with and managing Run:ai metadata objects, including Projects, Departments, Clusters, and Users.

Public API documentation is available at [api-docs.run.ai](https://api-docs.run.ai){target=_blank}. For self-hosted deployments, access the documentation at `https://<control-plane-url>/api/docs`.

[View Documentation](https://api-docs.run.ai){target=_blank .md-button .md-button--primary}
