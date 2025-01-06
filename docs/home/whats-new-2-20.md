# What’s New in Version 2.20

## **Release Content** <date>

* [Deprecation notifications](#deprecation-notifications)  

## Researchers


### Stop/run actions for distributed workloads

You can now stop and run distributed workloads from the UI and API. 
Scheduling rules for training workloads will also be applied for distributed workloads. This enhances control over distributed workloads, enabling greater flexibility and resource management. 
This requires a minimum cluster version of 2.20.

### Visibility into idle GPU devices

Added idle GPU devices to Workloads in the UI and API to display the number of allocated GPU devices that have been idle for more than 5 minutes. This offers enhanced visibility into resource utilization, supporting more efficient workload management. This feature is not cluster version dependent.


### Configurable workload completion with multiple runs

You can now define the number of runs a training workload must complete to be considered finished directly in the **UI**, **API**, and **CLI v2**. Running training workloads multiple times improves the reliability and validity of training results. Additionally, you can configure how many runs can be scheduled in parallel, helping to significantly reduce training time and simplifying the process of managing jobs that require multiple runs.  This requires a minimum cluster version of 2.20. See [standard training](../Researcher/workloads/training/trainings-v2.md) for more details.


### Configurable grace period for workload preemption
You can now set a grace period in the UI, API and CLI V2 providing a buffer time for preempted workloads to reach a safe checkpoint before being forcibly preempted for [standard](../Researcher/workloads/training/trainings-v2.md) and [distributed training](../Researcher/workloads/training/distributed-training.md) workloads. The grace period can be configured between 0 seconds and 5 minutes. This avoids data loss and unnecessary retraining by ensuring the latest checkpoints are saved, especially, in case of checkpointing periods that are too far spread apart. This requires a minimum cluster version of 2.20. (Sherin)


### Pod deletion policy for terminal workloads

Administrators can now specify which pods should be deleted when a distributed workload reaches a terminal state (completed/failed) using cleanPodPolicy in CLI V2 and API. This enhancement provides greater
control over resource cleanup and helps maintain a more organized and efficient cluster environment. This feature is not cluster version dependent. See [cleanPodPolicy](../platform-admin/workloads/policies/policy-reference.md) for more details.

### User applications for API authentication

Users can now create their own applications for API integrations with Run:ai. Each application includes client credentials which can be used to obtain an authentication token and utilize it for subsequent API calls. This requires a minimum cluster version of 2.20. See [User Applications](../developer/user-applications.md) for more details.


### Adding instructions to environment variables 

- Users can now add instructions to environment variables when creating new environments. These instructions provide guidance for other users enabling them to set the environment variable values correctly. 

- Run:ai's environments now include default instructions to help users set the correct values for the environment variables. 

Adding instructions is available in the UI and API. This feature is not cluster version dependent.



### Enhancements for asset management

#### Environments and compute resources

Introduced several updates to improve managing Environments and Compute Resources. This requires a minimum cluster version of 2.20:

* The action bar now contains **Make a Copy** and **Edit**. 
* The **Rename** option has been removed.
* A new **"Last Updated"** column has been added for easier tracking of asset modifications. 

#### Data sources and credentials 

- Added a new "Kubernetes name" column to Data Sources and Credentials tables. This update enhances visibility into Kubernetes resource associations, making it easier for users to manage and track their assets.
- Added a new Environments column to the Credentials table displaying the environments associated with the credential.

This requires a minimum cluster version of 2.20.

### Windows OS support for CLI V2

CLI V2 now supports Windows operating systems, enabling you to leverage the full capabilities of the CLI. This requires a minimum cluster version of 2.18.

### Unified training command structure in CLI V2

Unified the `distributed` command into the `training` command to align with the Run:ai UI,. The `training` command 
now includes a new sub-command to support distributed workloads, ensuring a more consistent and streamlined user experience 
across both the CLI and UI.

### New CLI V2 command for Kubernetes access

Added a new CLI V2 command, `runai kubconfig set`, allowing users to set the kubeconfig file with Run:ai authorization parameters. This enhancement enables users to gain access to the Kubernetes cluster, 
simplifying authentication and integration with Run:ai-managed environments. 

### View workload labels in CLI V2
Users can now view the labels associated with a workload when using the CLI V2 `runai workload describe` command for all 
workload types. This enhancement provides better visibility into workload metadata. 


## ML Engineers

### Enhanced visibility into rolling updates for inference workloads
Run:ai now provides a phase message that provides detailed insights into the current state of the update, by hovering over the workload's status. This helps users monitor and manage updates more effectively. This requires a minimum cluster version of 2.20. See [rolling inference updates](../Researcher/workloads/inference/inference-overview.md#rolling-inference-updates).

### Inference serving endpoint configuration

Users can now define an **inference serving endpoint** directly within the environment using the Run:ai UI. This requires a minimum cluster version of v2.19. 

### Persistent token management for Hugging Face models** 
Run:ai now allows users to save their Hugging Face tokens persistently as part of their credentials within the Run:ai UI. Once saved, tokens can be easily selected from a list of stored credentials, removing the need to manually enter them each time. This enhancement improves the process of deploying Hugging Face models, making it more efficient and user-friendly.
This requires a minimum cluster version of 2.13. See [inference workloads with Hugging Face](../Researcher/workloads/inference/hugging-face-inference.md) for more details.

### Deploy and manage NVIDIA NIM models in inference workloads
Run:ai now supports NVIDIA NIM models, enabling users to easily deploy and manage these models when submitting inference workloads. 
Users can select a NIM model and leverage NVIDIA’s hardware optimizations directly through the Run:ai UI. This feature also allows you to take advantage of Run:ai capabilities such as autoscaling and GPU fractioning.
This feature is not cluster version dependent. See [inference workloads with NVIDIA NIM](../Researcher/workloads/inference/nim-inference.md) for more details.


## Platform Administrator

### New Reports feature for Analytics

The new Reports enables users to generate and organize large data in a structured, CSV-formatted layout. With this feature, users can monitor resource consumption, identify trends, and make informed decisions to optimize their AI workloads with greater efficiency. 
This requires a minimum cluster version of 2.20.

### Client credentials for applications

Applications now use client credentials - Client ID and Client secret - to obtain an authentication token. This requires a minimum cluster version of 2.20. See [Applications](../platform-admin/authentication/applications.md) for more details.

### Enhanced metrics for node pools
Enhanced metric graphs in the DETAILS tab for node pools by aligning these graphs with the dashboard and the node pools API. As part of this improvement, the following columns have been removed from the [Node pools table](../platform-admin/aiinitiatives/resources/node-pools.md). This feature is not cluster version dependent. 

* Node GPU Allocation
* GPU Utilization Distribution 
* GPU Utilization 
* GPU Memory Utilization
* CPU Utilization
* CPU Memory Utilization

### Enhanced project deletion 

Deleting a [project](../platform-admin/aiinitiatives/org/projects.md) will now attempt to delete the project's associated workloads and assets, allowing better management of your organization assets. This requires a minimum cluster version of 2.20.

### Policy-based default field values
Administrators can now set default values for fields that are automatically calculated based on the values of other fields using [defaulFrom](../platform-admin/workloads/policies/policy-reference.md). This ensures that critical fields in the workload submission form are populated automatically if not provided by the user. This feature supports various field types. This requires a minimum cluster version of 2.20:

* integer fields (e.g., `cpuCoresRequest`),
* number fields (e.g., `gpuPortionRequest`), 
* and quantity fields (e.g., `gpuMemoryRequest`)

### Improved control over data source and storage class visibility

Run:ai now provides adminstrators with the ability to control the visibility of data source types and storage in the UI. Data source types that are restricted by policy will no longer appear during workload submission or when creating new data source assets. Additionally, administrators can configure storage classes as internal using an API. See TBD. This requires a minimum cluster version of 2.20.

### Email notifications API
Email notifications can now be configured via API in addition to the UI enabling integration with external tools. See [NotificationChannels API](https://api-docs.run.ai/latest/tag/NotificationChannels/) for more details.

## Infrastructure Administrator 

### Configuration and installation

* Run:ai now supports Kubernetes version 1.32. 
* Run:ai now supports OpenShift version 4.17.

### Exclude Nodes in mixed node clusters
Run:ai now allows you to exclude specific nodes in a mixed node cluster using the `nodeSelectorTerms` flag. This requires a minimum cluster version of 2.20. See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md).

### Advanced configuration options for cluster services

Introduced new cluster configuration options for setting node affinity and TolerationsNode affinity for Run:ai cluster services.
These configuration ensure that the Run:ai cluster services are scheduled on the desired nodes. This requires a minimum cluster version of 2.20. (Sherin - check naming) See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md).

