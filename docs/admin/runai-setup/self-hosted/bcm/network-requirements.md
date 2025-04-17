# Network requirements

The following network requirements are for the NVIDIA Run:ai components installation and usage.

## Installation

### Inbound rules

| Name                        | Description      | Source  | Destination                | Port |
| --------------------------- | ---------------- | ------- | -------------------------- | ---- |
| Installation via BCM    | SSH Access | Installer Machine | NVIDIA Base Command Manager headnodes | 22  |

### Outbound rules
| Name                        | Description      | Source  | Destination                | Port |
| --------------------------- | ---------------- | ------- | -------------------------- | ---- |
| Container Registry | Pull NVIDIA Run:ai images                                                        | All kubernetes nodes       | runai.jfrog.io                   | 443  |
| Helm repository    | NVIDIA Run:ai Helm repository for installation                                   | Installer machine          | runai.jfrog.io                   | 443  |

The NVIDIA Run:ai installation has [software requirements](system-requirements.md) that require additional components to be installed on the cluster. This article includes simple installation examples which can be used optionally and require the following cluster outbound ports to be open:

| Name                       | Description                                | Source               | Destination     | Port |
| -------------------------- | ------------------------------------------ | -------------------- | --------------- | ---- |
| Kubernetes Registry        | Ingress Nginx image repository             | All kubernetes nodes | registry.k8s.io | 443  |
| Google Container Registry  | GPU Operator, and Knative image repository | All kubernetes nodes | gcr.io          | 443  |
| Red Hat Container Registry | Prometheus Operator image repository       | All kubernetes nodes | quay.io         | 443  |
| Docker Hub Registry        | Training Operator image repository         | All kubernetes nodes | docker.io       | 443  |



## External access

Set out below are the domains to whitelist and ports to open for installation, upgrade, and usage of the application and its management.


!!! Note
    Ensure the inbound and outbound rules are correctly applied to your firewall.

### Inbound rules

To allow your organization’s NVIDIA Run:ai users to interact with the cluster using the [NVIDIA Run:ai Command-line interface](../../reference/cli/runai/), or access specific UI features, certain inbound ports need to be open:

| Name                        | Description      | Source  | Destination                | Port |
| --------------------------- | ---------------- | ------- | -------------------------- | ---- |
| NVIDIA Run:ai control plane | HTTPS entrypoint | 0.0.0.0 | NVIDIA Run:ai system nodes | 443  |
| NVIDIA Run:ai cluster       | HTTPS entrypoint | RFC1918 private IP ranges (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)
 | NVIDIA Run:ai system nodes | 443  |


### Outbound rules

!!! Note
    Outbound rules applied to the NVIDIA Run:ai cluster component only. In case the NVIDIA Run:ai cluster is installed together with the NVIDIA Run:ai control plane, the NVIDIA Run:ai cluster FQDN refers to the NVIDIA Run:ai control plane FQDN.
    {% endhint %}

For the NVIDIA Run:ai cluster installation and usage, certain **outbound** ports must be open:

| Name               | Description                                                                      | Source                     | Destination                      | Port |
| ------------------ | -------------------------------------------------------------------------------- | -------------------------- | -------------------------------- | ---- |
| Cluster sync       | Sync NVIDIA Run:ai cluster with NVIDIA Run:ai control plane                      | NVIDIA Run:ai system nodes | NVIDIA Run:ai control plane FQDN | 443  |
| Metric store       | Push NVIDIA Run:ai cluster metrics to NVIDIA Run:ai control plane's metric store | NVIDIA Run:ai system nodes | NVIDIA Run:ai control plane FQDN | 443  |

## Internal network

Ensure that all Kubernetes nodes can communicate with each other across all necessary ports. Kubernetes assumes full interconnectivity between nodes, so you must configure your network to allow this seamless communication. Specific port requirements may vary depending on your network setup.