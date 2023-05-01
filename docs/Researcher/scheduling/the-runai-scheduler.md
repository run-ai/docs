## Introduction

At the heart of the Run:ai solution is the Run:ai scheduler. The scheduler is the gatekeeper of your organization's hardware resources. It makes decisions on resource allocations according to pre-created rules.

The purpose of this document is to describe the Run:ai scheduler and explain how resource management works.

## Terminology

### Workload Types

Run:ai differentiates between three types of deep learning workloads:

*   __Interactive__ build workloads. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm, or similar and accesses GPU resources directly. Build workloads typically do not tax the GPU for a long duration. There are also typically real users behind an interactive workload that need an immediate scheduling response.
*   __Unattended__ (or "non-interactive") training workloads. Training is characterized by a deep learning run that has a start and a finish. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. Training workloads typically utilize large percentages of the GPU. During the execution, the Researcher can examine the results. A Training session can take anything from a few minutes to a couple of weeks. It can be interrupted in the middle and later restored.   
It follows that a good practice for the Researcher is to save checkpoints and allow the code to restore from the last checkpoint.

* __Inference__ workloads. These are production workloads that serve requests. The Run:ai scheduler treats these workloads as _Interactive_ workloads.

### Projects

Projects are quota entities that associate a Project name with a __deserved__ GPU quota as well as other preferences.

A Researcher submitting a workload must associate a Project with any workload request. The Run:ai scheduler will then compare the request against the current allocations and the Project's deserved quota and determine whether the workload can be allocated with resources or whether it should remain in a pending state.

For further information on Projects and how to configure them, see: [Working with Projects](../../admin/admin-ui-setup/project-setup.md)

### Departments

A _Department_ is the second hierarchy of resource allocation above _Project_. A Department quota supersedes a Project quota in the sense that if the sum of Project quotas for Department A exceeds the Department quota -- the scheduler will use the Department quota rather than the Projects' quota.  

For further information on Departments and how to configure them, see: [Working with Departments](../../admin/admin-ui-setup/department-setup.md)

### Pods

_Pods_ are units of work within a Job. 

* Typically, each Job has a single Pod. However, in some scenarios (see Hyperparameter Optimization and Distribute Training below) there will be multiple Pods per Job. 
* All Pods execute with the same arguments as added via ``runai submit``. E.g. The same image name, the same code script, the same number of Allocated GPUs, memory.


## Basic Scheduling Concepts

### Interactive, Training and Inference

The Researcher uses the _--interactive_ flag to specify whether the workload is an unattended "train" workload or an interactive "build" workload.

*   Interactive & Inference workloads will get precedence over training workloads.
*   Training workloads can be preempted when the scheduler determines a more urgent need for resources. Interactive workloads are never preempted.

### Guaranteed Quota and Over-Quota

There are two use cases for Quota and Over-Quota:

__Node pools are disabled__

Every new workload is associated with a Project. The Project contains a deserved GPU quota. During scheduling:

*   If the newly required resources, together with currently used resources, end up within the Project's quota, then the workload is ready to be scheduled as part of the guaranteed quota.
*   If the newly required resources together with currently used resources end up above the Project's quota, the workload will only be scheduled if there are 'spare' GPU resources. There are nuances in this flow that are meant to ensure that a Project does not end up with an over-quota made fully of interactive workloads. For additional details see below.

__Node pools are enabled__

Every new workload is associated with a Project. The Project contains a deserved GPU quota that is the sum off all node pools GPU quotas. During scheduling:

*   If the newly required resources, together with currently used resources, end up within the overall Project's quota and the requested node pool(s) quota, then the workload is ready to be scheduled as part of the guaranteed quota.
*   If the newly required resources together with currently used resources end up above the Project's quota or the requested node pool(s) quota, the workload will only be scheduled if there are 'spare' GPU resources within the same node pool but not part of this Project. There are nuances in this flow that are meant to ensure that a Project does not end up with an over-quota made entirely of interactive workloads. For additional details see below.


### Quota with Multiple Resources

A project may have a quota set for more than one resource (GPU, CPU or CPU Memory). For a project to be "Over Quota" it will have to have at _least one_ resource over its quota. For a project to be under quota it needs to have _all of its_ resources under quota.

## Scheduler Details

### Allocation & Preemption

The Run:ai scheduler wakes up periodically to perform allocation tasks on pending workloads:

