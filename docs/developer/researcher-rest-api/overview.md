# Researcher REST API

The purpose of the Researcher REST API is to provide an easy-to-use web interface for submitting, listing and deleting Jobs. 

There are other APIs that each the same functionality. Specifically:

* If your code is script-based, you may consider using the [Run:AI command-line interface](../../Researcher/cli-reference/Introduction.md).
* You can communicate directly with the underlying Kubernetes infrastructure by [sending YAML files](../k8s-api/launch-job-via-yaml.md) or by using a variety of programming languages to send requests to Kubernetes. See [Submit a Run:AI Job via Kubernetes API](../k8s-api/launch-job-via-kubernetes-api.md).

## Finding the API Endpoint URL

The URL is composed of an IP address part and a port part (`<IP-ADDRESS>:<PORT>`). To find the endpoint, run:

``` bash
echo "http://$(kubectl get nodes -o=jsonpath='{.items[0].status.addresses[0].address}'):$(kubectl get services -n runai -o=jsonpath='{.items[?(@.metadata.name == "researcher-service")].spec.ports[0].nodePort}')"
```

## Limitations

The Researcher REST API does not work when the [system is configured to authenticate Researchers](../../Administrator/Cluster-Setup/researcher-authentication.md). We are working to add this functionality.