* `spec.global.affinity`
* `spec.global.tolerations`
* `spec.daemonSetsTolerations`

### Custom labels for built-in alerts

Administrators can now add their own custom labels to the built-in alerts from Prometheus by setting `spec.prometheus.additionalAlertLabels` in their cluster. This requires a minimum cluster version of 2.20. See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md).

### Enhanced configuration flexibility for cluster replica management

Administrators can now use the `spec.global.replicaCount` to manage replicas for for Run:ai services. This requires a minimum cluster version of 2.20. See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md).

## Run:ai Developer

### Metrics and telemetry

  Additional metrics and telemetry are available via the API. For more details, see [Metrics API](../developer/metrics/metrics-api.md):

* Metrics (over time)  
    * Project  
        * GPU_QUOTA 
        * CPU_QUOTA_MILLICORES
        * CPU_MEMORY_QUOTA_MB
        * GPU_ALLOCATION
        * CPU_ALLOCATION_MILLICORES
        * CPU_MEMORY_ALLOCATION_MB 
    * Department  
        * GPU_QUOTA 
        * CPU_QUOTA_MILLICORES
        * CPU_MEMORY_QUOTA_MB
        * GPU_ALLOCATION
        * CPU_ALLOCATION_MILLICORES
        * CPU_MEMORY_ALLOCATION_MB 

