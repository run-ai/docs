# Upgrading a Cluster Installation

<!-- To perform the tasks below you will need the Run:AI Administrator CLI. See [Installing the Run:AI Administrator Command-line Interface](cli-admin-install.md). -->


## Find the current Run:AI cluster version

To find the current version of the Run:AI cluster, run:

```
kubectl get deployment -n runai runai-operator -o yaml \
    -o jsonpath='{.spec.template.spec.containers[*].image}'
```

If the Run:AI cluster version is __1.X__ you will need to uninstall Run:AI before installing version 2.X. Uninstalling Run:AI does not stop any existing Jobs. It only prevents the creation of new Jobs until Run:AI is installed again.

## Upgrade from version 1.X


Uninstall Run:AI version 1.X by running:

```
runai-adm uninstall -A
helm repo remove runai
```

Install Run:AI by performing the install steps [here](../cluster-install/#step-3-install-runai)

## Upgrade from version 2.X


Run:

```
helm repo update
helm upgrade runai-cluster runai/runai-cluster -n runai --reuse-values
kubectl apply -f https://raw.githubusercontent.com/run-ai/docs/master/updated_crds.yaml
```

## Verify successful installation

To verify that the upgrade has succeeded run:

```
kubectl get pods -n runai
```

Verify that all pods are running or completed.


