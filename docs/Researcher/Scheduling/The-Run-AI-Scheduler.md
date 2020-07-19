# Introduction

&nbsp;At the heart of the Run:AI solution is the Run:AI scheduler. The scheduler is the gatekeeper of your organization's hardware resources. It makes decisions on resource allocations according to pre-created rules.

The purpose of this document is to describe the Run:AI scheduler and explain how<span>&nbsp;resource management works.</span>

# Terminology

## Workload Types

Run:AI differentiates between two types of deep learning workloads:

*   ___Interactive___ build workloads. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm or similar and accesses GPU resources directly<span>. Build workloads typically do not tax the GPU for a long duration. There are also typically real users behind an interactive workload that need an immediate scheduling response&nbsp;</span>
*   ___Unattended___&nbsp;(or "non-interactive") training&nbsp;workloads.&nbsp;<span>Training is characterized&nbsp;by a deep learning run that has a start and a finish.&nbsp;</span>With these types of workloads, the data scientist prepares a self-running workload and sends it for execution.&nbsp;<span>Training workloads typically utilize large percentages of the GPU.&nbsp;</span>During the execution, the researcher can examine the results<span>. A Training session can take anything from a few minutes to a couple of weeks. It can be interrupted in the middle and later restored.   
It follows that a good practice for the researcher is to save checkpoints and allow the code to restore from the last checkpoint.&nbsp;</span>

## Projects

Projects are quota entities that associate a project name with a ___deserved___&nbsp; GPU quota as well as other preferences.&nbsp;

A researcher submitting a workload must associate a project with any workload request. The Run:AI scheduler will then compare the request against the current allocations and the project's deserved quota and determine whether the workload can be allocated with resources or whether it should remain in a pending state.

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">For further information on projects and how to configure them, see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011591300-Working-with-Project-Quotas>&nbsp;</span>

<span style="font-size: 2.1em; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Basic Scheduling Concepts</span>

## Interactive vs. Unattended&nbsp;

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">The Researcher uses the _--interactive_ flag to specify whether the workload is an unattended "train" workload or an interactive "build" workload.&nbsp;</span>

*   Interactive workloads will get precedence over unattended workloads.&nbsp;
*   <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Unattended workloads can be preempted when the scheduler determines a more urgent need for resources. Interactive workloads are never preempted</span>

<span style="font-size: 1.5em; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Guaranteed Quota and Over-Quota</span>

Every new workload is associated with a Project. The project contains a deserved GPU quota. During scheduling:

*   If the newly required resources, together with currently used resources, end up within the project's quota, then the workload is ready to be scheduled as part of the guaranteed quota.
*   If the newly required resources together with currently used resources end up above the project's quota, the workload will only be scheduled if there are 'spare' GPU resources. There are nuances in this flow which are meant to ensure that a project does not end up with over-quota made fully of interactive workloads. For additional details see below

&nbsp;

# Scheduler Details

## Allocation &amp; Preemption

The Run:AI scheduler wakes up periodically to perform allocation tasks on pending workloads:

*   The scheduler looks at each Project separately and selects the most 'deprived' Project.
*   For this deprived project it chooses a single workload to work on:
    
    *   Interactive workloads are tried first, but only up to the project's guaranteed quota.&nbsp; If such a workload exists, it is&nbsp;scheduled even if it means __preempting__ a running unattended workload in this Project.&nbsp;&nbsp;
    *   Else, it looks for an unattended workload and schedules it on guaranteed quota or over-quota.&nbsp;
    
    
    
*   The scheduler then recalculates the next 'deprived' project and continues with the same flow until it finishes attempting to schedule all workloads

## Reclaim

<span>During the above process, there may be a pending workload whose project is below the deserved capacity. Still, it cannot be allocated due to the lack of GPU resources. The scheduler will then look for alternative allocations&nbsp;<span class="wysiwyg-underline">at the expense of another project</span> which has gone over-quota while preserving fairness between projects.</span>

## Fairness

<div class="p-rich_text_section">The Run:AI scheduler determines fairness between multiple over-quota projects according to their GPU quota. Consider for example two projects, each spawning a significant amount of workloads (e.g. for Hyper-parameter tuning) all of which wait in the queue to be executed. The Run:AI Scheduler allocates resources while preserving fairness between the different projects regardless of the time they entered the system. The fairness works according to the&nbsp;<strong data-stringify-type="bold">relative portion of GPU quota for each project.&nbsp;</strong>&nbsp;To further illustrate that, suppose that:<span class="c-mrkdwn__br" data-stringify-type="paragraph-break"></span>
</div>

<ul class="p-rich_text_list p-rich_text_list__bullet" data-indent="0" data-stringify-type="unordered-list">
<li>project A has been allocated with a quota of 3 GPUs, and</li>
<li>project B has been allocated with a quota of 1 GPU.</li>
</ul>

<div class="p-rich_text_section">Then, if both projects go over quota, project A will receive 25% (=1/(1+3)) of the idle GPUs and project B will receive 75% (=3/(1+3)) of the idle GPUs. This ratio will be recalculated every time a new job is submitted to the system or existing job ends.</div>

&nbsp;

<h2 class="p-rich_text_section">Bin-packing &amp; Consolidation</h2>

Part of an efficient scheduler is the ability to eliminate defragmentation:

*   The first step in avoiding defragmentation is bin packing: try and fill nodes (machines) up before allocating workloads to new machines.
*   The next step is to consolidate jobs on demand. If a workload cannot be allocated due to defragmentation, the scheduler will try and move unattended workloads from node to node in order to get the required amount of GPUs to schedule the pending workload.&nbsp;

## Elasticity

Run:AI Elasticity is explained <a href="https://support.run.ai/hc/en-us/articles/360011347560-Elasticity-Dynamically-Stretch-Compress-Jobs-According-to-GPU-Availability" target="_self">here</a>. In essence, it allows<span>&nbsp;unattended</span><span>&nbsp;workloads to shrink or expand based on the cluster's availability.&nbsp;</span>

*   <span>Shrinking happens when the scheduler is unable to schedule an elastic unattended workload and no amount of&nbsp;_consolidation&nbsp;_helps. The scheduler then divides the requested GPUs by half again and again and tries to reschedule.&nbsp;</span>
*   <span>Shrink jobs will expand when enough GPUs will be available.</span>
*   <span>Expanding happens when the scheduler finds spare GPU resources, enough to double the amount of GPUs for an elastic workload.</span>

&nbsp;
&nbsp;
&nbsp;