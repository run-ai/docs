This article explains the procedure for managing Node pools.

Node pools assist in managing heterogeneous resources effectively. A node pool is a Run:ai construct representing a set of nodes grouped into a bucket of resources using a predefined node label (e.g. NVidia GPU type) or an administrator-defined node label (any key/value pair).

Typically, the grouped nodes share a common feature or property, such as GPU type or other HW capability (such as Infiniband connectivity), or represent a proximity group (i.e. nodes interconnected via a local ultra-fast switch). Researchers and ML Engineers would typically use node pools to run specific workloads on specific resource types.

Platform administrators can create, view, edit, and delete node pools. Creating a new node pool creates a new instance of the Run:ai scheduler, workloads submitted to a node pool will be scheduled using the node pool’s designated scheduler instance.

Once a new node pool is created, it is automatically assigned to all Projects and Departments with a quota of zero GPU resources, unlimited CPU resources, and over-quota enabled (Medium priority if over-quota priority is enabled). This allows any Project and Department to use any node pool when over-quota is enabled, even if the administrator has not assigned a quota for a specific node pool in a Project or Department.

Workloads can be submitted using a prioritized list of node pools, the node pool selector picks one node pool at a time (according to the prioritized list) and the designated node pool scheduler instance handles the submission request and tries to match the requested resources within that node pool. If the scheduler cannot find resources to satisfy the submitted workload, the node pool selector will move the request to the next node pool in the prioritized list, if no node pool satisfies the request, the node pool selector will start from the first node pool again until one of the node pools satisfies the request.

## Node pools table

The Node pools table can be found under **Nodes** in the Run:ai platform.

The Node pools table lists all the node pools defined in the Run:ai platform and allows you to manage them.

!!! Note
      By default, the Run:ai platform includes a single node pool named ‘default’. When no other node pool is defined, all existing and new nodes are associated with the ‘default’ node pool. When deleting a node pool, if no other node pool matches any of the nodes’ labels, the node will be included in the default node pool.

![](img/node-pools-view.png)

The Node pools table consists of the following columns:

| Column | Description |
| :---- | :---- |
| Node pool | The node pool name, set by the administrator during its creation (the node pool name cannot be changed after its creation). |
| Status | Node pool status. A ‘Ready’ status means the scheduler can use this node pool to schedule workloads. ‘Empty’ status means no nodes are currently included in that node pool. |
| Label key <br> Label value | The node pool controller will use this node-label key-value pair to match nodes into this node pool. |
| Node(s) | List of nodes included in this node pool. Click the field to view details (the details are in the [Nodes](./nodes.md) article). |
| GPU devices | The total number of GPU devices installed into nodes included in this node pool. For example, a node pool that includes 12 nodes each with 8 GPU devices would show a total number of 96 GPU devices. |
| GPU memory | The total amount of GPU memory included in this node pool. The total amount of GPU memory installed in nodes included in this node pool. For example, a node pool that includes 12 nodes, each with 8 GPU devices, and each device with 80 GB of memory would show a total memory amount of 7.68 TB. |
| Projects’ GPU quota | The sum of all Projects’ assigned GPU quota in this node pool. |
| Allocated GPUs | The total allocation of GPU devices in units of GPUs (decimal number). For example, if 3 GPUs are 50% allocated, the field prints out the value 1.50. This value represents the portion of GPU memory consumed by all running pods using this node pool. ‘Allocated GPUs’ can be larger than ‘Projects’ GPU quota’ if over-quota is used by workloads, but not larger than GPU devices. |
| Used GPU memory | The actual amount of memory (in GB or MB) used by pods running on nodes that are included in this node pool. |
| GPU compute utilization | The average compute utilization of all GPU devices included in this node pool (decimal percentage) |
| GPU memory utilization | The average memory utilization of all GPU devices included this node pool (decimal percentage) |
| CPUs (Cores) | The number of CPU cores installed on nodes included in this node |
| CPU memory | The total amount of CPU memory installed on nodes using this node pool |
| Projects’ CPU quota (Cores) | The sum of all Projects’ assigned CPU quota in this node pool. |
| Projects’ CPU memory quota | The sum of all Projects’ assigned CPU memory quota in this node pool. |
| Allocated CPUs (Cores) | The total allocation of CPU compute in units of Cores (decimal number). This value represents the amount of CPU cores consumed by all running pods using this node pool. ‘Allocated CPUs’ can be larger than ‘Projects’ GPU quota’ if over-quota is used by workloads, but not larger than CPUs (Cores). |
| Allocated CPU memory | The total allocation of CPU memory in units of TB/GB/MB (decimal number). This value represents the amount of CPU memory consumed by all running pods using this node pool. ‘Allocated CPUs’ can be larger than ‘Projects’ CPU memory quota’ if over-quota is used by workloads, but not larger than CPU memory. |
| Used CPU memory | The total amount of actually used CPU memory by pods running on nodes included in this node pool. Pods may allocate memory but not use all of it, or go beyond their CPU memory allocation if using Limit > Request for CPU memory (burstable workloads). |
| CPU compute utilization | The average utilization of all CPU compute resources on nodes included in this node pool (percentage) |
| CPU memory utilization | The average utilization of all CPU memory resources on nodes included in this node pool (percentage) |
| GPU placement strategy | Sets the Scheduler strategy for the assignment of pods requesting **both GPU and CPU resources** to nodes, which can be either Bin-pack or Spread. By default, Bin-Pack is used, but can be changed to Spread by editing the node pool. When set to Bin-pack the scheduler will try to fill nodes as much as possible before using empty or sparse nodes, when set to spread the scheduler will try to keep nodes as sparse as possible by spreading workloads across as many nodes as it succeeds. |
| CPU placement strategy | Sets the Scheduler strategy for the assignment of pods requesting **only CPU** **resources** to nodes, which can be either Bin-pack or Spread. By default, Bin-Pack is used, but can be changed to Spread by editing the node pool. When set to Bin-pack the scheduler will try to fill nodes as much as possible before using empty or sparse nodes, when set to spread the scheduler will try to keep nodes as sparse as possible by spreading workloads across as many nodes as it succeeds. |
| Last update | The date and time when the node pool was last updated |
| Creation time | The date and time when the node pool was created |
| Workload(s) | List of workloads running on nodes included in this node pool, click the field to view details (described below in this article) |

