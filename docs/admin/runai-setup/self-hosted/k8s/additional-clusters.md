# Installing additional Clusters

The first Run:ai cluster is typically installed on the same Kubernetes cluster as the Run:ai control plane. Run:ai supports multiple clusters per single control plane. This document is about installing additional clusters on __different Kubernetes clusters__.


## Installation

Follow the Run:ai SaaS installation network instructions as described [here](../../cluster-setup/cluster-prerequisites.md#cluster-url).  Specifically:

1. Install Run:ai [prerequisites](../../cluster-setup/cluster-prerequisites.md). Including ingress controller and Prometheus. 
2. The Cluster should have a dedicated URL with a trusted certificate.
3. Create a secret in the Run:ai namespace containing the details of a trusted certificate. 
4. Run the `helm` command as instructed.  

<!---
Create a new cluster and download a values file. Perform the following changes in the file:

* Under: `spec.global` set `clusterDomain` to the domain name of the new cluster.
* Under `spec.researcher-service` set `ingress` to `true`.

-->