
---
title: Researcher REST API  Overview
---
# Researcher REST API

The purpose of the Researcher REST API is to provide an easy-to-use programming interface for submitting, listing, and deleting Jobs. 

There are other APIs that provide the same functionality. Specifically:

* If your code is script-based, you may consider using the [Run:AI command-line interface](../../Researcher/cli-reference/Introduction.md).
* You can communicate directly with the underlying Kubernetes infrastructure by [sending YAML files](../k8s-api/launch-job-via-yaml.md) or by using a variety of programming languages to send requests to Kubernetes. See [Submit a Run:AI Job via Kubernetes API](../k8s-api/launch-job-via-kubernetes-api.md).

## Find the API Endpoint URL

If your installation is _Self Hosted_, your organization has created a DNS entry for the researcher service. If your installation is _SaaS_ based, then the URL is composed of an IP address part and a port part (`<IP-ADDRESS>:<PORT>`). To find the endpoint, run:

``` bash
echo "http://$(kubectl get nodes -o=jsonpath='{.items[0].status.addresses[0].address}'):$(kubectl get services -n runai -o=jsonpath='{.items[?(@.metadata.name == "researcher-service")].spec.ports[0].nodePort}')"
```

## Authentication

By default, the Researcher REST API is not authenticated. When the system is configured [ to authenticate Researchers](../../admin/runai-setup/cluster-setup/researcher-authentication.md), you will need to add a token. To get the token, [login to Run:AI](../../../Researcher/cli-reference/runai-login) via the command-line, then retrieve the token from the Kubernetes configuration file. The token is time-based. 