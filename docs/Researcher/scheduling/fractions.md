# Allocation of GPU Portions

##  Introduction

GPUs have a significant amount of memory. Ranging from a couple of gigabytes in older generations and up to 80GB per GPU in the later models of the latest NVIDIA GPU technology.

This amount of memory is important for processing large amounts of data, such as in training deep learning models. However, there are quite a few applications that do not need this size of memory. Examples can be inference workloads and the model-creation phase. It would thus be convenient if we could __divide up a GPU__ between various workloads, thus achieving better GPU utilization. 

This article describes two complimentary technologies that allow the division of GPU and how to use them with Run:AI:

1. Run:AI Fractions. 
2. Dynamic allocation using NVIDIA Multi-instance GPU (MIG)


## Run:AI Fractions

Run:AI provides the capability to allocate a container with a specific amount of GPU RAM. As a researcher, if you know that your code needs 4GB of RAM. You can use the flag `--gpu-memory 4G` to specify the exact _portion_ of the GPU memory that you need. Run:AI will allocate your container that specific amount of GPU RAM. Attempting to reach beyond your allotted RAM will result in an out-of-memory exception. 

For more details on Run:AI fractions see the [fractions quickstart](../Walkthroughs/walkthrough-fractions.md).


!!! limitation
    The fraction technology divides up memory. It cannot currently divide compute resources. As such, three containers getting a non-equal share of GPU memory will still get an equal share of computing power. 


## Dynamic MIG

NVIDIA MIG allows GPUs based on the NVIDIA Ampere architecture (such as NVIDIA A100) to be partitioned into separate GPU Instances:

* When divided, the portion acts as a fully independent GPU.
* The division is static, in the sense that you have to call NVIDIA API or the `nvidia-smi` command to create or remove the MIG partition.  
* The division is both of compute and memory.
* The division has fixed sizes. Up to 8 units of compute and 7 units of memory in fixed sizes. The various _MIG profiles_ can be found in the [NVIDIA documentation](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/){target=_blank}. A typical profile can be __MIG 2g.10gb__ which provides 2/8 of the compute power and 10GB of RAM

Run:AI provides a way to __dynamically__ create a MIG partition. Using the same experience as the Fractions technology above, if you know that your code needs 4GB of RAM. You can use the flags `--gpu-memory 4G` and `--gpu-compute xx` to specify the _portion_ of the GPU memory that you need. Run:AI will call the NVIDIA MIG API, generate the smallest possible MIG profile for your request and allocate it to your container.

Run:AI provides an additional flag to dynamically create the specific MIG partition in NVIDIA terminology. As such, you can specify `--mig 2g.10gb`.  

Run:AI will automatically deallocate the partition when the workload finishes. This happens in a _lazy_ fashion in the sense that the partition will not be removed until the scheduler decides that it is needed elsewhere. 

For more details on Run:AI fractions see the [dynamic MIG quickstart] xx (../Walkthroughs/walkthrough-dynamic-mig.md).

### Setting up Dynamic MIG

As described above, MIG is only available in the latest NVIDIA architecture. For such nodes, the administrator needs to specifically enable dynamic MIG on the node by running: 

```
runai-adm set node-role --mig-enabled <node-name>
```

(use `runai-adm remove` to unset)


## Fractions and Dynamic MIG together.

Given a specific node, the IT administrator can decide whether to use one technology or the other. When the Researcher asks for a specific amount of GPU memory, Run:AI will either provide it on an annotated node by dynamically allocating a MIG partition, or use a different node using the fractions technology.



