# Running workspaces

This article explains how to create a workspace via the Run:ai UI.

A workspace contains the setup and configuration needed for building your model, including the container, images, data sets, and resource requests, as well as the required tools for the research, all in a single place.

The workspace is assigned to a project and is affected by the project’s quota just like any other workload. For a list of supported features and capabilities for workspaces, check the [Workloads in Run:ai](https://portal.document360.io/saas/docs/workloads-in-runai) article.

![](img/creating-workspace.png)

## Creating a new Workspace

Before starting, make sure you have a project.

To add a new workspace:

1.  Go to the Workload manager → Workloads
2.  Click +NEW WORKLOAD and select Workspace  
    within the new workspace form:
3.  Select under which cluster to create the workload
4.  Select the project in which your workspace will run
5.  Select a preconfigured template or select Start from scratch to launch a new workspace quickly
6.  Enter a unique name for the workspace (if the name already exists in the project’s namespace, you will need to choose a different one)
7.  Click CONTINUE  
    In the next step:
8.  Select the environment for your workspace
    *   Select an environment or click +NEW ENVIRONMENT to add a new environment to the gallery.  
        For a step-by-step guide on adding environments to the gallery, check the [Environments](https://portal.document360.io/saas/docs/environments) article.Once created, the new environment will be automatically selected.
    *   Set the connection for your tool(s). The tools are configured as part of the environment.
        *   External URL
            *   Custom URL
                *   Set the URL
            *   Optional: modify who can access the tool:
                *   All authenticated users (default)  
                    Everyone within the organization’s account
                *   Specific group(s)

Click +GROUP

Enter group names as they appear in your identity provider. You must be a member of one of the groups listed to have access to the tool.

*   *   *   *   *   Specific user(s)

Click +USER

Enter a valid email address or username. If you remove yourself, you will lose access to the tool.

*   *   *   Node port
            *   Custom port
                *   Set the node port (enter a port between 30000 and 32767; if the node port is already in use, the workload will fail and display an error message)
    *   Set the User ID (UID), Group ID (GID) and the supplementary groups that can run commands in the container
        *   Enter UID
        *   Enter GID
        *   Add Supplementary groups (multiple groups can be added, separated by commas).
    *   Optional: Set the command and arguments for the container running the workload  
        When no command is added, the default command of the image is used (the image entry-point).
        *   Modify the existing command or click +COMMAND & ARGUMENTS to add a new command.
        *   Set multiple arguments separated by spaces, using the following format (e.g.: --arg1=val1).
    *   Optional: Set the environment variable(s)  
        The environment variable(s) are added to the environment variables already configured in the environment.
        *   Click +ENVIRONMENT VARIABLE
        *   Enter a name
        *   Set a value

1.  Select the compute resource for your workspace
    *   Select a compute resource or click +NEW COMPUTE RESOURCE to add a new compute resource to the gallery.  
        For a step-by-step guide on adding compute resources to the gallery, check the [compute resources](https://portal.document360.io/saas/docs/compute-resources) article. Once created, the new compute resource will be automatically selected.
    *   Optional: Set the order of priority for the node pools on which the scheduler tries to run the workload.  
        When a workload is created, the scheduler will try to run it on the first node pool on the list. If the node pool doesn't have free resources, the scheduler will move on to the next one until it finds one that's available.
        *   Drag and drop them to change the order, remove unwanted ones, or reset to the default order defined in the project.
        *   Click +NODE POOL to add a new node pool from the list of node pools that were defined on the cluster.  
            To configure a new node pool and for additional information, check the [node pools](https://portal.document360.io/saas/docs/node-pools) article.
    *   Select a node affinity to schedule the workload on a specific node type.  
        If the administrator added a ‘[node type (affinity)](https://run-ai.document360.io/docs/scheduling-rules#node-type-affinity)’ scheduling rule to the project/department, then this field is mandatory.  
        Otherwise entering a node type (affinity) is optional. [Nodes must be tagged](https://run-ai.document360.io/docs/scheduling-rules#labelling-nodes-for-node-types-grouping) with a label that matches the node type key and value.  
        Optional: Set toleration(s) to let the workload be scheduled on a node with a matching taint
        *   Click +TOLERATION
        *   Enter a key
        *   Select the operator
            *   Exists - If the key exists on the node, the effect will be applied.
            *   Equals - if the key and the value set below matches to the value on the node, the effect will be applied
                *   Enter a value matching the value on the node
        *   Select the effect for the toleration
            *   NoExecute - Pods that do not tolerate this taint are evicted immediately.
            *   NoSchedule - No new pods will be scheduled on the tainted node unless they have a matching toleration. Pods currently running on the node will not be evicted.
            *   PreferNoSchedule - The control plane will try to avoid placing a pod that does not tolerate the taint on the node, but it is not guaranteed.
            *   Any - All effects above match.
2.  Optional: Set the volume needed for your workload  
    A volume allocates storage space to your workload that is persistent across restarts.
    *   Click +VOLUME
    *   Select the storage class
        *   None - Proceed without defining a storage class.
        *   Custom storage class - This option applies when selecting a storage class based on existing storage classes.  
            To add new storage classes to the storage class list, and for additional information, check [Kubernetes storage classes](https://run-ai.document360.io/docs/shared-storage#kubernetes-storage-classes)
    *   Select the access mode(s) (multiple modes can be selected)
        *   Read-write by one node - The volume can be mounted as read-write by a single node.
        *   Read-only by many nodes - The volume can be mounted as read-only by many nodes.
        *   Read-write by many nodes - The volume can be mounted as read-write by many nodes.
    *   Set the claim size and its units
    *   Select the volume mode
        *   File system (default) - This allows the volume to be mounted as a file system, enabling the usage of directories and files.
        *   Block - This exposes the volume as a block storage, which can be formatted or used directly by applications without a file system.
    *   Set the volume target location
        *   Container path
    *   Set the volume persistency
        *   Persistent - The volume and its data will be deleted only when the workload is deleted.
        *   Ephemeral - The volume and its data will be deleted every time the workload’s status changes to “Stopped.”
3.  Optional: Select data sources for your workspace  
    Select a data source or click +NEW DATA SOURCE to add a new data source to the gallery. If there are issues with the connectivity to the cluster, or if there were issues while creating the data source, the data source won't be available for selection.  
    For a step-by-step guide on adding data sources to the gallery, check the [data resources](https://portal.document360.io/saas/docs/compute-resources) article.  
    Once created, the new data source will be automatically selected.
    *   Optional: Modify the data target location for the selected data source(s).
4.  Optional - General settings:
    *   Allow the workload to exceed the project quota (Workloads running over quota may be preempted and stop at any time).
    *   Set the backoff limit before workload failure. The backoff limit is the maximum number of retry attempts for failed workloads. After reaching the limit, the workload status will change to "Failed." (Enter a value between 1 and 100.)
    *   Set the timeframe for auto-deletion after workload completion or failure (the time after which a completed or failed workload is deleted; if this field is set to 0 seconds, the workload will be deleted automatically).
    *   Set annotations(s)  
        Kubernetes annotations are key-value pairs attached to the workload. They are used for storing additional descriptive metadata to enable documentation, monitoring and automation.
        *   Click +ANNOTATION
        *   Enter a name
        *   Enter a value
    *   Set labels(s)  
        Kubernetes labels are key-value pairs attached to the workload. They are used for categorizing to enable querying.
        *   Enter a name
        *   Enter a value
5.  Click CREATE WORKSPACE

## Workload Policies

When creating a new workload, fields and assets may have limitations or defaults. These rules and defaults are derived from a policy your administrator set.

Policies let you control, standardize, and simplify the workload submission process. For additional information, check [Workload Policies and Rules](https://portal.document360.io/saas/docs/policies-and-rules1).

The effects of the policy are reflected in the workspace creation form:

*   Defaults derived from the policy will be displayed automatically for specific fields.
*   Disabled actions or values must be within a certain range.
*   Rules and defaults for entire sections (such as environments, compute resources, or data sources) may prevent selection and will appear on the entire library card with an option for additional information via an external modal.

## Managing and monitoring

After the workspace is created, it is added to the [Workloads](https://portal.document360.io/saas/docs/workloads) table, where it can be managed and monitored.

## Using CLI

To view the available actions on workspaces, please visit the Workspaces [CLI v2 reference](https://docs.run.ai/latest/Researcher/cli-reference/new-cli/runai_workspace_submit/) or the [CLI v1 reference](https://docs.run.ai/latest/Researcher/cli-reference/runai-submit/).

## Using API

To view the available actions on workspaces, please visit the [Workspaces API reference](https://api-docs.run.ai/2.19/tag/Workspaces).