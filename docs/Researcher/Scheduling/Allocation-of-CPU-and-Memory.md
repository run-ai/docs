## Introduction

When we discuss the allocation of deep learning compute resources, the discussion tends to focus on GPUs as the most critical resource. But there are two additional resources that are no less important:

*   CPUs. Mostly needed for preprocessing and postprocessing tasks during a deep learning training run.
*   Memory. Has a direct influence on the quantities of data a training run can process in batches.

GPU servers tend to come installed with a significant amount of memory and CPUs.

## Requesting CPU & Memory

When submitting a job, you can request a guaranteed amount of CPUs and memory by using the __--cpu__ and __--memory__ flags in the _runai submit_ command. For example:

    runai submit job1 -i ubuntu --gpu 2 --cpu 12 --memory 1G

The system guarantees that if the job is scheduled, you will be able to receive this amount of CPU and memory.

For further details on these flags see: [runai submit](../cli-reference/runai-submit.md)

### CPU over allocation

The number of CPUs your job will receive is guaranteed to be the number defined using the --cpu flag. In practice, however, you may receive <ins>more CPUs than you have asked</ins> for:

*   If you are currently alone on a node, you will receive all the node CPUs until such time when another workload has joined.
*   However, when a second workload joins, each workload will receive a number of CPUs <ins>proportional</ins> to the number requested via the --cpu flag. For example, if the first workload asked for 1 CPU and the second for 3 CPUs, then on a node with 40 nodes, the workloads will receive 10 and 30 CPUs respectively.

### Memory over allocation

The amount of Memory your job will receive is guaranteed to be the number defined using the --memory flag. In practice, however, you may receive <ins>more memory than you have asked</ins> for. This is along the same lines as described with CPU over allocation above.

It is important to note, however, that if you have used this memory over-allocation, and new workloads have joined, your job may receive an out of memory exception and terminate.

## CPU and Memory limits

You can limit your job's allocation of CPU and memory by using the __--cpu-limit__ and __--memory-limit__ flags in the __runai submit__ command. For example:

    runai submit job1 -i ubuntu --gpu 2 --cpu 12 --cpu-limit 24 \
        --memory 1G --memory-limit 4G

The limit behavior is different for CPUs and memory.

*   Your job will never be allocated with more than the amount stated in the --cpu-limit flag
*   If your job tries to allocate more than the amount stated in the --memory-limit flag it will receive an out of memory exception.

For further details on these flags see: [runai submit](../cli-reference/runai-submit.md)

## Flag Defaults

### Defaults for --cpu flag

If your job has not specified --cpu, the system will use a default. The default is cluster-wide and is defined as a __ratio__ of GPUs to CPUs.

Consider the default of 1:6. If your job has only specified --gpu 2 and has not specified --cpu, then the implied --cpu flag value is 12 CPUs.

The system comes with a cluster-wide default of 1:1. To change this default please contact Run:AI customer support.

### Defaults for --memory flag

If your job has not specified --memory, the system will use a default. The default is cluster-wide and is proportional to the number of requested GPUs.

The system comes with a cluster-wide default of 100MiB per GPU. To change this default please contact Run:AI customer support.

## Validating CPU & Memory Allocations

To review a CPU & Memory allocations you need to look into Kubernetes. A Run:AI job creates a Kubernetes _pod_. The pod declares its resource requests and limits. To see the memory and CPU consumption in Kubernetes:

*  Get the pod name for the job by running: 

        runai get <JOB_NAME>

 the pod will appear under ``PODS``. 

*  Run:

        kubectl describe pod <POD_NAME>
        
The information will appear under ``Requests`` and ``Limits``. For example:

    Limits:
        nvidia.com/gpu:  2
    Requests:
      cpu:             1
      memory:          104857600
      nvidia.com/gpu:  2
