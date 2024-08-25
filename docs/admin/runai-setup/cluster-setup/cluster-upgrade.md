
# Upgrading a Cluster Installation
Below are the instructions on how to upgrade a Run:ai cluster.

## Upgrade Run:ai cluster 

Follow the steps below, based on the Run:ai cluster version you want to upgrade to:

=== "2.15-latest"
    * In the Run:ai interface, navigate to `Clusters`
    * Select the cluster you want to upgrade
    * Click `Get Installation instructions`
    * Choose the `Run:ai version` to upgrade to
    * Click `Continue`
    * Copy the [Helm](https://helm.sh/docs/intro/install/) command provided in the `Installation Instructions` and run it on in the cluster.
    * In the case of a failure, refer to the [Installation troubleshooting guide](../../troubleshooting/troubleshooting.md#installation).

=== "2.13"
    Run:

    ```
    helm get values runai-cluster -n runai > old-values.yaml
    ```

    * Review the file `old-values.yaml` and see if there are any changes performed during the last installation.
    * In the Run:ai interface, navigate to `Clusters`.
    * Select the cluster you want to upgrade.
    * Click `Get Installation instructions`.

    * Follow the instructions to download a new values file. 
    * Merge the changes from Step 1 into the new values file.
    * Copy the [Helm](https://helm.sh/docs/intro/install/) command provided in the `Installation Instructions` and run it on in the cluster.

## Verify Successful Upgrade

See [Verify your installation](cluster-install.md#verify-your-clusters-health) on how to verify a Run:ai cluster installation

Before proceeding with the upgrade, it's crucial to apply the specific prerequisites associated with your current version of Run:ai and every version in between up to the version you are upgrading to.

### Upgrade from version 2.9 

Two significant changes to the control-plane installation have happened with version 2.12: _PVC ownership_ and _installation customization_. 

```
kubectl patch pvc -n runai-backend pvc-thanos-receive  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
kubectl patch pvc -n runai-backend pvc-postgresql  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
```

#### Ingress

Delete the ingress object which will be recreated by the control plane upgrade.