* Telemetry (current time)  
    * Project  
        * GPU_QUOTA 
        * CPU_QUOTA 
        * MEMORY_QUOTA
        * GPU_ALLOCATION
        * CPU_ALLOCATION
        * MEMORY_ALLOCATION
        * GPU_ALLOCATION_NON_PREEMPTIBLE
        * CPU_ALLOCATION_NON_PREEMPTIBLE
        * MEMORY_ALLOCATION_NON_PREEMPTIBLE 
    * Department    
        * GPU_QUOTA 
        * CPU_QUOTA 
        * MEMORY_QUOTA
        * GPU_ALLOCATION
        * CPU_ALLOCATION
        * MEMORY_ALLOCATION
        * GPU_ALLOCATION_NON_PREEMPTIBLE
        * CPU_ALLOCATION_NON_PREEMPTIBLE
        * MEMORY_ALLOCATION_NON_PREEMPTIBLE 

## Deprecation notifications 

### CLI V1 deprecation

CLI v1 is being deprecated, and no new features will be developed for it. It will remain available for use for the next two releases to ensure a smooth transition for all users. 
We recommend switching to **CLI v2**, which provides feature parity, backwards compatibility, and ongoing support for new enhancements. CLI v2 is designed to deliver a more robust, efficient, and user-friendly experience.

### Legacy Jobs view deprecation

Starting with version 2.20, the legacy **Jobs view** will be discontinued in favor of the more advanced **Workloads view**. The legacy submission form will still be accessible via the Workload manager view for a smoother transition. 


Depracating these two, using client crdentials client secret and ID TBD Sherin
"appID": "string",
"appSecret": "string", TBD
