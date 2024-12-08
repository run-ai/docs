
Workloads are the basic unit of work in Run:ai. Researchers and Engineers use workloads for every stage in their AI [Project](../../../platform-admin/aiinitiatives/org/projects.md) lifecycle. Workloads can be used to build, train, or deploy a model. Run:ai supports all types of Kubernetes workloads. Researchers can work with any workload in their organization but will get the largest value working with Run:ai native workloads.

Run:ai offers three native types of workloads:

* [Workspace](../../../Researcher/workloads/workspaces/overview.md). Used for data preparation and model-building tasks.  
* [Training](../../../Researcher/workloads/trainings.md). Used for training tasks.  
* [Inference](../../../Researcher/workloads/inference-overview.md). Used for inference and model serving tasks  

Run:ai native workloads can be created via the Run:ai User interface, [API](https://api-docs.run.ai/2.18/tag/Workloads) or [Command-line interface](../../../Researcher/cli-reference/Introduction.md).

## Levels of support

Different types of workloads have different levels of support. Understanding what capabilities are needed before selecting the workload type to work with is important. The table below details the level of support for each workload type in Run:ai. The Run:ai native workloads are fully supported with all of Run:ai advanced features and capabilities. While third-party workloads are partially supported. The list of capabilities can change between different Run:ai versions.

| Functionality | Workload Type |  |  |                        |  |
| ----- | :---: | :---: | :---: |:----------------------:| ----- |
|  | Run:ai workloads |  |  |                        | Third-party workloads |
|  | Training - Standard | Workspace | Inference | Training - distributed | All K8s workloads |
| [Fairness](../../../Researcher/scheduling/the-runai-scheduler.md#fairness-fair-resource-distribution) | v | v | v |           v            | v |
| [Priority and preemption](../../../Researcher/scheduling/the-runai-scheduler.md#preemption) | v | v | v |           v            | v |
| [Over quota](../../../Researcher/scheduling/the-runai-scheduler.md#over-quota-priority) | v | v | v |           v            | v |
| [Node pools](../../../platform-admin/aiinitiatives/resources/node-pools.md) | v | v | v |           v            | v |
| Bin packing / Spread | v | v | v |           v            | v |
| Fractions | v | v | v |           v            | v |
| Dynamic fractions | v | v | v |           v            | v |
| Node level scheduler | v | v | v |           v            | v |
| GPU swap | v | v | v |           v            | v |
| Elastic scaling | NA | NA | v |           v            | v |
| [Gang scheduling](../../../Researcher/scheduling/the-runai-scheduler.md#gang-scheduling) | v | v | v |           v            | v |
| [Monitoring](../../../admin/maintenance/alert-monitoring.md) | v | v | v |           v            | v |
| [RBAC](../../../admin/authentication/authentication-overview.md#role-based-access-control-rbac-in-runai) | v | v | v |           v            |  |
| Workload awareness | v | v | v |           v            |  |
| [Workload submission](../../../Researcher/workloads/overviews/managing-workloads.md) | v | v | v |           v            |  |
| Workload actions (stop/run) | v | v | v |           v            |  |
| [Policies](../../../platform-admin/workloads/policies/overview.md) | v | v | v |           v            |  |
| [Scheduling rules](../../../platform-admin/aiinitiatives/org/scheduling-rules.md) | v | v | v |           v            |  |

!!! Note
    __Workload awareness__

    Specific workload-aware visibility, so that different pods are identified and treated as a single workload (for example GPU utilization, workload view, dashboards).

!!! Note
    __Workload actions__, __Scheduling rules__

    Actions and scheduling rules for distributed training are supported from clusters v2.20 and above with the matching training operator versions. (see installation docs).


## Workload scopes

Workloads must be created under a [project](../../../platform-admin/aiinitiatives/org/projects.md). A project is the fundamental organization unit in the Run:ai account. To manage workloads, it’s required to first create a project or have one created by the administrator.

## Policies and rules

[Policies and rules](../../../platform-admin/workloads/policies/overview.md) empower administrators to establish default values and implement restrictions on workloads allowing enhanced control, assuring compatibility with organizational policies, and optimizing resource usage and utilization.

## Workload statuses

The following table describes the different phases in a workload life cycle.

| Phase | Description | Entry condition | Exit condition |
| :---- | :---- | :---- | :---- |
| Creating | Workload setup is initiated in the Cluster. Resources and pods are now provisioning | A workload is submitted | A multi-pod group is created |
| Pending | Workload is queued and awaiting resource allocation. | A pod group exists | All pods are scheduled |
| Initializing | Workload is retrieving images, starting containers, and preparing pods | All pods are scheduled—handling of multi-pod groups TBD | All pods are initialized or a failure to initialize is detected |
| Running | Workload is currently in progress with all pods operational | All pods initialized (all containers in pods are ready) | workload completion or failure |
| Degraded | Pods may not align with specifications, network services might be incomplete, or persistent volumes may be detached. Check your logs for specific details. | Pending: All pods are running but with issues Running: All pods are running with no issues. | Running: All resources are OK Completed: Workload finished with fewer resources Failed: Workload failure or user-defined rules |
| Deleting | Workload and its associated resources are being decommissioned from the cluster | Deleting the workload. | Resources are fully deleted |
| Stopped | The workload is on hold and resources are intact but inactive | Stopping the workload without deleting resources | Transitioning back to the initializing phase or proceeding to deleting the workload |
| Failed | Image retrieval failed or containers experienced a crash. Check your logs for specific details. | An error occurs preventing the successful completion of the workload | Terminal State |
| Completed | Workload has successfully finished its execution | The workload has finished processing without errors | Terminal State |

