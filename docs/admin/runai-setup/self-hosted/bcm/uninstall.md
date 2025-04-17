# Uninstall

## Uninstall the control plane

To delete the control plane, run:

```bash
helm uninstall runai-backend -n runai-backend
```

## Uninstall the cluster 

Uninstalling NVIDIA Run:ai cluster from the Kubernetes cluster does __not__ delete existing projects, departments or workloads submitted by users.

To uninstall the NVIDIA Run:ai cluster, run the following [helm](https://helm.sh/) command in your terminal:

``` bash
helm uninstall runai-cluster -n runai
```

To delete the NVIDIA Run:ai cluster from the NVIDIA Run:ai Platform, see [Removing a cluster](../../config/clusters.md#removing-a-cluster).
