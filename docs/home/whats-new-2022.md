## January 2022 Run:AI Version 2.0

We have now stablized on a single version numbering system for all Run:AI artifacts: 

* Run:AI Backend (control-plane).
* Run:AI Cluster.
* Run:AI Command-line interface.
* Run:AI Administrator Command-line interface.

Components will vary at the third digit as we provide patches to customers.

### Release Contents

* In order to give more control over resource allocation, the Run:AI platform now provides the ability to define different over-quota priority for projects. For full details see [Controlling over-quota behavior](../../admin/admin-ui-setup/project-setup/#controlling-over-quota-behavior).
* In order to help review and track resource consumption per department, the Department object was added to multiple dashboard metrics.

Supportability enhancements:

* A new tool was added, to allow IT administrators to validate cluster and control-plane installation pre-requisites. For full details see [cluster installation prerequisites](../../admin/runai-setup/cluster-setup/cluster-prerequisites/#pre-install-script), Kubernetes [self-hosted prerequisites](../../admin/runai-setup/self-hosted/k8s/prerequisites/#pre-install-script) or Openshift [self-hosted prerequisites](../../admin/runai-setup/self-hosted/ocp/prerequisites/#pre-install-script).
* To better analyze scheduling issues, node name was added to multiple scheduler log events.