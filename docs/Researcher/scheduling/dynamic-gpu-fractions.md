---
title: Dynamic GPU Fractions
summary: New set of core capabilities enabling workloads to use GPU resources and to specify and consume GPU memory and compute resources dynamically
authors:
    - Jason Novich
date: 2023-10-31
---
## Introduction

Many AI workloads as researchers' notebooks are using GPU resources intermittently. This means that these resources are not used all the time, but only when needed for running AI applications, or debugging a model in development. Other workloads such as Inference, might be using GPU resources at lower utilization rate than requested, and may suddenly ask for higher guaranteed resources at peak utilization times.

This pattern of resource request vs. actual resource utilization causes lower utilization of GPUs. This mainly happens if there are many workloads requesting resources to match their peak demand, even though the majority of the time they operate far below that peak.

Run:ai has introduced *Dynamic GPU fractions* in v2.15 in order to cope with resource request vs. actual resource utilization to enable users to optimize GPU resources.

*Dynamic GPU fractions* is part of Run:ai's core capabilities to enable workloads to optimize the use of GPU resources. This works by providing the ability to specify and consume GPU memory and compute resources dynamically by leveraging Kubernetes *Request and Limit notations*.

*Dynamic GPU fractions* allows a workload to request a guaranteed fraction of GPU memory or GPU compute resource (similar to a Kubernetes request), and at the same time also request the ability to grow beyond that guaranteed request up to a specific limit (similar to a Kubernetes limit), if the resources are available.

For example, with *Dynamic GPU Fractions*, a user can specify a workload with a GPU fraction Request of 0.25 GPU, and add the parameter `gpu-fraction-limit` of up to 0.80 GPU. The cluster/node-pool scheduler schedules the workload to a node that can provide the GPU fraction request (0.25), and then assigns the workload to a GPU. The GPU scheduler monitors the workload and allows it to occupy memory between 0 to 0.80 of the GPU memory (based on the parameter `gpu-fraction-limit`), where only 0.25 of the GPU memory is actually guaranteed to that workload. The rest of the memory (from 0.25 to 0.8) is “loaned” to the workload, as long as it is not needed by other workloads.

Run:ai automatically manages the state changes between `request` and `Limit` as well as the reverse (when the balance need to be "returned"), updating the metrics and workloads' states and graphs.

## Setting Fractional GPU Memory Limits

With the fractional GPU memory limit, users can submit workloads using GPU fraction `Request` and `Limit`.

You can either:

1. Use a GPU Fraction parameter (use the `gpu-fraction` annotation)

or

2. Use an absolute GPU Memory parameter (`gpu-memory` annotation)

When set a GPU memory limit either as GPU fraction, or GPU memory size, the `Limit` must be equal or greater than the GPU fraction memory request.

Both GPU fraction, and GPU memory are translated into the actual requested memory size of the Request (guaranteed) and the Limit (best effort).

To guarantee fair quality of service between different workloads using the same GPU, Run:ai developed an extendable GPU `OOMKiller` (Out Of Memory Killer) component that guarantees the quality of service using Kubernetes semantics for resources Request and Limit.

The `OOMKiller` capability requires adding `CAP_KILL` capabilities to the *Dynamic GPU fraction* and to the Run:ai core scheduling module (toolkit daemon). This capability is disabled by default.

To enable *Dynamic GPU Fraction* it, edit the `runaiconfig` file and set:

```YAML
spec: 
  global: 
    core: 
      dynamicFraction: 
        enabled: true
```

To set the gpu memory limit per workload, add the `RUNAI_GPU_MEMORY_LIMIT` environment variable to the first container in the pod. This is the GPU consuming container.

<!-- TODO: add example yaml). -->

To use `RUNAI_GPU_MEMORY_LIMIT` environment variable:

1. Submit a workload yaml directly, and set the `RUNAI_GPU_MEMORY_LIMIT` environment variable.

2. Create a policy, per Project or globally. For example, set all Interactive workloads of `Project=research_vision1` to always set the environment variable of `RUNAI_GPU_MEMORY_LIMIT` to 1.

3. Pass the environment variable through the CLI or the UI.

The supported values depend on the label used. You can use them in either the UI or the CLI. Use **only** one of the variables in the following table (they cannot be mixed):

| Variable | Input format |
| --- |  --- |
| `gpu-fraction`  | A fraction value (for example: 0.25, 0.75). |
| `gpu-memory`  | Kubernetes resources quantity which **must** be larger than `gpu-memory`. For example, 500000000, 2500M, 4G. **NOTE**: The `gpu-memory` label values are always in MB, unlike the env variable. |
