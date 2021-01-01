# Researcher REST API

The purpose of the Researcher REST API is to provide an easy-to-use web interface for submitting, listing and deleting Jobs. 

There are other APIs that each the same functionality. Specifically:

* If your code is script-based, you may consider using the [Run:AI command-line interface](../../Researcher/cli-reference/Introduction.md).
* You can communicate directly with the underlying Kubernetes infrastructure by [sending YAML files](../k8s-api/launch-job-via-yaml.md) or by using a variety of programming languages to send requests to Kubernetes. See [Submit a Run:AI Job via Kubernetes API](../k8s-api/launch-job-via-kubernetes-api.md).

## Getting the API endpoint

Run:

```
kubectl get svc -n runai | grep researcher-service
```

Use the IP Address and the port in conjunction

## Limitations

The Researcher REST API does not work when the [system is configured to authenticate Researchers](../../Administrator/Cluster-Setup/researcher-authentication.md). We are working to add this functionality.