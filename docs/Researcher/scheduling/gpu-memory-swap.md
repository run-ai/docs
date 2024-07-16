---
title: GPU Memory SWAP
summary: This article describes the Run:ai memory swap feature and includes configuration information.
authors:
    - Jamie Weider
    - Hagay Sharon
date: 2024-Jun-26
---

## Introduction

To ensure efficient and effective usage of an organization’s resources, Run:ai provides multiple features on multiple layers to help administrators and practitioners maximize their existing GPUs resource utilization.

Run:ai’s *GPU memory swap* feature helps administrators and AI practitioners to further increase the utilization of existing GPU hardware by improving GPU sharing between AI initiatives and stakeholders. This is done by expanding the GPU physical memory to the CPU memory which is typically an order of magnitude larger than that of the GPU.

Expanding the GPU physical memory, helps the Run:ai system to put more workloads on the same GPU physical hardware, and to provide a smooth workload context switching between GPU memory and CPU memory, eliminating the need to kill workloads when the memory requirement is larger than what the GPU physical memory can provide.

## Benefits of GPU memory swap

There are several use cases where GPU memory swap can benefit and improve the user experience and the system's overall utilization:

### Sharing a GPU between multiple interactive workloads (notebooks)

AI practitioners use notebooks to develop and test new AI models and to improve existing AI models. While developing or testing an AI model, notebooks use GPU resources intermittently, yet, required resources of the GPU’s are pre-allocated by the notebook and cannot be used by other workloads after one notebook has already reserved them. To overcome this inefficiency, Run:ai introduced *Dynamic Fractions* and *Node Level Scheduler*.

When one or more workloads require more than their requested GPU resources, there’s a high probability not all workloads can run on a single GPU because the total memory required is larger than the physical size of the GPU memory.

With *GPU memory swap*, several workloads can run on the same GPU, even if the sum of their used memory is larger than the size of the physical GPU memory. *GPU memory swap* can swap in and out workloads interchangeably, allowing multiple workloads to each use the full amount of GPU memory. The most common scenario is for one workload to run on the GPU (for example, an interactive notebook),while other notebooks are either idle or using the CPU to develop new code (while not using the GPU). From a user experience point of view, the swap in and out is a smooth process since the notebooks do not notice that they are being swapped in and out of the GPU memory. On rare occasions, when multiple notebooks need to access the GPU simultaneously, slower workload execution may be experienced.

Notebooks typically use the GPU intermittently, therefore with high probability, only one workload (for example, an interactive notebook), will use the GPU at a time. The more notebooks the system puts on a single GPU, the higher the chances are that there will be more than one notebook requiring the GPU resources at the same time. Admins have a significant role here in fine tuning the number of notebooks running on the same GPU, based on specific use patterns and required SLAs. Using ‘Node Level Scheduler’ reduces GPU access contention between different interactive notebooks running on the same node.

### Sharing a GPU between inference/interactive workloads and training workloads

A single GPU can be shared between an interactive or inference workload (for example, a Jupyter notebook, image recognition services, or an LLM service), and a training workload that is not time-sensitive or delay-sensitive. At times when the inference/interactive workload uses the GPU, both training and inference/interactive workloads share the GPU resources, each running part of the time swapped-in to the GPU memory, and swapped-out into the CPU memory the rest of the time.

Whenever the inference/interactive workload stops using the GPU, the swap mechanism swaps out the inference/interactive workload GPU data to the CPU memory. Kubernetes wise, the POD is still alive and running using the CPU. This allows the training workload to run faster when the inference/interactive workload is not using the GPU, and slower when it does, thus sharing the same resource between multiple workloads, fully utilizing the GPU at all times, and maintaining uninterrupted service for both workloads.

### Serving inference warm models with GPU memory swap

Running multiple inference models is a demanding task and you will need to ensure that your SLA is met. You need to provide high performance and low latency, while maximizing GPU utilization. This becomes even more challenging when the exact model usage patterns are unpredictable. You must plan for the agility of inference services and strive to keep models on standby in a ready state rather than an idle state.

Run:ai’s *GPU memory swap* feature enables you to load multiple models to a single GPU, where each can use up to the full amount GPU memory. Using an application load balancer, the administrator can control to which server each inference request is sent. Then the GPU can be loaded with multiple models, where the model in use is loaded into the GPU memory and the rest of the models are swapped-out to the CPU memory. The swapped models are stored as ready models to be loaded when required. *GPU memory swap* always maintains the context of the workload (model) on the GPU so it can easily and quickly switch between models. This is unlike industry standard model servers that load models from scratch into the GPU whenever required.

