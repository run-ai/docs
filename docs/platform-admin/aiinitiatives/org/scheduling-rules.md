This article explains the procedure of configuring and managing Scheduling rules. Scheduling rules refer to restrictions applied over workloads. These restrictions apply to either the resources (nodes) on which workloads can run or to the duration of the workload run time. Scheduling rules are set for Projects and apply to a specific workload type. Once scheduling rules are set for a project, all matching workloads associated with the project will have the restrictions as defined when the workload was submitted. New scheduling rules added to a project are not applied over already created workloads associated with that project.

There are 3 types of rules:

* **Workload time limit** - This rule limits the duration of a workload run time. Workload run time is calculated as the total time in which the workload was in status “Running“.  
* **Idle GPU time limit** - This rule limits the total GPU time of a workload. Workload idle time is counted from the first time the workload is in status Running and the GPU was idle. We calculate idleness by employing the `runai_gpu_idle_seconds_per_workload metric`. This metric determines the total duration of zero GPU utilization within each 30-second interval. If the GPU remains idle throughout the 30-second window, 30 seconds are added to the idleness sum; otherwise, the idleness count is reset.

* **Node type (Affinity)** - This rule limits a workload to run on specific node types. node type is a node affinity applied on the node. Run:ai labels the nodes with the appropriate affinity and indicates the scheduler where it is allowed to schedule the workload.

Adding a scheduling rule to a project

To add a scheduling rule:

1. Select the project you want to add a scheduling rule for  
2. Click **EDIT**  
3. In the **Scheduling rules** section click **\+RULE**  
4. Select the **rule type**  
5. Select the **workload type** and **time limitation period**  
6. For Node type, choose one or more labels for the desired nodes.  
7. Click **SAVE**

!!! Note
    You can review the defined rules in the Projects table in the relevant column.

## Editing the project’s scheduling rule

To edit a scheduling rule:

1. Select the project you want to edit its scheduling rule  
2. Click **EDIT**  
3. Find the scheduling rule you would like to edit  
4. Edit the rule  
5. Click **SAVE**

## Deleting the project’s scheduling rule

To delete a scheduling rule:

1. Select the project you want to delete a scheduling rule from  
2. Click **EDIT**  
3. Find the scheduling rule you would like to delete  
4. Click on the x icon  
5. Click **SAVE**

## Using API

Go to the [Projects](https://app.run.ai/api/docs#tag/Projects/operation/create_project) API reference to view the available actions

