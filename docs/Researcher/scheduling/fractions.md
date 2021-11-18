# Allocation of GPU Fractions

##  Introduction

A single GPU has a significant amount of memory. Ranging from a couple of gigabytes in older generations and up to 80GB per GPU in the later models of the latest NVIDIA GPU technology. A single GPU also has a vast amount of computing power. 

This amount of memory and computing power is important for processing large amounts of data, such as in training deep learning models. However, there are quite a few applications that do not need this power. Examples can be inference workloads and the model-creation phase. It would thus be convenient if we could __divide up a GPU__ between various workloads, thus achieving better GPU utilization. 

This article describes two complementary technologies that allow the division of GPU and how to use them with Run:AI:

1. Run:AI Fractions. 
2. Dynamic allocation using NVIDIA Multi-instance GPU (MIG)


## Run:AI Fractions

Run:AI provides the capability to allocate a container with a specific amount of GPU RAM. As a researcher, if you know that your code needs 4GB of RAM. You can submit a job using the flag `--gpu-memory 4G` to specify the exact _portion_ of the GPU memory that you need. Run:AI will allocate your container that specific amount of GPU RAM. Attempting to reach beyond your allotted RAM will result in an out-of-memory exception. 

You can also use the flag `--gpu 0.2` to get 20% of the GPU memory on the GPU assigned for you. 

For more details on Run:AI fractions see the [fractions quickstart](../Walkthroughs/walkthrough-fractions.md).


!!! limitation
    With the fraction technology all running workloads share the compute in parallel and on average get an even share of the compute. For example, assuming two containers, one with 0.25 GPU workload and the other with 0.75 GPU workload - both will get (on average) an __equal__ part of the computation power. If one of the workloads does not utilize the GPU, the other workload will get the entire GPU compute power.

## Dynamic MIG

NVIDIA MIG allows GPUs based on the NVIDIA Ampere architecture (such as NVIDIA A100) to be partitioned into separate GPU Instances:

* When divided, the portion acts as a fully independent GPU.
* The division is static, in the sense that you have to call NVIDIA API or the `nvidia-smi` command to create or remove the MIG partition. 
* The division is both of compute and memory.
* The division has fixed sizes.  Up to 7 units of compute and memory in fixed sizes. The various _MIG profiles_ can be found in the [NVIDIA documentation](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/){target=_blank}. A typical profile can be `MIG 2g.10gb` which provides 2/8 of the compute power and 10GB of RAM
* Reconfiguration of MIG profiles on the GPU requires administrator permissions and the draining of all running workloads. 


Run:AI provides a way to __dynamically__ create a MIG partition:

* Using the same experience as the Fractions technology above, if you know that your code needs 4GB of RAM. You can use the flag `--gpu-memory 4G` to specify the _portion_ of the GPU memory that you need. Run:AI will call the NVIDIA MIG API to generate the smallest possible MIG profile for your request, and allocate it to your container. 
* MIG is configured on the fly according to workload demand, without needing to drain workloads or to involve an IT administrator.
* Run:AI will automatically deallocate the partition when the workload finishes. This happens in a _lazy_ fashion in the sense that the partition will not be removed until the scheduler decides that it is needed elsewhere. 
* Run:AI provides an additional flag to dynamically create the __specific__ MIG partition in NVIDIA terminology. As such, you can specify `--mig-profile 2g.10gb`.  
* In a single GPU cluster you have have some MIG nodes that are dynamically allocated and some that are not.

For more details on Run:AI fractions see the [dynamic MIG quickstart] xx (../Walkthroughs/walkthrough-dynamic-mig.md).


### Setting up Dynamic MIG

As described above, MIG is only available in the latest NVIDIA architecture. For such nodes, the administrator needs to specifically enable dynamic MIG on the node by running: 

```
runai-adm set node-role --dynamic-mig-enabled <node-name>
```

(use `runai-adm remove` to unset)

!!! Limitations
    * Once a node has been marked as dynamic MIG enabled, it can only be used via the Run:AI scheduler.
    * When it comes to Kubernete, NVIDIA defines a concept called [MIG Strategy](https://docs.nvidia.com/datacenter/cloud-native/kubernetes/mig-k8s.html#mig-strategies){target=_blank}. With Run:AI you must set the MIG strategy to `mixed`.
    * Run:AI currently supports only A100 nodes with 40GB RAM (if you need support for A30 or A100 with 80GB RAM, please contact Run:AI customer support).

## Mixing Fractions and Dynamic MIG

Given a specific node, the IT administrator can decide whether to use one technology or the other. When the Researcher asks for a specific amount of GPU memory, Run:AI will either provide it on an annotated node by dynamically allocating a MIG partition, or use a different node using the fractions technology.



