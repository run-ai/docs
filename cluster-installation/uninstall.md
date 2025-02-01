# Uninstall

This article explains how to uninstall the Run:ai Cluster from the Kubernetes cluster.

## Uninstall Run:ai cluster 

Uninstall of Run:ai cluster from the Kubernetes cluster does not delete existing projects, departments or workloads submitted by users.

To uninstall the Run:ai cluster, run the following [helm](https://helm.sh/) command in your terminal:

```
helm uninstall runai-cluster -n runai
```
To remove the Run:ai cluster from the Run:ai Platform, see [Removing a cluster](../infrastructure-procedures/clusters.md#removing-a-cluster).
