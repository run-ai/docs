---
title: Dynamic GPU Fractions
summary: New set of core capabilities enabling workloads to use GPU resources and to specify and consume GPU memory and compute resources dynamically
authors:
    - Jason Novich
date: 2023-10-31
---

Many AI workloads as researchers' notebooks, are using GPU resources intermittently which means that these resources are not used all the time, but only when needed for running AI applications, or debugging a model in development. Other workloads such as Inference, might be using GPU resources at lower utilization rate than requested, and suddenly ask for higher guaranteed resources at peak utilization times.

This pattern of resource request vs. actual resource utilization causes lower utilization of GPUs, especially if there are many workloads requesting resources to match their peak demand, even thought the majority of the time they operate far below that peak.

Run:ai has introduced *Dynamic GPU fractions* in v2.15 in order to cope with this fluctuation and to enable users to optimize GPU resources.

This is a suite of new core capabilities enabling workloads to optimize the use of GPU resources. This workks by providing the ability to specify and consume GPU memory and compute resources dynamically by leveraging Kubernetes *Request and Limit notations*.

*Dynamic GPU fractions* allows a workload to request a certain amount of guaranteed fraction of GPU memory or GPU compute resource (similar to a Kubernetes request), and at the same time also request the ability to grow beyond that guaranteed GPU memory and/or GPU fraction if the resources  available up to a specified limit (similar to a Kubernetes limit).

For example, with *Dynamic GPU Fractions*, a user can specify a workload with a GPU fraction Request of 0.25 GPU, and add a new notation of `gpu-fraction-limit` of up to 0.80 GPU. The cluster/node-pool scheduler schedules the workload to a node that can provide the GPU fraction request (0.25), and the local node scheduler assigns the workload a GPU. The GPU scheduler monitors the workload and allows it to occupy memory between 0 to 0.80 of the GPU memory, where only 0.25 of the GPU memory is actually guaranteed to that workload. The rest of the memory (from 0.25 to 0.8) is “loaned” to the workload, as long as the rightful owners of that memory do not need to use it.

Run:ai automatically manages the state changes between `request` to `Limit` as well as the reverse (when the balance need to be "returned"), updating the metrics and workloads states and graphs.

## Setting Fractional GPU Memory Limits

With the fractional GPU memory limit, users can submit workloads using GPU fraction `Request` and `Limit`.

There are two ways to use this capability:

1. Using a GPU Fraction parameter (i.e. use the `gpu-fraction` annotation)
2. Using an absolute GPU Memory parameter (`gpu-memory` annotation)

Then set a GPU memory limit, either as GPU fraction or GPU memory size, the Limit must be equal or greater than the GPU fraction/memory request.

Eventually, both GPU fraction and GPU memory are translated into the actual requested memory size of the Request (guaranteed) and Limit (best effort).

To guarantee a fair quality of service between the different workloads using the same GPU, Run:ai developed an extendable GPU OOMKiller component that guarantees the quality of service using the known K8S semantics for resources Request and Limit.

The `OOMKiller` capability requires adding `CAP_KILL` capabilities - enabling ‘Dynamic GPU fraction’ will automatically add this capability to the Run:ai core scheduling module (aka toolkit daemon). This capability is disabled by default.

To enable ‘Dynamic GPU Fraction’ it, edit the `runaiconfig` CRD and set:

`spec: global: core: dynamicFraction: enabled: true`

To set per workload a gpu memory limit is done by adding the `RUNAI_GPU_MEMORY_LIMIT` environment variable to the first container in the pod which is the GPU consuming container.

(TODO: add example yaml).

In v2.15 this can be done by:

1. Submitting a workload yaml directly and set the `RUNAI_GPU_MEMORY_LIMIT` environment variable.

2. Creating a policy, per Project or global, e.g. set all Interactive workloads of Project=research\_vision1 to always set the environment variable of `RUNAI_GPU_MEMORY_LIMIT` to 1

3. Passing the environment variable through the CLI\\GUI.


The supported values depends on the label used, in the following way, and can not be mixed:

| **Annotation(UI Compute Resource Param / CLI Param)** | `RUNAI_GPU_MEMORY_LIMIT` format |
| --- |  --- |
| `gpu-fraction` ('GPU Fraction of Device' /\--gpu) | 2-fixed point fraction value where `gpu-fraction` <= value <= `1.0`for example: 0.25, 0.75 |
| `gpu-memory` ('GPU Memory of 1 device' /\--gpu-memory) | k8s resources quantity like any other resource, which has to be larger the the `gpu-memory` , for example:500000000, 2500M, 4G,**note:** The `gpu-memory` annotation label values are always in MB, unlike the env var. |
