
# Upgrading a Cluster Installation

## Find out Run:AI Cluster version 

To find the Run:AI cluster version before and after upgrade run:

```
helm list -n runai -f runai-cluster
```

and record the chart version in the form of `runai-cluster-<version-number>`

## Upgrade
Run:

```
kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/updated_crds.yaml
helm repo update
helm get values runai-cluster -n runai > values.yaml
helm upgrade runai-cluster runai/runai-cluster -n runai -f values.yaml
```

## Verify successful installation

To verify that the upgrade has succeeded run:

```
kubectl get pods -n runai
```

Verify that all pods are running or completed.


