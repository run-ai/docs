# What’s New in Version 2.20

## **Release Content** <date>

The Run:ai v2.20 What's New provides a detailed summary of the latest features, enhancements, and updates introduced in this version. They serve as a guide to help users, administrators, and researchers understand the new capabilities and how to leverage them for improved workload management, resource optimization, and more. 

!!! Important Note
    For a complete list of features that will be deprecated, see [Deprecation notifications](#deprecation-notifications).



### Researchers


#### Workloads - Workspaces and Training 

*  **Stop/run actions for distributed workloads** - You can now stop and run distributed workloads from the UI, CLI, and API. Scheduling rules for training workloads also apply to distributed workloads. This enhances control over distributed workloads, enabling greater flexibility and resource management. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

* **Visibility into idle GPU devices** - Idle GPU devices are now displayed in in the UI and API showing the number of allocated GPU devices that have been idle for more than 5 minutes. This provides better visibility into resource utilization, enabling more efficient workload management.

* **Configurable workload completion with multiple runs** - You can now define the number of runs a training workload must complete to 
be considered finished directly in the UI, API, and CLI V2. Running training workloads multiple times improves 
the reliability and validity of training results. Additionally, you can configure how many runs can be scheduled in parallel, 
helping to significantly reduce training time and simplifying the process of managing jobs that require multiple runs.
See [standard training](../Researcher/workloads/training/standard-training/trainings-v2.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

* **Configurable grace period for workload preemption** - You can now set a grace period in the UI, API and CLIv2 providing a 
buffer time for preempted workloads to reach a safe checkpoint before being forcibly preempted for
[standard](../Researcher/workloads/training/standard-training/trainings-v2.md) and [distributed training](../Researcher/workloads/training/distributed-training/distributed-training.md) workloads. 
The grace period can be configured between 0 seconds and 5 minutes. This aims to minimize data loss and avoid unnecessary retraining, ensuring the 
latest checkpoints are saved. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span> 


#### Workload Assets

* **Instructions for environment variables** - You can now add instructions to environment variables when creating new environments via the UI and API. In addition, Run:ai's environments now include default instructions. Adding instructions provides guidance enabling anyone using the environment to set the environment variable values correctly. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>


* **Enhanced environments and compute resource management** - The action bar now contains "Make a Copy" and "Edit" while the "Rename" option has been removed. A new "Last Updated" column has also been added for easier tracking of asset modifications. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>


* **Enhanced data sources and credentials tables** - Added a new "Kubernetes name" column to data sources and credentials tables for visibility into Kubernetes resource associations. The credentials table now includes an  "Environments" column displaying the environments associated with the credential. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

#### Authenitication and authorization

* **User applications for API authentication** - You can now create your own applications for API integrations with Run:ai. 
Each application includes client credentials which can be used to obtain an authentication token to utilize for subsequent API calls. 
See [User Applications](../developer/user-applications.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

#### Scheduler

* **Support for multiple fractional GPUs in a single workload** - Run:ai now supports submitting workloads that utilize multiple fractional GPUs within a single workload using the UI and CLI. This feature enhances GPU utilization, increases scheduling probability in shorter timeframes, and allows workloads to consume only the memory they need. It maximizes quota usage and 
enables more workloads to share the same GPUs effectively. See [Multi-GPU fractions](../Researcher/scheduling/fractions.md#multi-gpu-fractions) and [Multi-GPU dynamic fractions](../Researcher/scheduling/dynamic-gpu-fractions.md#multi-gpu-dynamic-fractions) for more details. <span style="display:inline-block; background-color:white; color:#fc774a; padding:3px 8px; border-radius:3px; border:1px solid #fc774a; font-size:12px;">Beta for Dynamic Fractions</span> <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>
 

* **Support for GPU memory swap with multiple GPUs per workload** - Run:ai now supports GPU memory swap for workloads utilizing multiple GPUs. 
By leveraging GPU memory swap, you can maximize GPU utilization and serve more workloads using the same hardware. 
The swap scheduler on each node ensures that all GPUs of a distributed model run simultaneously, maintaining synchronization across GPUs. 
Workload configurations combine swap settings with multi-GPU dynamic fractions, providing flexibility and efficiency for managing 
large-scale workloads. See [Multi-GPU memory swap](../Researcher/scheduling/gpu-memory-swap.md#multi-gpu-memory-swap). 
<span style="display:inline-block; background-color:white; color:#fc774a; padding:3px 8px; border-radius:3px; border:1px solid #fc774a; font-size:12px;">Beta</span> <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>


#### Command Line Interface (CLI V2)

* **Support for Windows OS** - CLI V2 now supports Windows operating systems, enabling you to leverage the full 
capabilities of the CLI. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.18 onward</span>

* **Unified training command structure** - Unified the `distributed` command into the `training` command to align with the Run:ai UI. 
The `training` command now includes a new sub-command to support distributed workloads, ensuring a more consistent and streamlined user experience across both the CLI and UI.

* **New command for Kubernetes access** - Added a new CLI V2 command, `runai kubconfig set`, allowing users to set the 
kubeconfig file with Run:ai authorization token. This enhancement enables users to gain access to the Kubernetes cluster, 
simplifying authentication and integration with Run:ai-managed environments. 

* **Added view workload labels** - You can now view the labels associated with a workload when using the CLI V2 `runai workload describe` command for all workload types. This enhancement provides better visibility into workload metadata. 


### ML Engineers

#### Workloads - Inference

* **Enhanced visibility into rolling updates for inference workloads** - Run:ai now provides a phase message that provides detailed 
insights into the current state of the update, by hovering over the workload's status. This helps users to monitor and manage updates
more effectively. See [rolling inference updates](../Researcher/workloads/inference/inference-overview.md#rolling-inference-updates) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

* **Inference serving endpoint configuration** - You can now define an **inference serving endpoint** directly within the environment 
using the Run:ai UI. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.19 onward</span>

* **Persistent token management for Hugging Face models** - Run:ai allows users to save their Hugging Face tokens persistently as part of their credentials within the Run:ai UI. Once saved, tokens can be easily selected from a list of stored credentials, removing the need to manually enter them each time. This enhancement improves the process of deploying Hugging Face models, making it more efficient and user-friendly. See [inference workloads with Hugging Face](../Researcher/workloads/inference/hugging-face-inference.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.13 onward</span>

* **Deploy and manage NVIDIA NIM models in inference workloads** - Run:ai now supports NVIDIA NIM models, enabling you to 
easily deploy and manage these models when submitting inference workloads. You can select a NIM model and leverage NVIDIA’s 
hardware optimizations directly through the Run:ai UI. This feature also allows you to take advantage of Run:ai capabilities such as autoscaling and GPU fractioning. See [inference workloads with NVIDIA NIM](../Researcher/workloads/inference/nim-inference.md) for more details. 

*  **Customizable autoscaling plans for inference workloads** - Run:ai allows advanced users practicing 
autoscaling for inference workloads to fine-tune their autoscaling plans 
using the [Update inference spec API](https://api-docs.run.ai/latest/tag/Inferences/#operation/update_inference_spec). This feature enables you to achieve optimal behavior to meet fluctuating request demands. <span style="display:inline-block; background-color:white; color:#3dd37a; padding:3px 8px; border-radius:3px; border:1px solid #3dd37a; font-size:12px;">Experimental</span>
<span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

### Platform Administrator

#### Analytics

* **New Reports view for analytics** - The new Reports enables generating and organizing large data in a structured, 
CSV-formatted layout. With this feature, you can monitor resource consumption, identify trends, and make informed decisions 
to optimize their AI workloads with greater efficiency. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

#### Authorization and authentication

* **Client credentials for applications** - Applications now use client credentials - Client ID and Client secret - to obtain an 
authentication token. See [Applications](../platform-admin/authentication/applications.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

#### Node pools

* **Enhanced metric graphs for node pools** - Enhanced metric graphs in the DETAILS tab for node pools by aligning these graphs with 
the dashboard and the node pools API. As part of this improvement, the following columns have been removed 
from the [Node pools table](../platform-admin/aiinitiatives/resources/node-pools.md). 

    * Node GPU Allocation 
    * GPU Utilization Distribution 
    * GPU Utilization 
    * GPU Memory Utilization
    * CPU Utilization
    * CPU Memory Utilization

#### Organizations - Projects/Departments

* **Enhanced project deletion** - Deleting a [project](../platform-admin/aiinitiatives/org/projects.md) will now attempt to
delete the project's associated workloads and assets, allowing better management of your organization's assets. 
<span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

* **Enhanced resource prioritization for projects and departments** - Run:ai has introduced advanced prioritization capabilities to
manage resources between projects or between departments more effectively using the [Projects](https://api-docs.run.ai/latest/tag/Projects) and [Departments](https://api-docs.run.ai/latest/tag/Departments) APIs. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

    This feature allows administrators to:

    * Prioritize resource allocation and reclaim between different departments. 
    * Prioritize projects within the same department. 
    * Set priorities per node-pool for both projects and departments. 
    * Implement distinct SLAs by assigning strict priority levels to over-quota resources. 


* **Updated over quota naming** - Renamed over quota priority to over quota weight to reflect its actual functionality.


#### Policy

* **Added policy-based default field values** - Administrators can now set default values for fields that are automatically 
calculated based on the values of other fields using [defaultFrom](../platform-admin/workloads/policies/policy-reference.md). 
This ensures that critical fields in the workload submission form are populated automatically if not provided by the user. 
<span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

    This feature supports various field types:

    * Integer fields (e.g., `cpuCoresRequest`),
    * Number fields (e.g., `gpuPortionRequest`), 
    * Quantity fields (e.g., `gpuMemoryRequest`)

* **Pod deletion policy for terminal workloads** - Administrators can now specify which pods should be deleted when a distributed 
workload reaches a terminal state (completed/failed) using cleanPodPolicy in CLI V2 and API. This enhancement provides greater
control over resource cleanup and helps maintain a more organized and efficient cluster environment. See [cleanPodPolicy](../platform-admin/workloads/policies/policy-reference.md) for more details. 


#### Data sources

* **Improved control over data source and storage class visibility** - Run:ai now provides administrators with the ability 
to control the visibility of data source types and storage in the UI. Data source types that are restricted by policy 
will no longer appear during workload submission or when creating new data source assets. Additionally, administrators 
can configure storage classes as internal using the [Storage class configuration API](https://api-docs.run.ai/latest/tag/Storage-Classes). <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

#### Email notifications

* **Added email notifications API** - Email notifications can now be configured via API in addition to the UI, enabling integration 
with external tools. See [NotificationChannels API](https://api-docs.run.ai/latest/tag/NotificationChannels/) for more details. 

### Infrastructure Administrator 


#### NVIDIA Data Center GPUs - Grace-Hopper 

* **Support for ARM-Based Grace-Hopper Superchip (GH200)** - Run:ai now supports the ARM-based Grace-Hopper Superchip (GH200). 
Due to a limitation in version 2.20 with ARM64, the Run:ai control plane services must be scheduled on non-ARM based CPU nodes. 
This limitation will be addressed in a future release. See [Self-Hosted installation over Kubernetes](../admin/runai-setup/self-hosted/k8s/prerequisites.md#arm-limitation) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

#### System requirements 

* Run:ai now supports Kubernetes version 1.32. 
* Run:ai now supports OpenShift version 4.17.

#### Advanced cluster configurations

* **Exclude nodes in mixed node clusters** - Run:ai now allows you to exclude specific nodes in a mixed node cluster using the `nodeSelectorTerms` flag. See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md#runai-managed-nodes) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

* **Advanced configuration options for cluster services** - Introduced new cluster configuration options for setting node affinity and tolerations for Run:ai cluster services. These configuration ensure that the Run:ai cluster services are scheduled on the desired nodes.  See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

    * `global.affinity`
    * `global.tolerations`
    * `daemonSetsTolerations`

* **Added Argo workflows auto-pod grouping** - Introduced a new cluster configuration option, `gangScheduleArgoWorkflow`, to modify the 
default behavior for grouping ArgoWorkflow pods, allowing you to prevent pods from being grouped into a single pod-group. 
See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">Cluster v2.20 and v2.18</span>

* **Added cloud auto-scaling for memory fractions** - Run:ai now supports auto-scaling for workloads using memory fractions in 
cloud environments. Using `gpuMemoryToFractionRatio` configuration option allows a failed scheduling 
attempt for a memory fractions workload to create Run:ai scaling pods, triggering the auto-scaler. See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.19 onward</span>

* **Added stale gang eviction timeout for improved stability** - Run:ai has introduced a default timeout of 60 seconds 
for gang eviction in gang scheduling workloads using `defaultStalenessGracePeriod`. This timeout allows both the workload controller and the scheduler sufficient time to remediate the workload, improving the stability of large training jobs. See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.18 onward</span>

* **Added custom labels for built-in alerts** - Administrators can now add their own custom labels to the built-in alerts 
from Prometheus by setting `spec.prometheus.additionalAlertLabels` in their cluster. See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md) for mode details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

* **Enhanced configuration flexibility for cluster replica management** - Administrators can now use the `spec.global.replicaCount` to 
manage replicas for for Run:ai services. See [Advanced Cluster Configurations](../admin/config/advanced-cluster-config.md) for more details. <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

#### Built-in alerts

* **Added unknown state alert for a node** - The Kubernetes node hosting GPU workloads is in an unknown state, and its health and readiness cannot be determined. See [Built-in alerts](../admin/maintenance/alert-monitoring.md#built-in-alerts). <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>

* **Added low memory node alert** - The Kubernetes node hosting GPU workloads has insufficient memory to support current or upcoming workloads. See [Built-in alerts](../admin/maintenance/alert-monitoring.md#built-in-alerts). <span style="display:inline-block; background-color:white; color:#616161; padding:3px 8px; border-radius:3px; border:1px solid #616161; font-size:12px;">From cluster v2.20 onward</span>



### Run:ai Developer

#### Metrics and Telemtry 

* Additional metrics and telemetry are available via the API. For more details, see [Metrics API](../developer/metrics/metrics-api.md):

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

### Ongoing Dynamic MIG deprecation process
The Dynamic MIG deprecation process started in version 2.19. Run:ai supports standard MIG profiles as detailed in [Configuring NVIDIA MIG profiles](../platform-admin/aiinitiatives/resources/configuring-mig-profiles.md).

* Before upgrading to version 2.20, workloads submitted with Dynamic MIG and their associated node configurations must be removed
* In version 2.20, MIG was removed from the Run:ai UI under compute resources.
* In Q2/25 all ‘Dynamic MIG’ APIs and CLI commands will be fully deprecated. (it will fail)


### CLI V1 deprecation 
CLI V1 is being deprecated, and no new features will be developed for it. It will remain available for use for the next 
two releases to ensure a smooth transition for all users. We recommend switching to **CLI V2**, which provides feature parity, 
backwards compatibility, and ongoing support for new enhancements. CLI V2 is designed to deliver a more robust, efficient, and 
user-friendly experience.

### Legacy Jobs view deprecation

Starting with version 2.20, the legacy **Jobs view** will be discontinued in favor of the more advanced **Workloads view**. 
The legacy submission form will still be accessible via the Workload manager view for a smoother transition. 

### appID and appSecret deprecation 

Deprecating appID and appSecret parameters in the [Create an application token API](https://api-docs.run.ai/latest/tag/Tokens). 
To create application tokens, use your client credentials - Client ID and Client secret.

