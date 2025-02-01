# How the Scheduler works

Efficient resource allocation is critical for managing AI and compute-intensive workloads in Kubernetes clusters. The Run:ai Scheduler enhances Kubernetes' native capabilities by introducing advanced scheduling principles such as fairness, quota management, and dynamic resource balancing. It ensures that workloads, whether simple single-pod or complex distributed tasks, are allocated resources effectively while adhering to organizational policies and priorities.

This guide explores the Run:ai Scheduler’s allocation process, preemption mechanisms, and resource management. Through examples and detailed explanations, you'll gain insights into how the Scheduler dynamically balances workloads to optimize cluster utilization and maintain fairness across projects and departments.

## Allocation process

### Pod creation and grouping

When a workload is submitted ,the workload controller creates a pod or pods (for distributed training workloads or deployment based inference). When the Scheduler gets a submit request with the first pod, it creates a pod group and allocates all the relevant building blocks of that workload. The next pods of the same workload are attached to the same pod group. 

### Queue management

A workload, with its associated pod group, is queued in the appropriate scheduling queue. In every scheduling cycle, the Scheduler ranks the order of queues by calculating their precedence for scheduling.

### Resource binding

The next step is for the Scheduler to find nodes for those pods, assign the pods to their nodes (bind operation), and bind other building blocks of the pods such as storage, ingress and so on. If the pod group has a ‘gang scheduling’ rule attached to it, the Scheduler either allocates and binds all pods together, or puts all of them into pending state. It retries to schedule them all together in the next scheduling cycle. The Scheduler also updates the status of the pods and their associated pod group. Users are able to track the workload submission process both in the CLI or Run:ai UI. For more details on submitting and managing workloads, see Workloads.

## Preemption

If the Scheduler cannot find resources for the submitted workloads (and all of its associated pods), and the workload deserves resources either because it is under its queue quota or its queue fairshare, the Scheduler tries to reclaim resources from other queues. If this does not solve the resource issue, the Scheduler tries to preempt lower priority preemptible workloads within the same queue (project).

### Reclaim preemption between projects and departments

Reclaim is an inter-project and inter-department resource balancing action that takes back resources from one project or department that has used them as an over quota. It returns the resources back to a project (or department) that deserves those resources as part of its deserved quota, or to balance fairness between projects (or departments), so a project (or department) does not exceed its fairshare (portion of the unused resources).

This mode of operation means that a lower priority workload submitted in one project (e.g. training) can reclaim resources from a project that runs a higher priority workload (e.g. preemptive workspace) if fairness balancing is required.

!!! Note
    Only preemptive workloads can go over quota as they are susceptible to reclaim (cross-projects preemption) of the over quota resources they are using. The amount of over quota resources a project can gain depends on the over quota weight or quota (if over quota weight is disabled). Departments’ over quota is always proportional to its quota.

### Priority preemption within a project 

Higher priority workloads may preempt lower priority preemptible workloads within the same project/node pool queue. For example, in a project that runs a training workload that exceeds the project quota for a certain node pool, a newly submitted workspace within the same project/node pool may stop (preempt) the training workload if there are not enough over quota resources for the project within that node pool to run both workloads (e.g. workspace using in-quota resources and training using over quota resources).

!!! Note
    Workload priority applies only within the same project and does not influence workloads across different projects, where fairness determines precedence.

## Quota, over quota, and fairshare

The Run:ai Scheduler strives to ensure fairness between projects and between departments. This means each department and project always strive to get their deserved quota, and unused resources are split between projects according to known rules (e.g. over quota weights). 

If a project needs more resources even beyond its fairshare, and the Scheduler finds unused resources that no other project needs, this project can consume resources even beyond its fairshare. 

Some scenarios can prevent the Scheduler from fully providing deserved quota and fairness:

* Fragmentation or other scheduling constraints such affinities, taints etc. 
* Some requested resources, such as GPUs and CPU memory, can be allocated, while others, like CPU cores, are insufficient to meet the request. As a result, the Scheduler will place the workload in a pending state until the required resource becomes available.


### Example of splitting quota

The example below illustrates a split of quota between different projects and departments using several node pools:

TBD image

The example below illustrates how fairshare is calculated per project/node pool for the above example:

TBD image

* For each Project:
  * The over quota (OQ) portion of each project (per node pool) is calculated as: [(OQ-Weight) / (Σ Projects OQ-Weights)] x (Unused Resource per node pool)
  Fairshare is calculated as the sum of quota + over quota.

* In Project 2, we assume that out of the 36 available GPUs in node pool A, 20 GPUs are currently unused. This means  either these GPUs are not part of any project’s quota, or they are part of a project’s quota but not used by any workloads of that project:

  * Project 2 over quota share: 
    [(Project 2 OQ-Weight) / (Σ all Projects OQ-Weights)] x (Unused Resource within node pool A)
    [(3) / (2 + 3 + 1)] x (20) = (3/6) x 20 = 10 GPUs

  * Fairshare = deserved quota + over quota = 6 +10 = 16 GPUs. Similarly, fairshare is also calculated for CPU and CPU memory. The Scheduler can grant a project more resources than its fairshare if the Scheduler finds resources not required by other projects that may deserve those resources.


* In Project 3, fairshare = deserved quota + over quota = 0 +3 = 3 GPUs. Project 3 has no guaranteed quota, but it still has a share of the excess resources in node pool A. The Run:ai Scheduler ensures that Project 3 receives its part of the unused resources for over quota, even if this results in reclaiming resources from other projects and preempting preemptible workloads.

## Fairshare balancing

The Scheduler constantly re-calculates the fairshare of each project and department per node pool, represented in the scheduler as queues, resulting in the re-balancing of resources between projects and between departments. This means that a preemptible workload that was granted resources to run in one scheduling cycle, can find itself preempted and go back to pending state while waiting for resources in the next cycle. 

A queue, representing a scheduler-managed object for each project or department per node pool, can be in one of 3 states:

* In-quota: The queue’s allocated resources ≤ queue deserved quota. The Scheduler’s first priority is to ensure each queue receives its deserved quota. 
* Over quota but below fairshare: The queue’s deserved quota < queue’s allocates resources <= queue’s fairshare. The Scheduler tries to find and allocate more resources to queues that need resources beyond their deserved quota and up to their fairshare. 
* Over-fairshare and over quota: The queue’s fairshare < queue’s allocated resources. The Scheduler tries to allocate resources to queues that need even more resources beyond their fairshare.

When re-balancing resources between queues of different projects and departments, the Scheduler goes in the opposite direction, i.e. first take resources from over-fairshare queues, then from over quota queues, and finally, in some scenarios, even from queues that are below their deserved quota. 

TBD image

## Next Steps

Now that you have gained insights into how the Scheduler dynamically balances workloads to optimize cluster utilization and maintain fairness across projects and departments, you can [submit workloads](../workloads-in-runiai/workloads.md). Before submitting your workloads, it’s important to familiarize yourself with the following key topics:

* [Introduction to workloads](../workloads-in-runiai/introduction-to-workloads.md): Learn what workloads are and what is supported for both Run:ai-specific and third-party workloads.
* [Run:ai workload types](../workloads-in-runiai/workload-types.md): Explore the various Run:ai workload types available and understand their specific purposes to enable you to choose the most appropriate workload type for your needs. 