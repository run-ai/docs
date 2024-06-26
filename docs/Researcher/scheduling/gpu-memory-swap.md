---
title: GPU Memory SWAP
summary: This article describes the Run:ai memory swap feature.
authors:
    - Jamie Weider
    - Hagay Sharon
date: 2024-Jun-26
---

To ensure efficient and effective usage of an organization’s resources, Run:ai provides multiple features on multiple layers to help administrators and practitioners maximize their existing GPUs resource utilization.
Run:ai’s GPU memory swap feature helps administrators and AI practitioners to further increase the utilization of existing GPU HW by improving GPU sharing between AI initiatives and stakeholders. This is done by expending the GPU physical memory to the CPU memory which is typically an order of magnitude larger than that of the GPU.
Expending the GPU physical memory, helps the Run:ai system to put more workloads on the same GPU physical HW, and to provide a smooth workload context switching between GPU memory and CPU memory, eliminating the need to kill workloads when the memory requirement is larger than what the GPU physical memory can provide, as long as each single workload requires no more than the size of the GPU physical memory.
