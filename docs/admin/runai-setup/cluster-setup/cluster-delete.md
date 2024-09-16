This article explains how to uninstall Run:ai Cluster installation from the Kubernetes cluster.

## Unistall Run:ai cluster 

Uninstall of Run:ai cluster from the Kubernetes cluster does __not__ delete existing projects, departments or workloads submitted by users.

To uninstall the Run:ai cluster, run the following [helm](https://helm.sh/) command in your terminal:

``` bash
helm uninstall runai-cluster -n runai
```

To delete the Run:ai cluster from the Run:ai Platform, see [Removing a cluster](../../config/clusters.md#removing-a-cluster).
