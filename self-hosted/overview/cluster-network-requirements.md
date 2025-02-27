# Cluster network requirements

The following network requirements are for the Run:ai cluster installation and usage.

## External access

Set out below are the domains to whitelist and ports to open for installation, upgrade, and usage of the application and its management.

{% hint style="info" %}
Ensure the inbound and outbound rules are correctly applied to your firewall.
{% endhint %}

### Inbound rules

To allow your organization’s Run:ai users to interact with the cluster using the [Run:ai Command-line interface](broken-reference), or access specific UI features, certain inbound ports need to be open.

| Name           | Description                     | Source  | Destination   | Port |
| -------------- | ------------------------------- | ------- | ------------- | ---- |
| Run:ai cluster | Run:ai cluster HTTPS entrypoint | 0.0.0.0 | all k8s nodes | 443  |

### Outbound rules

For the Run:ai cluster installation and usage, certain **outbound** ports must be open.

| Name                      | Description                | Source              | Destination                                          | Port |
| ------------------------- | -------------------------- | ------------------- | ---------------------------------------------------- | ---- |
| Run:ai Platform           | Run:ai cloud instance      | Run:ai system nodes | app.run.ai                                           | 443  |
| Grafana                   | Run:ai cloud metrics store | Run:ai system nodes | prometheus-us-central1.grafana.net and runailabs.com | 443  |
| Google Container Registry | Run:ai image repository    | All K8S nodes       | gcr.io/run-ai-prod                                   | 443  |
| JFrog Artifactory         | Run:ai Helm repository     | Helm client machine | runai.jfrog.io                                       | 443  |

The Run:ai installation has [software requirements](broken-reference) that require additional components to be installed on the cluster. This article includes simple installation examples which can be used optionally and require the following cluster outbound ports to be open:

| Name                       | Description                                | Source        | Destination     | Port |
| -------------------------- | ------------------------------------------ | ------------- | --------------- | ---- |
| Kubernetes Registry        | Ingress Nginx image repository             | All K8S nodes | registry.k8s.io | 443  |
| Google Container Registry  | GPU Operator, and Knative image repository | All K8S nodes | gcr.io          | 443  |
| Red Hat Container Registry | Prometheus Operator image repository       | All K8S nodes | quay.io         | 443  |
| Docker Hub Registry        | Training Operator image repository         | All K8S nodes | docker.io       | 443  |

{% hint style="info" %}
&#x20;If you are using an HTTP proxy, contact Run:ai support for further instructions
{% endhint %}

## Internal network

Ensure that all Kubernetes nodes can communicate with each other across all necessary ports. Kubernetes assumes full interconnectivity between nodes, so you must configure your network to allow this seamless communication. Specific port requirements may vary depending on your network setup.
