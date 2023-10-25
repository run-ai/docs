---
title: GPU Time Slicing Scheduler
summary: This article describes the trainings feature. This feature provides a wizard like experience to submit training jobs.
authors:
    - Jason Novich
date: 2023-Oct-25
---

### Background:

Run:ai supports simultaneous submission of multiple workloads submission to a single GPU when using fractional GPU workloads. This takes place by slicing the GPU memory between the different workloads, according to the requested GPU fraction, and by using NVidia's GPU orchestrator to share the GPU compute runtime. Run:ai ensures each workload strictly receives the exact share of the GPU memory (= gpu\_memory \* requested), while the NVidia GPU orchestrator splits the GPU runtime evenly between the different workloads running on that GPU. For example, when there are 2 workloads running on the same GPU, each will get 50% of the GPU compute runtime, even if one workload requested 25% of the GPU memory, and the other workload requests 75% of the GPU memory.

### New Time-slicing scheduler by Run:ai:

To provide customers with a predictable and accurate GPU compute resources scheduling, Run:ai is introducing a new Time-slicing GPU scheduler, this is a new Run:ai core feature introduced in release v2.15, which adds **fractional compute** capabilities on top of other existing Run:ai **memory fractions** capabilities. Unlike the default NVIDIA GPU orchestrator which doesn’t provide the ability to split or limit the runtime of each workload, Run:ai created a new mechanism that gives each workload **exclusive** access to the full GPU for a **limited** amount of time (**lease time**) in each scheduling cycle (**plan time**), this cycle repeats itself for the lifetime of the workload.

Using the GPU runtime this way guarantees a workload is granted its requested GPU compute resources proportionally to its requested GPU fraction.

Run:ai offers two new Timeslicing modes:

1.  **Strict** - Each workload gets its **precise** GPU compute fraction, which equals to its requested GPU (memory) fraction. In terms of official Kubernetes resource specification, this means:
    
    1.  gpu-compute-request = gpu-compute-limit = gpu-(memory-)fraction.
        
2.  **Fair** - Each workload is guaranteed at least its GPU compute fraction, but at the same time can also use additional GPU runtime compute slices that are not used by other idle workloads. Those excess time slices are divided equally between all workloads running on that GPU (after each got at least its requested GPU compute fraction). In terms of official Kubernetes resource specification, this means:
    
    1.  gpu-compute-request = gpu-(memory-)fraction
        
    2.  gpu-compute-limit = 1.0.
        

The figure below illustrates how **strict** time slicing mode is using the GPU from Lease(slice) and Plan(cycle) perspective:

