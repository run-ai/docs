# Introduction

Researchers submit Jobs. To streamline resource allocation and prioritize work, Run:ai introduces the concept of **Projects**. Projects are the tool to implement resource allocation policies as well as create segregation between different initiatives. A project in most cases represents a team, an individual, or an initiative that shares resources or has a specific resources budget (quota).

A Researcher submitting a Job needs to associate a Project name with the request. The Run:ai scheduler will compare the request against the current allocations and the Project and determine whether the workload can be allocated resources or whether it should remain in the queue for future allocation.

## Modeling Projects

As an Admin, you need to determine how to model Projects. You can:

* Set a Project per user.
* Set a Project per team of users.
* Set a Project per a real organizational Project.

## Node Pools

For detailed information on node pools, see [Using node pools](../../Researcher/scheduling/using-node-pools.md).

By default, all nodes in a cluster are part of the `Default` node pool. The administrator can choose to create new node pools and include a set of nodes in a node pool by associating the nodes with a label.

Each node pool is automatically associated with all Projects and Departments with zero resource allocation (Quotas).
When submitting a Job (or Deployment), the Researcher can choose one or more node pools. When choosing more than one node pool, the researcher sets the order of priority between the chosen node pools. The scheduler will try to schedule the Job to the first node pool. If not successful the scheduler will try the second node pool in the list, and so forth until it finds a node pool that can provide the Job's specification.

An administrator can set a Project's `default priority list` of node pools. In case the Researcher did not specify any node pool (or node pool list), the scheduler will use the Project's default node pool priority list to determine the order that the scheduler will use when scheduling the Job.

## Project Quotas

Each Project is associated with a total quota of GPU and CPU resources (CPU Compute & CPU Memory) that can be allocated for the Project at the same time. This total is the sum of all node pools' quotas associated with this Project. This is **guaranteed quota** in the sense that Researchers using this Project are guaranteed to get this amount of GPU and CPU resources, no matter what the status in the cluster is.

Beyond that, a user of this Project can receive an **over-quota** (The administrator needs to enable over-quota per project). As long as GPUs are unused, a Researcher using this Project can get more GPUs. **However, these GPUs can be taken away at a moment's notice**. When the node pools flag is enabled, over-quota is effective and calculated per node pool, this means that a workload requesting resources from a certain node pool can get its resources from a quota that belongs to another Project for the same node pool if the resources are exhausted for this Project and available on another Project. For more details on over-quota scheduling see [the Run:ai Scheduler](../../Researcher/scheduling/the-runai-scheduler.md).

!!! Important
    Best practice: As a rule, the sum of the Projects' allocations should be equal to the number of GPUs in the cluster.

### Controlling Over-Quota Behavior

By default, the amount of over-quota available for Project members is proportional to the original quota provided above. The [Run:ai scheduler document](../../Researcher/scheduling/the-runai-scheduler.md) provides further examples which show how over-quota is distributed amongst competing Projects.

As an administrator, you may want to disconnect the two parameters. So, for example, a Project with a high **quota** will receive little or no **over**-quota. To perform this:

* Under `Settings | General` turn on the `Enable Over-quota Priority` feature
* When creating a new Project, you can now see a slider for over-quota priority ranging from `None` to `High`

## Create a Project

!!! Note
    To be able to create or edit Projects, you must have *Editor* access. See the [Users](admin-ui-users.md) documentation.

