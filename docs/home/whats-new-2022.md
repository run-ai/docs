## July 2022 Run:ai Version 2.7 

* New [Audit Log API](../admin/runai-setup/maintenance/audit-log.md) is now available. The _last login_ indication is now showing at the bottom left of the screen for single-sign-on users as well as regular users. 
* Built-in [Tensorboard support](../Researcher/tools/dev-tensorboard.md) in the Run:ai user interface.
* You can now submit a Job and allocate [Extended Kubernetes Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#extended-resources){target=_blank}. Extended resources are third-party devices (such as high-performance NICs, FPGAs, or InfiniBand adapters) that you want to allocate to your Job. The third-party vendor has extended Kubernetes using a [Device Plugin](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/){target=_blank}. Run:ai now allows the allocation of these resources via the Run:ai user interface Job form as well as the Run:ai Workload API. 
* You can now submit a job with additional [Linux Capabilities](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-capabilities-for-a-container){target=_blank}. Linux capabilities allow the researcher to give the Job additional permissions without actually giving the Job root access to the node. Run:ai allows adding such capabilities to the Job via the Run:ai user interface Job form as well as the Run:ai Workload API.  


## June 2022 Run:ai Version 2.6 (Cloud update only)

* The login screen now provides the capability to recover a password. 
* With single-sign-on, you can now (optionally) map the user's first and last name from the organizational directory. See [single-sign-on prerequisites](../admin/runai-setup/authentication/sso.md#prerequisites)
* A new user role of __ML Engineer__. The role allows the user to view and manage inference deployments and cluster resources. 
* [Clearer documentation](../admin/researcher-setup/cli-install.md#install-runai-cli) on how to perform port-forwarding when accessing the Run:ai cluster from Windows.
* Using the Run:ai user interface it is now possible to clone an existing Job. The clone operation will open a Job form and allow you to change parameters before re-submitting. 

## May 2022 Run:ai Version 2.5

* __Command-line interface installation__ The command-line interface utility is no longer a separate install. Instead is now installed by logging into the control plane and downloading the utility which matches the cluster's version. 
!!! Warning
    The command-line interface utility for version 2.3 is not compatible with a cluster version of 2.5 or later. If you upgrade the cluster, you must also upgrade the command-line interface. 
* __Inference__. Run:ai inference offering has been overhauled with the ability to submit deployments via the user interface and a new and consistent API. For more information see [Inference overview](../admin/workloads/inference-overview.md). To enable the new inference module call by Run:ai customer support.
* __CPU and CPU memory quotas__ can now be configured for projects and departments. These are hard quotas which means that the total amount of the requested resource for all workloads associated with a project/department cannot exceed the set limit. To enable this feature please call Run:ai customer support.
* __Workloads__. We have revamped the way Run:ai submits Jobs. Run:ai now submits [Workloads](../admin/workloads/workload-overview-admin.md). The change includes:
    * New [Cluster API](../developer/cluster-api/workload-overview-dev.md). The older [API](../developer/deprecated/researcher-rest-api/overview.md) has been deprecated and remains for backward compatibility. The API creates all the resources required for the run, including volumes, services, and the like. It also deletes all resources when the workload itself is deleted. 
    * Administrative templates have been replaced with [Policies](../admin/workloads/policies.md). Policies apply across all ways to submit jobs: command-line, API, and user interface. 
* `runai delete` has been changed in favor of `runai delete job` 
* Self-hosted installation: The default OpenShift installation is now set to work with a __configured__ Openshift IdP. See [creation of backend values](../admin/runai-setup/self-hosted/ocp/backend.md) for more information. In addition, the default for OpenShift is now HTTPS.
* To send logs to Run:ai customer support there is a utility to package all logs into one tar file. Version 2.5 brings a new method that __automatically sends all new logs to Run:ai support__ servers for a set amount of time. See [collecting logs](../index.md#collect-logs-to-send-to-support) for more information.
* It is now possible to mount an __S3 bucket__ into a Run:ai Job. The option is only available via the command-line interface. For more information see [runai submit](../Researcher/cli-reference/runai-submit.md).
* User interface improvements: The top navigation bar of the Run:ai user interface has been improved and now allows users to easily access everything related to the account, as well as multiple helpful links to the product documentation, CLI and APIs. 
* [Researcher Authentication](../admin/runai-setup/authentication/researcher-authentication.md) configuration is now mandatory. 


### Newly Supported Versions
* Run:ai now supports Kubernetes 1.24
* Run:ai now supports OpenShift 4.10
* Distributed training now supports MPI version 0.3. Support for older versions of MPI has been removed. 

## April 2022 Run:ai Version 2.4 (Controlled Release only)

### Important Upgrade Note

This version contains a significant change in the way that Run:ai uses and installs NVIDIA pre-requisites. Prior to this version, Run:ai has installed its own variants of two NVIDIA components: [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin){target=_blank} and [NVIDIA DCGM Exporter](https://github.com/NVIDIA/dcgm-exporter){target=_blank}. 

As these two variants are no longer needed, Run:ai now uses the standard NVIDIA installation which makes the Run:ai installation experience simpler. It does however require non-trivial changes when __upgrading__ from older versions of Run:ai. 

Going forward, we also mandate the usage of the NVIDIA GPU Operator version 1.9. The Operator easies the installation of all NVIDIA software. Drivers and Kubernetes components alike. 

For further information see the [Run:ai NVIDIA prerequisites](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#nvidia) as well as the [Run:ai cluster upgrade](../admin/runai-setup/cluster-setup/cluster-upgrade.md#upgrade-from-version-23-or-older-to-version-24-or-higher).

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
* See [user interface Jobs area](../admin/admin-ui-setup/jobs.md) for a description of how to submit, view and delete Jobs from the unified user interface. 


Other features:
 
* Additional information about scheduler decisions can now be found as part of the Job's status. View the Job status by running [runai describe job](../Researcher/cli-reference/runai-describe.md) or selecting a Job in the user interface and clicking `Status History`.
* Run:ai now support _Charmed Kubernetes_. 
* Run:ai now supports orchestration of containerized virtual machines via [KubeVirt](https://kubevirt.io/){target=_blank}. For more information see [KubeVirt support](../admin/integration/kubevirt.md).
* Run:ai now supports OpenShift 4.9, Kubernetes 1.22, and 1.23.

## February 2022 Run:ai Version 2.2 (Cloud update only)

* When enabling Single-Sign, you can now use _role groups_. With groups, you no longer need to provide roles to individuals. Rather, you can create a group in the organization's directory and assign its members with specific Run:ai Roles such as Administrator, Researcher, and the like. For more information see [single-sign-on](../admin/runai-setup/authentication/sso.md).
* REST API has changed. The new API relies on `Applications`. See [Calling REST APIs](../developer/rest-auth.md) for more information. 
* Added a new user role `Research Manager`. The role automatically assigns the user as a Researcher to all projects, including future projects. 

## January 2022 Run:ai Version 2.0

We have now stabilized on a single version numbering system for all Run:ai artifacts: 

* Run:ai Control plane.
* Run:ai Cluster.
* Run:ai Command-line interface.
* Run:ai Administrator Command-line interface.

Future versions will be numbered using 2 digits (2.0, 2.1, 2.2, etc.). The numbering for the different artifacts will vary at the third digit as we provide patches to customers. As such, in the future, the control plane can be tagged as 2.1.0 while the cluster tagged as 2.1.1.

### Release Contents

* To allow for better control over resource allocation, the Run:ai platform now provides the ability to define different over-quota priorities for projects. For full details see [Controlling over-quota behavior](../../admin/admin-ui-setup/project-setup/#controlling-over-quota-behavior).
* To help review and track resource consumption per department, the Department object was added to multiple dashboard metrics.

Supportability enhancements:

* A new tool was added, to allow IT administrators to validate cluster and control-plane installation prerequisites. For full details see [cluster installation prerequisites](../../admin/runai-setup/cluster-setup/cluster-prerequisites/#pre-install-script), Kubernetes [self-hosted prerequisites](../../admin/runai-setup/self-hosted/k8s/prerequisites/#pre-install-script) or OpenShift [self-hosted prerequisites](../../admin/runai-setup/self-hosted/ocp/prerequisites/#pre-install-script).
* To better analyze scheduling issues, the node name was added to multiple scheduler log events.
