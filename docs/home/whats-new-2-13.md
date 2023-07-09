# Run:ai version 2.13

## Version 2.13.0

### Release content

<!-- RUN-9024/9027 Ray Support - schedule and support of Ray Jobs -->

<!-- RUN-9312/9313 Projects V2 -->
**Projects**

**Projects** is a tool for administrators and researchers to control resource allocation, create efficient organizational structures, and help prioritize workloads.

For administrators:

* Monitor resource allocation and performance for multiple workloads.
* Organize, isolate, and allocate resources for multiple workloads and groups of researchers.
* Granular control over resource allocation for multiple groups of researchers.

For researchers:

* Control over workload resource allocation and prioritization.
* Control over workload node assignment and node pool priority.

To configure a project, see [Projects](../admin/admin-ui-setup/project-setup.md).

**Dashboards**

<!-- RUN9530/9577 New Dashboard for Quota management -->
* Added a new dashboard for Quota management. The dashboard filters the display of resource quotas based on *Departments*, *Projects*, and *Node pools*. For more information, see [Quota management dashboard](../admin/admin-ui-setup/dashboard-analysis.md#quota-management-dashboard).

* Added to the Overview dashboard a dropdown filter for node pools. From the dropdown, select one or more node pools.

<!-- RUN-9359/9360 Incorporating Node Pools in Workspaces -->
**Nodes**

* A node is a worker machine that runs workloads, and a node pool is group of nodes within a cluster that all have the same configuration. Node pools use node labels as its identification. Run:ai has added a table for viewing nodes and for configuring node pools. To configure a node pool, see [Configuring node pools](../Researcher/scheduling/using-node-pools.md#creating-new-node-pools).

<!-- RUN-9960/9961 Per node-pool GPU placement strategy -->
* Added support for per node pool GPU and CPU scheduling strategy. Choose from `Bin Pack` or `Spread`. For configuration information, see [Creating new node pools](../Researcher/scheduling/using-node-pools.md#creating-new-node-pools).

* Added columns to the node pool grid to show the current placement Strategy per node pool (`Bin Pack` or `Spread`).

**Integrations**

<!-- RUN-9651/9652 Schedule and support of Elastic Jobs (Spark) -->
* Added support for SPARK and Elastic jobs. For more information, see [Running SPARK jobs with Run:AI](../admin/integration/spark.md#).

<!-- RUN-8748/8958 RUN-9627/10483 WANDB-SWEEP & Run.ai integration / WANDB SWEEP Integration - phase 2 -->
* Added sweep to Weights and Biases job submission. Sweep combines a strategy for exploring hyperparameter values with the code that evaluates them. The strategy can be as simple as trying every option or as complex as Bayesian Optimization and Hyperband (BOHB). To configure WANDB sweep, see [Sweep configuration](../admin/integration/weights-and-biases.md#sweep-configuration).

**Workspaces**

<!-- RUN-9270/9274 - Interactive Time limit Fixes -->
* Fixed time limits so that any workload that reach the timeout are now suspended/stopped. The admin can change the time limit and the timeout for new and already running workloads. Already running workloads will update and stop based on the new settings.

<!-- RUN-8862/9292 - Department as a workspace asset creation scope - phase 1 -->
* Added a tree selection function to the scope field when creating a new asset.  Included assets are *Environment*, *Compute resource*,  and some types of *Data source*.

<!-- RUN-8904/8960 - Cluster wide PVC in workspaces -->
* Added support for making a PVC data source available to all projects. In the *New data source* form, when creating a new PVC data source, select *All* from the *Project* pane.

**Environments**
<!-- RUN-8862/9292 - Department as a workspace asset creation scope - phase 1 -->
* Added a tree selection function to the scope field when creating a new environment. For more information see, [Creating a new environment](../Researcher/user-interface/workspaces/create/create-env.md#creating-a-new-environment).

<!-- RUN-9843/9852 - Allow researcher to create docker registry secrets -->
* Added *Docker registry* to the *Credentials* menu. Users can create docker credentials for use in specific projects for image pulling. To configure credentials, see [Configuring credentials](../admin/admin-ui-setup/credentials-setup.md#configuring-credentials).

<!-- RUN-8453/8454/8927 Technical documentation of 'Projects new parameters and options' use existing namespace, status, and more  -->

<!-- RUN-10105/10106 Align Departments with Projects V2 -->
* Added support for node pools to *Departments*, including new columns in the *Departments* grid.

**Researcher tools**

<!-- RUN-8631/8880 Researcher API for train jobs -->
* Added `suspend`/`stop` to [Submitting Workloads via HTTP/REST](../developer/cluster-api/submit-rest.md).

**Administrative**

<!-- RUN-7757/9296 Custom logo in UI -->
* Added support for uploading a custom company logo to be displayed in the UI for both SaaS and self-hosted environments. Use the  [Upload tenant logo](https://app.run.ai/api/docs#tag/Tenant/operation/upload_tenant_logo){target=_blank} endpoint in the Admin API.

<!-- RUN-10588/10590 Allow workload policy to prevent the use of a new pvc -->
* Added support for default item fields. For more information, see Policies, [Complex values](../admin/workloads/policies.md#complex-values).

<!-- RUN-9521/9522  Provide a description in CLI when command fails no need to document-->


<!-- RUN-10287/10317/10313-10851 Show Node pools priority list according to workspace policy -->
* Added Node pool selection as part of the workload and workspace submission form. This allows researchers to quickly determine the list of node pools available and their priority. Priority is set by dragging and dropping them in the desired order of priority. In addition, when the node pool priority list is locked by an administrator policy, the list isn't editable by the Researcher even if the workspace is created from a template or copied from another workspace.

<!-- RUN-9826/10186 Support PVC from block storage -->
* Added support for PVC block storage in the *New data source* form. For more information, see [Create a PVC data source](../Researcher/user-interface/workspaces/create/create-ds.md#create-a-pvc-data-source).

<!-- RUN-9364/10850 Search box for cards in V2 assets -->
* Added a search box for cards in *Workspaces*, *Trainings*, and *Templates*. The search box is available in any section where there is a card gallery and will filter based on titles or field values.

* In the *New data source* form for a new PVC data source, in the *Volume mode* field, select from *Filesystem* or *Block*.


## Installation

The manual process of upgrading Kubernets CRDs is no longer needed when upgrading to the most recent version (2.13) of Run:ai.
### Known issues

### Fixed issues

| Internal ID | Description                                                                                                                                |
| :---------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
| RUN-9039    | Fixed an issue where in the new job screen, after toggling off the pre-emptible flag, and a job is submitted, the job still shows as pre-emptible. |
| RUN-9323    | Fixed an issue with a non-scaleable error message when scheduling hundreds of nodes is not successful.                                     |
| RUN-9324    | Fixed an issue where the scheduler did not take into consideration the amount of storage so there is no explanation that pvc is not ready. |
| RUN-9902    | Fixed an issue where Prometheus doesn't have sufficient permissions in 2.9 on openshift                                                    |
| RUN-9920    | Fixed an issue where the `canEdit` key is not validated properly for itemized fields.                                                     |
| RUN-10052   | Fixed an issue where a job can't be submitted using the previous version job from template.                                                |
| RUN-10053   | Fixed an issue where the Node pool column is unsearchable in the job list.                                                                 |
| RUN-10102   | Fixed an issue where duplicate series for the match group error were found in some tables in the analytics screen.                         |
| RUN-10366   | Fixed an issue in Elastic fair share calculations.                                                                                       |
| RUN-10367   | Fixed an issue when correctly sorting ray and kubeflow pods.                                                                               |
| RUN-10379   | Fixed an issue where projects with an over quota weight greater 0 cannot be saved.                                                         |
| RUN-10380   | Fixed an issue in the new Projects UI. The project is stuck `Updating` without changing any field.                                         |
| RUN-10406   | Fixed an issue where cluster sync takes a long time after a restart to update new jobs.                                                    |
| RUN-10422   | Fixed an issue where node details show associated workloads that are actually finished (successfully/failed/etc.).                         |
| RUN-10500   | Fixed an issue where jobs are shown as running even though they don't exist in the cluster.                                                |
| RUN-10729   | Fixed an issue where the runaijob-contoller reports an incorrect status.                                                                   |
| RUN-10813   | Fixed an issue adding a data source.                                                                                                       |
