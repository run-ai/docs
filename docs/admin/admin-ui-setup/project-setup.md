## Introduction


Researchers submit Jobs. To streamline resource allocation and prioritize work, Run:ai introduces the concept of __Projects__. Projects are the tool to implement resource allocation policies as well as create segregation between different initiatives. A project in most cases represents a team, an individual, or an initiative that shares resources or has a specific resources budget (quota).

A Researcher submitting a Job needs to associate a Project name with the request. The Run:ai scheduler will compare the request against the current allocations and the Project and determine whether the workload can be allocated resources or whether it should remain in the queue for future allocation.


## Modeling Projects

As an Admin, you need to determine how to model Projects. You can:

*   Set a Project per user.
*   Set a Project per team of users.
*   Set a Project per a real organizational Project.

## Project Quotas

Each Project is associated with a quota of GPUs that can be allocated for this Project at the same time. This is __guaranteed quota__ in the sense that Researchers using this Project are guaranteed to get this number of GPUs, no matter what the status in the cluster is. 

Beyond that, a user of this Project can receive an __over-quota__. As long as GPUs are unused, a Researcher using this Project can get more GPUs. However, these GPUs can be taken away at a moment's notice. For more details on over-quota scheduling see: [The Run AI Scheduler](../../Researcher/scheduling/the-runai-scheduler.md).

__Important best practice:__ As a rule, the sum of the Project allocation should be equal to the number of GPUs in the cluster.

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

When [Researcher Authentication](../runai-setup/config/) is enabled, the Project form will contain an additional _Access Control_ tab. The tab will allow you to assign Researchers to their Projects. 

If you are using Single-sign on, you can also assign Groups 

## Other Project Properties
### Limit Jobs to run on Specific Node Groups

You can assign specific Projects to run only on specific nodes (machines). This can happen for various reasons. Examples:

*   The project team needs specialized hardware (e.g. with enough memory).
*   The project team is the owner of specific hardware which was acquired with a specialized budget.
*   We want to direct build/interactive workloads to work on weaker hardware and direct longer training/unattended workloads to faster nodes.

While such 'affinities' are sometimes needed, it's worth mentioning that at the end of the day any affinity settings hurts overall system utilization.

#### Grouping Nodes 

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

As interactive sessions involve human interaction, Run:ai provides an additional tool to enforce a policy that sets the time limit for such sessions. This policy is often used to handle situation like researchers leaving sessions open even when they do not need to access the resources.

!!! Warning
    This feature will cause containers to automatically stop. Any work not saved to a shared volume will be lost

To set a duration limit for interactive Jobs:

*   Create a Project or edit an existing Project.
*   Go to the _Time Limit_ tab and set a limit (day, hour, minute).

The setting only takes effect for Jobs that have started after the duration has been changed. 


## See Also

Run:ai supports an additional (optional) level of resource allocation called [Departments](department-setup.md). 