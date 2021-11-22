---
title: Administrator REST API Overview
---
# Administrator REST API

The purpose of the Administrator  REST API is to provide an easy-to-use programming interface for administrative tasks.

## Document conventions

The rest of this documentation is using the [Open API specification](https://swagger.io/specification/) to describe the API. You can test the API within the document after logging in.


## Security and authentication

You must create a _Client Application_ to make API requests. Once you have an application, you can call an API to get a time-bound bearer token. You can use the token for subsequent API calls. See more information under [calling REST APIs](../rest-auth.md)


## Example Usage (Python)

See the [following](https://github.com/run-ai/docs/blob/master/examples/create-user-and-project.py){target=_blank} code for an example of how to use the Run:AI Administrator REST API to create a User and a Project 
