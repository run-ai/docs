
---
title: Researcher REST API Overview
---
# Researcher REST API


!!! Warning
    Researcher Kubernetes API is deprecated. See [Cluster API](../../cluster-api/workload-overview-dev.md) for its replacement.
    
    
The purpose of the Researcher REST API is to provide an easy-to-use programming interface for submitting, listing, and deleting Jobs. 

There are other APIs that provide the same functionality. Specifically:

* If your code is script-based, you may consider using the [Run:ai command-line interface](../../../Researcher/cli-reference/Introduction.md).
* You can communicate directly with the underlying Kubernetes infrastructure by [sending YAML files](../k8s-api/launch-job-via-yaml.md) or by using a variety of programming languages to send requests to Kubernetes. See [Submit a Run:ai Job via Kubernetes API](../k8s-api/launch-job-via-kubernetes-api.md).

The Researcher REST API is cluster-specific in the sense that if you have multiple GPU clusters, you will have a separate URL per cluster.
This `<CLUSTER-ENDPOINT>` can be found in the Run:ai User Interface, under `Clusters`. Each cluster will have a separate URL.


## Authentication

* By default, researcher APIs are unauthenticated. To protect researcher API, you must [configure researcher authentication](../../../admin/runai-setup/authentication/researcher-authentication.md).
* Once configured, you must create a _Client Application_ to make API requests. Use the client application and secret, to obtain a time-bound bearer token (`<ACCESS-TOKEN>`). For details, see [Calling REST APIs](../../rest-auth.md).
* Use the token for subsequent API calls. 

## Example

Get all the jobs for a project named `team-a`: 

``` bash
curl  'https://<CLUSTER-ENDPOINT>/researcher/api/v1/jobs/team-a' \
  -H 'accept: application/json' \
--header 'Authorization: Bearer <ACCESS-TOKEN>' 
```


## Researcher API Scope

The Researcher API provides the following functionality:

* Submit a new Job
* List jobs for specific Projects.
* Delete an existing Job
* Get a list of Projects for which you have access to


##  Researcher API Documentation

To review API documentation:

* Open the Run:ai user interface
* Go to `Clusters`
* Locate your cluster and browse to `https://<cluster-url>/researcher/api/docs`.
* When using the `Authenticate` button, add `Bearer <ACCESS TOKEN>` (simply adding the access token will not work).

The document uses the [Open API specification](https://swagger.io/specification/) to describe the API. You can test the API within the document after creating and saving a token.