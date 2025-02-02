# The Run:ai Scheduler: concepts and principles

When a user [submits a workload](../workloads-in-runai/workloads.md), the workload is directed to the selected Kubernetes cluster and managed by the Run:ai Scheduler. The Scheduler’s primary responsibility is to allocate workloads to the most suitable node or nodes based on resource requirements and other characteristics, as well as adherence to Run:ai’s fairness and quota management.  

The Run:ai Scheduler schedules native Kubernetes workloads, Run:ai workloads, or any other type of third-party workloads. To learn more about workloads support, see [Introduction to workloads](../workloads-in-runai/introduction-to-workloads.md). 

To understand what is behind the Run:ai Scheduler’s decision-making logic, get to know the key concepts, resource management and scheduling principles of the Scheduler.

## Workloads and pod groups

[Workloads](../workloads-in-runai/workload-types.md) can range from a single pod running on individual nodes to distributed workloads using multiple pods, each running on a node (or part of a node). For example, a large scale training workload could use up to 128 nodes or more, while an inference workload could use many pods (replicas) and nodes. 

Every newly created pod is assigned to a pod group, which can represent one or multiple pods within a workload. For example, a distributed PyTorch training workload with 32 workers is grouped into a single pod group. All pods are attached to the pod group with certain rules, such as [gang scheduling](#gang-scheduling), applied to the entire pod group.

## Scheduling queue

A scheduling queue (or simply a queue) represents a scheduler primitive that manages the scheduling of workloads based on different parameters. 

A queue is created for each [project/node pool pair](../manage-ai-initiatives/adapting-ai-initiatives.md#mapping-your-organization) and [department/node pool pair](../manage-ai-initiatives/adapting-ai-initiatives.md#mapping-your-organization). The Run:ai Scheduler supports hierarchical queueing, project queues are bound to department queues, per node pool. This allows an organization to manage quota, over quota and more for projects and their associated departments. 

## Resource management

### Quota

Each project and department includes a set of deserved resource quotas, per node pool and resource type. For example, project “LLM-Train/Node Pool NV-H100” quota parameters specify the number of GPUs, CPUs(cores), and the amount of CPU memory that this project deserves to get when using this node pool. [Non-preemptible workloads](#priority-and-preemption) can only be scheduled if their requested resources are within the deserved resource quotas of their respective project/node-pool and department/node-pool.

### Over quota

Projects and departments can have a share in the unused resources of any node pool, beyond their quota of deserved resources. These resources are referred to as over quota resources. The administrator configures the over quota parameters per node pool for each project and department.

### Over quota weight

Projects can receive a share of the cluster/node pool unused resources when the over quota weight setting is enabled. The part each Project receives depends on its over quota weight value, and the total weights of all other projects’ over quota weights. The administrator configures the over quota weight parameters per node pool for each project and department.

### Multi-level quota system

Each project has a set of guaranteed resource quotas (GPUs, CPUs, and CPU memory) per node pool. Projects can go over quota and get a share of the unused resources in a node pool beyond their guaranteed quota in that node pool. The same applies to Departments. The Scheduler balances the amount of over quota between departments, and then between projects. The department’s deserved quota and over quota limit the sum of resources of all projects, within the department. If the project shows it has deserved quota, but the department deserved quota is exhausted, the Scheduler will not give the project anymore deserved resources. The same applies to over quota resources. over quota resources are first given to the department, and only then split among its projects. 

### Fairshare and fairshare balancing

The Run:ai Scheduler calculates a numerical value, fairshare, per project (or department) for each node pool, representing the project’s (department’s) sum of guaranteed resources plus the portion of non-guaranteed resources in that node pool.

The Scheduler aims to provide each project (or department) the resources they deserve per node pool using two main parameters: deserved quota and deserved fairshare (i.e. quota + over quota resources). If one project’s node pool queue is below fairshare and another project’s node pool queue is above fairshare, the Scheduler shifts resources between queues to balance [fairness](#fairness-fair-resource-distribution). This may result in the preemption of some over quota preemptible workloads.

### Over-subscription

Over-subscription is a scenario where the sum of all guaranteed resource quotas surpasses the physical resources of the cluster or node pool. In this case, there may be scenarios in which the Scheduler cannot find matching nodes to all workload requests, even if those requests were within the resource quota of their associated projects.

### Placement strategy - bin-pack and spread

The administrator can set a [placement strategy](../manage-ai-initiatives/managing-your-resources/node-pools.md#adding-a-new-node-pool), bin-pack or spread, of the Scheduler per node pool. For GPU based workloads, workloads can request both GPU and CPU resources. For CPU-only based workloads, workloads can request CPU resources only.

* **GPU workloads:** 
  * **Bin-pack** - The Scheduler places as many workloads as possible in each GPU and node to use fewer resources and maximize GPU and node vacancy.
  * **Spread** - The Scheduler spreads workloads across as many GPUs and nodes as possible to minimize the load and maximize the available resources per workload.

* CPU workloads:
  * **Bin-pack** - The Scheduler places as many workloads as possible in each CPU and node to use fewer resources and maximize CPU and node vacancy.
  * **Spread** - The Scheduler spreads workloads across as many CPUs and nodes as possible to minimize the load and maximize the available resources per workload.

## Scheduling principles

### Priority and Preemption

Run:ai supports scheduling workloads using different priority and preemption policies:

* High-priority workloads (pods) can preempt [lower priority workloads](#preemption-of-lower-priority-workloads-within-a-project) (pods) within the same scheduling queue (project), according to their preemption policy. The Run:ai Scheduler implicitly assumes any PriorityClass >= 100 is non-preemptible and any PriorityClass < 100 is preemptible.
* Cross project and cross department workload preemptions are referred to as [resource reclaim](#reclaim-of-resources-between-projects-and-departments) and are based on [fairness](#fairness-fair-resource-distribution) between queues rather than the priority of the workloads.

To make it easier for users to submit workloads, Run:ai preconfigured several Kubernetes PriorityClass objects. The Run:ai preset PriorityClass objects have their ‘preemptionPolicy’ always set to ‘PreemptLowerPriority’, regardless of their actual Run:ai preemption policy within the Run:ai platform. A non-preemptible workload is only scheduled if in-quota and cannot be preempted after being scheduled, not even by a higher priority workload.

| PriorityClass Name | PriorityClass | Run:ai preemption policy | K8S preemption policy |
| ----- | ----- | ----- | ----- |
| Inference | 125 | Non-preemptible | PreemptLowerPriority |
| Build | 100 | Non-preemptible | PreemptLowerPriority |
| Interactive-preemptible | 75 | Preemptible | PreemptLowerPriority |
| Train | 50 | Preemptible | PreemptLowerPriority |

### Preemption of lower priority workloads within a project

Workload priority is always respected within a project. This means higher priority workloads are scheduled before lower priority workloads. It also means that higher priority workloads may preempt lower priority workloads within the same project if the lower priority workloads are preemptible. 

### Fairness (fair resource distribution)

[Fairness](how-the-scheduler-works.md) is a major principle within the Run:ai scheduling system. It means that the Run:ai Scheduler always respects certain resource splitting rules (fairness) between projects and between departments.

### Reclaim of resources between projects and departments

[Reclaim](how-the-scheduler-works.md#reclaim-preemption-between-projects-and-departments) is an inter-project (and inter-department) scheduling action that takes back resources from one project (or department) that has used them as over quota, back to a project (or department) that deserves those resources as part of its deserved quota, or to balance fairness between projects, each to its fairshare (i.e. sharing fairly the portion of the unused resources).

### Gang scheduling

Gang scheduling describes a scheduling principle where a workload composed of multiple pods is either fully scheduled (i.e. all pods are scheduled and running) or fully pending (i.e. all pods are not running). Gang scheduling refers to a single pod group. 

## Next Steps

Now that you have learned the key concepts and principles of the Run:ai Scheduler, see [how the Scheduler works](./how-the-scheduler-works.md) - allocating pods to workloads, applying preemption mechanisms, and managing resources.