### Workloads associated with the node pool

Click one of the values in the Workload(s) column, to view the list of workloads and their parameters.

!!! Note
      This column is only viewable if your role in the Run:ai platform gives you read access to workloads, even if you are allowed to view workloads, you can only view the workloads within your allowed scope. This means, there might be more pods running on this node than appear in the list your are viewing.

| Column | Description |
| :---- | :---- |
| Workload | The name of the workload. If the workloads’ type is one of the recognized types (for example: Pytorch, MPI, Jupyter, Ray, Spark, Kubeflow, and many more), an appropriate icon is printed. |
| Type | The Run:ai platform type of the workload - Workspace, Training, or Inference |
| Status | The state of the workload. The Workloads state is described in the ‘Run:ai Workloads’ article. |
| Created by | The User or Application created this workload |
| Running/requested pods | The number of running pods out of the number of requested pods within this workload. |
| Creation time | The workload’s creation date and time |
| Allocated GPU compute | The total amount of GPU compute allocated by this workload. A workload with 3 Pods, each allocating 0.5 GPU, will show a value of 1.5 GPUs for the workload. |
| Allocated GPU memory | The total amount of GPU memory allocated by this workload. A workload with 3 Pods, each allocating 20GB, will show a value of 60 GB for the workload. |
| Allocated CPU compute (cores) | The total amount of CPU compute allocated by this workload. A workload with 3 Pods, each allocating 0.5 Core, will show a value of 1.5 Cores for the workload. |
| Allocated CPU memory | The total amount of CPU memory allocated by this workload. A workload with 3 Pods, each allocating 5 GB of CPU memory, will show a value of 15 GB of CPU memory for the workload. |

### Customizing the table view

* Filter - Click ADD FILTER, select the column to filter by, and enter the filter values  
* Search - Click SEARCH and type the value to search by  
* Sort - Click each column header to sort by  
* Column selection - Click COLUMNS and select the columns to display in the table  
* Download table - Click MORE and then Click Download as CSV  
* Show/Hide details - Click to view additional information on the selected row

## Adding a new node pool

To create a new node pool:

1. Click **+NEW NODE POOL**  
2. Enter a **name** for the node pool.  
    Node pools names must start with a letter and can only contain lowercase Latin letters, numbers or a hyphen ('-’)  
3. Enter the **node pool label**:  
   The node pool controller will use this node-label key-value pair to match nodes into this node pool.  
      * **Key** is the unique identifier of a node label.  
         * The key must fit the following regular expression:  `^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?/?([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9]$`  
         * The administrator can put an automatically preset label such as the nvidia.com/gpu.product that labels the GPU type or any other key from a node label.  
      
      * **Value** is the value of that label identifier (key). The same key may have different values, in this case, they are  
       considered as different labels.  
         * Value must fit the following regular expression: `^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$`  
      * A node pool is defined by a single key-value pair. You must not use different labels that are set on the same node by  
       different node pools, this situation may lead to unexpected results.  
   
   4. Set the **GPU placement strategy**:  
      * **Bin-pack** - Place as many workloads as possible in each GPU and node to use fewer resources and maximize GPU and node vacancy.  
      * **Spread** Spread workloads across as many GPUs and nodes as possible to minimize the load and maximize the available resources per workload.  
      * GPU workloads are workloads that request both GPU and CPU resources

   5. Set the **CPU placement strategy**:  
      * **Bin-pack** - Place as many workloads as possible in each CPU and node to use fewer resources and maximize CPU and node vacancy.  
      * **Spread** - Spread workloads across as many CPUs and nodes as possible to minimize the load and maximize the available resources per workload.  
      * CPU workloads are workloads that request purely CPU resources  
  
   6. Click **CREATE NODE POOL**

Editing a node pool

1. Select the node pool you want to edit  
2. Click **EDIT**  
3. Update the node pool and click **SAVE**

## Deleting a node pool

1. Select the node pool you want to delete  
2. Click **DELETE**  
3. On the dialog, click **DELETE** to confirm the deletion

!!! Note
      The `default` node pool cannot be deleted. When deleting a node pool, if no other node pool matches any of the nodes’ labels, the node will be included in the default node pool.

## Using API

Go to the [Node pools](https://app.run.ai/api/docs#tag/NodePools) API reference to view the available actions

