## May 2022 Run:ai Version 2.5

Revamp of the Run:ai researcher API, workloads etc.
Distributed training now supports MPI 3.0 (only)
runai delete vs runai delete job
Openshift default is now Openshift IdP support.
Inference
CPU scheduling (2.6?)
Automate sending of logs
CLI installed from backend
Database has been removed from cluster (probably not interesting)
Something on SSO with users and groups
S3 (both ui and cli)

## April 2022 Run:ai Version 2.4 (Controlled Release only)

### Important Upgrade Note

This version contains a significant change in the way that Run:ai uses and installs NVIDIA pre-requisites. Prior to this version, Run:ai has installed its own variants of two NVIDIA components: [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin){target=_blank} and [NVIDIA DCGM Exporter](https://github.com/NVIDIA/dcgm-exporter){target=_blank}. 

As these two variants are no longer needed, Run:ai now uses the standard NVIDIA installation which makes the Run:ai installation experience simpler. It does however require non-trivial changes when __upgrading__ from older versions of Run:ai. 

Going forward, we also mandate the usage of the NVIDIA GPU Operator version 1.9. The Operator easies the installation of all NVIDIA software. Drivers and Kubernetes components alike. 

For further information see the [Run:ai NVIDIA prerequisies](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#nvidia) as well as the [Run:ai cluster upgrade](../admin/runai-setup/cluster-setup/cluster-upgrade.md#upgrade-from-version-23-or-older-to-version-24-or-higher).

### Dynamic MIG Support

Run:ai now supports the dynamic allocation of NVIDIA MIG slices. For further information see the document on [fractions](../Researcher/scheduling/fractions.md) as well as the [dynamic MIG quickstart](../Researcher/Walkthroughs/quickstart-mig.md).

Other features:

* Run:ai now support fractions on GKE. GKE has a different software stack for NVIDIA. To install Run:ai on GKE please contact Run:ai customer support. 



## March 2022 Run:ai Version 2.3

### Important Upgrade Note

To upgrade to version 2.3 cluster from earlier versions, you must uninstall version 2.2 or earlier and only then install version 2.3. For detailed information see [cluster upgrade](../admin/runai-setup/cluster-setup/cluster-upgrade.md).

### Unified User Interface

The Researcher user interface and the Administrator user interface have been unified into a single unified _Run:ai user interface_. The new user interface is served from `https://<company-name>.run.ai`. The user interface capabilities are subject to the role of the individual user. 

* See [instructions](../admin/admin-ui-setup/overview.md) on how to set up the unified user interface. 
* See [user interface Jobs area](../admin/admin-ui-setup/jobs.md) for a description on how to submit, view and delete Jobs from the unified user interface. 


Other features:
 
* Additional information about scheduler decisions can now be found as part of the Job's status. View the Job status by running [runai describe job](../Researcher/cli-reference/runai-describe.md) or selecting a Job in the user interface and clicking `Status History`.
* Run:ai now support _Charmed Kubernetes_. 
* Run:ai now supports orchastraction of containerized virtual machines via [Kubevirt](https://kubevirt.io/){target=_blank}. For more information see [kubevirt support](../admin/integration/kubevirt.md).
* Run:ai now supports Openshift 4.9, Kubernetes 1.22 and 1.23.

## February 2022 Run:ai Version 2.2

* When enabling Single-Sign, you can now use _role groups_. With groups, you no longer need to provide roles to individuals. Rather, you can create a group in the organization's directory and assign its members with specific Run:ai Roles such as Administrator, Researcher, and the like. For more information see [single-sign on](../admin/runai-setup/authentication/sso.md).
* REST API has changed. The new API relies on `Applications`. See [Calling REST APIs](../developer/rest-auth.md) for more information. 
* Added a new user role `Research Manager`. The role automatically assigns the user as a Researcher to all projects, including future projects. 

## January 2022 Run:ai Version 2.0

We have now stabilized on a single version numbering system for all Run:ai artifacts: 

* Run:ai Control plane (also called Backend).
* Run:ai Cluster.
* Run:ai Command-line interface.
* Run:ai Administrator Command-line interface.

Future versions will be numbered using 2 digits (2.0, 2.1, 2.2, etc.). Numbering for the different artifacts will vary at the third digit as we provide patches to customers. As such, in the future, the control plane can be tagged as 2.1.0 while the cluster tagged as 2.1.1.

### Release Contents

* To allow for better control over resource allocation, the Run:ai platform now provides the ability to define different over-quota priorities for projects. For full details see [Controlling over-quota behavior](../../admin/admin-ui-setup/project-setup/#controlling-over-quota-behavior).
* To help review and track resource consumption per department, the Department object was added to multiple dashboard metrics.

Supportability enhancements:

* A new tool was added, to allow IT administrators to validate cluster and control-plane installation pre-requisites. For full details see [cluster installation prerequisites](../../admin/runai-setup/cluster-setup/cluster-prerequisites/#pre-install-script), Kubernetes [self-hosted prerequisites](../../admin/runai-setup/self-hosted/k8s/prerequisites/#pre-install-script) or Openshift [self-hosted prerequisites](../../admin/runai-setup/self-hosted/ocp/prerequisites/#pre-install-script).
* To better analyze scheduling issues, node name was added to multiple scheduler log events.