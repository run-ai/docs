---
title: What's New 2.15 - December 3, 2023
summary: This article is a summary of new and improved features in the Run:ai platform.
authors:
    -  Jason Novich
date: 2023-Dec-3
---

## Release Content

### Researcher

#### Jobs, Workloads, Trainings, and Workspaces

* <!-- RUN-10404/RUN-11747 Submit distributed training * RUN-11194/RUN-11239 All changes done in the UI for distributed training are hidden behind feature flag  RUN-11186/RUN-11241 Submitting an MPI/PT/TF/XGBoost distributed training from UI - 1st form page  RUN-11206/RUN-11242 Submitting distributed training from UI - 2nd form page RUN-11219/RUN-11602 Submitting an MPI distributed training from UI - 3rd form page RUN-11231/RUN-11240 Environment for distributed training-->Added support to run distributed workloads via the training view in the UI. You can configure distributed training on the following:

    * Trainings form
    * Environments form

    You can select `single` or `multi-node (distributed)` training. When configuring distributed
    training, you will need to select a framework from the list. Supported frameworks now
    include:

    * PyTorch
    * Tensorflow
    * XGBoost
    * MPI

    For *Trainings* configuration, see [Adding trainings](../Researcher/user-interface/trainings.md#adding-trainings). See your Run:ai representative to enable this feature. For *Environments* configuration, see [Creating an Environment](../Researcher/user-interface/ workspaces/create/create-env.md#creating-a-new-environment).

* <!-- RUN-10241/RUN-12872 - New Workloads view -->Preview the new *Workloads* view. *Workloads* is a new view for jobs that are running in the AI cluster. The *Workloads* view provides a more advanced UI than the previous *Jobs* UI. The new table format provides:

    * Improved views of the data
    * Improved filters and search
    * More information
  
    Use the toggle at the top of the *Jobs* page to switch to the *Workloads* view. For more information, see [Workloads](../admin/workloads/workload-overview-admin.md#workloads-view).

* <!-- RUN-10639/RUN-11389 - Researcher Service Refactoring RUN-12505/RUN-12506 - Support Kubeflow notebooks for scheduling/orchestration -->Improved support for Kubeflow Notebooks. Run:ai now supports the scheduling of Kubeflow notebooks with fractional GPUs. Kubeflow notebooks are identified automatically and appear with a dedicated icon in the *Jobs* UI.
* <!-- RUN-11292/RUN-11592 General changes in favor of any asset based workload \(WS, training, DT\)-->Improved the *Trainings* and *Workspaces* forms. Now the runtime field for *Command* and *Arguments* can be edited directly in the new *Workspace* or *Training* creation form.
* <!-- RUN-10235/RUN-10485  Support multi service types in the CLI submission -->Added new functionality to the Run:ai CLI that allows submitting a workload with multiple service types at the same time in a CSV style format. Both the CLI and the UI now offer the same functionality. For more information, see [runai submit](../Researcher/cli-reference/runai-submit.md#s----service-type-string).
* <!-- RUN-10335/RUN-10510 Node port command line -->Improved functionality in the `runai submit` command so that the port for the container is specified using the `nodeport` flag. For more information, see `runai submit` [--service-type](../Researcher/cli-reference/runai-submit.md#-s-service-type-string) `nodeport`.

#### Credentials

* <!-- RUN-10862/RUN-10863 Department as a workspace phase 2 - scope in credentials -->Improved *Credentials* creation. A Run:ai scope can now be added to credentials. For more information, see [Credentials](../admin/admin-ui-setup/credentials-setup.md).

#### Environments

* <!-- RUN-10271/RUN-10321 Mark environment for workload type-->Added support for workload types when creating a new or editing existing environments. Select from `single-node` or `multi-node (distributed)` workloads. The environment is available only on feature forms which are relevant to the workload type selected.

#### Volumes and Storage

* <!--RUN-9958/RUN-10061 Ephemeral volumes in workspaces -->Added support for Ephemeral volumes in *Workspaces*. Ephemeral storage is temporary storage that gets wiped out and lost when the workspace is deleted. Adding Ephemeral storage to a workspace ties that storage to the lifecycle of the *Workspace* to which it was added. Ephemeral storage is added to the *Workspace* configuration form in the *Volume* pane. For configuration information, see [Create a new workspace](../Researcher/user-interface/workspaces/create/workspace-v2.md#create-a-new-workspace).

#### Templates

* <!-- RUN-11692/RUN-11694 Scoping for template-->Added support for Run:ai a *Scope* in the template form. For configuration information, see [Creating templates](../admin/admin-ui-setup/templates.md#creating-templates).

#### Deployments

* <!-- RUN-11563/RUN-11564 MPS and tolerance -->Improvements in the New *Deployment* form include:
    * Support for *Tolerations*. *Tolerations* guide the system to which node each pod can be scheduled to or evicted by matching between rules and taints defined for each Kubernetes node.
    * Support for *Multi-Process Service (MPS)*. *MPS* is a service which allows the running of parallel processes on the same GPU, which are all run by the same userid. To enable *MPS* support, use the toggle switch on the *Deployments* form.
    !!! Note
        If you do not use the same userid, the processes will run in serial and could possibly degrade performance.

#### Auto Delete Jobs

* <!-- RUN-8586/RUN-11777 -->Added new functionality to the UI and CLI that provides configuration options to automatically delete jobs after a specified amount of time upon completion. Auto-deletion provides more efficient use of resources and makes it easier for researchers to manage their jobs. For more configuration options in the UI, see *Auto deletion* (Step 9) in [Create a new workspace](../Researcher/user-interface/workspaces/create/workspace-v2.md#create-a-new-workspace). For more information on the CLI flag, see [--auto-deletion-time-after-completion](../Researcher/cli-reference/runai-submit.md#-auto-deletion-time-after-completion).

### Run:ai Administrator

#### Authorization

* <!-- RUN-7510/9002 and lots of others -->Run:ai has now revised and updated the *Role Based Access Control (RBAC)* mechanism, expanding the scope of Kubernetes. Using the new *RBAC* mechanism makes it easier for administrators to manage access policies across multiple clusters and to define specific access rules over specific scopes for specific users and groups. Along with the revised *RBAC* mechanism, new user interface views are introduced to support the management of users, groups, and access rules. For more information, see [Role based access control](../admin/runai-setup/access-control/rbac.md#role-based-access-control).

#### Policies

* <!-- RUN-12698/RUN-12699 -->During Workspaces and Training creation, assets that do not comply with policies cannot be selected. These assets are greyed out and have a button on the cards when the item does not comply with a configured policy. The button displays information about which policies are non-compliant.
* <!-- RUN-10622/RUN-10625 Policy blocks workloads that attempt to store data on the node-->Added configuration options to *Policies* in order to prevent the submission of workloads that use data sources of type `host path`. This prevents data from being stored on the node, so that data is not lost when a node is deleted. For configuration information, see [Prevent Data Storage on the Node](../admin/workloads/policies.md#prevent-data-storage-on-the-node).
* <!-- RUN-10575/RUN-10579 Add numeric rules in the policy to GPU memory, CPU memory & CPU -->Improved flexibility when creating policies which provide the ability to allocate a `min` and a `max` value for CPU and GPU memory. For configuration information, see [GPU and CPU memory limits](../admin/workloads/policies.md#gpu-and-cpu-memory-limits) in *Configuring policies*.

#### Nodes and Node Pools

* <!-- RUN-11282/RUN-11283 Nodepools enabled by default-->Node pools are now enabled by default. There is no need to enable the feature in the settings.

#### Quotas and Over-Quota

* <!-- RUN-10251/RUN-10252 - Block over-subscription of quota by Projects/Departments- -->Improved control over how over-quota is managed by adding the ability to block over-subscription of the quota in *Projects* or *Departments*. For more information, see [Limit Over-Quota](../Researcher/scheduling/the-runai-scheduler.md#limit-quota-over-or-under-subscription).
* <!-- RUN-13167/RUN-13168 Department Over-Quota Priority behavior -->Improved the scheduler fairness for departments using the `over quota priority` switch (in Settings). When the feature flag is disabled, over-quota weights are equal to the deserved quota and any excess resources are divided in the same proportion as the in-quota resources. For more information, see [Over Quota Priority](../Researcher/scheduling/the-runai-scheduler.md#over-quota-priority).
* Added new functionality to always guarantee in-quota workloads at the expense of inter-Department fairness. Large distributed workloads from one department may preempt in-quota smaller workloads from another department. This new setting in the `RunaiConfig` file preserves in-quota workloads, even if the department quota or over-quota-fairness is not preserved. For more information, see [Scheduler Fairness](../Researcher/scheduling/the-runai-scheduler.md#fairness).

#### Notifications

* <!-- RUN-9868/RUN-10087 support per user scheduling events notifications (slack/email) -->Added new functionality that provides notifications from scheduling events. Run:ai can now send notifications via email and can be configured so that each user will only get events that are relevant to their workloads. For more information, see [email notifications](../admin/researcher-setup/email-messaging.md#email-notifications).

### Control & Visibility

#### Dashboards

* <!-- RUN-12313/12314 - CPU focused dashboards -->To ease the management of AI CPU and cluster resources, a new CPU focused dashboard was added for CPU based environments. The dashboards display specific information for CPU based nodes, node-pools, clusters, or tenants. These dashboards also include additional metrics that are specific to CPU based environments. This will help optimize visual information eliminating the views of empty GPU dashlets. For more information see [CPU Dashboard](../admin/admin-ui-setup/dashboard-analysis.md#cpu-dashboard).
* <!-- RUN-11421/RUN-11508 Consumption report - Cost and bugs-->Improved the Consumption report interface by moving the Cost settings to the *General* settings menu.
* <!-- RUN-11421/RUN-11508 Consumption report cost and bugs -->Added an additional table to the Consumption dashboard that displays the consumption and cost per department. For more information, see [Consumption dashboard](../admin/admin-ui-setup/dashboard-analysis.md#consumption-dashboard).

#### Nodes

* <!-- RUN-9943/RUN-12176 Nodes - reflect the correct status of the node - add to nodes page the table from the TW ticket -->Improved the readability of the *Nodes* table to include more detailed statuses and descriptions. The added information in the table makes it easier to inspect issues that may impact resource availability in the cluster. For more information, see [Node and Node Pool Status](../Researcher/scheduling/using-node-pools.md#node-and-node-pool-status).

#### UI Enhancements

* <!-- RUN-10221/RUN-10426 Projects V2 - User will be able to export a CSV report - NEW FEATURE -->Added the ability to download a CSV file from any page that contains a table. Downloading a CSV provides a snapshot of the page's history over the course of time, and helps with compliance tracking. All the columns that are selected (displayed) in the table are downloaded to the file.

### Installation and Configuration

#### Cluster Installation and configuration

* <!-- RUN-7085/RUN-9480 Installation - Cluster wizard Improvements -->New cluster wizard for adding and installing new clusters to your system.

#### OpenShift Support

* <!-- RUN-7495/RUN11388 Support PSA / SCCs V2 \(security mechanism for pods on K8S/OCP\)-->Added support for `restricted` policy for [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){target=_blank} (PSA) on OpenShift only. For more information, see [Pod security admission](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#pod-security-admission).
* <!-- RUN-12943 Ability to configure cluster routes certificate in OpenShift-->Added the ability, in OpenShift environments, to configure cluster routes created by Run:ai instead of using the OpenShift certificate. For more information, see the table entry [Dedicated certificate for the researcher service route](../admin/runai-setup/cluster-setup/customize-cluster-install.md#configurations).
