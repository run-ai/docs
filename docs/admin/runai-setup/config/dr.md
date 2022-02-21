
# Planning for Disaster Recovery

The SaaS version of Run:AI moves the bulk of the burden of disaster recovery to Run:AI. Backup of data is hence not an issue in such environments. 

With the __self-hosted__ version, it is the responsibility of the IT organization to backup data for a possible disaster and to learn how to recover when needed.

## Backup 

### Database

Run:AI uses an internal PostgreSQL database. The database is stored on a Kubernetes _Persistent Volume_ (PV). You must provide a backup solution for the database. 

Alternatives:

* (Recommended) Back up the PV.
* Use the company's enterprise PostgreSQL solution if exists, instead of the in-place instance that Run:AI spawns.

### Metrics

Run:AI stores metric history using [Thanos](https://github.com/thanos-io/thanos){target=_blank}. Thanos is configured to store data on a persistent volume. The recommendation is to back up the PV.

### Additional Configuration

During the installation of Run:AI you have created two value files, 

* one for the Run:AI control plane (also called 'backend'). See [kubernetes](../self-hosted/k8s/backend.md) or [OpenShift](../self-hosted/ocp/backend.md),
*  and one for the cluster (see [kubernetes](../self-hosted/k8s/cluster.md) or [OpenShift](../self-hosted/ocp/cluster.md)). 

You will want to save these files, or extract a current version of the file by using the [upgrade](../self-hosted/k8s/upgrade.md) script. 

Administrators may also create templates. Templates are stored as ConfigMaps in the `runai` namespace. 

## Recovery

To recover Run:AI

* Re-create the Kubernetes/OpenShift cluster.
* Recover the persistent volumes for metrics and database. 
* Re-install the Run:AI control plane. Use the stored values file. If needed, modify the values file to connect to the restored PostgreSQL PV. Connect Prometheus to the stored metrics PV. 
* Re-install the cluster. Use the stored values file or download a new file from the Administration UI. 
* If the cluster is configured such that Projects do not create namespace automatically, you will need to re-create namespaces and apply role bindings as discussed in [kubernetes](../self-hosted/k8s/project-management.md) or [OpenShift](../self-hosted/ocp/project-management.md).