## Configuring memory swap

**Perquisites**&mdash;before configuring the *GPU Memory Swap* the administrator must configure the *Dynamic Fractions* feature, and optionally configure the *Node Level Scheduler* feature. 

The first enables you to make your workloads burstable, and both features will maximize your workloads’ performance and GPU utilization within a single node.

To enable *GPU memory swap* in a Run:aAi cluster, the administrator must update the `runaiconfig` file with the following parameters:

``` yaml
spec: 
 global: 
   core: 
     swap:
       enabled: true
       limits:
         cpuRam: 100Gi
```

The example above uses `100Gi` as the size of the swap memory.

You can also use the `patch` command from your terminal:

``` yaml
kubectl patch -n runai runaiconfigs.run.ai/runai --type='merge' --patch '{"spec":{"global":{"core":{"swap":{"enabled": true}}}}}'
```

To make a workload swappable, a number of conditions must be met:

1. The workload MUST use Dynamic Fractions. This means the workload’s memory request is less than a full GPU, but it may add a GPU memory limit to allow the workload to effectively use the full GPU memory.

2. The administrator must label each node that they want to provide GPU memory swap with a `run.ai/swap-enabled=true` this enables the feature on that node. Enabling the feature reserves CPU memory to serve the swapped GPU memory from all GPUs on that node. The administrator sets the size of the CPU reserved RAM memory using the runaiconfigs file.

3. Optionally, configure *Node Level Scheduler*. Using node level scheduler can help in the following ways:

    * The Node Level Scheduler automatically spreads workloads between the different GPUs on a node, ensuring maximum workload performance and GPU utilization.
    * In scenarios where Interactive notebooks are involved, if the CPU reserved memory for the GPU swap is full, the Node Level Scheduler preempts the GPU process of that workload and potentially routes the workload to another GPU to run.

### Configure `system reserved` GPU Resources

Swappable workloads require reserving a small part of the GPU for non-swappable allocations like binaries and GPU context. To avoid getting out-of-memory (OOM) errors due to non-swappable memory regions, the system reserves a 2GiB of GPU RAM memory by default, effectively truncating the total size of the GPU memory. For example, a 16GiB T4 will appear as 14GiB on a swap-enabled node.
The exact reserved size is application-dependent, and 2GiB is a safe assumption for 2-3 applications sharing and swapping on a GPU.
This value can be changed by editing the `runaiconfig` specification as follows:

```yml
spec: 
 global: 
   core: 
     swap:
       limits:
         reservedGpuRam: 2Gi
```

You can also use the `patch` command from your terminal:

```bash
kubectl patch -n runai runaiconfigs.run.ai/runai --type='merge' --patch '{"spec":{"global":{"core":{"swap":{"limits":{"reservedGpuRam": <quantity>}}}}}}'
```

This configuration is in addition to the *Dynamic Fractions* configuration, and optional *Node Level Scheduler* configuration.

## Preventing your workloads from getting swapped

If you prefer your workloads not to be swapped into CPU memory, you can specify on the pod an anti-affinity to `run.ai/swap-enabled=true` node label when submitting your workloads and the Scheduler will ensure not to use swap-enabled nodes.

## Known Limitations

* A pod created before the GPU memory swap feature was eneabled in that cluster, cannot be scheduled to a swap-enabled node. A proper event is generated in case no matching node is found. Users must re-submit those pods to make them swap-enabled.
* GPU memory swap cannot be enabled if fairshare time-slicing or strict time-slicing is used, GPU memory swap can only be used with the default time-slicing mechanism.
* CPU RAM size cannot be decreased once GPU memory swap is enabled.

## What happens when the CPU reserved memory for GPU swap is exhausted?

CPU memory is limited, and since a single CPU serves multiple GPUs on a node, this number is usually between 2 to 8. For example, when using 80GB of GPU memory, each swapped workload consumes up to 80GB (but may use less) assuming each GPU is shared between 2-4 workloads. In this example, you can see how the swap memory can become very large. Therefore, we give administrators a way to limit the size of the CPU reserved memory for swapped GPU memory on each swap enabled node.

Limiting the CPU reserved memory means that there may be scenarios where the GPU memory cannot be swapped out to the CPU reserved RAM. Whenever the CPU reserved memory for swapped GPU memory is exhausted, the workloads currently running will not be swapped out to the CPU reserved RAM, instead, *Node Level Scheduler* and *Dynamic Fractions* logic takes over and provides GPU resource optimization.see [Dynamic Fractions](fractions.md#dynamic-mig) and [Node Level Scheduler](node-level-scheduler.md#how-to-configure-node-level-scheduler).
