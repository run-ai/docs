## Introduction


Researchers submit Jobs. To streamline resource allocation and prioritize work, Run:ai introduces the concept of __Projects__. Projects are the tool to implement resource allocation policies as well as create segregation between different initiatives. A project in most cases represents a team, an individual, or an initiative that shares resources or has a specific resources budget (quota).

A Researcher submitting a Job needs to associate a Project name with the request. The Run:ai scheduler will compare the request against the current allocations and the Project and determine whether the workload can be allocated resources or whether it should remain in the queue for future allocation.


## Modeling Projects

As an Admin, you need to determine how to model Projects. You can:

*   Set a Project per user.
*   Set a Project per team of users.
*   Set a Project per a real organizational Project.

## Node Pools 
By default, the Run:ai system associates all nodes with a _Default_ node pool. The administrator can choose to create new node pools and include a set of nodes with a specific node pool by associating the node pool with a label that is shared by all those nodes.
Each node pool is automatically associated with all Projects and Departments with zero resource allocation (Quotas). 

## Project Quotas

Each Project is associated with a total quota of GPU and CPU resources that can be allocated for the Project at the same time. This total is the sum of all node pools' quotas associated with this Project. This is the __guaranteed quota__ in the sense that Researchers using this Project are guaranteed to get this amount of GPU and CPU resources, no matter what the status of the cluster is.

Beyond the guaranteed resources, a user of this Project can receive an __over-quota__ (the administrator needs to enable over-quota per project). As long as GPUs are unused, a Researcher using this Project can get more GPUs. However, these GPUs can be taken away at a moment's notice. 

When node pools are enabled, over-quota is effective and calculated __per node pool__, this means that a workload requesting resources from a specific node pool, will get its resources from a quota that belongs to another Project - if the resources are exhausted for this Project and available on another Project. For more details on over-quota scheduling see [The Run: ai Scheduler](../../Researcher/scheduling/the-runai-scheduler.md).

__Important best practice:__ As a rule, the sum of the Projects' allocations should be equal to the number of GPUs in the cluster.

### Controlling Over-Quota Behavior

By default, the amount of over-quota available for Project members is proportional to the original quota provided above. The [Run:ai scheduler document](../../Researcher/scheduling/the-runai-scheduler.md) provides further examples which show how over-quota is distributed amongst competing Projects. 

As an administrator, you may want to disconnect the two parameters. So that, for example, a Project with a high __quota__ will receive little or no __over__-quota. To perform this:

* Under `General | Settings` turn on the `Enable Over-quota Priority` feature
* When creating a new Project, you can now see a slider for over-quota priority ranging from `None` to `High` 


## Create a Project

!!! Note 
    To be able to create or edit Projects, you must have _Editor_ access. See the [Users](admin-ui-users.md) documentation.

*   Login to the Projects area of the Run:ai user interface at `<company-name>.run.ai`.
*   On the top right, select "Add New Project"
*   Choose a Project name and a Project quota 
*   Press "Save"

## Assign Users to Project

When [Researcher Authentication](../runai-setup/authentication/researcher-authentication.md) is enabled, the Project form will contain an additional _Access Control_ tab. The tab will allow you to assign Researchers to their Projects. 

If you are using Single-sign-on, you can also assign Groups 

## Other Project Properties
### Limit Jobs to run on Specific Node Groups

You can assign a Project to run on specific nodes (machines). This is achieved using two different mechanisms:

*   __Node Pools__: All node pools in the system are associated with each Project. Each node pool can allocate GPU and CPU resources to this Project. By associating quota on specific node pools for this Project, you can control which nodes this Project can utilize. In addition, each workload should choose the node pool to use (if no choice is made, it will use the  `Default` node pool). Note that node pools with zero resources associated with this Project or with exhausted resources can still be used by this Project when the Over-Quota flag is enabled.

*   __Node Affinities__ (a.k.a. Node Type). The administrator can associate specific node sets characterized by a shared run-ai/node-type label value to a Project. This means that descendant workloads can only use nodes from one of those node affinity groups. A workload can specify which node affinity to use, out of the list bound to its parent Project.

There are many use cases and reasons to use specific nodes for a Project and its descendant workloads, here are some examples:
 
