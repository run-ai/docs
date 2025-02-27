---
title: Uninstall self-hosted Kubernetes installation
---

# Uninstall

## Uninstall a Run:ai cluster

{% include "../../.gitbook/includes/cluster-uninstall.md" %}

## Uninstall the Run:ai control plane

To delete the control plane, run:

```bash
helm uninstall runai-backend -n runai-backend
```
