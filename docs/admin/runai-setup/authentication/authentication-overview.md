## Authentication Overview

To access Run:AI resources, you have to authenticate. The purpose of this document is to explain how authentication works at Run:AI.

## Authentication Endpoints

Generally speaking, there are two authentication endpoints:

* The Run:AI control plane.
* Run:AI GPU Clusters.

Both endpoints are accessible via APIs as well as a user interface. 


## Users

Out of the box, Run:AI provides a way to create users and associate them with access roles. 

It is also possible to configure Run:AI to connect to a company directory using the SAML protocol. For more information see [single sign-on](sso.md).

## Authentication Method

Both endpoints described above are protected via time-limited oauth2-like JWT authentication tokens.

There are two ways of getting a token:
* Using a user/password combination.
* Using [client applications](../../../developer/overview-developer.md) for API access.


## Authentication Flows

### Run:AI control plane

### Run:AI GPU Clusters
