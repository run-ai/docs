# Compute Resource

A compute resource, is assigned to a single project or all projects (current and future ones). The latter option can only be created by a Run:ai administrator. A compute resource, by design, is shared with all project members.

You can select one or more resources. For example, one compute resource may consist of a CPU resource request only, whereas a different request can consist of a CPU memory request and a GPU request.

!!! Note
    Selecting resources more than the cluster can supply will result in a permanently failed workspace.

## Set GPU resources

GPU resources can be expressed in various ways:

1. Request GPU devices: this option supports whole GPUs (for example, 1 GPU, 2 GPUs, 3 GPUs) or a fraction of GPU (for example, 0.1 GPU, 0.5 GPU, 0.93 GPU, etc.)
2. Request partial memory of a single GPU device: this option allows to explicitly state the amount of memory needed (for example, 5GB GPU RAM).
3. Request a MIG profile: this option will dynamically provision the requested [MIG profile](../../../scheduling/fractions.md#dynamic-mig) (if the relevant hardware exists).

!!! Note

    * Selecting a GPU fraction (for example, 0.5 GPU) in a heterogeneous cluster may result in inconsistent results: For example, half of a V100 16GB GPU memory is different than A100 with 40GB). In such scenarios. Requesting specific GPU memory is a better strategy.
    * When selecting partial memory of a single GPU device, if NVIDIA MIG is enabled on a node, then the memory can be provided as a MIG profile. For more information see [Dynamic MIG](../../../scheduling/fractions.md#dynamic-mig).
    * If GPUs are not requested, they will not be allocated even if resources are available. In that case, the project's GPU quota will not be affected.

## Set CPU resources

A CPU resource consists of cores and memory. When GPU resources are requested the user interface will automatically present a proportional amount of CPU cores and memory (as set on the cluster side).

!!! Note
    If no GPU, CPU and memory resources are defined, the request will not be allocated any GPUs. The scheduler will create a container with no minimal CPU and memory. Such a job will run but is likely to be preempted at any time by other jobs. The scheme is relevant for testing and debugging purposes.  

## Create a new Compute Resource

To create a compute resource:

1. Select the `New Compute Resource` button.
2. In the *Scope* pane, choose one item from the tree. The compute resource is assigned to that item and all its subsidiaries.
3. Give the resource a meaningful name.
4. In the resources pane, set the resource request.
      1. To add GPU resources, enter the number of GPUs to request. You can then enter the amount of GPU memory by selecting a percentage of the GPU, memory size in MB or GB, or multi-instance GPUs.
      2. To add CPU resources, in the CPU compute pane enter the number of requested resources by choosing cores or millicores. In the CPU memory pane, enter the amount of memory to request, and choose from MB or GB. Select limit if you want limit the number of resources, and enter the limit.
5. Press *More* settings to add additional settings to the resource.
      1. Enable *Increased shared memory size* to increase the default memory size.
      2. Press *Extended resource* to add additional resources. Enter the resource subdomain and name and the quantity of resources to request. For more information, see [Extended resources](https://kubernetes.io/docs/tasks/configure-pod-container/extended-resource/){target=_blank} and [Quantity](https://kubernetes.io/docs/reference/kubernetes-api/common-definitions/quantity/){target=_blank}.
