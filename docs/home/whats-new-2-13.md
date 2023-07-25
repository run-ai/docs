# Run:ai version 2.13

## Version 2.13.7

### Release date

July 2023

#### Release content

<!-- RUN-10803 -->
* Added dashboard filters to apply on historic quota ratio widget.

#### Fixed issues

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-10785 | [Backend][RBAC] auth svc cant get tenant name after  migration. |
| RUN-11080 | Fixed an issue in OpenShift environments where log in via SSO with the kubeadmin user, gets blank pages for every page. |
| RUN-11119 | wrong value in nodepools modal in projects UI. - Natasha |
| RUN-11120 | Fixed an issue where the *Projects* table does not show correct metrics when Run:a version 2.13 is paired with a Run:ai 2.8 cluster. |
| RUN-11121 | Fixed an issue where the wrong over quota memory alert is shown in the *Quota management* pane in project edit form. |
| RUN-11272 | ocp multi cluster - fix cluster drop down. - Noa F.|
## Version 2.13.4

### Release date

July 2023

#### Fixed issues

| Internal ID | Description |
|-----------|--------------|
| RUN-11089 | Fixed an issue when creating an environment, commands in the *Runtime settings* pane and are not available in other assets (for example in a new *Training*). |

## Version 2.13.1

### Release date

July 2023

#### Release content
<!-- RUN-10477 -->
* Added a feature in the controller that deletes completed or failed jobs after a defined period of time. This allows the reusing of workload names that were used before, and helps to clean up the database from jobs that are no longer relevant so they do not show in the UI or CLI.

<!-- RUN-11024 -->
* Made an improvement so that occurrences of labels that are not in use anymore are deleted.

#### Fixed issues

N/A

## Version 2.13.0

### Release content

This version contains features and fixes from previous versions starting with 2.9. Refer to the prior versions for specific features and fixes. For information about features, functionality, and fixed issues in previous versions see:

