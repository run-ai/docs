# GPU memory swap

Run:ai’s GPU memory swap helps administrators and AI practitioners to further increase the utilization of their existing GPU hardware by improving GPU sharing between AI initiatives and stakeholders. This is done by expanding the GPU physical memory to the CPU memory, typically an order of magnitude larger than that of the GPU.

Expanding the GPU physical memory helps the Run:ai system to put more workloads on the same GPU physical hardware, and to provide a smooth workload context switching between GPU memory and CPU memory, eliminating the need to kill workloads when the memory requirement is larger than what the GPU physical memory can provide.

## Benefits of GPU memory swap¶

There are several use cases where GPU memory swap can benefit and improve the user experience and the system's overall utilization.

### Sharing a GPU between multiple interactive workloads (notebooks)

AI practitioners use notebooks to develop and test new AI models and to improve existing AI models. While developing or testing an AI model, notebooks use GPU resources intermittently, yet, required resources of the GPUs are pre-allocated by the notebook and cannot be used by other workloads after one notebook has already reserved them. To overcome this inefficiency, Run:ai introduced [dynamic GPU fractions](dynamic-gpu-fractions.md) and [Node Level Scheduler](node-level-scheduler.md).

When one or more workloads require more than their requested GPU resources, there’s a high probability not all workloads can run on a single GPU because the total memory required is larger than the physical size of the GPU memory.

With GPU memory swap, several workloads can run on the same GPU, even if the sum of their used memory is larger than the size of the physical GPU memory. GPU memory swap can swap in and out workloads interchangeably, allowing multiple workloads to each use the full amount of GPU memory. The most common scenario is for one workload to run on the GPU (for example, an interactive notebook),while other notebooks are either idle or using the CPU to develop new code (while not using the GPU). From a user experience point of view, the swap in and out is a smooth process since the notebooks do not notice that they are being swapped in and out of the GPU memory. On rare occasions, when multiple notebooks need to access the GPU simultaneously, slower workload execution may be experienced.

Notebooks typically use the GPU intermittently, therefore with high probability, only one workload (for example, an [interactive notebook](../../workloads-in-runai/workload-types.md)), will use the GPU at a time. The more notebooks the system puts on a single GPU, the higher the chances are that there will be more than one notebook requiring the GPU resources at the same time. Admins have a significant role here in fine tuning the number of notebooks running on the same GPU, based on specific use patterns and required SLAs. Using Node Level Scheduler reduces GPU access contention between different interactive notebooks running on the same node.

### Sharing a GPU between inference/interactive workloads and training workloads¶

A single GPU can be shared between an [interactive or inference workload](../../workloads-in-runai/workload-types.md) (for example, a Jupyter notebook, image recognition services, or an LLM service), and a training workload that is not time-sensitive or delay-sensitive. At times when the inference/interactive workload uses the GPU, both training and inference/interactive workloads share the GPU resources, each running part of the time swapped-in to the GPU memory, and swapped-out into the CPU memory the rest of the time.

Whenever the inference/interactive workload stops using the GPU, the swap mechanism swaps out the inference/interactive workload GPU data to the CPU memory. Kubernetes wise, the pod is still alive and running using the CPU. This allows the training workload to run faster when the inference/interactive workload is not using the GPU, and slower when it does, thus sharing the same resource between multiple workloads, fully utilizing the GPU at all times, and maintaining uninterrupted service for both workloads.

### Serving inference warm models with GPU memory swap¶

Running multiple[ inference models](../../workloads-in-runai/workload-types.md) is a demanding task and you will need to ensure that your SLA is met. You need to provide high performance and low latency, while maximizing GPU utilization. This becomes even more challenging when the exact model usage patterns are unpredictable. You must plan for the agility of inference services and strive to keep models on standby in a ready state rather than an idle state.

Run:ai’s GPU memory swap feature enables you to load multiple models to a single GPU, where each can use up to the full amount GPU memory. Using an application load balancer, the administrator can control to which server each inference request is sent. Then the GPU can be loaded with multiple models, where the model in use is loaded into the GPU memory and the rest of the models are swapped-out to the CPU memory. The swapped models are stored as ready models to be loaded when required. GPU memory swap always maintains the context of the workload (model) on the GPU so it can easily and quickly switch between models. This is unlike industry standard model servers that load models from scratch into the GPU whenever required.

## How GPU memory swap works

Swapping the workload’s GPU memory to and from the CPU is performed simultaneously and synchronously for all GPUs used by the workload. In some cases, if workloads specify a memory limit smaller than a full GPU memory size, multiple workloads can run in parallel on the same GPUs, maximizing the utilization and shortening the response times.

In other cases, workloads will run serially, with each workload running for a few seconds before the system swaps them in/out. If multiple workloads occupy more than the GPU physical memory and attempt to run simultaneously, memory swapping will occur. In this scenario, each workload will run part of the time on the GPU while being swapped out to the CPU memory the other part of the time, slowing down the execution of the workloads. Therefore, it is important to evaluate whether memory swapping is suitable for your specific use cases, weighing the benefits against the potential for slower execution time. To better understand the benefits and use cases of GPU memory swap, refer to the detailed sections below. This will help you determine how to best utilize GPU swap for your workloads and achieve optimal performance.

The workload MUST use [dynamic GPU fractions](dynamic-gpu-fractions.md). This means the workload’s memory Request is less than a full GPU, but it may add a GPU memory Limit to allow the workload to effectively use the full GPU memory. The Run:ai Scheduler allocates the dynamic fraction pair (Request and Limit) on single or multiple GPU devices in the same node.