*   The scheduler looks at each Project separately and selects the most 'deprived' Project.
*   For this deprived Project it chooses a single workload to work on:
    
    *   Interactive & Inference workloads are tried first, but only up to the Project's guaranteed quota. If such a workload exists, it is scheduled even if it means __preempting__ a running unattended workload in this Project.
    *   Else, it looks for an unattended workload and schedules it on guaranteed quota or over-quota.
    
*   The scheduler then recalculates the next 'deprived' Project and continues with the same flow until it finishes attempting to schedule all workloads

### Node Pools
A _Node Pool_ is a set of nodes grouped by an Administrator into a distinct group of resources from which resources can be allocated to Projects and Departments.
By default, any node pool created in the system is automatically associated with all Projects and Departments using zero quota resource (GPUs, CPUs, Memory) allocation. This allows any Project and Department to use any node pool with Over-Quota (for Preemptible workloads), thus maximizing the system resource utilization.

*   An Administrator can allocate resources from a specific node pool to chosen Projects and Departments. See [Project Setup](../../admin/admin-ui-setup/project-setup.md#limit-jobs-to-run-on-specific-node-groups)
*   The Researcher can use node pools in two ways. The first one is where a Project has guaranteed resources on node pools - The Researcher can then submit a workload and specify a single node pool or a prioritized list of node pools to use and receive guaranteed resources. 
The second is by using node-pool(s) with no guaranteed resource for that Project (zero allocated resources), and in practice using Over-Quota resources of node-pools. This means a Workload must be Preemptible as it uses resources out of the Project or node pool quota. The same scenario occurs if a Researcher uses more resources than allocated to a specific node pool and goes Over-Quota.
*   By default, if a Researcher doesn't specify a node-pool to use by a workload, the scheduler assigns the workload to run using the Project's 'Default node-pool list'.


### Node Affinity 

Both the Administrator and the Researcher can provide limitations as to which nodes can be selected for the Job. Limits are managed via [Kubernetes labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){target=_blank}:

* The Administrator can set limits at the Project level. Example: Project `team-a` can only run `interactive` Jobs on machines with a label of `v-100` or `a-100`. See [Project Setup](../../admin/admin-ui-setup/project-setup.md#limit-jobs-to-run-on-specific-node-groups) for more information.
* The Researcher can set a limit at the Job level, by using the command-line interface flag `--node-type`. The flag acts as a subset to the Project setting. 

Node affinity constraints are used during the _Allocation_ phase to filter out candidate nodes for running the Job. For more information on how nodes are filtered see the `Filtering` section under [Node selection in kube-scheduler](https://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/#kube-scheduler-implementation){target=_blank}. The Run:ai scheduler works similarly.

### Reclaim

During the above process, there may be a pending workload whose Project is below the deserved capacity. Still, it cannot be allocated due to the lack of GPU resources. The scheduler will then look for alternative allocations at the expense of another Project which has gone over-quota while preserving fairness between Projects.

### Fairness

The Run:ai scheduler determines fairness between multiple over-quota Projects according to their GPU quota. Consider for example two Projects, each spawning a significant amount of workloads (e.g. for Hyperparameter tuning) all of which wait in the queue to be executed. The Run:ai Scheduler allocates resources while preserving fairness between the different Projects regardless of the time they entered the system. The fairness works according to the __relative portion of the GPU quota for each Project.__ To further illustrate that, suppose that:

* Project A has been allocated a quota of 3 GPUs.
* Project B has been allocated a quota of 1 GPU.

Then, if both Projects go over quota, Project A will receive 75% (=3/(1+3)) of the idle GPUs and Project B will receive 25% (=1/(1+3)) of the idle GPUs. This ratio will be recalculated every time a new Job is submitted to the system or an existing Job ends.

This fairness equivalence will also be maintained amongst __running__ Jobs. The scheduler will preempt training sessions to maintain this equivalence 

### Over-Quota Priority
When the Over Quota Priority feature is enabled, The Run:ai scheduler allocates GPUs within-quota and over-quota using different weights. Within quota, GPUs are allocated based on assigned GPUs. The remaining over-quota GPUs are allocated based on their relative portion of GPU Over Quota Priority for each Project. 
GPUs Over-Quota Priority values are translated into numeric values as follows: None-0, Low-1, Medium-2, High-3.

Let's examine the previous example with Over-Quota Weights:

* Project A has been allocated with a quota of 3 GPUs and GPU over quota weight is set to Low.
* Project B has been allocated with a quota of 1 GPU and GPU over quota weight is set to High.

Then, Project A is allocated with 3 GPUs and project B is allocated with 1 GPU. If both Projects go over quota, Project A will receive an additional 25% (=1/(1+3)) of the idle GPUs and Project B will receive an additional 75% (=3/(1+3)) of the idle GPUs.

With the addition of node pools, the principles of Over-Quota and Over-Quota priority remain unchanged. However, the number of resources that are allocated with Over-Quota and Over-Quota Priority is calculated against node pool resources instead of the whole Project resources.

* Note: Over-Quota On/Off and Over-Quota Priority settings remain at the Project and Department level.  

### Bin-packing & Consolidation

Part of an efficient scheduler is the ability to eliminate fragmentation:

*   The first step in avoiding fragmentation is bin packing: try and fill nodes (machines) up before allocating workloads to new machines.
*   The next step is to consolidate Jobs on demand. If a workload cannot be allocated due to fragmentation, the scheduler will try and move unattended workloads from node to node in order to get the required amount of GPUs to schedule the pending workload.

## Advanced

### GPU Fractions

Run:ai provides a Fractional GPU sharing system for containerized workloads on Kubernetes. The system supports workloads running CUDA programs and is especially suited for lightweight AI tasks such as inference and model building. The fractional GPU system transparently gives data science and AI engineering teams the ability to run multiple workloads simultaneously on a single GPU.

Run:ai’s fractional GPU system effectively creates logical GPUs, with their own memory and computing space that containers can use and access as if they were self-contained processors. 

One important thing to note is that fraction scheduling divides up __GPU memory__. As such the GPU memory is divided up between Jobs. If a Job asks for 0.5 GPU, and the GPU has 32GB of memory, then the Job will see only 16GB. An attempt to allocate more than 16GB will result in an out-of-memory exception.

GPU Fractions are scheduled as regular GPUs in the sense that:

* Allocation is made using fractions such that the total of the GPU allocation for a single GPU is smaller or equal to 1.
* Preemption is available for non-interactive workloads.  
* Bin-packing & Consolidation work the same for fractions.

Support: 

* Hyperparameter Optimization supports fractions. 


### Distributed Training

Distributed Training, is the ability to split the training of a model among multiple processors. It is often a necessity when multi-GPU training no longer applies; typically when you require more GPUs than exist on a single node. Each such split is a _pod_ (see definition above). Run:ai spawns an additional _launcher_ process that manages and coordinates the other worker pods.

Distribute Training utilizes a practice sometimes known as __Gang Scheduling__:

* The scheduler must ensure that multiple pods are started on what are typically multiple Nodes before the Job can start. 
* If one pod is preempted, the others are also immediately preempted.
* When node pools are enabled, all pods must be scheduled to the same node pool.

Gang Scheduling essentially prevents scenarios where part of the pods are scheduled while other pods belonging to the same Job are pending for resources to become available; scenarios that can cause deadlock situations and major inefficiencies in cluster utilization. 

The Run:ai system provides:

* Inter-pod communication. 
* Command-line interface to access logs and an interactive shell. 

For more information on Distributed Training in Run:ai see [here](../Walkthroughs/walkthrough-distributed-training.md)


### Hyperparameter Optimization

Hyperparameter optimization (HPO) is the process of choosing a set of optimal hyperparameters for a learning algorithm. A hyperparameter is a parameter whose value is used to control the learning process, to define the model architecture or the data pre-processing process, etc. Example hyperparameters: learning rate, batch size, different optimizers, and the number of layers.

To search for good hyperparameters, Researchers typically start a series of small runs with different hyperparameter values, let them run for a while, and then examine the results to decide what works best.


With HPO, the Researcher provides a single script that is used with multiple, varying, parameters. Each run is a _pod_ (see definition above). Unlike Gang Scheduling, with HPO, pods are __independent__. They are scheduled independently, started, and end independently, and if preempted, the other pods are unaffected. The scheduling behavior for individual pods is exactly as described in the Scheduler Details section above for Jobs. 
In case node pools are enabled, if the HPO workload has been assigned with more than one node pool, the different pods might end up running on different node pools. 

For more information on Hyperparameter Optimization in Run:ai see [here](../Walkthroughs/walkthrough-hpo.md)
