## Introduction

At the heart of the Run:AI solution is the Run:AI scheduler. The scheduler is the gatekeeper of your organization's hardware resources. It makes decisions on resource allocations according to pre-created rules.

The purpose of this document is to describe the Run:AI scheduler and explain how resource management works.

## Terminology

### Workload Types

Run:AI differentiates between two types of deep learning workloads:

*   __Interactive__ build workloads. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm or similar and accesses GPU resources directly. Build workloads typically do not tax the GPU for a long duration. There are also typically real users behind an interactive workload that need an immediate scheduling response.
*   __Unattended__ (or "non-interactive") training workloads.Training is characterized by a deep learning run that has a start and a finish. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. Training workloads typically utilize large percentages of the GPU. During the execution, the researcher can examine the results. A Training session can take anything from a few minutes to a couple of weeks. It can be interrupted in the middle and later restored.   
It follows that a good practice for the researcher is to save checkpoints and allow the code to restore from the last checkpoint.

### Projects

Projects are quota entities that associate a project name with a __deserved__ GPU quota as well as other preferences.

A researcher submitting a workload must associate a project with any workload request. The Run:AI scheduler will then compare the request against the current allocations and the project's deserved quota and determine whether the workload can be allocated with resources or whether it should remain in a pending state.

For further information on projects and how to configure them, see: [Working with Projects](../../Administrator/Admin-User-Interface-Setup/Working-with-Projects.md)

### Departments

A _Department_ is a second hierarchy of resource allocation above _Project_. A Department quota supersedes a Project quota in the sense that if the sum of Project quotas for Department A exceeds the Department quota -- the scheduler will use the Department quota rather than the Project quota.  

For further information on departments and how to configure them, see: [Working with Departments](../../Administrator/Admin-User-Interface-Setup/Working-with-Departments.md)


## Basic Scheduling Concepts

### Interactive vs. Unattended

The Researcher uses the _--interactive_ flag to specify whether the workload is an unattended "train" workload or an interactive "build" workload.

*   Interactive workloads will get precedence over unattended workloads.
*   Unattended workloads can be preempted when the scheduler determines a more urgent need for resources. Interactive workloads are never preempted.

### Guaranteed Quota and Over-Quota

Every new workload is associated with a Project. The project contains a deserved GPU quota. During scheduling:

*   If the newly required resources, together with currently used resources, end up within the project's quota, then the workload is ready to be scheduled as part of the guaranteed quota.
*   If the newly required resources together with currently used resources end up above the project's quota, the workload will only be scheduled if there are 'spare' GPU resources. There are nuances in this flow which are meant to ensure that a project does not end up with over-quota made fully of interactive workloads. For additional details see below

## Scheduler Details

### Allocation &amp; Preemption

The Run:AI scheduler wakes up periodically to perform allocation tasks on pending workloads:

*   The scheduler looks at each Project separately and selects the most 'deprived' Project.
*   For this deprived project it chooses a single workload to work on:
    
    *   Interactive workloads are tried first, but only up to the project's guaranteed quota. If such a workload exists, it is scheduled even if it means __preempting__ a running unattended workload in this Project.
    *   Else, it looks for an unattended workload and schedules it on guaranteed quota or over-quota.
    
*   The scheduler then recalculates the next 'deprived' project and continues with the same flow until it finishes attempting to schedule all workloads

### Reclaim

During the above process, there may be a pending workload whose project is below the deserved capacity. Still, it cannot be allocated due to the lack of GPU resources. The scheduler will then look for alternative allocations at the expense of another project which has gone over-quota while preserving fairness between projects.

### Fairness

The Run:AI scheduler determines fairness between multiple over-quota projects according to their GPU quota. Consider for example two projects, each spawning a significant amount of workloads (e.g. for Hyper-parameter tuning) all of which wait in the queue to be executed. The Run:AI Scheduler allocates resources while preserving fairness between the different projects regardless of the time they entered the system. The fairness works according to the __relative portion of GPU quota for each project.__ To further illustrate that, suppose that:

<li>project A has been allocated with a quota of 3 GPUs, and</li>
<li>project B has been allocated with a quota of 1 GPU.</li>


Then, if both projects go over quota, project A will receive 75% (=3/(1+3)) of the idle GPUs and project B will receive 25% (=1/(1+3)) of the idle GPUs. This ratio will be recalculated every time a new job is submitted to the system or existing job ends.

This fairness equivalence will also be maintained amongst __running__ jobs. The scheduler will preempt training sessions to maintain this equivalence 

### Bin-packing &amp; Consolidation

Part of an efficient scheduler is the ability to eliminate defragmentation:

*   The first step in avoiding defragmentation is bin packing: try and fill nodes (machines) up before allocating workloads to new machines.
*   The next step is to consolidate jobs on demand. If a workload cannot be allocated due to defragmentation, the scheduler will try and move unattended workloads from node to node in order to get the required amount of GPUs to schedule the pending workload.

### Elasticity

Run:AI Elasticity is explained [here](../researcher-library/Elasticity-Dynamically-Stretch-Compress-Jobs-According-to-GPU-Availability.md). In essence, it allows unattended workloads to shrink or expand based on the cluster's availability.

*   Shrinking happens when the scheduler is unable to schedule an elastic unattended workload and no amount of _consolidation_ helps. The scheduler then divides the requested GPUs by half again and again and tries to reschedule.
*   Shrink jobs will expand when enough GPUs will be available.
*   Expanding happens when the scheduler finds spare GPU resources, enough to double the amount of GPUs for an elastic workload.

## Distributed Training

Distributed Training, is the ability to split the training of a model among multiple processors. It is often a necessity when multi-GPU training no longer applies; typically when you require more GPUs than exist on a single node. 
Distribute Training utilizes a practice sometimes known as __Gang Scheduling__. The scheduler must ensure that multiple containers are started on what is typically multiple nodes, before the job can actually start. 