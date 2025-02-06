# Introduction to workloads

Run:ai enhances visibility and simplifies [management](../docs/overviews/managing-workloads.md), by monitoring, presenting and orchestrating all AI workloads in the clusters it is installed on. Workloads are the fundamental building blocks for consuming resources, enabling AI practitioners such as researchers, data scientists and engineers to efficiently support the entire life cycle of an [AI initiative](../platform-admin/aiinitiatives/overview.md).

## Workloads across the AI lifecycle

A typical AI initiative progresses through several key stages, each with distinct workloads and objectives. With Run:ai, research and engineering teams can host and manage all these workloads to achieve the following:

* **Data preparation:** Aggregating, cleaning, normalizing, and labeling data to prepare for training.
* **Training:** Conducting resource-intensive model development and iterative performance optimization.
* **Fine-tuning:** Adapting pre-trained models to domain-specific data sets while balancing efficiency and performance.
* **Inference:** Deploying models for real-time or batch predictions with a focus on low latency and high throughput.
* **Monitoring and optimization:** Ensuring ongoing performance by addressing data drift, usage patterns, and retraining as needed.

## What is a workload?

A workload runs in the cluster, is associated with a namespace, and operates to fulfill its targets, whether that is running to completion for a [batch job](workload-types.md#training-scaling-resources-for-model-development), allocating resources for [experimentation](workload-types.md#workspaces-the-experimentation-phase) in an integrated development environment (IDE)/notebook, or serving [inference](workload-types.md#inference-deploying-and-serving-models) requests in production.

The workload, defined by the AI practitioner, consists of:

* **Container images:** This includes the application, its dependencies, and the runtime environment.
* **Compute resources:** CPU, GPU, and RAM to execute efficiently and address the workload’s needs.
* **Data sets:** The data needed for processing, such as training data sets or input from external databases.
* **Credentials:** The access to certain data sources or external services, ensuring proper authentication and authorization.

## Workload scheduling and orchestration

Run:ai’s core mission is to optimize AI resource usage at scale. This is achieved through efficient [scheduling and orchestrating](../Researcher/scheduling/the-runai-scheduler.md) of all cluster workloads using the Run:ai Scheduler. The Scheduler allows the prioritization of workloads across different departments and projects within the organization at large scales, based on the resource distribution set by the system administrator.

## Run:ai and third-party workloads

* **Run:ai workloads:** These workloads are submitted via the Run:ai platform. They are represented by Kubernetes Custom Resource Definitions (CRDs) and APIs. When using Run:ai workloads, a complete Workload and Scheduling Policy solution is offered for administrators to ensure optimizations, governance and security standards are applied.
* **Third-party workloads:** These workloads are submitted via third-party applications that use the Run:ai Scheduler. The Run:ai platform manages and monitors these workloads. They enable seamless integrations with external tools, allowing teams and individuals flexibility.

### Levels of support

Different types of workloads have different levels of support. Understanding what capabilities are needed before selecting the workload type to work with is important. The table below details the level of support for each workload type in Run:ai. Run:ai workloads are fully supported with all of Run:ai advanced features and capabilities. While third-party workloads are partially supported. The list of capabilities can change between different Run:ai versions.

| Functionality                                                                                                                                                |    Workload Type    |           |           |                        |                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | :-----------------: | :-------: | :-------: | :--------------------: | --------------------- |
|                                                                                                                                                              |   Run:ai workloads  |           |           |                        | Third-party workloads |
|                                                                                                                                                              | Training - Standard | Workspace | Inference | Training - distributed |                       |
| [Fairness](../scheduling-and-resource-optimization/scheduling/runai-scheduler-concepts-and-principles.md#fairness-fair-resource-distribution)                |          v          |     v     |     v     |            v           | v                     |
| [Priority and preemption](../scheduling-and-resource-optimization/scheduling/runai-scheduler-concepts-and-principles.md#priority-and-preemption)             |          v          |     v     |     v     |            v           | v                     |
| [Over quota](../scheduling-and-resource-optimization/scheduling/runai-scheduler-concepts-and-principles.md#over-quota)                                       |          v          |     v     |     v     |            v           | v                     |
| [Node pools](../manage-ai-initiatives/managing-your-resources/node-pools.md)                                                                                 |          v          |     v     |     v     |            v           | v                     |
| [Bin packing / Spread](../scheduling-and-resource-optimization/scheduling/runai-scheduler-concepts-and-principles.md#placement-strategy-bin-pack-and-spread) |          v          |     v     |     v     |            v           | v                     |
|                                                                                                                                                              |          v          |     v     |     v     |            v           | v                     |
| [Multi-GPU dynamic fractions](../scheduling-and-resource-optimization/resource-optimization/dynamic-gpu-fractions.md)                                        |          v          |     v     |     v     |            v           | v                     |
| [Node level scheduler](../scheduling-and-resource-optimization/resource-optimization/node-level-scheduler.md)                                                |          v          |     v     |     v     |            v           | v                     |
| [Multi-GPU memory swap](../scheduling-and-resource-optimization/resource-optimization/gpu-memory-swap.md)                                                    |          v          |     v     |     v     |            v           | v                     |
| Elastic scaling                                                                                                                                              |          NA         |     NA    |     v     |            v           | v                     |
| [Gang scheduling](../scheduling-and-resource-optimization/scheduling/runai-scheduler-concepts-and-principles.md#gang-scheduling)                             |          v          |     v     |     v     |            v           | v                     |
| [Monitoring](../infrastructure-procedures/runai-system-monitoring.md)                                                                                        |          v          |     v     |     v     |            v           | v                     |
| [RBAC](../authentication-and-authorization/authentication-and-authorization.md#role-based-access-control-rbac-in-run-ai)                                     |          v          |     v     |     v     |            v           |                       |
| Workload awareness                                                                                                                                           |          v          |     v     |     v     |            v           |                       |
| [Workload submission](workloads.md)                                                                                                                          |          v          |     v     |     v     |            v           |                       |
| [Workload actions (stop/run)](workloads.md)                                                                                                                  |          v          |     v     |     v     |            v           |                       |
| [Workload Policies](../policies/workload-policies.md)                                                                                                        |          v          |     v     |     v     |            v           |                       |
| [Scheduling rules](../policies/scheduling-rules.md)                                                                                                          |          v          |     v     |     v     |            v           |                       |

{% hint style="info" %}
**Workload awareness**

Specific workload-aware visibility, so that different pods are identified and treated as a single workload (for example GPU utilization, workload view, dashboards).
{% endhint %}
