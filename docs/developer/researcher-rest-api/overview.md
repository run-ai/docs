
---
title: Researcher REST API Overview
---
# Researcher REST API

The purpose of the Researcher REST API is to provide an easy-to-use programming interface for submitting, listing, and deleting Jobs. 

There are other APIs that provide the same functionality. Specifically:

* If your code is script-based, you may consider using the [Run:AI command-line interface](../../Researcher/cli-reference/Introduction.md).
* You can communicate directly with the underlying Kubernetes infrastructure by [sending YAML files](../k8s-api/launch-job-via-yaml.md) or by using a variety of programming languages to send requests to Kubernetes. See [Submit a Run:AI Job via Kubernetes API](../k8s-api/launch-job-via-kubernetes-api.md).

## Endpoint URL for API

The Researcher REST API is cluster-specific in the sense that if you have multiple GPU clusters, you will have a separate URL per cluster.
To find this `<CLUSTER-ENDPOINT>`, do one of the following:

* Go to the cluster command-line and run: `kubectl get ingress -n runai`.
* In the Administrator user interface, go to `Clusters`. Each cluster will have a separate URL.

## Authentication

* By default, researcher APIs are unauthenticated. To protect researcher API (and the researchers themselves), you must [configure researcher authentication](../../admin/runai-setup/config/researcher-authentication.md).
* Once configured, you must create a _Client Application_ to make API requests. 
* Using the client application and secret, you can call an API to get a time-bound bearer token. You can use the token for subsequent API calls. 

## Example

Get all the jobs for a project named `team-a`: 

``` bash
curl  'https://<CLUSTER-ENDPOINT>/researcher/api/v1/job/team-a' \
  -H 'accept: application/json' \
--header 'Authorization: Bearer <access-token>' 
```


## Researcher API Documentation

The Researcher API provides the following functionality:

* Submit a new Job
* List jobs for specific Projects.
* Delete an existing Job
* Get a list of Projects for which you have access to


To review API documentation:

* Open the Run:AI user interface
* Go to `Clusters`
* Locate your cluster and browse to `https://<cluster-url>/researcher/api/docs'.

API documentation is still work-in-progress and will be updated soon. 


The document uses the [Open API specification](https://swagger.io/specification/) to describe the API. You can test the API within the document after creating and saving a token.