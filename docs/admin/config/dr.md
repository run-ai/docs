
# Backup & Restore

## Run:ai Cluster Restore

This article explains how to restore a Run:ai cluster on a different Kubernetes environment.

In the event of a critical Kubernetes failure or alternatively, if you want to migrate a Run:ai cluster to a new Kubernetes environment, simply reinstall the Run:ai cluster. Once you have reinstalled and reconnected the cluster - projects, workloads and other cluster data is synced automatically.

The restoration or back-up of Run:ai cluster Advanced features and [Customized deployment configurations](../runai-setup/cluster-setup/customize-cluster-install.md) which are stored locally on the Kubernetes cluster is optional and they can be restored and backed-up separately.

### Backup

As back-up of data is not required, the backup procedure is optional for advanced deployments, as explained above.

#### Backup cluster configurations

To backup Run:ai cluster configurations:

1. Run the following command in your terminal:  
    ``` bash
    kubectl get runaiconfig runai -n runai -o yaml -o=jsonpath='{.spec}' > runaiconfig_backup.yaml
    ```
2. Once the `runaiconfig_back.yaml` back-up file is created, save the file externally, so that it can be retrieved later.

### Restore

Follow the steps below to restore the Run:ai cluster on a new Kubernetes environment.

#### Prerequisites

Before restoring the Run:ai cluster, it is essential to validate that it is both disconnected and uninstalled.

1. If the Kubernetes cluster is still available, [uninstall](../runai-setup/cluster-setup/cluster-delete.md) the Run:ai cluster - make sure not to remove the cluster from the Control Plane  
2. Navigate to the Cluster page in the Run:ai platform  
3. Search for the cluster, and make sure its status is __Disconnected__

#### Re-installing Run:ai Cluster

1. Follow the Run:ai cluster [installation](../runai-setup/cluster-setup/cluster-install.md) instructions and ensure all prerequisites are met  
2. If you have a back-up of the cluster configurations, reload it once the installation is complete  
    ``` bash
    kubectl apply -f runaiconfig_backup.yaml -n runai
    ```
3. Navigate to the Cluster page in the Run:ai platform  
4. Search for the cluster, and make sure its status is __Connected__


## Run:ai Control Plane

The [self-hosted](../runai-setup/installation-types.md#self-hosted-installation) variant of Run:ai also installs the control-plane at the customer site. As such, it becomes the responsibility of the IT organization to verify that the system is configured for proper backup and learn how to recover the data when needed.

### Database Storage

Run:ai uses an internal PostgreSQL database. The database is stored on a Kubernetes *Persistent Volume* (PV). You must provide a backup solution for the database. Some options:

* Backing up of PostgreSQL itself. Example: `kubectl -n runai-backend exec -it runai-backend-postgresql-0 -- env  PGPASSWORD=password pg_dump -U postgres   backend   > cluster_name_db_backup.sql`
* Backing up the persistent volume holding the database storage.
* Using third-party backup solutions.

Run:ai also supports an external PostgreSQL database. For details see [external PostgreSQL database](../runai-setup/self-hosted/k8s/preparations.md#external-postgres-database-optional)

### Metrics Storage

Run:ai stores metric history using [Thanos](https://github.com/thanos-io/thanos){target=_blank}. Thanos is configured to store data on a persistent volume. The recommendation is to back up the PV.

### Backing up Control-Plane Configuration

The installation of the Run:ai control plane can be [configured](../runai-setup/self-hosted/k8s/backend.md#additional-runai-configurations-optional). The configuration is provided as `--set` command in the helm installation. These changes will be preserved on upgrade, but will not be preserved on uninstall or upon damage to Kubernetes. Thus, it is best to back up these customizations. For a list of customizations used during the installation, run:

`helm get values runai-backend -n runai-backend`

### Recovery

To recover Run:ai

* Re-create the Kubernetes/OpenShift cluster.
* Recover the persistent volumes for metrics and database.
* Re-install the Run:ai control plane. Use the additional configuration previously saved and connect to the restored PostgreSQL PV. Connect Prometheus to the stored metrics PV.
* Re-install the cluster. Add additional configuration post-install.  
* If the cluster is configured such that Projects do not create a namespace automatically, you will need to re-create namespaces and apply role bindings as discussed in [Kubernetes](../runai-setup/self-hosted/k8s/project-management.md) or [OpenShift](../runai-setup/self-hosted/ocp/project-management.md).