* [What's new 2.12](whats-new-2-12.md)
* [What's new 2.10](whats-new-2-10.md)
* [What's new 2.9](whats-new-2-9.md)

**Projects**
<!-- RUN-9312/9313 Projects V2 -->
* Improved the **Projects** UI for ease of use. **Projects** follows UI upgrades and changes that are designed to make setting up of components and assets easier for administrators and researchers. To configure a project, see [Projects](../admin/admin-ui-setup/project-setup.md).

**Dashboards**

<!-- RUN9530/9577 New Dashboard for Quota management -->
* Added a new dashboard for **Quota management**, which provides an efficient means to monitor and manage resource utilization within the AI cluster. The dashboard filters the display of resource quotas based on *Departments*, *Projects*, and *Node pools*. For more information, see [Quota management dashboard](../admin/admin-ui-setup/dashboard-analysis.md#quota-management-dashboard).

* Added to the **Overview dashboard**, the ability to filter the cluster by one or more node pools. For more information, see [Node pools](../Researcher/scheduling/using-node-pools.md).

**Nodes and Node pools**
<!-- RUN-9960/9961 Per node-pool GPU placement strategy -->
* Run:ai scheduler supports 2 scheduling strategies: Bin Packing (default) and Spread. For more information, see [Scheduling strategies](../Researcher/scheduling/strategies.md). You can configure the scheduling strategy in the node pool level to improve the support of clusters with mixed types of resources and workloads. For configuration information, see [Creating new node pools](../Researcher/scheduling/using-node-pools.md#creating-new-node-pools).

* GPU device level DCGM Metrics are collected per GPU and presented by Run:ai in the Nodes table. Each node contains a list of its embedded GPUs with their respective DCGM metrics.
See [DCGM Metrics](https://docs.nvidia.com/datacenter/dcgm/latest/user-guide/feature-overview.html#metrics){target=_blank} for the list of metrics which are provided by NVidia DCGM and collected by Run:ai. Contact your Run:ai customer representative to enable this feature.

<!-- Hagay says no ticket number for this -->
* Added per node pool over-quota priority. Over-quota priority sets the relative amount of additional unused resources that an asset can get above its current quota. For more information, see [Over-quota priority](../Researcher/scheduling/the-runai-scheduler.md#over-quota-priority).

<!-- RUN-9359/9360 Incorporating Node Pools in Workspaces -->
* Added support of associating workspaces to node pool.
The association between workspaces and node pools is done using *Compute resources* section. In order to associate a compute resource to a node pool, in the *Compute resource* section, press *More settings*. Press *Add new* to add more node pools to the configuration. Drag and drop the node pools to set their priority.

<!-- RUN-10287/10317/10313-10851 Show Node pools priority list according to workspace policy -->
* Added Node pool selection as part of the workload submission form. This allows researchers to quickly determine the list of node pools available and their priority. Priority is set by dragging and dropping them in the desired order of priority. In addition, when the node pool priority list is locked by a policy, the list isn't editable by the Researcher even if the workspace is created from a template or copied from another workspace.

**Time limit duration**

* Improved the behavior of any workload time limit (for example, *Idle time limit*) so that the time limit will affect existing workloads that were created before the time limit was configured. This is an optional feature which provides help in handling situations where researchers leave sessions open even when they do not need to access the resources. For more information, see [Limit duration of interactive training jobs](../admin/admin-ui-setup/project-setup.md#limit-duration-of-interactive-and-training-jobs).

* Improved workspaces time limits. Workspaces that reach a time limit will now transition to a state of `stopped` so that they can be reactivated later.

* Added time limits for training jobs per project. Administrators (Department Admin, Editor) can limit the duration of Run:ai Training jobs per Project using a specified time limit value. This capability can assist administrators to limit the duration and resources consumed over time by training jobs in specific projects. Each training job that reaches this duration will be terminated. 

<!-- Logically this part shopuld go above the integration. The flow of information is broken. Then we should have PVC Data Sources, Crenetials and Policies-->
**Workload assets**

<!-- RUN-8862/9292 - Department as a workspace asset creation scope - phase 1 -->

* Extended the collaboration functionality for any workload asset such as *Environment*, *Compute resource*, and some *Data source types*. These assets are now shared with **Departments** in the organization in addition to being shared with specific projects, or the entire cluster.

<!-- RUN-9364/10850 Search box for cards in V2 assets -->
* Added a search box for card galleries in any asset based workload creation form to provide an easy way to search for assets and resources. To filter use the asset name or one of the field values of the card.

**PVC data sources**
<!-- RUN-9826/10186 Support PVC from block storage -->
* Added support for PVC block storage in the *New data source* form. In the *New data source* form for a new PVC data source, in the *Volume mode* field, select from *Filesystem* or *Block*. For more information, see [Create a PVC data source](../Researcher/user-interface/workspaces/create/create-ds.md#create-a-pvc-data-source).

**Credentials**

<!-- RUN-9843/9852 - Allow researcher to create docker registry secrets -->
* Added *Docker registry* to the *Credentials* menu. Users can create docker credentials for use in specific projects for image pulling. To configure credentials, see [Configuring credentials](../admin/admin-ui-setup/credentials-setup.md#configuring-credentials).

<!-- RUN-8453/8454/8927 Technical documentation of 'Projects new parameters and options' use existing namespace, status, and more added to projects v2-->

**Policies**
<!-- RUN-10588/10590 Allow workload policy to prevent the use of a new pvc -->
* Improved policy support by adding `DEFAULTS` in the `items` section in the policy. The `DEFAULTS` section sets the default behavior for items declared in this section. For example, this can be use to limit the submission of workloads only to existing PVCs. For more information and an example, see Policies, [Complex values](../admin/workloads/policies.md#complex-values).

<!-- RUN-8904/8960 - Cluster wide PVC in workspaces -->
* Added support for making a PVC data source available to all projects. In the *New data source* form, when creating a new PVC data source, select *All* from the *Project* pane.

**Researcher API**

<!-- RUN-8631/8880 Researcher API for train jobs -->
* Extended researcher's API to allow stopping and starting of workloads using the API. For more information, see [Submitting Workloads via HTTP/REST](../developer/cluster-api/submit-rest.md).

**Integrations**

<!-- RUN-9651/9652 Schedule and support of Elastic Jobs (Spark) -->
* Added support for Spark and Elastic jobs. For more information, see [Running Spark jobs with Run:ai](../admin/integration/spark.md#).
<!-- RUN-9024/9027 Ray Support - schedule and support of Ray Jobs -->
* Added support for Ray jobs. Ray is an open-source unified framework for scaling AI and Python applications. For more information, see [Integrate Run:ai with Ray](../admin/integration/ray.md#integrate-runai-with-ray).

* Added integration with Weights & Biases Sweep to allow data scientists to submit hyperparameter optimization workloads directly from the Run:ai UI. To configure sweep, see [Sweep configuration](../admin/integration/weights-and-biases.md#sweep-configuration).

<!-- RUN-9510 -->
* Added support for XGBoost. XGBoost, which stands for Extreme Gradient Boosting, is a scalable, distributed gradient-boosted decision tree (GBDT) machine learning library. It provides parallel tree boosting and is the leading machine learning library for regression, classification, and ranking problems. For more information, see [runai submit-dist xgboost](../Researcher/cli-reference/runai-submit-dist-xgboost.md)

**Compatability**

* Added support for multiple OpenShift clusters. For configuration information, see [Installing additional Clusters](../admin/runai-setup/self-hosted/ocp/additional-clusters.md).

## Installation

* The manual process of upgrading Kubernetes CRDs is no longer needed when upgrading to the most recent version (2.13) of Run:ai.
* From Run:ai 2.12 and above, the control-plane installation has been simplified and no longer requires the creation of a *backend values* file. Instead, install directly using `helm` as described in [Install the Run:ai Control Plane](../admin/runai-setup/self-hosted/k8s/backend.md#install-the-control-plane).  
* From Run:ai 2.12 and above, the air-gapped, control-plane installation now generates a `custom-env.yaml` values file during the [preparation](../admin/runai-setup/self-hosted/k8s/preparations.md#prepare-installation-artifacts) stage. This is used when installing the [control-plane](../admin/runai-setup/self-hosted/k8s/backend.md#install-the-control-plane).

### Known issues
| Internal ID | Description            |
| :---------- | :---------------------------------- |
| RUN-11005 | Incorrect error messages when trying to run `runai` CLI commands in an OpenShift environment. |
| RUN-11009 | Incorrect error message when a user without permissions to tries to delete another user. |

### Fixed issues

| Internal ID | Description                                                                                                                                |
| :---------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
| RUN-9039    | Fixed an issue where in the new job screen, after toggling off the preemptible flag, and a job is submitted, the job still shows as preemptible. |
| RUN-9323    | Fixed an issue with a non-scaleable error message when scheduling hundreds of nodes is not successful.                                     |
| RUN-9324    | Fixed an issue where the scheduler did not take into consideration the amount of storage so there is no explanation that pvc is not ready. |
| RUN-9902    | Fixed an issue in OpenShift environments, where there are no metrics in the dashboard because Prometheus doesn’t have permissions to monitor the `runai` namespace after an installation or upgrade to 2.9. |
| RUN-9920    | Fixed an issue where the `canEdit` key in a policy is not validated properly for itemized fields when configuring an interactive policy.   |
| RUN-10052   | Fixed an issue when loading a new job from a template gives an error until there are changes made on the form.   |
| RUN-10053   | Fixed an issue where the Node pool column is unsearchable in the job list.                                                                 |
| RUN-10422   | Fixed an issue where node details show running workloads that were actually finished (successfully/failed/etc.).                         |
| RUN-10500   | Fixed an issue where jobs are shown as running even though they don't exist in the cluster.                                                |
| RUN-10813   | Fixed an issue in adding a `data source` where the path is case sensitive and didn't allow uppercase. |
