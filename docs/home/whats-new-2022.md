## March 2022 Run:ai Version 2.3

### Important installation note

To upgrade version 2.3 cluster from earlier versions, you must uninstall version 2.2 or earlier and then install version 2.3. For detailed information see [cluster upgrade](../admin/runai-setup/cluster-setup/cluster-upgrade.md).

### Unified user interface

The Researcher user interface and the Administrator user interface have been unified into a single unified _Run:ai user interface_. The new user interface is served from `<company-name>.run.ai`

* See [instructions](../admin/admin-ui-setup/overview.md) on how to set up the unified user interface. 
* See [User interface Jobs area](../admin/admin-ui-setup/jobs.md) for a description on how to submit, view and delete Jobs from the unified user interface. 


Other features:
 
* Additional information about scheduler decisions can now be found as part of the Job's status. View the Job status by running [runai describe job](../Researcher/cli-reference/runai-describe.md) or selecting a Job in the user interface and clicking `Status History`.
* Run:ai now support _Charmed Kubernetes_. 
* Run:ai now supports [Kubevirt](https://kubevirt.io/){target=_blank}. For more information see [kubevirt support](../admin/integration/kubevirt.md).

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