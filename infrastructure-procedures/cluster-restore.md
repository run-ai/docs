# Cluster restore

## Run:ai Cluster Restore

This article explains how to restore a Run:ai cluster on a different Kubernetes environment.

In the event of a critical Kubernetes failure or alternatively, if you want to migrate a Run:ai cluster to a new Kubernetes environment, simply reinstall the Run:ai cluster. Once you have reinstalled and reconnected the cluster - projects, workloads and other cluster data is synced automatically.

The restoration or back-up of Run:ai cluster Advanced features and [Customized deployment configurations](../docs/runai-setup/cluster-setup/customize-cluster-install.md) which are stored locally on the Kubernetes cluster is optional and they can be restored and backed-up separately.

### Backup

As back-up of data is not required, the backup procedure is optional for advanced deployments, as explained above.

#### Backup cluster configurations

To backup Run:ai cluster configurations:

1.  Run the following command in your terminal:

    ```bash
    kubectl get runaiconfig runai -n runai -o yaml -o=jsonpath='{.spec}' > runaiconfig_backup.yaml
    ```
2. Once the `runaiconfig_back.yaml` back-up file is created, save the file externally, so that it can be retrieved later.

### Restore

Follow the steps below to restore the Run:ai cluster on a new Kubernetes environment.

#### Prerequisites

Before restoring the Run:ai cluster, it is essential to validate that it is both disconnected and uninstalled.

1. If the Kubernetes cluster is still available, [uninstall](../docs/runai-setup/cluster-setup/cluster-delete.md) the Run:ai cluster - make sure not to remove the cluster from the Control Plane
2. Navigate to the Cluster page in the Run:ai platform
3. Search for the cluster, and make sure its status is **Disconnected**

#### Re-installing Run:ai Cluster

1. Follow the Run:ai cluster [installation](../docs/runai-setup/cluster-setup/cluster-install.md) instructions and ensure all prerequisites are met
2.  If you have a back-up of the cluster configurations, reload it once the installation is complete

    ```bash
    kubectl apply -f runaiconfig_backup.yaml -n runai
    ```
3. Navigate to the Cluster page in the Run:ai platform
4. Search for the cluster, and make sure its status is **Connected**
