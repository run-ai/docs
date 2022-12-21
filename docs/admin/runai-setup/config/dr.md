
# Planning for Disaster Recovery

The SaaS version of Run:ai moves the bulk of the burden of disaster recovery to Run:ai. Backup of data is hence not an issue in such environments. 

With the __self-hosted__ version, it is the responsibility of the IT organization to back up data for a possible disaster and to learn how to recover when needed.

## Backup 

### Database

Run:ai uses an internal PostgreSQL database. The database is stored on a Kubernetes _Persistent Volume_ (PV). You must provide a backup solution for the database. Typically by backing up the persistent volume holding the database storage.
### Metrics

Run:ai stores metric history using [Thanos](https://github.com/thanos-io/thanos){target=_blank}. Thanos is configured to store data on a persistent volume. The recommendation is to back up the PV.

### Additional Configuration

During the installation of Run:ai you have created two value files:

* One for the Run:ai control plane. See [Kubernetes](../self-hosted/k8s/backend.md) or [OpenShift](../self-hosted/ocp/backend.md),
* One for the cluster (see [Kubernetes](../self-hosted/k8s/cluster.md) or [OpenShift](../self-hosted/ocp/cluster.md)). 

You will want to save these files or extract a current version of the file by using the [upgrade](../self-hosted/k8s/upgrade.md) script. 

## Recovery

To recover Run:ai

* Re-create the Kubernetes/OpenShift cluster.
* Recover the persistent volumes for metrics and database. 
* Re-install the Run:ai control plane. Use the stored values file. If needed, modify the values file to connect to the restored PostgreSQL PV. Connect Prometheus to the stored metrics PV. 
* Re-install the cluster. Use the stored values file or download a new file from the Administration UI. 
* If the cluster is configured such that Projects do not create a namespace automatically, you will need to re-create namespaces and apply role bindings as discussed in [Kubernetes](../self-hosted/k8s/project-management.md) or [OpenShift](../self-hosted/ocp/project-management.md).






