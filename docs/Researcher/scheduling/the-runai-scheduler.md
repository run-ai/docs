## Introduction

At the heart of the Run:AI solution is the Run:AI scheduler. The scheduler is the gatekeeper of your organization's hardware resources. It makes decisions on resource allocations according to pre-created rules.

The purpose of this document is to describe the Run:AI scheduler and explain how resource management works.

## Terminology

### Workload Types

Run:AI differentiates between two types of deep learning workloads:

*   __Interactive__ build workloads. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm, or similar and accesses GPU resources directly. Build workloads typically do not tax the GPU for a long duration. There are also typically real users behind an interactive workload that need an immediate scheduling response.
*   __Unattended__ (or "non-interactive") training workloads.Training is characterized by a deep learning run that has a start and a finish. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. Training workloads typically utilize large percentages of the GPU. During the execution, the Researcher can examine the results. A Training session can take anything from a few minutes to a couple of weeks. It can be interrupted in the middle and later restored.   
It follows that a good practice for the Researcher is to save checkpoints and allow the code to restore from the last checkpoint.

* __Inference__ workloads. These are production workloads that serve requests. The Run:AI scheduler treats these workloads as _Interactive_ workloads.

### Projects

Projects are quota entities that associate a Project name with a __deserved__ GPU quota as well as other preferences.

A Researcher submitting a workload must associate a Project with any workload request. The Run:AI scheduler will then compare the request against the current allocations and the Project's deserved quota and determine whether the workload can be allocated with resources or whether it should remain in a pending state.

For further information on Projects and how to configure them, see: [Working with Projects](../../admin/admin-ui-setup/project-setup.md)

### Departments

A _Department_ is the second hierarchy of resource allocation above _Project_. A Department quota supersedes a Project quota in the sense that if the sum of Project quotas for Department A exceeds the Department quota -- the scheduler will use the Department quota rather than the Project quota.  

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

Every new workload is associated with a Project. The Project contains a deserved GPU quota. During scheduling:

*   If the newly required resources, together with currently used resources, end up within the Project's quota, then the workload is ready to be scheduled as part of the guaranteed quota.
*   If the newly required resources together with currently used resources end up above the Project's quota, the workload will only be scheduled if there are 'spare' GPU resources. There are nuances in this flow that are meant to ensure that a Project does not end up with an over-quota made fully of interactive workloads. For additional details see below

## Scheduler Details

### Allocation & Preemption

The Run:AI scheduler wakes up periodically to perform allocation tasks on pending workloads:

*   The scheduler looks at each Project separately and selects the most 'deprived' Project.
*   For this deprived Project it chooses a single workload to work on:
    
    *   Interactive & Inference workloads are tried first, but only up to the Project's guaranteed quota. If such a workload exists, it is scheduled even if it means __preempting__ a running unattended workload in this Project.
    *   Else, it looks for an unattended workload and schedules it on guaranteed quota or over-quota.
    
*   The scheduler then recalculates the next 'deprived' Project and continues with the same flow until it finishes attempting to schedule all workloads

### Node Affinity 

Both the Administrator and the Researcher can provide limitations as to which nodes can be selected for the Job. Limits are managed via [Kubernetes labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){target=_blank}:

* The Administrator can set limits at the Project level. Example: Project `team-a` can only run `interactive` Jobs on machines with a label of `v-100` or `a-100`. See [Project Setup](../../admin/admin-ui-setup/project-setup.md#limit-jobs-to-run-on-specific-node-groups) for more information.
* The Researcher can set a limit at the Job level, by using the command-line interface flag `--node-type`. The flag acts as a subset to the Project setting. 

Node affinity constraints are used during the _Allocation_ phase to filter out candidate nodes for running the Job. For more information on how nodes are filtered see the `Filtering` section under [Node selection in kube-scheduler](https://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/#kube-scheduler-implementation){target=_blank}. The Run:AI scheduler works similarly.

### Reclaim

During the above process, there may be a pending workload whose Project is below the deserved capacity. Still, it cannot be allocated due to the lack of GPU resources. The scheduler will then look for alternative allocations at the expense of another Project which has gone over-quota while preserving fairness between Projects.

### Fairness

The Run:AI scheduler determines fairness between multiple over-quota Projects according to their GPU quota. Consider for example two Projects, each spawning a significant amount of workloads (e.g. for Hyperparameter tuning) all of which wait in the queue to be executed. The Run:AI Scheduler allocates resources while preserving fairness between the different Projects regardless of the time they entered the system. The fairness works according to the __relative portion of the GPU quota for each Project.__ To further illustrate that, suppose that:

* Project A has been allocated with a quota of 3 GPUs.
* Project B has been allocated with a quota of 1 GPU.

Then, if both Projects go over quota, Project A will receive 75% (=3/(1+3)) of the idle GPUs and Project B will receive 25% (=1/(1+3)) of the idle GPUs. This ratio will be recalculated every time a new Job is submitted to the system or an existing Job ends.

This fairness equivalence will also be maintained amongst __running__ Jobs. The scheduler will preempt training sessions to maintain this equivalence 

### Bin-packing & Consolidation

Part of an efficient scheduler is the ability to eliminate fragmentation:

*   The first step in avoiding fragmentation is bin packing: try and fill nodes (machines) up before allocating workloads to new machines.
*   The next step is to consolidate Jobs on demand. If a workload cannot be allocated due to fragmentation, the scheduler will try and move unattended workloads from node to node in order to get the required amount of GPUs to schedule the pending workload.

### Elasticity

Run:AI Elasticity is explained [here](../researcher-library/rl-elasticity.md). In essence, it allows unattended workloads to shrink or expand based on the cluster's availability.

*   Shrinking happens when the scheduler is unable to schedule an elastic unattended workload and no amount of _consolidation_ helps. The scheduler then divides the requested GPUs by half again and again and tries to reschedule.
*   Shrink Jobs will expand when enough GPUs will be available.
*   Expanding happens when the scheduler finds spare GPU resources, enough to double the amount of GPUs for an elastic workload.

## Advanced

### GPU Fractions

Run:AI provides a Fractional GPU sharing system for containerized workloads on Kubernetes. The system supports workloads running CUDA programs and is especially suited for lightweight AI tasks such as inference and model building. The fractional GPU system transparently gives data science and AI engineering teams the ability to run multiple workloads simultaneously on a single GPU.

Run:AI’s fractional GPU system effectively creates logical GPUs, with their own memory and computing space that containers can use and access as if they were self-contained processors. 

One important thing to note is that fraction scheduling divides up __GPU memory__. As such the GPU memory is divided up between Jobs. If a Job asks for 0.5 GPU, and the GPU has 32GB of memory, then the Job will see only 16GB. An attempt to allocate more than 16GB will result in an out-of-memory exception.

GPU Fractions are scheduled as regular GPUs in the sense that:

* Allocation is made using fractions such that the total of the GPU allocation for a single GPU is smaller or equal to 1.
* Preemption is available for non-interactive workloads.  
* Bin-packing & Consolidation work the same for fractions.

Support: 

* Elasticity is not supported with fractions.
* Hyperparameter Optimization supports fractions. 


### Distributed Training

Distributed Training, is the ability to split the training of a model among multiple processors. It is often a necessity when multi-GPU training no longer applies; typically when you require more GPUs than exist on a single node. Each such split is a _pod_ (see definition above). Run:AI spawns an additional _launcher_ process that manages and coordinates the other worker pods.

Distribute Training utilizes a practice sometimes known as __Gang Scheduling__:

* The scheduler must ensure that multiple pods are started on what are typically multiple Nodes before the Job can start. 
* If one pod is preempted, the others are also immediately preempted.

Gang Scheduling essentially prevents scenarios where part of the pods are scheduled while other pods belonging to the same Job are pending for resources to become available; scenarios that can cause deadlock situations and major inefficiencies in cluster utilization. 

The Run:AI system provides:

* Inter-pod communication. 
* Command-line interface to access logs and an interactive shell. 

For more information on Distributed Training in Run:AI see [here](../Walkthroughs/walkthrough-distributed-training.md)


### Hyperparameter Optimization

Hyperparameter optimization (HPO) is the process of choosing a set of optimal hyperparameters for a learning algorithm. A hyperparameter is a parameter whose value is used to control the learning process, to define the model architecture or the data pre-processing process, etc. Example hyperparameters: learning rate, batch size, different optimizers, number of layers.

To search for good hyperparameters, Researchers typically start a series of small runs with different hyperparameter values, let them run for a while, and then examine results to decide what works best.


With HPO, the Researcher provides a single script that is used with multiple, varying, parameters. Each run is a _pod_ (see definition above). Unlike Gang Scheduling, with HPO, pods are __independent__. They are scheduled independently, started, and end independently, and if preempted, the other pods are unaffected. The scheduling behavior for individual pods is exactly as described in the Scheduler Details section above for Jobs. 

For more information on Hyperparameter Optimization in Run:AI see [here](../Walkthroughs/walkthrough-hpo.md)