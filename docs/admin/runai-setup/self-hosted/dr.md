
# Planning for Disaster Recovery

The SaaS version of Run:AI moves the bulk of the burden of disaster recovery to Run:AI. With the __self-hosted__ version, it is the responsibility of IT to prepare for possible disasters. 

The purpose of this document is to detail the required preparations to recover.

## Backup 

### Database

Run:AI uses an internal PostgreSQL database. The database is stored on a Kubernetes _Persistent Volume_ (PV). You must provide a backup solution for the database. 

Alternatives:

* (Recommended) Back up the PV.
* Use the company's enterprise PostgreSQL solution if exists, instead of the in-place instance that Run:AI spawns.

### Metrics

Run:AI stores metric history using [Thanos](https://github.com/thanos-io/thanos){target=_blank}. Thanos is configured to store data on a persistent volume. The recommendation is to back up the PV.

### Additional Configuration

During the installation of Run:AI you have created two value files, one for the backend (see [kubernetes](k8s/backend.md) or [OpenShift](ocp/backend.md)) and one for the cluster (see [kubernetes](k8s/cluster.md) or [OpenShift](ocp/cluster.md)). You will want to save these file, or extract a current version of the file by using the [upgrade](k8s/upgrade.md) script. 

Administrators may also create templates. Templates are stored as ConfigMaps in the `runai` namespace. 

## Recovery

To recover Run:AI

* Re-create the Kubernetes/OpenShift cluster.
* Recover the persistent volumes for metrics and database. 
* Re-install the Run:AI backend. Use the stored values file. If needed, modify the values file to connect to the restored PostgreSQL PV. Connect Prometheus to the stored metrics PV. 
* Re-install the cluster. Use the stored values file or download a new file from the Administration UI. 
* If the cluster is configured such that Projects do not create namespace automatically, you will need to re-create namespaces and apply role bindings as discussed in [kubernetes](k8s/project-management.md) or [OpenShift](ocp/project-management.md).