The administrator must label each node that they want to provide GPU memory swap with a run.ai/swap-enabled=true to enable that node. Enabling the feature reserves CPU memory to serve the swapped GPU memory from all GPUs on that node. The administrator sets the size of the CPU reserved RAM memory using the `runaiconfig` file as detailed in [enabling and configuring GPU memory swap](gpu-memory-swap.md#enabling-and-configuring-gpu-memory-swap).

Optionally, you can also configure the [Node Level Scheduler](node-level-scheduler.md):

* The Node Level Scheduler automatically spreads workloads between the different GPUs on a node, ensuring maximum workload performance and GPU utilization.
* In scenarios where Interactive notebooks are involved, if the CPU reserved memory for the GPU swap is full, the Node Level Scheduler preempts the GPU process of that workload and potentially routes the workload to another GPU to run.

## Multi-GPU memory swap

Run:ai also supports workload submission using multi-GPU memory swap. Multi-GPU memory swap works similarly to single GPU memory swap, but instead of swapping memory for a single GPU workload, it swaps memory for workloads across multiple GPUs simultaneously and synchronously.

The Run:ai Scheduler allocates the same dynamic GPU fraction pair (Request and Limit) on multiple GPU devices in the same node. For example, if you want to run two LLM models, each consuming 8 GPUs that are not used simultaneously, you can use GPU memory swap to share their GPUs. This approach allows multiple models to be stacked on the same node.

The following outlines the advantages of stacking multiple models on the same node:

* **Maximizes GPU utilization** - Efficiently uses available GPU resources by enabling multiple workloads to share GPUs.
* **Improves cold start times** - Loading large LLM models to a node and it’s GPUs can take several minutes during a “cold start”. Using memory swap turns this process into a “warm start” that takes only a faction of a second to a few seconds (depending on the model size and the GPU model).
* **Increases GPU availability** - Frees up and maximizes GPU availability for additional workloads (and users), enabling better resource sharing.
* **Smaller quota requirements** - Enables more precise and often smaller quota requirements for the end user.

## Deployment considerations

* A pod created before the GPU memory swap feature was enabled in that cluster, cannot be scheduled to a swap-enabled node. A proper event is generated in case no matching node is found. Users must re-submit those pods to make them swap-enabled.
* GPU memory swap cannot be enabled if the Run:ai [strict or fair time-slicing](gpu-time-slicing.md#gpu-time-slicing-modes) is used. GPU memory swap can only be used with the default NVIDIA time-slicing mechanism.
* CPU RAM size cannot be decreased once GPU memory swap is enabled.

## Enabling and configuring GPU memory swap¶

Before configuring GPU memory swap, dynamic GPU fractions must be enabled. You can also configure and use Node Level Scheduler. Dynamic GPU fractions enable you to make your workloads burstable, while both features will maximize your workloads’ performance and GPU utilization within a single node.

To enable GPU memory swap in a Run:ai cluster:

1. Edit the `runaiconfig` file with the following parameters. This example uses 100Gi as the size of the swap memory. For more details, see [Advanced cluster configurations](../../advanced-setup/advanced-cluster-configurations.md):

```yaml
 spec: 
  global: 
    core: 
      swap:
        enabled: true
        limits:
          cpuRam: 100Gi
```

2. Or, use the following patch command from your terminal:

```bash
 kubectl patch -n runai runaiconfigs.run.ai/runai --type='merge' --patch '{"spec":{"global":{"core":{"swap":{"enabled": true, "limits": {"cpuRam": "100Gi"}}}}}}'
```

### Configuring system reserved GPU Resources¶

Swappable workloads require reserving a small part of the GPU for non-swappable allocations like binaries and GPU context. To avoid getting out-of-memory (OOM) errors due to non-swappable memory regions, the system reserves a 2GiB of GPU RAM memory by default, effectively truncating the total size of the GPU memory. For example, a 16GiB T4 will appear as 14GiB on a swap-enabled node. The exact reserved size is application-dependent, and 2GiB is a safe assumption for 2-3 applications sharing and swapping on a GPU. This value can be changed by:

1. Editing the `runaiconfig` as follows:

```yaml
 spec: 
  global: 
    core: 
      swap:
        limits:
          reservedGpuRam: 2Gi
```

2. Or, using the following patch command from your terminal:

```bash
 kubectl patch -n runai runaiconfigs.run.ai/runai --type='merge' --patch '{"spec":{"global":{"core":{"swap":{"limits":{"reservedGpuRam": <quantity>}}}}}}'
```

### Preventing your workloads from getting swapped¶

If you prefer your workloads not to be swapped into CPU memory, you can specify on the pod an anti-affinity to `run.ai/swap enabled=true` node label when submitting your workloads and the Scheduler will ensure not to use swap-enabled nodes. An alternative way is to set swap on a dedicated node pool and not use this node pool for workloads you prefer not to swap.

### What happens when the CPU reserved memory for GPU swap is exhausted?¶

CPU memory is limited, and since a single CPU serves multiple GPUs on a node, this number is usually between 2 to 8. For example, when using 80GB of GPU memory, each swapped workload consumes up to 80GB (but may use less) assuming each GPU is shared between 2-4 workloads. In this example, you can see how the swap memory can become very large. Therefore, we give administrators a way to limit the size of the CPU reserved memory for swapped GPU memory on each swap enabled node as shown in [enabling and configuring GPU memory swap](gpu-memory-swap.md#enabling-and-configuring-gpu-memory-swap).

Limiting the CPU reserved memory means that there may be scenarios where the GPU memory cannot be swapped out to the CPU reserved RAM. Whenever the CPU reserved memory for swapped GPU memory is exhausted, the workloads currently running will not be swapped out to the CPU reserved RAM, instead, [Node Level Scheduler](node-level-scheduler.md) (if enabled) logic takes over and provides GPU resource optimization.
