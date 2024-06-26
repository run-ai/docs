---
title: GPU Memory SWAP
summary: This article describes the Run:ai memory swap feature.
authors:
    - Jamie Weider
    - Hagay Sharon
date: 2024-Jun-26
---

## Introduction

To ensure efficient and effective usage of an organization’s resources, Run:ai provides multiple features on multiple layers to help administrators and practitioners maximize their existing GPUs resource utilization.

Run:ai’s GPU memory swap feature helps administrators and AI practitioners to further increase the utilization of existing GPU HW by improving GPU sharing between AI initiatives and stakeholders. This is done by expending the GPU physical memory to the CPU memory which is typically an order of magnitude larger than that of the GPU.

Expending the GPU physical memory, helps the Run:ai system to put more workloads on the same GPU physical HW, and to provide a smooth workload context switching between GPU memory and CPU memory, eliminating the need to kill workloads when the memory requirement is larger than what the GPU physical memory can provide, as long as each single workload requires no more than the size of the GPU physical memory.

## Benefits of GPU memory swap

There are a number of use cases where GPU memory swap can benefit and improve the user experience and the system's overall utilization:

### Sharing a GPU between multiple interactive workloads (notebooks)

AI practitioners use notebooks to develop and test new AI models and to improve existing AI models. While developing or testing an AI model, notebooks use GPU resources intermittently, but the required resources of the GPU’s are pre-allocated by the notebook and cannot be used by other workloads after one notebook has already reserved them. To overcome this inefficiency, Run:ai introduced Dynamic Fractions and Node Level Scheduler. 

When one or more workloads require more than their requested GPU resources, there’s a high probability not all workloads can run on a single GPU, because the total memory required is larger than the physical size of the GPU memory. 

With GPU memory swap, several workloads can run on the same GPU, even if the sum of their used memory is larger than the size of the physical GPU memory. While GPU memory swap can swap-in and swap-out workloads interchangeably, allowing multiple workloads to each use the full GPU memory, the more common scenario is for one workload to run, say an interactive notebook running, while other notebooks are either idle or using the CPU to develop new code but not using the GPU at the same time. Swap-in and swap-out is a smooth process from a user-experience point of view, the notebooks do not notice that they are being swapped in and out of the GPU memory, and the user-experience effect is a slower execution pace when multiple notebooks use the GPU simultaneously. 

The assumption is that notebooks only use the GPU intermittently, therefore with high probability, only one workload (interactive notebook in this case) will use the GPU at a time. The more notebooks the system puts on a single GPU, the higher the chances are that there will be more than one notebook requiring the GPU resources at the same time. Admins have a significant role here in fine-tuning the amount of notebooks running on the same GPU, based on the customer’s specific use patterns and required SLA.

### Sharing a GPU between "frontend" interaractive workloads and "background" training workloads

A single GPU can be shared between an interactive frontend workload such as a notebook, and a backend training process that is not time-sensitive or delay-sensitive as an interactive workload. Whenever the interactive workload uses the GPU, both workloads share the GPU time, each running part of the time swapped-in and swapped-out in the CPU memory the rest of the time. 

Each time the interactive workload stops using the GPU (idle), the Run:ai system keeps the interactive workload data in the CPU memory while Kubernetes- wise, maintaining the POD state as running, and the same goes for the training session. This allows the training workload to run faster when the interactive workload is not using the GPU, and slower when it does, thus sharing the same resource between multiple workloads and maintaining uninterrupted service for both workloads.

### Serving inference warm models with GPU memory swap

When running multiple models, it is important to decide how to best utilize your GPU HW when you don’t know exactly how many instances you want to keep “hot” on a GPU, vs. cold models, stored in HDD or CPU memory, waiting to be loaded to the GPU. 

Run:ai’s GPU memory swap feature enables you to load multiple models to a single GPU, each can occupy up to the full GPU memory. Using a load balancer, the administrator can control which inference request is sent to which server. The GPU can be loaded with multiple models, where the model in use is loaded to the GPU memory and the rest of the models swapped-out to the CPU memory, stored as warm models and ready to be loaded when required. GPU memory swap always maintains the context of the workload on the GPU, it can easily and quickly switch between models, unlike cold models that must be loaded completely from scratch.

## Configuring memory swap

To enable ‘GPU memory swap’ in a Run:aAi cluster, the administrator must update runaiconfig file with the following configuration:

``` yaml
spec: 
 global: 
   core: 
     swap:
       enabled: true
```

Or use the patch command from your host terminal:

``` yaml
kubectl patch -n runai runaiconfigs.run.ai/runai --type='merge' --patch '{"spec":{"global":{"core":{"swap":{"enabled": true}}}}}'
```

This configuration is in addition to the ‘Dynamic Fractions’ configuration, and optionally ‘Node Level Scheduler’ to maximize performance within a single node.

** ADD SYSTEM RESERVED CONFIGURATION ** 1G x number of workloads, recommended 2-3 workloads

To make a workload swappable, a number of conditions must be met:

1. The workload MUST use Dynamic Fractions. This means the workload’s memory request is less than a full GPU, but it may add a GPU memory limit to allow the workload to effectively use the full GPU memory. If regular fractions are used instead of Dynamic Fractions is NOT used but regular fraction is (for that workload), the swap logic assumes this workload prefers NOT to be swapped-out and therefore, all other workloads on the same GPU are NOT swapped either.

2. The administrator must label each node that they want to provide GPU memory swap with a “run.ai/swap-enabled=true” this enables the feature on that node. Enabling the feature creates a local swap file in the CPU to serve the swapped memory from all GPUs on that node. Setting the size of the CPU swap file, the administrator sets that figure as a runaiconfigs value.

3. Optionally configure ‘Node Level Scheduler’ - using node level scheduler can help in two ways:
When the cluster/node-pool 

Anti affinity to avoid being swapped

## What happens when CPU SWAP file is exhausted?
CPU memory is limited, and since a single CPU serves multiple GPUs on a node, this number is usually between 2 to 8. Even if we take as an example an 80GB GPU memory, each swapped workload consumes up to 80GB (but usually consumes less), and as you can easily foresee how the swap file can rapidly become very large. Therefore we limit the size of the CPU swap file per node. 

## What happens when the swap file is full? 
In this case, the node level scheduler and dynamic fractions logic take over and provide the same capability of GPU resource optimization, you can read more about this in Dynamic Fraction and Node Level Scheduler. 