*   The project team needs specialized hardware (e.g. with enough memory).
*   The project team is the owner of specific hardware which was acquired with a specialized budget.
*   We want to direct build/interactive workloads to work on weaker hardware and direct longer training/unattended workloads to faster nodes.

#### The difference between Node Pools and Affinities
Node pools represent an independent scheduling domain per Project, they are therefore completely segregated from each other. To use a specific node pool, any workload must specify the node pool it would like to use. For affinities, workloads that ask for a specific affinity will only be scheduled to nodes marked with that affinity, while workloads that did not specify any affinity might be scheduled as well to those nodes with an affinity. Thus the scheduler cannot guarantee quota for node affinities, only to node pools.


Note that using node pools and affinities narrows down the scope of nodes a specific project is eligible to use. It, therefore, reduces the odds of a specific workload under that Project getting scheduled. In some cases, this may reduce the overall system utilization.

#### Grouping Nodes using Node Pools  
To create a node pool you must first annotate nodes with a label or use an existing node label, as the key for grouping nodes into pools. You can use any unique label (in the format `key:value`) to form a node pool. a node pool is characterized by a label but also has its own unique node pool name.

To get the list of nodes and their current labels, run:

```
kubectl get nodes --show-labels
```

To annotate a specific node with the label `dgx-2`, run:

```
kubectl label node <node-name> node-model=dgx-2
```
You can annotate multiple nodes with the same label.

To create a node pool with the chosen common label use the [create node pool](https://app.run.ai/api/docs/#/NodePools/createNodePool){target=_blank} Run:ai API.

#### Setting Node Pools for a Specific Project

By default, all node pools are associated with every Project and Department using zero resource allocation. This means that by default any Project can use any node-pool if Over-Quota is set for that Project and only for preemptible workloads (i.e. Training workloads or Interactive using Preemptible flag).

* To guarantee resources for all workloads including non-preemptible workloads, the administrator should allocate resources in node pools.
*   Go to the `Node Pools` tab under Project and set a quota to specific node pools (GPU resources, CPU resources).
*   To mandate a Workload to run on a specific node pool, the Researcher should specify the node pool to use for a workload. 
*   If no node pool is specified, the `Default` node pool is used. 
*   Press `Save` to save your changes.

#### Grouping Nodes using Node Affinities  

To set node affinities, you must first annotate nodes with labels. These labels will later be associated with Projects. 

To get the list of nodes, run:

```
kubectl get nodes
```

To annotate a specific node with the label "dgx-2", run:

```
kubectl label node <node-name> run.ai/type=dgx-2
```

* Each node can only be annotated with a __single__ label.
* You can annotate multiple nodes with the same label.

#### Setting Affinity for a Specific Project

To mandate __training__ Jobs to run on specific node groups:

*   Create a Project or edit an existing Project.
*   Go to the _Node Affinity_ tab and set a limit to specific node groups.
*   If the label does not yet exist, press the + sign and add the label.
*   Press Enter to save the label.
*   Select the label.

To mandate __interactive__ Jobs to run on specific node groups, perform the same steps under the "interactive" section in the Project dialog.

#### Further Affinity Refinement by the Researcher

The Researcher can limit the selection of node groups by using the CLI flag ``--node-type`` with a specific label. When setting specific Project affinity, the CLI flag can only be used with a node group out of the previously chosen list.  See CLI reference for further information [runai submit](../../Researcher/cli-reference/runai-submit.md) 

### Limit Duration of Interactive Jobs

As interactive sessions involve human interaction, Run:ai provides an additional tool to enforce a policy that sets the time limit for such sessions. This policy is often used to handle situations like researchers leaving sessions open even when they do not need to access the resources.

!!! Warning
    This feature will cause containers to automatically stop. Any work not saved to a shared volume will be lost

To set a duration limit for interactive Jobs:

*   Create a Project or edit an existing Project.
*   Go to the _Time Limit_ tab and set a limit (day, hour, minute).

The setting only takes effect for Jobs that have started after the duration has been changed. 


## See Also

Run:ai supports an additional (optional) level of resource allocation called [Departments](department-setup.md). 
