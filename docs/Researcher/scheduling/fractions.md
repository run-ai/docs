# Allocation of GPU Fractions

##  Introduction

A single GPU has a significant amount of memory. Ranging from a couple of gigabytes in older generations and up to 80GB per GPU in the later models of the latest NVIDIA GPU technology. A single GPU also has a vast amount of computing power. 

This amount of memory and computing power is important for processing large amounts of data, such as in training deep learning models. However, there are quite a few applications that do not need this power. Examples can be inference workloads and the model-creation phase. It would thus be convenient if we could __divide up a GPU__ between various workloads, thus achieving better GPU utilization. 

This article describes two complementary technologies that allow the division of GPUs and how to use them with Run:ai.

1. Run:ai Fractions. 
2. Dynamic allocation using NVIDIA Multi-instance GPU (MIG)


## Run:ai Fractions

Run:ai provides the capability to allocate a container with a specific amount of GPU RAM. As a researcher, if you know that your code needs 4GB of RAM. You can submit a job using the flag `--gpu-memory 4G` to specify the exact _portion_ of the GPU memory that you need. Run:ai will allocate your container that specific amount of GPU RAM. Attempting to reach beyond your allotted RAM will result in an out-of-memory exception. 

You can also use the flag `--gpu 0.2` to get 20% of the GPU memory on the GPU assigned for you. 

For more details on Run:ai fractions see the [fractions quickstart](../Walkthroughs/walkthrough-fractions.md).


!!! limitation
    With the fraction technology all running workloads, which utilize the GPU, share the compute in parallel and on average get an even share of the compute. For example, assuming two containers, one with 0.25 GPU workload and the other with 0.75 GPU workload - both will get (on average) an __equal__ part of the computation power. If one of the workloads does not utilize the GPU, the other workload will get the entire GPU's compute power.

!!! Info
    For interoperability with other Kubernetes schedulers, Run:ai creates special _reservation_ pods. Once a workload has been allocated a fraction of a GPU, Run:ai will create a pod in a dedicated `runai-reservation` namespace with the full GPU as a resource. This would cause other schedulers to understand that the GPU is reserved.    

## Dynamic MIG

NVIDIA MIG allows GPUs based on the NVIDIA Ampere architecture (such as NVIDIA A100) to be partitioned into separate GPU Instances:

* When divided, the portion acts as a fully independent GPU.
* The division is static, in the sense that you have to call NVIDIA API or the `nvidia-smi` command to create or remove the MIG partition. 
* The division is both of compute and memory.
* The division has fixed sizes.  Up to 7 units of compute and memory in fixed sizes. The various _MIG profiles_ can be found in the [NVIDIA documentation](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/index.html){target=_blank}. A typical profile can be `MIG 2g.10gb` which provides 2/7 of the compute power and 10GB of RAM
* Reconfiguration of MIG profiles on the GPU requires administrator permissions and the draining of all running workloads. 


Run:ai provides a way to __dynamically__ create a MIG partition:

* Using the same experience as the Fractions technology above, if you know that your code needs 4GB of RAM. You can use the flag `--gpu-memory 4G` to specify the _portion_ of the GPU memory that you need. Run:ai will call the NVIDIA MIG API to generate the smallest possible MIG profile for your request, and allocate it to your container. 
* MIG is configured on the fly according to workload demand, without needing to drain workloads or to involve an IT administrator.
* Run:ai will automatically deallocate the partition when the workload finishes. This happens in a _lazy_ fashion in the sense that the partition will not be removed until the scheduler decides that it is needed elsewhere. 
* Run:ai provides an additional flag to dynamically create the __specific__ MIG partition in NVIDIA terminology. As such, you can specify `--mig-profile 2g.10gb`.  
* In a single GPU cluster you have some MIG nodes that are dynamically allocated and some that are not.

For more details on Run:ai fractions see the [dynamic MIG quickstart](../Walkthroughs/quickstart-mig.md).


### Setting up Dynamic MIG

As described above, MIG is only available in the latest NVIDIA architecture. 

* When working with Kubernetes, NVIDIA defines a concept called [MIG Strategy](https://docs.nvidia.com/datacenter/cloud-native/kubernetes/mig-k8s.html#mig-strategies){target=_blank}. With Run:ai you must set the MIG strategy to `mixed`. See [NVIDIA prerequisites](../../admin/runai-setup/cluster-setup/cluster-prerequisites.md#nvidia) on how to set this flag. 
* The administrator needs to specifically enable dynamic MIG on the node by running: 
    
    ```
    runai-adm set node-role --dynamic-mig-enabled <node-name>
    ```
    (use `runai-adm remove` to unset)


* Make sure that MIG is enabled on the node level by running `nvidia-smi` on the node and verifying that MIG Mode is enabled (see highlight below):

``` hl_lines="10"
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 460.91.03    Driver Version: 460.91.03    CUDA Version: 11.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  A100-SXM4-40GB      Off  | 00000000:00:04.0 Off |                   On |
| N/A   32C    P0    42W / 400W |      0MiB / 40536MiB |     N/A      Default |
|                               |                      |              Enabled |
+-------------------------------+----------------------+----------------------+
```

* To enable MIG Mode see [NVIDIA documentation](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/index.html#enable-mig-mode){target=_blank}.

* Set:
    ```
    kubectl label node <node-name> node-role.kubernetes.io/runai-mig-enabled=true
    ```
   (use `kubectl` to unset)

!!! Limitations
    * Once a node has been marked as dynamic MIG enabled, it can only be used via the Run:ai scheduler.
    * Run:ai currently supports H100 or A100 nodes with 40GB/80GB RAM.
    * GPU utilization, shown on the Run:ai dashboards, may not be accurate while MIG jobs are running.

## Mixing Fractions and Dynamic MIG

Given a specific node, the IT administrator can decide whether to use one technology or the other. When the Researcher asks for a specific amount of GPU memory, Run:ai will either provide it on an annotated node by dynamically allocating a MIG partition, or use a different node using the fractions technology.



## See Also

* Fractions [quickstart](../Walkthroughs/walkthrough-fractions.md).
* Dynamic MIG [quickstart](../Walkthroughs/quickstart-mig.md)

