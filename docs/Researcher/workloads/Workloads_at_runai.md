# Workloads at Run:ai

Run:ai enhances visibility and simplifies management, by monitoring, presenting and orchestrating all AI workloads in the clusters it is installed on. Workloads are the fundamental building blocks for consuming resources, enabling AI practitioners such as researchers, data scientists and engineers to efficiently support the entire life cycle of an AI initiative. 

## Workloads across the AI lifecycle

A typical AI initiative progresses through several key stages, each with distinct workloads and objectives. With Run:ai, research and engineering teams can host and manage all these workloads to achieve the following:

* Data preparation: Aggregating, cleaning, normalizing, and labeling data to prepare for training.
* Training: Conducting resource-intensive model development and iterative performance optimization.
* Fine-tuning: Adapting pre-trained models to domain-specific datasets while balancing efficiency and performance.
* Inference: Deploying models for real-time or batch predictions with a focus on low latency and high throughput.
* Monitoring and optimization: Ensuring ongoing performance by addressing data drift, usage patterns, and retraining as needed.

## What is a workload?

A workload runs in the cluster, is associated with a namespace, and operates to fulfill its targets, whether that is running to completion for a batch job, allocating resources for experimentation in an integrated development environment (IDE) or a notebook, or serving inference requests in production. 

The workload, defined by the AI practitioner, consists of:

* Container images: This includes the application, its dependencies, and the runtime environment.
* Compute resources: CPU, GPU, and RAM to execute efficiently and address the workload’s needs.
* Data sets: The data needed for processing, such as training data sets or input from external databases. 
* Credentials: The access to certain data sources or external services, ensuring proper authentication and authorization. 

Workload scheduling and orchestration

Run:ai’s core mission is to optimize AI resource usage at scale. This is achieved through efficient scheduling and orchestrating of all cluster workloads using the Run:ai Scheduler. The Scheduler allows the prioritization of workloads across different departments and projects within the organization at large scales, based on the resource distribution set by the system administrator. 

## Run:ai and third-party workloads

Run:ai workloads and third-party workloads are supported:

* Run:ai workloads: These workloads are submitted via the Run:ai platform. They are represented by Kubernetes Custom Resource Definitions (CRDs) and APIs. When using Run:ai workloads, a complete Workload and Scheduling Policy solution is offered for administrators to ensure optimizations, governance and security standards are applied. 
* Third-party workloads: These workloads are submitted via third-party applications that  use the Run:ai scheduler. The Run:ai platform manages and monitors these workloads. They enable seamless integrations with external tools, allowing teams and individuals flexibility. 

### Levels of support

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
