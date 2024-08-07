
# Upgrading a Cluster Installation
Below are instructions on how to upgrade a Run:ai cluster.

## Upgrade Run:ai cluster
Follow the steps below, based on the Run:ai Cluster version you would like to upgrade to:

=== "2.15-latest"
    * In the Run:ai interface, navigate to `Clusters`.
    * Select the cluster you want to upgrade.
    * Click on `Get Installation instructions`.
    * Choose the `Run:ai version` to upgrade to.
    * Press `Continue`.
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
    * Select `Run:ai version: 2.13`.
    * Select the `cluster's Kubernetes distribution` and the `Cluster location`
    * If the Cluster locaiton is remote to the control plane - Enter a  URL for the Kubernetes cluster.
    * Click `Continue`.
    * Follow the instructions to download a new values file. 
    * Merge the changes from Step 1 into the new values file.
    * Copy the [Helm](https://helm.sh/docs/intro/install/) command provided in the `Installation Instructions` and run it on in the cluster.

## Verify Successful Upgrade
See [Verify your installation](cluster-install.md#verify-your-clusters-health) on how to verify a Run:ai cluster installation



