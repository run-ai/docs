
---
title: Researcher REST API Overview
---
# Researcher REST API

The purpose of the Researcher REST API is to provide an easy-to-use programming interface for submitting, listing, and deleting Jobs. 

There are other APIs that provide the same functionality. Specifically:

* If your code is script-based, you may consider using the [Run:AI command-line interface](../../Researcher/cli-reference/Introduction.md).
* You can communicate directly with the underlying Kubernetes infrastructure by [sending YAML files](../k8s-api/launch-job-via-yaml.md) or by using a variety of programming languages to send requests to Kubernetes. See [Submit a Run:AI Job via Kubernetes API](../k8s-api/launch-job-via-kubernetes-api.md).

## Endpoint URL for API

The Researcher REST API is cluster-specific in the sense that if you have multiple GPU clustesr, you will have a separate URL per cluster.
To find the Base URL, go to the cluster command-line and run:

```
kubectl get ingress -n runai
```

## Authentication

* By default, researcher APIs are unauthenticated. To protect researcher API (and the researchers themselves), you must [configure researcher authentication](../../admin/runai-setup/advanced/researcher-authentication.md).
* Once configured, you must create a _Client Application_ to make API requests. 
* Using the client application and secret, you can call an API to get a time-bound bearer token. You can use the token for subsequent API calls. 

See more information under [calling REST APIs](../rest-auth.md)


## APIs

The Researcher API provides the following functionality:

* Submit a new Job
* List jobs for specific Projects.
* Delete an existing Job
* Get a list of Projects for which you have access to

Detailed API documentation can be found under `<BASE-URL>/api`

