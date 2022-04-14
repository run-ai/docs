
# Upgrading a Cluster Installation

## Find out Run:ai Cluster version 

To find the Run:ai cluster version before and after upgrade run:

```
helm list -n runai -f runai-cluster
```

and record the chart version in the form of `runai-cluster-<version-number>`

## Upgrade to version 2.2
Run:

```
kubectl apply -f https://raw.githubusercontent.com/run-ai/public/main/runai-crds.yaml
helm repo update
helm get values runai-cluster -n runai > values.yaml
helm upgrade runai-cluster runai/runai-cluster -n runai -f values.yaml
```

## Upgrade from version 2.2 or older to version 2.3 or higher

Delete the cluster as describe [here](cluster-delete.md) and perform cluster installation again.

## Upgrade from version 2.3 or older to version 2.4 or higher

1. Make sure you have no fractional jobs running.
2. Upgrade the cluster as describe [here](cluster-upgrade.md).
3. Install Nvidia gpu-operator (or equivalent) as described [here](cluster-prerequisites.md#nvidia).


## Verify successful installation

To verify that the upgrade has succeeded run:

```
kubectl get pods -n runai
```

Verify that all pods are running or completed.


