# Administrator REST API

The purpose of the Administrator  REST API is to provide an easy-to-use programming interface for administrative tasks.

## Document conventions

Endpoints are described with an HTTP method and a path. Example:

`POST  https://app.run.ai/v1/k8s/project/`


Curly braces, {}, in the path indicate a placeholder value that you must replace. Example:

`GET https://app.run.ai/v1/k8s/project/{project_id}`

The body of requests and responses for each resource is described in a JSON format table. Each table lists a resource's properties, their data types, whether or not they are read-only, whether or not they are required, and a description.


## Security and authentication

You must be a verified user to make API requests. You can authorize against the API using a dedicated user and password provided by Run:AI Customer Support.

Once authenticated, you will receive a token which you should use in all further API calls. 

Logging in:

``` shell
curl --request POST 'https://app.run.ai:443/v1/k8s/auth/login' \
--header 'Content-Type: application/json' \
--data-raw '{
	"email": "usrename",
	"password": "password"
}'
```

Example Response

``` json
{
    "tenant_id": 20,
    "access_token": "<token>",
    "token_type": "bearer",
    "expires_in": 86400
}
```

Future API calls would be made with the Header: `authorization: Bearer <token>`
