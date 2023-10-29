# Introduction

:octicons-versions-24: Version 2.8 and up.

Node pools assist in managing heterogeneous resources effectively.
A node pool is a set of nodes grouped into a bucket of resources using a predefined (e.g. GPU-Type) or administrator-defined label (key & value). Typically, those nodes share a common feature or property, such as GPU type or other HW capability (such as Infiniband connectivity) or represent a proximity group (i.e. nodes interconnected via a local ultra-fast switch). Those nodes would typically be used by researchers to run specific workloads on specific resource types, or by MLops engineers to run specific Inference workloads that require specific node types.

## Enabling Node-Pools

The *Node Pools* feature is enabled by default:

* To manage CPU resources - enable this feature under  `Settings` | `General`. Turn on `Enable CPU Resources Quota`.

Once the feature is enabled by the administrator, all nodes in each of your upgraded clusters are associated with the `Default` node pool.

## Creating and Using Node-Pools

An administrator creates logical groups of nodes by specifying a unique label (key & value) and associating it with a node pool. Run:ai allows an administrator to use any label key and value as the designated node-pool label (e.g. `gpu-type = A100` or `faculty = computer-science`). Each node pool has a unique name and label used to identify and group nodes into a node pool.
Once a new node pool is created, it is automatically assigned to all Projects and Departments with a quota of zero GPU resources and CPU resources. This allows any Project and Department to use any node pool when over-quota is enabled, even if the administrator has not assigned a quota for a specific node pool in a Project or Department.

Using resources with over-quota means these resources might be reclaimed by other Projects or Departments that have an assigned quota in place for those node pools. On the other hand, this pattern allows for maximizing the utilization of GPU and CPU resources by the system.
An administrator should assign resources from a node pool to a project for which the administrator wants to guarantee reserved resources on that node pool. The reservation should be done for GPU resources and CPU resources. Projects and Departments with no reserved resources for a specific node pool can still use node pool resources, but the resources are not reserved and can be reclaimed by the resources owner Project (or Department).

Creating a new node pool and assigning resources from a node pool to Projects and Departments is an operation limited to Administrators only. Researchers can use node pools when submitting a new workload. By specifying the node pool from which a workload allocates resources, the scheduler shell launch that workload on a node that is part of the specified node pool. If no node-pool is selected by a workload, the ‘Default’ node-pool is used.

### Creating New Node Pools

To create a node pool:

1. From the left menu select *Nodes* then *Node Pools*.
2. Press *New Nodepool*
3. Enter a name, label, and value for the node pool.
4. Select a *GPU* or *CPU* placement strategy. Press *Save* when complete.

To assign nodes to a node pool:

1. Get the list of nodes and their current labels using the following command:

    ```
    kubectl get nodes --show-labels
    ```

2. Annotate a specific node with a new label using the following command:

    ```
    kubectl label node <node-name> <key>=<value>
    ```

!!! Note
    * You can annotate multiple nodes with the same label.

### Node and Node Pool Status

The `Status` column in the *Node* and *Node pools* table enable you to quickly view and diagnose potential issues that you may run into. The following table describes the possible issues you may have with a node or node-pools.

| Status | Description |
|:-- |:--|
| Not ready (Disk pressure) | Disk capacity is low. |
| Not ready (Memory pressure) | Node memory is low. |
| Not ready (PID pressure) | Too many processes on the node. |
| Not ready (Network unavailable) | Network is not configured correctly for the node. |
| Not ready (Scheduling disabled) | Node might be cordoned and marked as unavailable to the scheduler. Remove the cordon to make it available. |
| Not ready (Undrained migrated node) | Evict all pod to make the node ready. |
| Not ready (Missing Nvidia Container Toolkit ) | The *NVIDIA Container Toolkit* enables users to build and run GPU-accelerated containers. |
| Not ready ( Missing Nvidia DCGM Exporter) | DCGM-Exporter allows users to gather GPU metrics and understand workload behavior or monitor GPUs in clusters. |

### Download Node and Node-pools Table

You can download the Node and Node-Pools tables to a CSV file. Downloading a CSV can provide a snapshot history of your node and node-pools over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

To download the Nodes table to a CSV:

1. From the left menu, press *Nodes*.
2. From the *Columns* icon, select the columns you would like to have displayed in the table.
3. Click on the ellipsis labeled *More*, and download the CSV.

To download the Node-Pools table to a CSV:

1. In the *Nodes*, table select *Node Pools*.
2. From the *Columns* icon, select the columns you would like to have displayed in the table.
3. Click on the ellipsis labeled *More*, and download the CSV.

## Multiple Node Pools Selection

:octicons-versions-24: Version 2.9 and up

Starting version 2.9, Run:ai system supports scheduling workloads to a node pool using a **list of prioritized node pools**. The scheduler will try to schedule the workload to the most prioritized node pool first, if it fails, it will try the second one and so forth. If the scheduler tried the entire list and failed to schedule the workload, it will start from the most prioritized node pool again. This pattern allows for maximizing the odds that a workload will be scheduled.

### Defining Project level 'default node pool priority list'

If the Researcher did not specify any node pool within the workload specification, the system will use the _default node pool priority list_ as defined by the administrator. If the administrator did not define the *default node pool priority list_, the system will use the `Default` node pool.

## Node-Pools Best Practices

Node pools give administrators the ability to manage quotas in a more granular manner than the Project level, allowing them to specify which Projects are assigned guaranteed resources on specific sets of nodes to be then used by Workloads that need specific node characteristics. Any Project can use any node pool, even if a quota was not assigned to the Node-Pool, it can still be used in an Over-Quota manner.

As a rule of thumb, it is best for the administrator to split the organization's GPU deployment to the smallest number of node pools that still serves its purpose, this would help in keeping each pool large enough and minimize the probability that the Run:ai scheduler would not be able to find available resources on a specific node-pool.

It is a good practice for researchers to use multiple node pools where applicable, to maximize their workload odds to get scheduled promptly or in cases where resources are scarce in a specific node pool.

Administrators should set Projects' default node pool priority list' to make sure that in case a workload was scheduled with no node pool selection, it is scheduled to the preferences of the Administrator, and to increase the workload's odds to get scheduled and promptly.

### Common Use Cases

* Training workloads that require specific GPU-type nodes, either because of the scale of parameters (computation time) or for other specific GPU capabilities
* Inference workloads that require specific GPU-type nodes to comply with constraints such as execution time
* Workloads that require proximity of nodes for purposes of local ultra-fast networking
* Organizations where specific nodes belong to specific a  department, and while assuring quota for that department and its subordinated projects, the administrator also wants to let other departments and projects use those nodes when not used by the resource owner
* Projects that need to use specific resources, but also ensure others will not occupy those resources

While the upper use cases refer to a single node pool, they are also applicable to multiple node pools. In cases where a workload's specification could be satisfied by more than one type of node, using multiple node pool selection potentially increases the probability of a workload finding resources to allocate and shortening the time it will take to get those resources.
