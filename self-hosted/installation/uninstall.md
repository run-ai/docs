---
title: Uninstall self-hosted Kubernetes installation
---
# Uninstall Run:ai 


## Uninstall a Run:ai Cluster

{% include "../../.gitbook/includes/cluster-uninstall.md" %}


## Uninstall the Run:ai Control Plane

To delete the control plane, run:

``` shell
helm uninstall runai-backend -n runai-backend

```



