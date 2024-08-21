---
title: Submitting Workloads
summary: This article describes how to submit a workload using the workloads V2 form.
authors:
    - Jason Novich
date: 2023-Dec-26
---

## How to Submit a Workload

To submit a workload using the UI:

1. In the left menu press *Workloads*.
2. Press *New Workload*, and select *Workspace*, *Training*, or *Inference*.

=== "Workspace"

      1. In the *Projects* pane, select a project. Use the search box to find projects that are not listed. If you can't find the project, see your system administrator.
      2. In the *Templates* pane, select a template from the list. Use the search box to find templates that are not listed. If you can't find the specific template you need, create a new one, or see your system administrator.
      3. Enter a `Workspace` name, and press continue.
      4. In the *Environment* pane select or [create a new environment](./assets/environments.md#creating-a-new-environment). Use the search box to find environments that are not listed.
   
        1. In the *Set the connection for your tool(s)* pane, choose a tool for your environment (if available). In the *Access* pane, edit the field and choose a type of access. *Everyone* allows all users in the platform to access the selected tool. *Group* allows you a select a specific group of users (Identity provider group). Press `+Group` to add more groups. *User* allows you to grant access individual users (by user email) in the platform. Press `+User` to add more users. (optional)
         2. In the *Runtime settings* field, Set commands and arguments for the container running in the pod. (optional)
         3. In the *Environment variable* field, you can set one or more environment variables. (optional)

      5. In the *Compute resource* pane, select resources for your trainings or [create a new compute resource](./assets/compute.md#create-a-compute-resource). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.
      6. Open the *Volume* pane, and press *Volume* to add a volume to your training.

         1. Select the *Storage class* from the dropdown.
         2. Select the *Access mode* from the dropdown.
         3. Enter a claim size, and select the units.
         4. Select a *Volume system*, mode from the dropdown.
         5. Enter the *Container path* for volume target location.
         6. Select a *Volume persistency*.

      7. In the *Data sources* pane, select a data source. If you need a new data source, press *add a new data source*. For more information, see [Creating a new data source](../../Researcher/workloads/assets/datasources.md#create-a-new-data-source) When complete press, *Create Data Source*.
      
        !!! Note
            * Data sources that have private credentials, which have the status of *issues found*, will be greyed out.
            * Data sources can now include *Secrets*.

      8. In the *General* pane, add special settings for your training (optional):

         1. Toggle the switch to allow the workspace to exceed the project's quota.
         2. Set the backoff limit before workload failure, this can be changed, if necessary. Use integers only. (Default = 6, maximum = 100, minimum = 0). 
         3. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails. (default = 30 days)
         4. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
         5. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

      9.  When complete, press *Create workspace*.

=== "Training"

      1. In the *Projects* pane, select the destination project. Use the search box to find projects that are not listed. If you can't find the project, you can create your own, or see your system administrator.
      2. In the *Multi-node* pane, choose `Single node` for a single node training, or `Multi-node (distributed)` for distributed training. When you choose `Multi-node`, select a framework that is listed, then select the `multi-node` training configuration by selecting either `Workers & master` or `Workers only`.
      3. In the *Templates* pane, select a template from the list. Use the search box to find templates that are not listed. If you can't find the specific template you need, see your system administrator.
      4. In the *Training name* pane, enter a name for the *Training*, then press continue.
      5. In the *Environment* pane select or [create a new environment](./assets/environments.md#creating-a-new-environment). Use the search box to find environments that are not listed. 
         1. In the *Set the connection for your tool(s)* pane, choose a tool for your environment (if available). In the *Access* pane, edit the field and choose a type of access. *Everyone* allows all users in the platform to access the selected tool. *Group* allows you a select a specific group of users (Identity provider group). Press `+Group` to add more groups. *User* allows you to grant access individual users (by user email) in the platform. Press `+User` to add more users. (optional)
         2. In the *Runtime settings* field, Set commands and arguments for the container running in the pod. (optional)
         3. In the *Environment variable* field, you can set one or more environment variables. (optional)
      6. In the *Compute resource* pane:

         1. Select the number of workers for your training.
         2. Select *Compute resources* for your training or [create a new compute resource](./assets/compute.md#create-a-new-compute-resource). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.

        !!! Note
            The number of compute resources for the workers is based on the number of workers selected.

      7. (Optional) Open the *Volume* pane, and press *Volume* to add a volume to your training.

         1. Select the *Storage class* from the dropdown.
         2. Select the *Access mode* from the dropdown.
         3. Enter a claim size, and select the units.
         4. Select a *Volume system*, mode from the dropdown.
         5. Enter the *Container path* for volume target location.
         6. Select a *Volume persistency*. Choose *Persistent* or *Ephemeral*.

      8. (Optional) In the *Data sources* pane, select a data source. If you need a new data source, press *add a new data source*. For more information, see [Creating a new data source](./assets/datasources.md#create-a-new-data-source) When complete press, *Create Data Source*.
   
        !!! Note
            * Data sources that have private credentials, which have the status of *issues found*, will be greyed out.
            * Data sources can now include *Secrets*.

      9.  (Optional) In the *General* pane, add special settings for your training (optional):

         1. Set the backoff limit before workload failure, this can be changed, if necessary. Use integers only. (Default = 6, maximum = 100, minimum = 0). 
         2. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails. (default = 30 days)
         3. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
         4. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

      10. If you if selected  `Workers & master` Press *Continue* to `Configure the master` and go to the next step. If not, then press *Create training*.

      11. If you do not want a different setup for the master, press *Create training*. If you would like to have a different setup for the master, toggle the switch to enable to enable a different setup.

         1. In the *Environment* pane select or [create a new environment](assets/environments.md#creating-a-new-environment). Use the search box to find environments that are not listed. Press *More settings* to add an `Environment variable` or to edit the *Command* and *Arguments* field for the environment you selected.
            1.  In the *Set the connection for your tool(s)* pane, choose a tool for your environment (if available). In the *Access* pane, edit the field and choose a type of access. *Everyone* allows all users in the platform to access the selected tool. *Group* allows you a select a specific group of users (Identity provider group). Press `+Group` to add more groups. *User* allows you to grant access individual users (by user email) in the platform. Press `+User` to add more users. (optional)
            2. In the *Runtime settings* field, Set commands and arguments for the container running in the pod. (optional)
            3. In the *Environment variable* field, you can set one or more environment variables. (optional)
         2. In the *Compute resource* pane, select a *Compute resources* for your training or [create a new compute resource](assets/compute.md#create-a-new-compute-resource). Use the search box to find resources that are not listed. Press *More settings* to use **Node Affinity** to limit the resources to a specific node.
         3. (Optional) Open the *Volume* pane, and press *Volume* to add a volume to your training.

            1. Select the *Storage class* from the dropdown.
            2. Select the *Access mode* from the dropdown.
            3. Enter a claim size, and select the units.
            4. Select a *Volume system*, mode from the dropdown.
            5. Enter the *Container path* for volume target location.
            6. Select a *Volume persistency*. Choose *Persistent* or *Ephemeral*.

         4. (Optional) In the *Data sources* pane, select a data source. If you need a new data source, press *add a new data source*. For more information, see [Creating a new data source](assets/datasources.md#create-a-new-data-source) When complete press, *Create Data Source*.

          !!! Note
              * Data sources that have private credentials, which have the status of *issues found*, will be greyed out.
              * Data sources can now include *Secrets*.

         5. (Optional) In the *General* pane, add special settings for your training (optional):

            1. Set the backoff limit before workload failure, this can be changed, if necessary. Use integers only. (Default = 6, maximum = 100, minimum = 0). 
            2. Press *Auto-deletion* to delete the training automatically when it either completes or fails. You can configure the timeframe in days, hours, minuets, and seconds. If the timeframe is set to 0, the training will be deleted immediately after it completes or fails. (default = 30 days)
            3. Press *Annotation* to a name and value to annotate the training. Repeat this step to add multiple annotations.
            4. Press *Label* to a name and value to label the training. Repeat this step to add multiple labels.

      12. When your training configuration is complete. press *Create training*.

=== "Inference"

      1. In the *Projects* pane, select a project. Use the search box to find projects that are not listed. If you can't find the project, see your system administrator.
      2. In the *Inference by type* pane select *Custom* or *model*.
          
         When you select *Model*:

         1. Select a catalog. Choose from *Run:ai* or *Hugging Face*.
            1. If you choose *Run:ai*, select a model from the tiles. Use the search box to find a model that is not listed. If you can't find the model, see your system administrator.
            2. If you choose *Hugging Face*, go to the next step.
         2. In the *Inference name* field, enter a name for the workload.
         3. In the *Credentials* field, enter the token to access the model catalog.
         4. If you selected *Hugging Face*, enter the name of the model in the *Model Name* section. This will not appear if you selected *Run:ai*.
         5. In the *Compute resource* field, select a compute resource from the tiles.
   
            1. In the *Replica autoscaling* section, set the minimum and maximum replicas for your inference. 
            2. In the *Set conditions for creating a new replica* section, use the drop down to select from `Throughput (Requests/sec)`, `Latency (milliseconds)`, or `Concurrency (Requests/sec)`. Then set the value. (default = 100) This section will only appear if you have 2 or more set as the maximum.
            3. In the *Set when replicas should be automatically scaled down to zero* section, from the drop down select *Never*, *After one, five, 15 or 30 minutes of inactivity*.
   
            !!! Note
                When automatic scaling to zero is enabled, the minimum number of replicas is 0.
         
            4. In the *Nodes* field, change the order of priority of the node pools, or add a new node pool to the list.
         6. When complete, press *Create inference*.

         When you select *Custom*:

         7. In the *Inference name* field, enter a name for the workload.
         8. In the *Environment* field, select an environment. Use the search box to find an environment that is not listed. If you can't find an environment, press *New environment* or see your system administrator. 
            1. In the *Set the connection for your tool(s)* pane, choose a tool for your environment (if available). In the *Access* pane, edit the field and choose a type of access. *Everyone* allows all users in the platform to access the selected tool. *Group* allows you a select a specific group of users (Identity provider group). Press `+Group` to add more groups. *User* allows you to grant access individual users (by user email) in the platform. Press `+User` to add more users. (optional)
            2. In the *Runtime settings* field, Set commands and arguments for the container running in the pod. (optional)
            3. In the *Environment variable* field, you can set one or more environment variables. (optional)
         9.  In the *Compute resource* field, select a compute resource from the tiles. Use the search box to find a compute resource that is not listed. If you can't find an environment, press *New compute resource* or see your system administrator.
   
            1. In the *Replica autoscaling* section, set the minimum and maximum replicas for your inference. 
            2. In the *Set conditions for creating a new replica* section, use the drop down to select from `Throughput (Requests/sec)`, `Latency (milliseconds)`, or `Concurrency (Requests/sec)`. Then set the value. (default = 100) This section will only appear if you have 2 or more set as the maximum.
            3. In the *Set when replicas should be automatically scaled down to zero* section, from the drop down select *Never*, *After one, five, 15 or 30 minutes of inactivity*.
   
            !!! Note
                When automatic scaling to zero is enabled, the minimum number of replicas is 0.

         10. In the *Data sources* field, add a *New data source*. (optional)
   
            !!! Note
                
                * Data sources that are not available will be greyed out.
                * Assets that are cluster syncing will be greyed out.
                * Only PVC, Git, and ConfigMap resources are supported.

         11. In the *General* field you can:
            1. Add an *Auto-deletion* time. This sets the timeframe between inference completion/failure and auto-deletion. (optional) (default = 30 days)
            2. Add one or more *Annotation*. (optional)
            3. Add one or more *Labels*. (optional)
         12. When complete, press *Create inference*.

## Workload Policies

As an administrator, you can set *Policies* on Workloads.  Policies allow administrators to *impose restrictions* and set *default values* for Researcher Workloads. For more information see [Workload Policies](../workloads/policies/policies.md).

## Worklaod Ownership Protection

Workload ownership protection in Run:ai ensures that only users who created a workload can delete or modify them. This feature is designed to safeguard important jobs and configurations from accidental or unauthorized modifications by users who did not originally create the workload.

By enforcing ownership rules, Run:ai helps maintain the integrity and security of your machine learning operations. This additional layer of security ensures that only users with the appropriate permissions can delete and suspend workloads.

This protection maintains workflow stability and prevents disruptions in shared or collaborative environments.

This feature is implemented at the cluster management entity level.

To enable ownership protection:

1. Update the runai-public configmap and set `workloadOwnershipProtection=true`.
2. Perform a cluster-sync to update cluster-service in the CP.
3. Use the workload-service flag to block deletion and suspension of workloads, when appropriate.
