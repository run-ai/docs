
# Backup & Restore

## Run:ai Cluster

The SaaS version of Run:ai does not store any data. The required data is moved into the control-plane. As such, backup of data is not an issue in such environments. 

### Backing up Cluster Configuration

The installation of Run:ai cluster can be customized. Changes to the defaults can be configured by editing the `runaiconfig` object as described [here](../cluster-setup/customize-cluster-install.md).  These changes will be preserved on upgrade, but will not be preserved on uninstall or damage to Kubernetes. Thus, it is best to back up these customizations. For a list of such changes run:

```
kubectl get runaiconfig runai -n runai -o yaml -o=jsonpath='{.spec}'
```

## Run:ai Control Plane
The [self-hosted](../installation-types.md#self-hosted-installation) variant of Run:ai also installs the control-plane at the customer site. As such, it becomes the responsibility of the IT organization to verify that the system is configured for proper backup and learn how to recover the data when needed. 

### Database Storage

Run:ai uses an internal PostgreSQL database. The database is stored on a Kubernetes _Persistent Volume_ (PV). You must provide a backup solution for the database. Some options:

* Backing up of PostgreSQL itself. Example: `kubectl -n runai-backend exec -it runai-backend-postgresql-0 -- env  PGPASSWORD=password pg_dump -U postgres   backend   > cluster_name_db_backup.sql`
* Backing up the persistent volume holding the database storage.
* Using third-party backup solutions.

Run:ai also supports an external PostgreSQL database. For details on how to configure an external database please contact Run:ai customer support.

### Metrics Storage

Run:ai stores metric history using [Thanos](https://github.com/thanos-io/thanos){target=_blank}. Thanos is configured to store data on a persistent volume. The recommendation is to back up the PV.

### Backing up Control-Plane Configuration

The installation of the Run:ai control plane can be [configured](../self-hosted/k8s/backend.md#optional-additional-configurations). The configuration is provided as `--set` command in the helm installation. These changes will be preserved on upgrade, but will not be preserved on uninstall or on damage to Kubernetes. Thus, it is best to back up these customizations. For a list of customizations used during the installation, run: 

```helm get values runai-backend -n runai-backend```


### Recovery

To recover Run:ai

* Re-create the Kubernetes/OpenShift cluster.
* Recover the persistent volumes for metrics and database. 
* Re-install the Run:ai control plane. Use the additional configuration previously saved and connect to the restored PostgreSQL PV. Connect Prometheus to the stored metrics PV. 
* Re-install the cluster. Add additional configuration post-install.  
* If the cluster is configured such that Projects do not create a namespace automatically, you will need to re-create namespaces and apply role bindings as discussed in [Kubernetes](../self-hosted/k8s/project-management.md) or [OpenShift](../self-hosted/ocp/project-management.md).