1. In the left-menu, press **Projects**, then press *+Add New Project*.
2. Choose a *Department* from the drop-down. The default is `default`.
3. Enter a *Project name*. Press *Namespace* to set the namespace associated with the project. You can either create the namespace from the project name (default) or enter an existing namespace.
4. In *Quota management*, configure the node pool priority (if editable), the GPUs, CPUs, CPU memory, and Over-quota priority settings. Configure the following:

       * *Order of priority*&mdash;the priority the node pool will receive when trying to schedule workloads. For more information, see [Node pool priority](../../Researcher/scheduling/using-node-pools.md#multiple-node-pools-selection).
       * *GPUs*&mdash;the number of GPUs in the node pool. Press *GPUs* and enter the number of GPUs, then press *Apply* to save.
       * *CPUs(Cores)*&mdash;the number of CPU cores in the node pool. Press *CPUs* and enter the number of GPUs, then press *Apply* to save.
       * *CPU Memory*&mdash;the amount of memory the CPUs will be allocated. Press *CPU Memory*, enter an amount of memory, then press *Apply* to save.
       * Over-quota priority&mdash;the priority for the specific node pool to receive over-quota allocations.
  
5. (Optional) In the *Scheduling rules* pane, use the dropdown arrow to open the pane. Press on the *+ Rule* button to add a new rule to the project. Add one (or more) of the following rule types:

    * *Idle GPU timeout*&mdash;controls the amount of time that specific workload GPUs which are idle will be remain assigned to the project before getting reassigned.
    * *Workspace duration*&mdash;limit the length of time a workspace will before being terminated.
    * *Training duration*&mdash;limit the length of time training workloads will run.
    * *Node type (Affinity)*&mdash;limits specific workloads to run on specific node types.
  
<!-- 4. In *Access control*, add one or more applications or users. If your user or application isn't in the list, see [Roles and permissions](admin-ui-users.md#roles-and-permissions), and verify that the users have the correct permissions. To change user permissions, see [Working with users](admin-ui-users.md#working-with-users). -->

## Assign Access Rules to a Project

<!-- This is no longer available even when it is set to enabled!!
When [Researcher Authentication](../runai-setup/authentication/researcher-authentication.md) is enabled, the Project form will contain an additional *Access Control* tab. The tab will allow you to assign Researchers to their Projects.  -->

To assign *Access rules* to the project:

1. Select a project from the list, then press *Access rules*, then press then press *+Access rule*.
2. From the *Subject* dropdown choose *User* or *Application*, then enter the user name or the application name.
3. From the *Role* dropdown, select the desired role, then press *Save rule*.
4. If you want to add another rule, use the *+Access rule*.
5. When all the rules are configured, press *Close*.

If you are using Single-sign-on, you can also assign Groups.

## Viewing Project Policies

Run:ai now provides the ability to view how policies effect your *Project*.

To view a project policy:

1. In the left menu, press *Projects*, then select a project from the list.
2. Press *View Policy*, and select a policy type. The *Policy Viewer* opens.

    !!! Note
        Policy types are greyed out if there are no policies applied in the platform.

3. To view the a policy restriction, expand a section of the policy. The following categories are available:

    * Parameter
    * Rule
    * Default
    * Source


## Other Project Properties

### Download Project Table

You can download the Projects table to a CSV file. Downloading a CSV can provide a snapshot history of your projects over the course of time, and help with compliance tracking. All the columns that are selected (displayed) in the table will be downloaded to the file.

To download the Projects table to a CSV:
1. Open *Projects*.
2. From the *Columns* icon, select the columns you would like to have displayed in the table.
3. Click on the ellipsis labeled *More*, and download the CSV.

### Limit Jobs to run on Specific Node Groups

You can assign a Project to run on specific nodes (machines). This is achieved by two different mechanisms:

* Node Pools:
        All node pools in the system are associated with each Project. Each node pool can allocate GPU and CPU resources (CPU Compute & CPU Memory) to a Project. By associating a quota on specific node pools for a Project, you can control which nodes a Project can utilize and which default priority order the scheduler will use (in case the workload did choose so by itself). Each workload should choose the node pool(s) to use, if no choice is made, it will use the Project's default 'node pool priority list'. Note that node pools with zero resources associated with a Project or node pools with exhausted resources can still be used by a Project when the Over-quota flag is enabled.

* Node Affinities (aka Node Type)
        Administrator can associate specific node sets characterized by a shared run-ai/node-type label value to a Project. This means descendant workloads can only use nodes from one of those node affinity groups. A workload can specify which node affinity to use, out of the list is bounded to its parent Project.

There are many use cases and reasons to use specific nodes for a Project and its descendant workloads, here are some examples:

* The project team needs specialized hardware (e.g. with enough memory).
* The project team is the owner of specific hardware which was acquired with a specialized budget.
* We want to direct build/interactive workloads to work on weaker hardware and direct longer training/unattended workloads to faster nodes.

#### The difference between Node Pools and Affinities

Node pools represent an independent scheduling domain per Project, therefore are completely segregated from each other. To use a specific node pool (or node pools), any workload must specify the node pool(s) it would like to use. While for affinities, workloads that ask for a specific affinity will only be scheduled to nodes marked with that affinity, while workloads that did not specify any affinity might be scheduled as well to those nodes with an affinity. Therefore the scheduler cannot guarantee quota for node affinities, only to node pools.

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

By default, all node pools are associated with every Project and Department using zero resource allocation. This means that by default any Project can use any node-pool if Over-Quota is set for that Project, but only for preemptible workloads (i.e. Training workloads or Interactive using Preemptible flag).

* To guarantee resources for all workloads including non-preemptible workloads, the administrator should allocate resources in node pools.
* Go to the *Node Pools* tab under Project and set a quota to any of the node pools (GPU resources, CPU resources) you want to use.
* To set the Project's default node pool's order of priority, you should set the precedence of each node pool, this is done in the Project's node pool tab.
* The node pool default priority order is used if the workload did not specify its preferred node pool(s) list of priority.
* To mandate a Workload to run on a specific node pool, the Researcher should specify the node pool to use for a workload.
* If no node-pool is specified - the Project's 'Default' node-pool priority list is used.
* Press 'Save' to save your changes.

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

* Each node can only be annotated with a **single** label.
* You can annotate multiple nodes with the same label.

#### Setting Affinity for a Specific Project

To mandate **training** Jobs to run on specific node groups:

* Create a Project or edit an existing Project.
* Go to the *Node Affinity* tab and set a limit to specific node groups.
* If the label does not yet exist, press the + sign and add the label.
* Press Enter to save the label.
* Select the label.

To mandate **interactive** Jobs to run on specific node groups, perform the same steps under the "interactive" section in the Project dialog.

#### Further Affinity Refinement by the Researcher

The Researcher can limit the selection of node groups by using the CLI flag ``--node-type`` with a specific label. When setting specific Project affinity, the CLI flag can only be used with a node group out of the previously chosen list.  See CLI reference for further information [runai submit](../../Researcher/cli-reference/runai-submit.md)

### Limit Duration of Interactive and Training Jobs

As interactive sessions involve human interaction, Run:ai provides an additional tool to enforce a policy that sets the time limit for such sessions. This policy is often used to handle situations like researchers leaving sessions open even when they do not need to access the resources.

!!! Warning
    This feature will cause containers to automatically stop. Any work not saved to a shared volume will be lost.

To set a duration limit for interactive Jobs:

* Create a Project or edit an existing Project.
* Go to the *Time Limit* tab
* You can limit interactive Jobs using two criteria:
  * Set a hard time limit (day, hour, minute) to an Interactive Job, regardless of the activity of this Job, e.g. stop the Job after 1 day of work.
  * Set a time limit for Idle Interactive Jobs, i.e. an Interactive Job idle for X time is stopped. Idle means no GPU activity.
  * You can set if this idle time limit is effective for Interactive Jobs that are Preemptible, non-Preemptible, or both.

The setting only takes effect for Jobs that have started after the duration has been changed.

In some use cases, you would like to stop Training Jobs if X time elapsed since they have started to run. This can be to clean up stale Training Jobs or Jobs that are running for too long probably because of wrong parameters set or other errors of the model.

To set a duration limit for Training Jobs:

* Create a Project or edit an existing Project.
* Go to the *Time Limit* tab:
  * Set a time limit for Idle Training Jobs, i.e. a Training Job idle for X time is stopped. Idle means no GPU activity.

The setting only takes effect for Jobs that have started after the duration has been changed.

## See Also

Run:ai supports an additional (optional) level of resource allocation called [Departments](department-setup.md).
