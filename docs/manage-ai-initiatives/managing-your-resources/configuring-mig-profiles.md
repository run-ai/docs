# Configuring NVIDIA MIG Profiles

NVIDIA’s Multi-Instance GPU (MIG) enables splitting a GPU into multiple logical GPU devices, each with its own memory and compute portion of the physical GPU. 

NVIDIA provides two MIG strategies that the user can split the GPU into:

* __Single__ - A GPU can be divided evenly. This means all MIG profiles are the same. 
* __Mixed__ - A GPU can be divided into different profiles. 

The Run:ai platform supports running workloads using NVIDIA MIG. Administrators can set the Kubernetes nodes to their preferred MIG strategy and configure the appropriate MIG profiles for researchers and MLOPS engineers to use. 

This guide explains how to configure MIG in each strategy to submit workloads. It also outlines the individual implications of each strategy and best practices for administrators.

!!! Note
    * Starting from v2.19, Dynamic MIG feature began a deprecation process and is now no longer supported. With Dynamic MIG, the Run:ai platform automatically configured MIG profiles according to on-demand user requests for different MIG profiles or memory fractions.  
    * GPU fractions and memory fractions are not supported with MIG profiles.
    * Single strategy supports both Run:ai and third-party workloads. Using mixed strategy can only be done using third-party workloads. For more details on Run:ai and third-party workloads, see [Introduction to workloads](../../workloads/overviews/introduction-to-workloads.md).

## Before you start

To use MIG single and mixed strategy effectively, make sure to familiarize yourself with the following NVIDIA resources:

* [NVIDIA Multi-Instance GPU](https://www.nvidia.com/en-eu/technologies/multi-instance-gpu/)
* [MIG User Guide](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/index.html) 
* [GPU Operator with MIG](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/gpu-operator-mig.html) 

## Configuring single MIG strategy

When deploying MIG using single strategy, all GPUs within a node are configured with the same profile. For example, a node might have GPUs configured with 3 MIG slices of profile type 1g.20gb, or 7 MIG slices of profile 1g.10gb. With this strategy, MIG profiles are displayed as whole GPU devices by CUDA. 

The Run:ai platform discovers these MIG profiles as whole GPU devices as well, ensuring MIG devices are transparent to the end-user (practitioner). For example, a node that consists of 8 physical GPUs split into MIG slices, 3×2g20gb slices each, is discovered by the Run:ai platform as a node with 24 GPU devices.

Users can submit workloads by requesting a specific number of GPU devices (X GPU) and Run:ai will allocate X MIG slices (logical devices). The Run:ai platform deducts X GPUs from the workload’s Project quota, regardless of whether this ‘logical GPU’ represents 1/3 of a physical GPU device or 1/7 of a physical GPU device.

## Configuring mixed MIG strategy

When deploying MIG using mixed strategy, each GPU in a node can be configured with a different combination of MIG profiles such as 2×2g.20gb and 3×1g.10gb. For details on supported combinations per GPU type, refer to [Supported MIG Profiles](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/index.html#supported-mig-profiles).

In mixed strategy, physical GPU devices continue to be displayed as physical GPU devices by CUDA, and each MIG profile is shown individually. The Run:ai platform identifies the physical GPU devices normally, however, MIG profiles are not visible in the UI or node APIs. 

When submitting third-party workloads with this strategy, the user should explicitly specify the exact requested MIG profile (for example, nvidia.com/gpu.product: A100-SXM4-40GB-MIG-3g.20gb). The Run:ai Scheduler finds a node that can provide this specific profile and binds it to the workload. 

A third-party workload submitted with a MIG profile of type Xg.Ygb (e.g. 3g.40gb or 2g.20gb) is considered as consuming X GPUs. These X GPUs will be deducted from the workload’s project quota of GPUs. For example, a 3g.40gb profile deducts 3 GPUs from the associated Project’s quota, while 2g.20gb deducts 2 GPUs from the associated Project’s quota. This is done to maintain a logical ratio according to the characteristics of the MIG profile. 

## Best practices for administrators

### Single strategy

* Configure proper and uniform sizes of MIG slices (profiles) across all GPUs within a node.
* Set the same MIG profiles on all nodes of a single node pool. 
* Create separate node pools with different MIG profile configurations allowing users to select the pool that best matches their workloads’ needs. 
* Ensure Project quotas are allocated according to the MIG profile sizes.

### Mixed strategy
* Use mixed strategy with workloads that require diverse resources. Make sure to evaluate the workload requirements and plan accordingly.
* Configure individual MIG profiles on each node by using a limited set of MIG profile combinations to minimize complexity. Make sure to evaluate your requirements and node configurations. 
* Ensure Project quotas are allocated according to the MIG profile sizes.

!!! Note
    Since MIG slices are a fixed size, once configured, changing MIG profiles requires administrative intervention.

