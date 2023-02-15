## Introduction

When we discuss the allocation of deep learning compute resources, the discussion tends to focus on GPUs as the most critical resource. But two additional resources are no less important:

*   CPUs. Mostly needed for preprocessing and postprocessing tasks during a deep learning training run.
*   Memory. Has a direct influence on the quantities of data a training run can process in batches.

GPU servers tend to come installed with a significant amount of memory and CPUs.

## Requesting CPU & Memory

When submitting a Job, you can request a guaranteed amount of CPUs and memory by using the __--cpu__ and __--memory__ flags in the _runai submit_ command. For example:

``` 
runai submit job1 -i ubuntu --gpu 2 --cpu 12 --memory 1G
```

The system guarantees that if the Job is scheduled, you will be able to receive this amount of CPU and memory.

For further details on these flags see: [runai submit](../cli-reference/runai-submit.md)

### CPU over allocation

The number of CPUs your Job will receive is guaranteed to be the number defined using the `--cpu` flag. In practice, however, you may receive <ins>more CPUs than you have asked</ins> for:

*   If you are currently alone on a node, you will receive all the node CPUs until such time when another workload has joined.
*   However, when a second workload joins, each workload will receive a number of CPUs <ins>proportional</ins> to the number requested via the `--cpu` flag. For example, if the first workload asked for 1 CPU and the second for 3 CPUs, then on a node with 40 cpus, the workloads will receive 10 and 30 CPUs respectively. If the flag `--cpu` is not specified, it will be taken from the cluster default (see the section below)

### Memory over allocation

The amount of Memory your Job will receive is guaranteed to be the number defined using the --memory flag. In practice, however, you may receive <ins>more memory than you have asked</ins> for. This is along the same lines as described with CPU over allocation above.

It is important to note, however, that if you have used this memory over-allocation, and new workloads have joined, your Job may receive an out-of-memory exception and terminate.

## CPU and Memory limits

You can limit your Job's allocation of CPU and memory by using the __--cpu-limit__ and __--memory-limit__ flags in the __runai submit__ command. For example:

    runai submit job1 -i ubuntu --gpu 2 --cpu 12 --cpu-limit 24 \
        --memory 1G --memory-limit 4G

The limit behavior is different for CPUs and memory.

*   Your Job will never be allocated with more than the amount stated in the `--cpu-limit` flag
*   If your Job tries to allocate more than the amount stated in the `--memory-limit` flag it will receive an out-of-memory exception.

The limit (for both CPU and memory) overrides the cluster default described in the section below

For further details on these flags see: [runai submit](../cli-reference/runai-submit.md)

## Flag Defaults

### Defaults for --cpu flag

If your Job has not specified `--cpu`, the system will use a default. The default is cluster-wide and is defined as a __ratio__ of GPUs to CPUs.

If, for example, the default has been defined as 1:6 and your Job has specified `--gpu 2` and has not specified `--cpu`, then the implied `--cpu` flag value is 12 CPUs.

The system comes with a cluster-wide default of 1:1. To change the ratio see below.

If you didn't request any GPUs for your job and has not specified `--cpu`, the default is defined as a ratio of CPU limit to CPUs.

If, for example, the default has been defined as 1:0.2 and your Job has specified `--cpu-limit 10` and has not specified `--cpu`, then the implied `--cpu` flag value is 2 CPUs.

The system comes with a cluster-wide default of 1:0.1. To change the ratio see below.


### Defaults for --memory flag

If your Job has not specified `--memory`, the system will use a default. The default is cluster-wide and is proportional to the number of requested GPUs.

The system comes with a cluster-wide default of 100MiB of allocated CPU memory per GPU. To change the ratio see below.

If you didn't request any GPUs for your job and has not specified `--memory`, the default is defined as a ratio of CPU Memory limit to CPU Memory Request.

The system comes with a cluster-wide default of 1:0.1. To change the ratio see below.


### Defaults for --cpu-limit flag

If your Job has not specified `--cpu-limit`, then by default, the system will not set a limit. You can set a cluster-wide limit as a __ratio__ of GPUs to CPUs. See below on how to change the ratio.



### Defaults for --memory-limit flag

If your Job has not specified `--memory-limit`, then by default, the system will not set a limit. You can set a cluster-wide limit as a __ratio__ of GPUs to Memory. See below on how to change the ratio.


### Changing the ratios

To change the cluster wide-ratio use the following process. The example shows: 

* a CPU request with a default ratio of 2:1 CPUs to GPUs.
* a CPU Memory request with a default ratio of 200MB per GPU.
* a CPU limit with a default ratio of 4:1 CPU to GPU.
* a Memory limit with a default ratio of 2GB per GPU.
* a CPU request with a default ratio of 0.1 CPUs per 1 CPU limit.
* a CPU Memory request with a default ratio of 0.1:1 request per CPU Memory limit.
 
You must edit the cluster installation values file:

* When installing the Run:ai cluster, edit the [values file](/admin/runai-setup/cluster-setup/cluster-install/#step-3-install-runai).
* On an existing installation, use the [upgrade](/admin/runai-setup/cluster-setup/cluster-upgrade) cluster instructions to modify the values file.
* You must specify at least the first 4 values as follows: 

```  yaml
runai-operator:
  config:
    limitRange:
      cpuDefaultRequestGpuFactor: 2
      memoryDefaultRequestGpuFactor: 200Mi
      cpuDefaultLimitGpuFactor: 4
      memoryDefaultLimitGpuFactor: 2Gi
      cpuDefaultRequestCpuLimitFactorNoGpu: 0.1
      memoryDefaultRequestMemoryLimitFactorNoGpu: 0.1
```


## Validating CPU & Memory Allocations

To review CPU & Memory allocations you need to look into Kubernetes. A Run:ai Job creates a Kubernetes _pod_. The pod declares its resource requests and limits. To see the memory and CPU consumption in Kubernetes:

*  Get the pod name for the Job by running: 

        runai describe job <JOB_NAME>

 the pod will appear under the `PODS` category. 

*  Run:

        kubectl describe pod <POD_NAME>
        
The information will appear under `Requests` and `Limits`. For example:

``` yaml
Limits:
    nvidia.com/gpu:  2
Requests:
    cpu:             1
    memory:          104857600
    nvidia.com/gpu:  2
```