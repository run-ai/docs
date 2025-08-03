# Train models using a distributed training workload

This article explains how to create a distributed training workload via the Run:ai UI.

A training workload contains the setup and configuration needed for building your model, including the container, images, data sets, and resource requests, as well as the required tools for the research, all in a single place. 

The distributed training workload is assigned to a project and is affected by the project’s quota.

To learn more about the distributed training workload type in Run:ai and determine that it is the most suitable workload type for your goals, see [Workload types](../../overviews/workload-types.md).

!!! Note
    Multi-GPU training and distributed training are two distinct concepts. Multi-GPU training uses multiple GPUs within a single node, whereas distributed training spans multiple nodes and typically requires coordination between them.

![](../../img/training-workload.png)

## Creating a distributed training workload

Before you start, make sure you have a project.

To add a new distributed training workload:

1.  Go to the Workload manager → Workloads
2.  Click __+NEW WORKLOAD__ and select __Training__  
    Within the new training form:
3.  Select under which __cluster__ to create the training workload
4.  Select the __project__ in which your training will run
5. Set the training workload architecture as __distributed__ workload, which consists of multiple processes working together. These processes can run on different nodes. This workload uses environments that support distributed training workloads only. 
    * Set the framework for the distributed workload. Select from - 
        
        * PyTorch
        * TensorFlow
        * XG Boost
        * MPI
        
        In case one the above frameworks is not enabled, see [Distributed training prerequisites](../../../../admin/runai-setup/cluster-setup/cluster-prerequisites.md#distributed-training) for details on enabling.  
    
    * Set the distributed workload configuration that defines how  distributed training workloads are divided across multiple machines or processes. Choose a configuration based on your training requirements and infrastructure -
    
        * Workers & master
        * Workers only

6.  Select a __preconfigured [template](../../assets/templates.md)__ or select __Start from scratch__ to launch a new training workload quickly
7.  Enter a unique __name__ for the training workload (if the name already exists in the project, you will be requested to submit a different name)
8.  Click __CONTINUE__  
    In the next step:
9.  Select the __environment__ for your training workload
    *   Select an environment or click __+NEW ENVIRONMENT__ to add a new environment to the gallery.  
        For a step-by-step guide on adding environments to the gallery, see [Environments](../../assets/environments.md). Once created, the new environment will be automatically selected.
    *   Set the connection for your __tool(s)__. The tools are configured as part of the environment.
        *   __External URL__
            *   __Custom URL__
                *   Set the URL
            *   Optional: Modify who can __access__ the tool:
                *   __All authenticated users__ (default)  
                    Everyone within the organization’s account
                *   __Specific group(s)__
                     * Click __+GROUP__
                     * Enter __group names__ as they appear in your identity provider. You must be a member of one of the groups listed to have access to the tool.
                *    __Specific user(s)__
                     * Click __+USER__
                     * Enter a valid email address or username. If you remove yourself, you will lose access to the tool.
        *   __Node port__
            *   __Custom port__
                *   Set the node port (enter a port between 30000 and 32767; if the node port is already in use, the workload will fail and display an error message)
    *   Set the __User ID (UID)__, __Group ID (GID)__ and the supplementary groups that can run commands in the container
        *   Enter __UID__
        *   Enter __GID__
        *   Add __Supplementary groups__ (multiple groups can be added, separated by commas).
    *   Optional: Set the __command and arguments__ for the container running the workload  
        When If no command is added, the container will use the image’s default command (entry-point).
        *   Modify the existing command or click __+COMMAND & ARGUMENTS__ to add a new command.
        *   Set multiple arguments separated by spaces, using the following format (e.g.: `--arg1=val1`).
    *   Set the __environment variable(s)__  
        * Modify the existing environment variable(s). The existing environment variables may include __instructions__ to guide you with entering the correct values.
        * (Optional) Add new variables
            *  Click __+ENVIRONMENT VARIABLE__
            *  Enter a __name__
            *  Select the __source__ for the environment variable
                * __Custom__
                    * Enter a value according to the provided instructions
                * __Credentials__ - Select existing credentials as the environment variable
                    * Select a __credential name__
                    To add new credentials to the credentials list, and for additional information, see [Credentials](../../assets/credentials.md).
                    * Select a __secret key__
10.  Select the __compute resource__ for your training workload
    * Set the number of workers for your workload
    *   Select a compute resource or click __+NEW COMPUTE RESOURCE__ to add a new compute resource to the gallery.  
        For a step-by-step guide on adding compute resources to the gallery, see [compute resources](../../assets/compute.md). Once created, the new compute resource will be automatically selected.
    *   Optional: Set the __order of priority__ for the __node pools__ on which the scheduler tries to run the workload.  
        When a workload is created, the scheduler will try to run it on the first node pool on the list. If the node pool doesn't have free resources, the scheduler will move on to the next one until it finds one that is available.
        *   Drag and drop them to change the order, remove unwanted ones, or reset to the default order defined in the project.
        *   Click __+NODE POOL__ to add a new node pool from the list of node pools that were defined on the cluster.  
            To configure a new node pool and for additional information, see [node pools](../../../../platform-admin/aiinitiatives/resources/node-pools.md).
    *   Select a __node affinity__ to schedule the workload on a specific node type.  
        If the administrator added a ‘[node type (affinity)](../../../../platform-admin/aiinitiatives/org/scheduling-rules.md#node-type-affinity)’ scheduling rule to the project/department, then this field is mandatory.  
        Otherwise, entering a node type (affinity) is optional. [Nodes must be tagged](../../../../platform-admin/aiinitiatives/org/scheduling-rules.md#labelling-nodes-for-node-types-grouping) with a label that matches the node type key and value.  
    * Optional: Set toleration(s) to allow the workload to be scheduled on a node with a matching taint
        
        !!! Note 
            Tolerations are disabled, by default. If you cannot see Tolerations in the menu, then it must be enabled by your Administrator, under General settings → Workloads → Tolerations

        *   Click __+TOLERATION__
        *   Enter a __key__
        *   Select the operator
            *   __Exists__ - If the key exists on the node, the effect will be applied.
            *   __Equals__ - if the key and the value set below matches to the value on the node, the effect will be applied
                *   Enter a __value__ matching the value on the node
        *   Select the effect for the toleration
            *   __NoExecute__ - Pods that do not tolerate this taint are evicted immediately.
            *   __NoSchedule__ - No new pods will be scheduled on the tainted node unless they have a matching toleration. Pods currently running on the node will not be evicted.
            *   __PreferNoSchedule__ - The control plane will try to avoid placing a pod that does not tolerate the taint on the node, but it is not guaranteed.
            *   __Any__ - All effects above match.
            

    * Optional: Set topology to let the workload be scheduled on nodes with a matching topology. Topology lets the workload to be scheduled on nodes within the same region, zone, placement group or any other topology you define.

        !!! Note 
            Setting topology is disabled, by default. If you cannot see Topology in the menu, then it must be enabled by your Administrator, under General settings → Workloads → Topology
        
         * Click __+TOPOLOGY__
         * Enter a __key__
         * Select the operator 
              * __Required__ - If the scheduler can’t schedule all pods within the same topology, the workload will be pending.
              * __Preferred__ - The scheduler will try to schedule all pods within the same topology but may schedule some pods on nodes that are not part of the same topology.

11. Optional: Set the volume needed for your workload  
    A volume allocates storage space to your workload that is persistent across restarts.
    *   Click __+VOLUME__
    *   Select the __storage class__
        * __None__ - Proceed without defining a storage class.
        * __Custom storage class__ - This option applies when selecting a storage class based on existing storage classes.  
            To add new storage classes to the storage class list, and for additional information, see [Kubernetes storage classes](../../../../admin/config/shared-storage.md).
    *   Select the __access mode(s)__ (multiple modes can be selected)
        *  __Read-write by one node__ - The volume can be mounted as read-write by a single node.
        *  __Read-only by many nodes__ - The volume can be mounted as read-only by many nodes.
        *  __Read-write by many nodes__ - The volume can be mounted as read-write by many nodes.
    *  Set the __claim size__ and its __units__
    *  Select the __volume mode__
        *   __File system__ (default) - This allows the volume to be mounted as a file system, enabling the usage of directories and files.
        *   __Block__ - This exposes the volume as a block storage, which can be formatted or used directly by applications without a file system.
    *   Set the __Container path__ with the volume target location
    *   Set the volume persistency
        *   __Persistent__ - The volume and its data will be deleted only when the workload is deleted.
        *   __Ephemeral__ - The volume and its data will be deleted every time the workload’s status changes to “Stopped.”
12. Optional: Select __data sources__ for your training workload 

    Select a data source or click __+NEW DATA SOURCE__ to add a new data source to the gallery. If there are issues with the connectivity to the cluster, or issues while creating the data source, the data source won't be available for selection.  
    For a step-by-step guide on adding data sources to the gallery, see [data sources](../../assets/datasources.md).  
    Once created, the new data source will be automatically selected.
       
       *   Optional: Modify the data target location for the selected data source(s).

13.  __Optional - General settings__:
    *  Set the __grace period__ for workload preemption. This is a buffer that allows a preempted workload to reach a safe checkpoint before it is forcibly preempted. Enter a timeframe between 0 sec and 5 min.
    *   Set the __backoff limit__ before workload failure. The backoff limit is the maximum number of retry attempts for failed workloads. After reaching the limit, the workload status will change to "Failed." Enter a value between 1 and 100.
    *   Set the __timeframe for auto-deletion__ after workload completion or failure. The time after which a completed or failed workload is deleted; if this field is set to 0 seconds, the workload will be deleted automatically. This setting does not affect log retention. Log retention is managed separately.
    *   Set __annotations(s)__  
        Kubernetes annotations are key-value pairs attached to the workload. They are used for storing additional descriptive metadata to enable documentation, monitoring and automation.
        *   Click __+ANNOTATION__
        *   Enter a __name__
        *   Enter a __value__
    *   Set __labels(s)__  
        Kubernetes labels are key-value pairs attached to the workload. They are used for categorizing to enable querying.
        *   Enter a __name__
        *   Enter a __value__
14. Click __CONTINUE__
15. Decide if you wish to define a different setup between the Workers and the Master via the toggle.
When disabled the master’s setup will inherit the workers’ setup.
    *  In case a different setup is requested or required, repeat  steps 9-13 stated above with necessary changes.

16.  Click __CREATE TRAINING__

## Workload Policies

When creating a new workload, fields and assets may have limitations or defaults. These rules and defaults are derived from a policy your administrator set.

Policies allow you to control, standardize, and simplify the workload submission process. For additional information, see [Workload Policies and Rules](../../../../platform-admin/workloads/policies/overview.md).

The effects of the policy are reflected in the training creation form:

*   Defaults derived from the policy will be displayed automatically for specific fields.
*   Disabled actions or values must be within a certain range.
*   Rules and defaults for entire sections (such as environments, compute resources, or data sources) may prevent selection and will appear on the entire library card with an option for additional information via an external modal.

## Managing and monitoring

After the training workload is created, it is added to the [Workloads](../../overviews/managing-workloads.md) table, where it can be managed and monitored.

## Using CLI

To view the available actions,see all possible distributed training workloads in the  [CLI v2 reference](../../../cli-reference/new-cli/overview.md) or the [CLI v1 reference](../../../cli-reference/Introduction.md).

## Using API

To view the available actions, see the [Distributed workload](https://api-docs.run.ai/latest/tag/Distributed/) API reference.