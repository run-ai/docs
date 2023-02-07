# Creating a new Compute Resource

Compute resource, is assigned to a single project or all projects (current and future ones). The latter option can only be created by a Run:ai administrator. A compute resource, by design, is shared with all project members.

To create a compute resource:

* Select the `create compute resource` button
* Select the project the resource will reside in
* Give the resource a meaningful name.

![](img/env-proj-select.png)

## Setting the resources request

A resources request is composed of 3 types of resources:

1. GPU
2. CPU Memory
3. CPU Compute

The user can select one or more resources. For example, one compute resource may consist of a CPU resource request only, whereas a different request can consist of a CPU memory request and a GPU request.

!!! Note 
    Selecting resources more than the cluster can supply will result in a permanently failed workspace.

![](img/compute-resource-create.png)


### Setting GPU resources

GPU resources can be expressed in various ways:

1. Request GPU devices: this option supports whole GPUs (e.g. 1 GPU, 2 GPUs, 3 GPUs) or a fraction of GPU (e.g. 0.1 GPU, 0.5 GPU, 0.93 GPU, etc.) 
2. Request partial memory of a single GPU device - this option allows to explicitly state the amount of memory needed (e.g. 5GB GPU RAM). 
3. Request a MIG profile - this option will dynamically provision the requested profile (if the relevant hardware exists). 

!!! Note  
    * Selecting a GPU fraction (e.g. 0.5 GPU) in a heterogeneous cluster may provide a different GPU memory allocation (e.g. half of a V100 16GB GPU memory is different than A100 40GB) per workspace. In such scenarios. Requesting specific GPU memory is a better strategy.
    * When selecting partial memory of a single GPU device, if NVIDIA MIG is enabled on a node, then the memory can be provided as a MIG profile. For more information see [Dynamic MIG](../../../../scheduling/fractions.md#dynamic-mig). 
    * If GPUs are not requested, they will not be allocated even if resources are available. In that case, the project's GPU quota will not be affected.

### Setting CPU resources

A CPU resource consists of cores and memory. When GPU resources are requested a faire share of cores and meoert, relative to GPU request is granted.

!!! Note
    If no resources are defined at all, the request is of an oppurtunistce nature, maeannign that it will look for any unallocated cpu node and tries to run the workload. But it could be preemted at any time without priorio notice (this could be very much relevant for testing and debugging).
