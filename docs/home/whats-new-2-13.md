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

To configure a project, see [Projects](). <!-- TODO - need to merge this with the current projects file. -->

<!-- RUN-9359/9360 Incorporating Node Pools in Workspaces -->
**Nodes**

A node is a worker machine that runs workloads, and a node pool is group of nodes within a cluster that all have the same configuration. Node pools use node labels as its identification. Run:ai has added a table for viewing nodes and for configuring node pools. To configure a node pool, see [Configuring node pools](../Researcher/scheduling/using-node-pools.md#creating-new-node-pools).

<!-- RUN-9651/9652 Schedule and support of Elastic Jobs (Spark) -->

Added support for SPARK and Elastic jobs. For more information, see [Running SPARK jobs with Run:AI](../admin/integration/spark.md#)

<!-- RUN-9960/9961 Per node-pool GPU placement strategy -->
Added support for node-pool GPU and CPU placement scheduling strategy in addition to the current scheduling strategy (cluster-wide).

Added to the node pool grid, columns to show the current placement Strategy per node pool (Bin Pack or Spread).

<!-- RUN-9270/9274 - Interactive Time limit Fixes -->

Fixed interactive time limits so that workloads that reach the timeout are now suspended/stopped. The admin can change the time limit and the timeout for new and already running workloads. Already running workloads will update and stop based on the new settings. Workloads do not reach a state of failure so that they can be resumed later.

<!-- RUN-8862/9292 - Department as a workspace asset creation scope - phase 1 -->
Added a tree selection function to the scope field when creating a new environment. For more information see, [Creating a new environment](../Researcher/user-interface/workspaces/create/create-env.md#creating-a-new-environment).

<!-- RUN-8904/8960 - Cluster wide PVC in workspaces -->
Added support for making a PVC data source available to all projects. In the *New data source* form, when creating a new PVC data source, select *All* from the *Project* pane.

<!-- RUN-8453/8454/8927 Technical documentation of 'Projects new parameters and options' use existing namespace, status, and more  -->

<!-- RUN-8789/8926 Integrate and certify DeepSpeed to be used with Run:ai (multi pod using open-mpi) - released in 2.12 -->

<!-- RUN-8748/8958 RUN-9627/10483 WANDB-SWEEP & Run.ai integration / WANDB SWEEP Integration - phase 2 -->

Added sweep to Weights and Biases job submission. Sweep combines a strategy for exploring hyperparameter values with the code that evaluates them. The strategy can be as simple as trying every option or as complex as Bayesian Optimization and Hyperband (BOHB). To configure WANDB sweep, see [Sweep configuration](../admin/integration/weights-and-biases.md#sweep-configuration).

<!-- RUN-8891/8959 Comet integration in workspace  - released in 2.12 -->

<!-- RUN-9530/9577 Added node pools and Departments to Dashboard -->
Added to the Overview and the Analytics dashboards, a dropdown filter for node pools.

<!-- RUN-10105/10106 Align Departments with Projects V2 -->
Added support for node pools to *Departments*, including new columns in the *Departments* grid.


<!-- RUN-8631/8880 Researcher API for train jobs -->
Added `suspend`/`stop` to [Submitting Workloads via HTTP/REST](../developer/cluster-api/submit-rest.md).

<!-- RUN-7757/9296 Custom logo in UI -->
Added support for uploading a custom company logo to be displayed in the UI for both SaaS and self-hosted environments. Use the  [Upload tenant logo](https://app.run.ai/api/docs#tag/Tenant/operation/upload_tenant_logo){target=_blank} endpoint in the Admin API.

<!-- RUN-8824/9352  Quick updates so workspace will support training workloads - done in 2.12 -->

<!-- RUN-9521/9522  Provide a description in CLI when command fails -->

<!-- RUN-9826/10186 Support PVC from block storage -->
In the *New data source* form for a new PVC data source, in the *Volume mode* field, select from *Filesystem* or *Block*.

## Installation

The manual process of upgrading Kubernets CRDs is no longer needed when upgrading to the most recent version (2.13) of Run:ai.
### Known issues

### Fixed issues
