# What’s New in Version 2.19

## **Release Content** <date>

* [Deprecation notifications](#deprecation-notifications)  

## Researchers

### Improved visibility into pending workloads

For workloads with the status of "Pending," the user can click the “i” icon next to the status to view details of why the workload hasn’t been scheduled.    
    
### New workload events  
    
  There are now new GPU resource optimization-related messages that are viewable as workload events. These events help users understand the decisions made by the Run:ai GPU toolkit while handling Run:ai’s GPU resource optimization features.  
  Run:ai’s GPU resource optimization offers unique capabilities that take GPU utilization to a new level and helps customers increase their productivity while maximizing their return on GPU investment. 

### Improved command line interface autocompletion

  CLI V2 now autocompletes nouns such as project names and workload names for better data consistency with the UI, auto-upgrades, and interactive mode.

### Details pane in the Workloads view 

  A new DETAILS tab for workloads has been added and presents additional workload information, including Container command, Environment variables, and CLI command syntax (if the workload was submitted via CLI). 


### Container path outside the data source asset  
    
  AI practitioners can now override the predefined container path for each data source when submitting a workload via the Run:ai UI. While the container path must still be specified as part of the data source asset, researchers can now override the default container path when submitting workloads.   
    
### Node toleration for workloads  
    
  Researchers can now optionally set tolerations for workloads, letting them bypass node taints during workload submission via the Run:ai UI.  
  To use this feature, make sure it is activated under General Settings.  
  For more information, refer to the Kubernetes [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) Guide.  
    
### Topology-aware scheduling  
    
  When submitting a distributed training workload through the Run:ai UI, researchers can enable topology-aware scheduling. This feature allows an optimized placement within specific placement groups, such as regions, availability zones, or other topologies. To use this, make sure it is activated under General Settings.  
    
### Bulk deletion of workloads  
    
  Users can now delete workloads in bulk via the Run:ai UI. They’ll be notified if they try to delete workloads for which they don’t have permissions (and those workloads will not be deleted in this process). Multi-selection can also be done using standard keyboard functions.   
    
### Enhanced policy representation in the Run:ai UI

  To improve AI practitioners' understanding of administrators’ policy rules and defaults, the UI now includes more clarity to the enforcement and the default values representation for workload fields that are not encapsulated in the asset selection. This update aims to make policy enforcement more intuitive and transparent for practitioners. 

### Configuration of credentials as environment variables

  Researchers can now easily define pre-configured credentials as environment variables to access private resources. This is available through the Run:ai UI during the workload submission process, specifically under the runtime settings section. 


### Expanded scope of ConfigMap as data source

  When creating a data source of type ConfigMap, researchers can now not only select a project but also a cluster or department.


### Improved workload scheduling algorithm  
    
  The Run:ai scheduler algorithm for handling large distributed workloads has been improved and is now more efficient, resulting in better handling of large distributed workloads, and better performance.   
  

## ML Engineer (Inference)

### Additional data sources for inference workloads

  When submitting an inference workload via the UI and API, users can now use NFS and hostPath data sources.

### Hugging Face integration improvements

  To reduce errors when submitting inference workloads, additional validations are done for the Hugging Face integration, ensuring that only valid models are submitted, thus enhancing overall reliability.

### Rolling inference updates

  ML engineers can now roll updates onto existing inference workloads. Once the revised workload (the update) is up and running, request traffic is redirected to the new version of the workload and the previous version is terminated, ensuring that services are not impacted during the update.

  See [Inference overview](../Researcher/workloads/inference-overview.md) for more information.


### Inference endpoint authorization   
  When sharing inference endpoints securely using Run:ai, ML engineers can limit access to the endpoint by specifying the authorized users or groups allowed to use the service (i.e., send requests to the endpoint) after being authenticated. This restriction is especially important when handling sensitive information or when you want to manage costs by sharing the service with a controlled group of consumers.

## Run:ai Developer

### Metrics and telemetry

  Additional metrics and telemetry are available via the API. For more information, see the details below and in [Metrics API](../developer/metrics/metrics-api.md): 

* Metrics (over time)  
    * Cluster  
        * TOTAL_GPU_NODES  
        * GPU_UTILIZATION_DISTRIBUTION  
        * UNALLOCATED_GPU  
    * Nodepool  
        * TOTAL_GPU_NODES   
        * GPU_UTILIZATION_DISTRIBUTION   
        * UNALLOCATED_GPU  
    * Workload  
        * GPU_ALLOCATION  
    * Node  
        * GPU_UTILIZATION_PER_GPU  
        * GPU_MEMORY_UTILIZATION_PER_GPU  
        * GPU_MEMORY_USAGE_BYTES_PER_GPU  
        * CPU_USAGE_CORES  
        * CPU_UTILIZATION  
        * CPU_MEMORY_USAGE_BYTES  
        * CPU_MEMORY_UTILIZATION  
* Telemetry (current time)  
    * Node  
        * ALLOCATED_GPUS  
        * TOTAL_CPU_CORES  
        * USED_CPU_CORES  
        * ALLOCATED_CPU_CORES  
        * TOTAL_GPU_MEMORY_BYTES  
        * USED_GPU_MEMORY_BYTES  
        * TOTAL_CPU_MEMORY_BYTES  
        * USED_CPU_MEMORY_BYTES  
        * ALLOCATED_CPU_MEMORY_BYTES  
        * IDLE_ALLOCATED_GPUS

## Administrator

### Pagination in user API  
  Pagination has been added, removing the limitation to the number of users listed in the Run:ai UI.

### Audit log

  The audit log has been updated, so system admins can view audit logs directly in the Run:ai UI and download them in CSV or JSON formats, providing flexible options for data analysis and compliance reporting. Version 2.19 reintroduces a fully functional audit log (event history), ensuring comprehensive tracking across projects, departments, access rules, and more. In the new version, all entities are logged except logins and workloads.   
  For more information, see [Audit logs](../admin/maintenance/audit-log.md).

## Platform Administrator

### Department scheduling rules  
  Scheduling rules have been added at the department level. For more information, see [scheduling rules](../platform-admin/aiinitiatives/org/scheduling-rules.md).  
    
### Department node pool priority  
  Node pool priority has been added at the department level. For more information, see [node pools](../platform-admin/aiinitiatives/resources/node-pools.md)   
    
### Department and project grids  
  There is now improved filtering and sorting in the Projects and Departments views, including a multi-cluster view and new filters.   
    
### Overview dashboard  
  “Idle allocated GPU devices” has been added to the Overview dashboard.

### Workload policy for distributed training workloads in the Run:ai UI  
    
  Distributed workload policies can now be created via the Run:ai UI. Admins can set defaults, enforce rules, and impose setup on distributed training through the UI YAML, as well as view the distributed policies (both in the policy grid and while submitting workloads). For distributed policies, workers and leaders may require different rules due to their different specifications.  
    
### Reconciliation of policy rules   
  A reconciliation mechanism for policy rules has been added to enhance flexibility in the policy submission process. Previously, if a specific field was governed by a policy for a certain hierarchy, other organizational units couldn’t submit a policy with rules that regarded this specific field. Now, new policies for hierarchies that mention an existing policy field will no longer be blocked.   
  The effective rules are selected based on the following logic:   
1. For the compute and security sections in the workload spec of the [Run:ai API](https://api-docs.run.ai/2.18/tag/Workspaces#operation/create_workspace1), the highest hierarchy is chosen for the effective policy (tenant > cluster > department > project).   
2. For any other fields in the policy, the lowest hierarchy closest to the actual workload becomes the effective for the policy (similar to policy defaults).  
   Additionally, while viewing the effective policy, each rule displays its source of the origin policy, allowing users to clearly understand the selected hierarchy of the effective policy.  
   

## Infrastructure Administrator 

### Support for COS over GKE   
    
  With Run:ai version 2.19, the Run:ai cluster on Google Kubernetes Engine (GKE) supports Container-Optimized OS (COS) when NVIDIA GPU Operator 24.6 or newer is installed. This is in addition to the already supported Ubuntu on GKE.  
    
### Run:ai and Karpenter interworking

	  
Run:ai now supports interworking with Karpenter. Karpenter is an open-source Kubernetes cluster auto-scaler built for cloud deployments. Karpenter optimizes the cloud cost of a customer’s cluster by moving workloads between different node types, bin-packing nodes, using lower-cost nodes where possible, scaling up new nodes on demand, and shutting down unused nodes with the goal of optimizing and reducing costs.

Please read the [documentation](../Researcher/scheduling/karpenter.md) for more information on Run:ai and Karpenter interworking considerations.

## Control and Visibility (UI changes)

### New Run:ai UI navigation

<video  width="800" controls>
<source src="../img/new-navigation2-19.mp4" type="video/mp4">
</video>

  The platform navigation has been updated to offer a more modern design, easier  navigation, and address all personas interacting with the UI.  

  The left-side menu now has seven categories, each with its own reorganized sub-options that appear in the pane next to the menu options.


  If you close the sub-options pane, you can hover over the categories, and the sub-options float and can be used in the same way.


  The options presented in the menu and categories continue to match each user’s permissions, as in the legacy navigation.


  Below is the full list of menu and sub-options and changes:


  **Analytics**  
  Displays the Run:ai dashboards allowing the different users to analyze, plan, and improve system performance AI workload execution.   
  This category contains the following options:

* Overview  
* Quota management  
* Analytics  
* Consumption  
* Multi-cluster overview  
    
**Workload manager**  
Enables AI practitioners to develop modes, train them, and deploy them into production.  All supported tools and capabilities can be found here. This category contains the following options: 

* Workloads  
* Deleted workloads (now separated from current workloads. If not visible, it can be activated from Settings -> Workloads -> Deleted workloads)  
* Templates  
* Assets (these options are visible via a collapsible menu)  
    * Models  
    * Environments  
    * Compute resources  
    * Data sources  
    * Credentials


**Resources**  
Enables viewing and managing all cluster resources. In the new navigation, nodes and node pools have been split into different grids.  
This category contains the following options:

* Clusters  
* Node pools (separated from the Nodes page to its own page)  
* Nodes  
    
**Organization**   
Maps system organizations to ensure that resource allocation and policies align with the organizational structure, business projects, and priorities.  
This category contains the following options:  

* Departments  
* Projects  
    
**Access**  
Makes it possible to provide authorization of the different system users to perform actions and alignment with their role and scope of projects within the organization.   
This was moved from the legacy menu where it appeared in the header of the screen under Tools and Settings.  
This category contains the following options:  

* Users  
* Applications  
* Roles (separated from the Access rules and roles page to its own page)  
* Access rules (separated from the Access rules and roles page to its own page)  
    
**Policies**  
Presents the tools to enforce controls over the AI infrastructure enabling different users to be effective while working in alignment with organizational policies.   
This category contains the following options:  
    
* Workload policies  
    
**Admin**   
Presents all administrator functions of the Run:ai platform.   
This was moved from the legacy menu where it appeared in the header of the screen under Tools and Settings.  
This category contains the following options:  

* General settings (previously General)  
* Event history  
    
For users with more than one cluster, in the legacy version the cluster selection appeared in the header of the page. In the new navigation, the cluster selection is part of the grid and changes only affect the items on that page.  
    
If a user prefers not to use the new UI navigation, there is an option to switch back to the legacy navigation by clicking the **Back to legacy navigation** option.  
    



**Installation and configuration**

* Tenant logos can now be uploaded to the Run:ai UI via API. The logo should be in base64 format and should not be white to avoid blending into the background. The logo should be no more than 20px tall. See [Upload logo for tenant API](https://api-docs.run.ai/2.18/tag/Logo/#operation/upload_tenant_logo1).  
* Run:ai now supports NVIDIA GPU Operator version 24.6  
* Run:ai now supports Kubernetes version 1.31

## Deprecation notifications

### Feature deprecations

#### Legacy Jobs view

The legacy Jobs view will be fully deprecated in the Q1/25 release. We recommend that all users adopt the [Workloads view](../platform-admin/workloads/workload-overview.md#workloads-view), which offers all the capabilities of the legacy Jobs view with additional enhancements.   
    SaaS customers will gradually be transitioned to the Workloads view during Q4/24.  
    
!!! Note 
    Users can still submit workloads via the legacy Jobs submission form.

#### Dynamic MIG deprecation 

Dynamic MIG deprecation process starts with Run:ai v2.19 (Q4/24 release)

* The feature is still available and MIG Profile APIs still function but are marked as Deprecated. See the table below for more details.
* In Q1/25 release, ‘Dynamic MIG’ will not be usable anymore but the APIs will still be accessible.
* In Q2/25 all ‘Dynamic MIG’ APIs will be fully deprecated.

#### Legacy navigation - Run:ai UI

The legacy navigation will be fully deprecated in the Q1/25 release, and during Q1/25 for SaaS customers.


### API support and endpoint deprecations

| Deprecated | Replacement |
| :---- | :---- |
| /v1/k8s/audit | /api/v1/audit/log |
| /api/v1/asset/compute/spec/migProfile ||
| /api/v1/workloads/spec/compute/migProfile ||
| /api/v1/workloads/workspaces/spec/compute/migProfile  ||
| /api/v1/workloads/Trainings/spec/compute/migProfile ||
| /api/v1/workloads/Inferences/spec/compute/migProfile ||
| /api/v1/workloads/distributed/spec/compute/migProfile ||
| /api/v1/workloads/distributed/masterSpec/compute/migProfile ||




## Documentation enhancements

### Workload policy documentation

  A comprehensive set of articles detailing the usage and the process of submitting new workload policies has been introduced. It covers the structure, syntax, best practices, and examples for configuring policy YAML files. The new documentation includes step-by-step explanations of how to create a new rule in a policy, together with information of the different value types, rule types, and policy spec sections. For more information, refer to the [Policies](../platform-admin/workloads/policies/workspaces-policy.md) section.  
  