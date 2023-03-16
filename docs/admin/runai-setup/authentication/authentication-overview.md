## Authentication Overview

To access Run:ai resources, you have to authenticate. The purpose of this document is to explain how authentication works at Run:ai.

## Authentication Endpoints

Generally speaking, there are two authentication endpoints:

* The Run:ai control plane.
* Run:ai GPU clusters.

Both endpoints are accessible via APIs as well as a user interface. 


## Identity Service

Run:ai includes an internal identity service. The identity service ensures users are who they claim to be and gives them the right kind of access to Run:ai.
 
## Users

Out of the box, The Run:ai identity service provides a way to create users and associate them with access roles. 

It is also possible to configure the Run:ai identity service to connect to a company directory using the SAML protocol. For more information see [single sign-on](sso.md).

## Authentication Method

Both endpoints described above are protected via time-limited oauth2-like JWT authentication tokens.

There are two ways of getting a token:

* Using a user/password combination.
* Using [client applications](../../../developer/overview-developer.md) for API access.


## Authentication Flows

### Run:ai control plane

You can use the Run:ai user interface to provide user/password. These are validated against the identity service. Run:ai will return a token with the right access rights for continued operation. 

You can also use a client application to get a token and then connect directly to the [administration API endpoint](../../../developer/admin-rest-api/overview.md). 
### Run:ai GPU Clusters

The Run:ai GPU cluster is a _Kubernetes_ cluster. All communication into Kubernetes flows through the [Kubernetes API server](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/){target=_blank}.

To facilitate authentication via Run:ai the Kubernetes API server must be configured to use the Run:ai identity service to validate authentication tokens. For more information on how to configure the Kubernetes API server see _Kubernetes configuration_ under [researcher authentication](researcher-authentication.md#mandatory-kubernetes-configuration).

## Inactivity timeout

:octicons-versions-24: Version 2.10 and later.

Run:ai session should timeout after 1 hour of inactivity.

!!! Note
    Timeout settings are configured in minutes.

To configure the inactivity timeout:
1. Open `Settings | General`.
2. Set the inactivity timeout in minutes. (Default is 60)

## See also

* To configure authentication for researchers [researcher authentication](researcher-authentication.md).
* To configure single sign-on, see [single sign-on](sso.md).
