# Upgrading a Cluster Installation

<!-- To perform the tasks below you will need the Run:AI Administrator CLI. See [Installing the Run:AI Administrator Command-line Interface](cli-admin-install.md). -->


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


