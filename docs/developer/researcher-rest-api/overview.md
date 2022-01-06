
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

See [calling REST APIs](../rest-auth.md) on how to get an `access token`.

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


Detailed API documentation can be found under [https://app.run.ai/researcher/api/docs](https://app.run.ai/researcher/api/docs){target=_blank}. The document uses the [Open API specification](https://swagger.io/specification/) to describe the API. You can test the API within the document after creating a token.

Different clusters can be of different versions, to see version-specific API documentation, go to `Settings | Clusters`, locate your cluster, and select `Show API Documentation`.

[Researcher API Documentation](https://app.run.ai/researcher/api/docs){target=_blank .md-button .md-button--primary }