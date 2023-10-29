---
title: Uninstall self-hosted Kubernetes installation
---
# Uninstall Run:ai 


## Uninstall a Run:ai Cluster
To uninstall the cluster see: [cluster delete](../../cluster-setup/cluster-delete.md) 


## Uninstall the Run:ai Control Plane

To delete the control plane, run:

``` shell
helm delete runai-backend -n runai-backend

```



