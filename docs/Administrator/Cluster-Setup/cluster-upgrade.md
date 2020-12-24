# Upgrading a Cluster Installation

To perform the tasks below you will need the Run:AI Administrator CLI. See [Installing the Run:AI Administrator Command-line Interface](cli-admin-install.md).


## Find the current Run:AI cluster version

To find the current version of the Run:AI cluster, run:

```
runai-adm get version
```

## Upgrade

To upgrade a Run:AI cluster, run:

```
 runai-adm upgrade -v <NEW_VERSION>
```

Replace ``<NEW_VERSION>`` with a version number you receive from Run:AI customer support.

To verify that the upgrade has succeeded run:

```
kubectl get pods -n runai
```

Verify that all pods are running or completed.


