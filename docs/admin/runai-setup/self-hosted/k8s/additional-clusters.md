# Installing additional Clusters

The first Run:ai cluster is typically installed on the same Kubernetes cluster as the Run:ai control plane. Run:ai supports multiple clusters per single control plane. This document is about installing additional clusters on __different Kubernetes clusters__.

The instructions are for Run:ai version 2.8 and up.


## Installation

Follow the Run:ai SaaS installation network instructions as describe [here](../../cluster-setup/cluster-prerequisites.md#domain-name).  Specifically:

1. The Cluster should have a dedicated URL with a trusted certificate.
2. Install NGINX.
3. Create a secret in the Run:ai namespace containing the details of a trusted certificate.  

Create a new cluster and download a values file. Perform the following changes in the file:

* Under: `runai-operator.config.global` set `clusterDomain` to the domain name of the new cluster.
* Under `runai-operator.config.researcher-service` set `ingress` to `true`.