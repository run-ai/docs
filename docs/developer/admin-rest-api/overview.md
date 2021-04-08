# Administrator REST API

The purpose of the Administrator  REST API is to provide an easy-to-use programming interface for administrative tasks.

## Document conventions

The rest of this documentation is using the [Open API specification](https://swagger.io/specification/) to describe the API. You can test the API within the document after logging in.


## Security and authentication

You must be a verified user to make API requests. You can authorize against the API using a dedicated user and password provided by Run:AI Customer Support. Note that the regular user will not suffice for API access. 

Once authenticated, you will receive a token (_bearer_) which you should use in all further API calls. 

Subsequent API calls would be made with the Header: `authorization: Bearer <token>`


## Example Usage (Python)

See the [following](){target=_blank} code for an example of how to use the Run:AI Administrator REST API to create a User and a Project 
