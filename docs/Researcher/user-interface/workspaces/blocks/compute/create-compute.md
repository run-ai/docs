# Creating a new compute resource

Compute resource, by definition, is assigned to a single project or all projects or all projects (current and future ones), where the second option is reserved to administrator role. A compute resource by design shared with all project members.

The first step would be to press the create compute resource button and to select under which project it resides and to give the environment a meaningful name.

![](img/env-proj-select.png)

## Setting the resources request

Resources request is composed of 3 types of resoures:

1. GPU
2. CPU Memory
3. CPU Compute

The user as the freedom to state his/hers request per each type. For example, one compute resource can consists of only CPU resources where a different can request compute resource which consist GPU as well.

Note (!) it is important to request for resource that are within the cluster’s spec in order to avoid setting an “empty group” which will result in a failed workspace.

![](img/compute-resource-create.png)


### Setting GPU resources
GPU resources can be expressed in various ways for the user conivnece:

1. Requesting for GPU devices - this option support fraction of GPU (e.g. 0.1 GPU, 0.5 GPU, 0.93 GPU, etc.) or number of GPUs
(e.g. 1 GPU, 2 GPU, 3 GPU, etc.)
2. Requesting for memory of 1 GPU device - this option allow to explicitly state the amount of memory needed
3. Requesting for MIG profile - this option will dynamically provision the request profile (if the relevant hardware exist)

Note (!) if GPUs are not requested, they will not be allocated even if resources are available. In that case, the project quota will not be affected.

### Setting CPU resources
CPU resource consist of cores and memory. When GPU resources are requested a faire share of cores and meoert, relative to GPU request is granted.

Note !: if no resources are defined at all, the request is of an oppurtunistce nature, maeannign that it will look for any unallocated cpu node and tries to run the workload. But it could be preemted at any time without priorio notice (this could be very much relevant for testing and debugging).
