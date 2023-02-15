## Introduction

Run:ai version 2.8 introduced a new building block to assist in managing resources effectively - node-pools.
A node-pool is a set of nodes grouped into a bucket of resources using a predefined (e.g. GPU-Type) or administrator-defined label (key & value). Typically, those nodes share a common feature or property, such as GPU type or other HW capability (such as Infiniband connectivity) or represent a proximity group (i.e. nodes interconnected via a local ultra-fast switch). Those nodes would typically be used by researchers to run specific workloads on specific resource types, or by MLops engineers to run specific Inference workloads that require specific node types. 

### Enabling Node-Pools
After upgrading from version 2.7 or older to version 2.8 or newer, the ‘Node Pools’ feature is disabled by default. Once the feature is enabled by the administrator, all nodes in each of your upgraded clusters are associated with the ‘Default’ node pool.
* To use node-pools - enable this feature under ‘Settings->General’, set ‘Enable Node Pools’ switch.
* To manage CPU resources - enable this feature under ‘Settings->General’, set ‘Enable CPU Resources Quota’.

### Creating and using Node-Pools
An administrator creates logical groups of nodes by specifying a unique label (key & value) and associating it with a node-pool. Run:ai allows an administrator to use any label key and value as the designated node-pool label (e.g. gpu-type = A100 or faculty = computer-science). Each node-pool has its unique name and label used identify and group nodes into a node-pool.
Once a new node-pool is created, it is automatically assigned to all Projects and Departments with a quota of zero GPU resources and CPU resources. This allows any Project and Department to use any node pool when over-quota is enabled, even if the administrator did not assign a quota for a specific node-pool in a Project or Department.

Using resources with over-quota means those resources might be reclaimed by other Projects or Departments that have assigned quota in place for those node-pools. On the other hand, this pattern allows to maximize the  utilization of GPU and CPU resources by the system.
An administrator should assign resources from a node-pool to a project for which the administrator wants to guarantee reserved resources on that node pool. The reservation should be done for GPU resources and CPU resources. Projects and Departments with no reserved resources for a specific node-pool can still use node-pools resources, but the resources are not reserved and can be reclaimed by the resources owner Project (or Department).

Creating a new node-pool and assigning resources from a node-pool to Projects and Departments is an operation limited to Administrators only. Researchers can use node-pools when submitting a new workload. By specifying the node pool from which a workload allocates resources, the scheduler shell launch that workload on a node that is part of the specified node pool. If no node-pool is selected by a workload, the ‘Default’ node-pool is used.

### Multi Node Pools Selection
Starting version 2.9, Run:ai system supports scheduling workloads to a node pool using a list of priortized node pools. The scheduler will try to schedule the workload to the most prioritzed node pool first, if it fails, it will try the second one and so forth. If the scheduler tried the all list and failed to schedule the workload, it will start from the most prioritzed node pool again. This patten allows to maximize the odds that a workload will be schdeuled. 
### Defininig Project level 'default node pool priority list'
If the Reseacher did not specify any node pool within the workload specification, the system will use the 'default node pool priority list' as defined by the administrator. If the administrator did not define the 'default node pool priority list', the system will use 'Default' node pool.

### Node-Pools Best Practices
Node-pools give administrators the ability to manage quotas in a more granular manner than the Project level, allowing them to specify which Projects are assigned guaranteed resources on specific sets of nodes to be then used by Workloads that need specific node characteristics. Any Project can use any Node-Pool, even if a quota was not assigned to the Node-Pool, it can still be used in Over-Quota manner.
As a rule of thumb, it is best for the administrator to split the organization's GPU deployment to the smallest number of node-pools that still serves its purpose, this would help in keeping each pool large enough and minimize the probability that the Run:ai scheduler would not be able to find available resources on a specific node-pool.
It is a good practice for researchers to use multi node pools where applicable, to maximize their workload odds to get scheduled in a timely manner or in cases where resources are scarce in specific node pool.
Administrators should set Projects' 'default node pool priority list' to make sure that incase a workload was scheduled with no node pool selection, it is scheduled to the preferences of the Administrator, and to increase the workload's odds to get scheduled and in a timely manner.

#### Common use-cases
- Training workloads that require specific GPU-type nodes, either because of the scale of parameters (computation time) or for other specific GPU capabilities
- Inference workloads that require specific GPU-type nodes to comply with constraints such as execution time
- Workloads that require proximity of nodes for purposes of local ultra-fast networking
- Organizations where specific nodes belong to specific a  department, and while assuring quota for that department and its subordinated projects, the administrator also wants to let other departments and projects use those nodes when not used by the resource owner
- Projects that need to use specific resources, but also ensure others will not occupy those resources

While the upper use cases refer to a single node pool, they are applicable to multi node pools as well. In cases where a workload's spcification could be statisfied by more than one type of node, using multiple node pools selection potentially increases the probability of a workload to find resources to allocate and shorten the time it will take to get those resources.

