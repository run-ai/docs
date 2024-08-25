This article explains how to uninstall Run:ai Cluster installation from the Kubernetes cluster.

## Delete Run:ai cluster installation

Deletion of Run:ai cluster from the Kubernetes cluster does **not** delete existing projects, departments or workloads submitted by users.

To delete the Run:ai cluster installation, run the following [helm](https://helm.sh/) command:

``` bash
helm uninstall runai-cluster -n runai
```

To delete the Run:ai cluster from the Run:ai Platform, see [Removing a cluster](../config/clusters.md#removing-a-cluster).

