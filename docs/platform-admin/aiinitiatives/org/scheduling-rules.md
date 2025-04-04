This article explains the procedure of configuring and managing Scheduling rules. 
Scheduling rules refer to restrictions applied over workloads. These restrictions apply to either the resources (nodes) on which workloads can run or to the duration of the workload run time. 
Scheduling rules are set for projects or departments and apply to a specific workload type. Once scheduling rules are set, all matching workloads associated with the project or (subordinate projects in case of department) have the restrictions as defined when the workload was submitted. New scheduling rules added, are not applied over already created workloads associated with that project/department.

## Scheduling Rules

There are 3 types of scheduling rules:

### Workload duration (time limit)
   
This rule limits the duration of a workload run time. Workload run time is calculated as the total time in which the workload was in status Running. You can apply a single rule per workload type - Preemptive Workspaces, Non-preemptive Workspaces, and Training.  

### Idle GPU time limit

This rule limits the total GPU time of a workload. Workload idle time is counted from the first time the workload is in status Running and the GPU was idle.  
We calculate idleness by employing the `runai_gpu_idle_seconds_per_workload` metric. This metric determines the total duration of zero GPU utilization within each 30-second interval. If the GPU remains idle throughout the 30-second window, 30 seconds are added to the idleness sum; otherwise, the idleness count is reset.  
You can apply a single rule per workload type - Preemptible Workspaces, Non-preemptible Workspaces, and Training.  
  
!!! Note 
    To make `Idle GPU timeout` effective, it must be set to a shorter duration than that workload duration of the same workload type. 

### Node type (Affinity)

Node type is used to select a group of nodes, typically with specific characteristics such as a hardware feature, storage type, fast networking interconnection, etc. The scheduler uses node type as an indication of which nodes should be used for your workloads, within this project.  

Node type is a label in the form of `run.ai/type` and a value (e.g. `run.ai/type = dgx200`) that the administrator uses to tag a set of nodes. Adding the node type to the project’s scheduling rules mandates the user to submit workloads with a node type label/value pairs from this list, according to the workload type - Workspace or Training. The Scheduler then schedules workloads using a node selector, targeting nodes tagged with the Run:ai node type label/value pair. Node pools and a node type can be used in conjunction. For example, specifying a node pool and a smaller group of nodes from that node pool that includes a fast SSD memory or other unique characteristics.

## Labelling nodes for node types grouping

The administrator should use a node label with the key of run.ai/type and any coupled value

To assign a label to nodes you want to group, set the ‘node type (affinity)’ on each relevant node:

1. Obtain the list of nodes and their current labels by coping the following to your terminal:
  ```
  kubectl get nodes --show-labels
  ```

2. Annotate a specific node with a new label by coping the following to your terminal:
  ```
  kubectl label node <node-name> run.ai/type=<value>
  ```


## Adding a scheduling rule to a project/department

To add a scheduling rule:

1. Select the project/department for which you want to add a scheduling rule  
2. Click **EDIT**  
3. In the **Scheduling rules** section click **\+RULE**  
4. Select the **rule type**  
5. Select the **workload type** and **time limitation period**  
6. For Node type, choose one or more labels for the desired nodes.  
7. Click **SAVE**

!!! Note
    You can review the defined rules in the Projects table in the relevant column.

## Editing the project/department scheduling rule

To edit a scheduling rule:

1. Select the project/department for which you want to edit its scheduling rule  
2. Click **EDIT**  
3. Find the scheduling rule you would like to edit  
4. Edit the rule  
5. Click **SAVE**

!!! Note
When a editing an inherited rule on a project/department (a rule defined by the department), you can only restrict the rule limitation

## Deleting the project/department scheduling rule

To delete a scheduling rule:

1. Select the project/department from which you want to delete a scheduling rule  
2. Click **EDIT**  
3. Find the scheduling rule you would like to delete  
4. Click on the x icon  
5. Click **SAVE**

!!!
You cannot delete rules inherited from the department from the project's set of rules
## Using API

Go to the [Projects](https://app.run.ai/api/docs#tag/Projects/operation/create_project) API reference to view the available actions

