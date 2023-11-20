# Run:ai version 2.15 - November 5, 2023

## New Features

<!-- RUN-10221/RUN-10426 Projects V2 - User will be able to export a CSV report - NEW FEATURE -->
* Added the ability to download a CSV file from all pages that contain a table. Downloading a CSV can provide a snapshot of the page's history over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

<!-- RUN-7495/RUN11388 Support PSA / SCCs V2 \(security mechanism for pods on K8S/OCP\)-->
* Added support for `restricted` policy for [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){target=_blank} (PSA) on OpenShift only. For more information, see [Pod security admission](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#pod-security-admission).

<!-- RUN-10241/RUN-12872 - New Workloads view -->
* Added a new button to the *Jobs* page to switch the view to *Workloads* (feature preview). *Workloads* is a new view for jobs that are running in the platform. The *Workloads* view provides a more advanced UI than the previous *Jobs* UI. The new table format provides:

      * Improved views of the data
      * Improved filters and search
      * More information

    For more information see [Workloads](../admin/workloads/workload-overview-admin.md#workloads-view).

<!-- RUN-12313/12314 - CPU focused dashboards -->
* Added a new dashboard for CPU based environments. The dashboards display specific information for CPU based nodes, node-pools, clusters, or tenants. These dashboards also include additional metrics that specific to CPU based environments. This will help optimize visual information eliminating the views of empty GPU dashlets. For more information see [CPU Dashboard](../admin/admin-ui-setup/dashboard-analysis.md#cpu-dashboard).

<!-- RUN-10622/RUN-10625 Policy blocks workloads that attempt to store data on the node-->
* Added the ability to prevent the submission of workloads that use data sources of type `host path` using policies. This is prevents data from being stored on the node. When a node is deleted, all data stored on that node is lost. For configuration information, see [Prevent Data Storage on the Node](../admin/workloads/policies.md#prevent-data-storage-on-the-node).

<!-- ADDLINK and uncomment when complete) RUN-10602/RUN-10603 - GPU Memory Request & Limit 
* Added the ability to use Dynamic GPU fractions. This allows a workload to request a certain amount of guaranteed GPU memory fraction, and at the same time also request to grow beyond that guaranteed memory fraction more is available. This allows a workload to request a certain amount of guaranteed GPU fraction processing, and at the same time also request to grow beyond that guaranteed fraction if more is available. For more information, see [Dynamic GPU fractions](). -->
  
<!-- RUN-9924/RUN-9925  Granular GPU compute time-slicing / Strict GPU compute time-slicing -->
* Added the ability to configure strict GPU compute time slicing. This gives workloads the exact GPU compute portion based on the requested GPU fraction (GPU Memory Fraction). This creates complete transparency and predictability of the amount of resources (Compute, Memory, etc.) a workload will get from a GPU. For more information, see [GPU Time Slicing](../Researcher/scheduling/GPU-time-slicing-scheduler.md).

<!-- RUN-7085/RUN-9480 Installation - Cluster wizard Improvements -->
* New cluster wizard for adding and installing new clusters to your system.
  
* New cluster installation. The new installation no longer requires downloading and customizing a *values file*. Cluster configurations are preserved during upgrade and are performed using the `runaiconfig` file which creates a separation between installation related flags and cluster customization flags. For more information, see [Customize cluster installation.](../admin/runai-setup/cluster-setup/customize-cluster-install.md).


--8<-- "home/whats-new-2-14.md:6:8"

--8<-- "home/whats-new-2-14.md:15:16"

--8<-- "home/whats-new-2-14.md:18:20"

--8<-- "home/whats-new-2-14.md:26:27"

--8<-- "home/whats-new-2-14.md:29:31"

<!-- --8<-- "home/whats-new-2-14.md:33:35" - removed as per Omer/Gal also in TOC. -->

--8<-- "home/whats-new-2-14.md:45:47"

## Improvements

<!-- RUN-9943/RUN-12176 Nodes - reflect the correct status of the node - add to nodes page the table from the TW ticket -->
* Improved the readability of the node table to include a more detailed status and its description. The added information in the table help to easily asses issues that may impact resource availability in the cluster. For more information, see [Node and Node Pool Status](../Researcher/scheduling/using-node-pools.md#node-and-node-pool-status)

<!-- RUN-11421/RUN-11508 Consumption report - Cost and bugs-->
* Improved the Consumption report interface by moving the Cost settings to the *General* settings menu.

<!-- RUN-10862/RUN-10863 Department as a workspace phase 2 - scope in credentials -->
* Improved *Credentials* creation. Now, a Run:ai scope can be added to credentials. For more information, see [Credentials](../admin/admin-ui-setup/credentials-setup.md).

<!-- RUN-10271/RUN-10321 Mark environment for workload type-->
* Added support for workload types when creating a new or editing and existing environment. Select from `single-node` or `multi-node (distributed)` workloads. The environment is available only on feature forms which are relevant to the workload type selected.

<!-- RUN-10639/RUN-11389 - Researcher Service Refactoring -->

<!-- RUN-12505/RUN-12506 - Support Kubeflow notebooks for scheduling/orchestration -->
* Improved support for KubeFlow Notebooks. Now Run:ai supports scheduling of Kubeflow notebook CRDs with fractional GPUs. Kubeflow notebooks are identified automatically and use a special icon in the *Jobs* UI.

<!-- RUN-10251/RUN-10252 - Block over-subscription of quota by Projects/Departments- -->
* Improved control over how over-quota is managed by adding the ability to block over-subscription of quota in *Projects* or *Departments*. For more information, see [Over quota blocking](../Researcher/scheduling/the-runai-scheduler.md#limit-quota-over-or-under-subscription).

<!-- RUN-13167/RUN-13168 Department Over-Quota Priority behavior -->
* Improved the fairness for departments using the `over quota priority` switch (in Settings). When the feature flag is disabled, over-quota weights are equal to deserved quota and any excess resources are divided in the same proportion as the in-quota resources.

<!-- RUN-10404/RUN-11747 Submit distributed training
* RUN-11194/RUN-11239 All changes done in the UI for distributed training are hidden behind feature flag 
* RUN-11186/RUN-11241 Submitting an MPI/PT/TF/XGBoost distributed training from UI - 1st form page 
* RUN-11206/RUN-11242 Submitting distributed training from UI - 2nd form page
* RUN-11219/RUN-11602 Submitting an MPI distributed training from UI - 3rd form page
* RUN-11231/RUN-11240 Environment for distributed training
-->
* Added support to run distributed workloads via Run:ai workspaces and training. You can configure distributed training on the following:

      * Trainings form
      * Environments form
  
    You can select `single` or `multi-node (distributed)` training. When configuring distributed training, you will need to select a framework from the list. Supported frameworks now include:

       * PyTorch
       * Tensorflow
       * XGBoost
       * MPI
  
    For *Trainings* configuration, see [Adding trainings](../Researcher/user-interface/trainings.md#adding-trainings). See your Run:ai representative to enable this feature. For *Environments* configuration, see [Creating an Environment](../Researcher/user-interface/workspaces/create/create-env.md#creating-a-new-environment).

<!-- RUN-10411/RUN-11390 Support self-signed certificates-->
* Run:ai can be installed in an isolated network. In this air-gapped configuration, the organization will not be using an established root certificate authority but a local certificate authority. This allows inserting the local certificate authority (CA) as a part of the Run:ai installation so it is reconized by all Run:ai services. For more information, see [Working with a Local Certificate Authority](../admin/runai-setup/config/org-cert.md).

<!-- RUN-12943 Ability to configure cluster routes certificate in OpenShift-->
* Added the ability, in OpenShift environments, to configure the certificate to be used in the cluster routes created by Run:ai, instead of using the OpenShift certificate. For more information, see the table entry [Dedicated certificate for the researcher service route](../admin/runai-setup/cluster-setup/customize-cluster-install.md#configurations).

<!-- RUN-10451/RUN-10452 Support new Kubernetes and OpenShift releases - Q3/2023-->
* Updated the compatibility matrix to include supported versions for Kubernetes and OpenShift. For more information, see [Cluster prerequisites](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#kubernetes)

--8<-- "home/whats-new-2-14.md:41:43"

<!-- RUN-11282/RUN-11283 Nodepools enabled by default-->
* Improvement in node pools which are now enabled by default. There is no need to enable the feature in the settings.

<!-- RUN-11292/RUN-11592 General changes in favor of any asset based workload \(WS, training, DT\)-->
* Improved the *Trainings* and *Workspaces* forms. Now the runtime field for *Commands* and *Arguments* can be edited even after it has inherited it from the environment.

<!-- RUN-11525/RUN-11538 Support Kubernetes non-privileged PSA on project namespaces for Openshift-->

<!-- RUN-11692/RUN-11694 Scoping for template-->
* Added support for *Scope* in the template form. For configuration information, see [Creating templates](../admin/admin-ui-setup/templates.md#creating-templates).

<!-- RUN-12698/RUN-12699 -->
* Improved support for assets that appear unusable. Assets that are greyed out now have a button on the cards when the item does not comply with a configured policy. The button displays information about which policies are non-compliant and will require a correction to enable the asset.

--8<-- "home/whats-new-2-14.md:49:56"