![](blob:https://runai.atlassian.net/a27e1e7b-f546-44fa-9bf9-1a3ee906c23c#media-blob-url=true&id=c71174db-82fb-46e3-a576-ca72657d34e1&collection=contentId-2649227281&contextId=2649227281&height=488&width=1162&alt=)

The figure below illustrates how **Fair** time slicing mode is using the GPU from Lease(slice) and Plan(cycle) perspective:

![](blob:https://runai.atlassian.net/9291de99-bd68-4106-a6c0-ea906e9a3015#media-blob-url=true&id=8a532ce2-f623-4e74-a733-cd46a7aa8a40&collection=contentId-2649227281&contextId=2649227281&height=339&width=681&alt=)

### Setting the Time-slicing scheduler policy:

Time-slicing is a cluster flag which changes the default behaviour of Run:ai GPU fractions feature, as explained in the previous paragraphs.

Enabling or setting Time-slicing is done by setting the following cluster flag in the **runaiconfig** file:

`global: core: timeSlicing: mode: fair/strict`

If the timeSlicing flag is not set, the system continues to use the default NVidia GPU orchestrator (as explained earlier in this page), this is the backward compatible mode.

### timeSlicing plan and lease times:

Each GPU scheduling cycle is a **plan**, the plan time is determined by the lease time and granularity (precision). By default, basic lease time is 250ms with 5% granularity (precision), which means the plan (cycle) time is: 250 / 0.05 = 5000ms (5 Sec). Using these values, a workload that asked to get gpu-fraction=0.5 gets 2.5s runtime out of 5s cycle time.

Different workloads requires different SLA and precision, so it also possible to tune the lease time and precision for customizing the time-slicing capabilities to your cluster.

**note:** decreasing the lease time makes timeslicing less accurate. Increasing the lease time make the system more accurate, but each workload is less responsive.

Once timeSlicing is enabled, all submitted GPU fraction or GPU memory workloads will have their gpu-compute-request\\limit set automatically by the system, depending on the annotation used on the timeSlicing mode:

#### Strict Compute Resources

<table data-testid="renderer-table" data-number-column="false"><colgroup><col><col><col><col></colgroup><tbody><tr><th rowspan="1" colspan="1" colorname="" data-colwidth="189" aria-sort="none"><div><p data-renderer-start-pos="4190"><strong data-renderer-mark="true">Annotation</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="118" aria-sort="none"><div><p data-renderer-start-pos="4204"><strong data-renderer-mark="true">Value</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="226" aria-sort="none"><div><p data-renderer-start-pos="4213"><strong data-renderer-mark="true">GPU Compute Request</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="223" aria-sort="none"><div><p data-renderer-start-pos="4236"><strong data-renderer-mark="true">GPU Compute Limit</strong></p></div></th></tr></tbody></table>

<table data-testid="renderer-table" data-number-column="false"><colgroup><col><col><col><col></colgroup><tbody><tr><th rowspan="1" colspan="1" colorname="" data-colwidth="189" aria-sort="none"><div><p data-renderer-start-pos="4190"><strong data-renderer-mark="true">Annotation</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="118" aria-sort="none"><div><p data-renderer-start-pos="4204"><strong data-renderer-mark="true">Value</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="226" aria-sort="none"><div><p data-renderer-start-pos="4213"><strong data-renderer-mark="true">GPU Compute Request</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="223" aria-sort="none"><div><p data-renderer-start-pos="4236"><strong data-renderer-mark="true">GPU Compute Limit</strong></p></div></th></tr><tr><td rowspan="1" colspan="1" colorname="" data-colwidth="189"><p data-renderer-start-pos="4259"><code data-renderer-mark="true">gpu-fraction</code></p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="118"><p data-renderer-start-pos="4275">x</p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="226"><p data-renderer-start-pos="4280">x</p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="223"><p data-renderer-start-pos="4285">x</p></td></tr><tr><td rowspan="1" colspan="1" colorname="" data-colwidth="189"><p data-renderer-start-pos="4292"><code data-renderer-mark="true">gpu-memory</code></p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="118"><p data-renderer-start-pos="4306">x</p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="226"><p data-renderer-start-pos="4311">0</p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="223"><p data-renderer-start-pos="4316">1.0</p></td></tr></tbody></table>

#### Fair Compute Resources

<table data-testid="renderer-table" data-number-column="false"><colgroup><col><col><col><col></colgroup><tbody><tr><th rowspan="1" colspan="1" colorname="" data-colwidth="189" aria-sort="none"><div><p data-renderer-start-pos="4351"><strong data-renderer-mark="true">Annotation</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="120" aria-sort="none"><div><p data-renderer-start-pos="4365"><strong data-renderer-mark="true">Value</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="226" aria-sort="none"><div><p data-renderer-start-pos="4374"><strong data-renderer-mark="true">GPU Compute Request</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="221" aria-sort="none"><div><p data-renderer-start-pos="4397"><strong data-renderer-mark="true">GPU Compute Limit</strong></p></div></th></tr></tbody></table>

<table data-testid="renderer-table" data-number-column="false"><colgroup><col><col><col><col></colgroup><tbody><tr><th rowspan="1" colspan="1" colorname="" data-colwidth="189" aria-sort="none"><div><p data-renderer-start-pos="4351"><strong data-renderer-mark="true">Annotation</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="120" aria-sort="none"><div><p data-renderer-start-pos="4365"><strong data-renderer-mark="true">Value</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="226" aria-sort="none"><div><p data-renderer-start-pos="4374"><strong data-renderer-mark="true">GPU Compute Request</strong></p></div></th><th rowspan="1" colspan="1" colorname="" data-colwidth="221" aria-sort="none"><div><p data-renderer-start-pos="4397"><strong data-renderer-mark="true">GPU Compute Limit</strong></p></div></th></tr><tr><td rowspan="1" colspan="1" colorname="" data-colwidth="189"><p data-renderer-start-pos="4420"><code data-renderer-mark="true">gpu-fraction</code></p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="120"><p data-renderer-start-pos="4436">x</p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="226"><p data-renderer-start-pos="4441">x</p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="221"><p data-renderer-start-pos="4446">1.0</p></td></tr><tr><td rowspan="1" colspan="1" colorname="" data-colwidth="189"><p data-renderer-start-pos="4455"><code data-renderer-mark="true">gpu-memory</code></p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="120"><p data-renderer-start-pos="4469">x</p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="226"><p data-renderer-start-pos="4474">0</p></td><td rowspan="1" colspan="1" colorname="" data-colwidth="221"><p data-renderer-start-pos="4479">1.0</p></td></tr></tbody></table>

**Note:** As you can see in the above tables, when submitting a workload using gpu-memory annotation, the system will split the GPU compute time between the different workloads running on that GPU, this means the workload can get anything from very little compute time (>0) to full GPU compute time (1.0).

### **INTERNAL USE ONLY NOT CUSTOMER FACING**

#### Custom Compute Resources

It is also possible to tune and hand-fit the compute request and limits by setting the `RUNAI_GPU_COMPUTE_REQUEST` and `RUNAI_GPU_COMPUTE_LIMIT` on each workload container, however Run:AI cluster scheduler does not take these into account compute requests QoS isn’t guarnteed, so we don’t recommend overwriting the default compute requests set by the system.

#### Advanced Compute Configurations

You can configure advanced configuration under `global::core::timeSliciing` in runaiconfig:

1.  `rateLimitCount` - An integer specifying GPU kernel ratelimiting
    
    1.  May be needed when running benchmarking applications like `quickstart-cuda` or `gpuburn`
        
    2.  The following values are recommended:
        
        1.  0 - disabled (default)
            
        2.  5 - high load workloads (`gpuburn`)
            
        3.  10 - medium load workloads (\`quickstart-cuda\`)
            
2.  `leaseTime` - An integer representing the minimal lease plan time slice in milliseconds (default: 250).
    
    1.  Decreasing this value reduce the total plan time and makes the applications more responsive but the timeSlicing less accurate
        
3.  `granularity` - the weight of `leaseTime` out of the total plan time (default 5%)
    
    1.  Chaning this value changes the total plan time. No real reason to change it, its better to configure `leaseTime` instead.
        

Like mentioned before, `plantime = (leaseTime * 100) / granularity` (default 5sec)

Be the first to add a reaction