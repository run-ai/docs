  
This article explains what environments are and how to create and use them.

Environments are one type of [workload asset](overview.md). An environment consists of a configuration that simplifies how workloads are submitted and can be used by AI practitioners when they submit their workloads.

An environment asset is a preconfigured building block that encapsulates aspects for the workload such as:

* Container image and container configuration  
* Tools and connections  
* The type of workload it serves

## Environments table

The Environments table can be found under __Environments__ in the Run:ai platform.

The Environment table provides a list of all the environment defined in the platform and allows you to manage them.

![](img/env-table.png)

The Environments table consists of the following columns:

| Column | Description |
| :---- | :---- |
| Environment | The name of the environment |
| Description | A description of the essence of the environment |
| Scope | The [scope](overview.md#asset-scope) of this environment within the organizational tree. Click the name of the scope to view the organizational tree diagram |
| Image | The application or service to be run by the workload |
| Workload Architecture | This can be either standard for running workloads on a single node or distributed for running distributed workloads on a multiple nodes |
| Tool(s) | The tools and connection types the environment exposes |
| Workload(s) | The list of existing workloads that use the environment |
| Workload types | The workload type that can use the environment |
| Template(s) | The list of workload templates that use this environment |
| Created by | The name of the user who created the environment |
| Creation time | The timestamp for when the environment was created |
| Cluster | The cluster that the environment is associated with |

### Customizing the table view

* Filter - Click ADD FILTER, select the column to filter by, and enter the filter values  
* Search - Click SEARCH and type the value to search by  
* Sort - Click each column header to sort by  
* Column selection - Click COLUMNS and select the columns to display in the table  
* Download table - Click MORE and then Click Download as CSV

## Adding a new environment

Environment creation is limited to [specific roles](overview.md#who-can-create-an-asset)

To add a new environment:

1. Go to the Environments table  
2. Click __+NEW ENVIRONMENT__  
3. Select under which cluster to create the environment  
4. Select a [scope](overview.md#asset-scope)  
5. Enter a __name__ for the environment. The name must be unique.  
6. Optional: Provide a __description__ of the essence of the environment  
7. Enter the __Image URL__  
   If a token or secret is required to pull the image, it is possible to create it via credentials of type docker registry. These credentials are automatically used once the image is pulled (which happens when the workload is submitted)  
8. Set the __image pull policy__ - the condition for when to pull the image from the registry  
9. Set the workload architecture:  
    * __Standard__  
    Only standard workloads can use the environment. A standard workload consists of a single process.  
    * __Distributed__  
    Only distributed workloads can use the environment. A distributed workload consists of multiple processes working together. These processes can run on different nodes.  
      * Select a framework from the list.  
10. Set the workload type:  
    * __Workspace__  
    * __Training__  
    * __Inference__  
      * When inference is selected, define the __endpoint__ of the model by providing both the protocol and the container’s serving port  
11. Optional: Set the connection for your __tool(s)__. The tools must be configured in the image. When submitting a workload using the environment, it is possible to connect to these tools  
    * Select the tool from the list (the available tools varies from IDE, experiment tracking, and more, including a custom tool for your choice)  
    * Select the connection type  
        * __External URL__  
            * __Auto generate__  
              A unique URL is automatically created for each workload using the environment  
            * __Custom URL__  
              The URL is set manually  
        * __Node port__  
            * __Auto generate__  
              A unique port is automatically exposed for each workload using the environment  
            * __Custom URL__  
              Set the port manually  
        * Set the __container port__  
12. Optional: Set a __command and arguments__ for the container running the pod  
    * When no command is added, the default command of the image is used (the image entrypoint)  
    * The command can be modified while submitting a workload using the environment  
    * The argument(s) can be modified while submitting a workload using the environment  
13. Optional: __Set the environment variable(s)__  
    * The environment variable(s) are added to the default environment variables that are already set within the image  
    * The environment variables can be modified and new variables can be added while submitting a workload using the environment  
14. Optional: Set the container’s __working directory__ to define where the container’s process starts running. When left empty, the default directory is used.  
15. Optional: Set where the UID, GID and supplementary groups are taken from, this can be:  
    * __From the image__  
    * __From the IdP token__ (only available in an SSO installations)  
    * __Custom__ (manually set) - decide whether the submitter can modify these value upon submission.  
16. Optional: Select __Linux capabilities__ - Grant certain privileges to a container without granting all the privileges of the root user.  
17. Click __CREATE ENVIRONMENT__

!!! Note
    It is also possible to add environments directly when creating a specific workspace, training or inference workload

## Editing an environment

To edit an environment:

1. Select the environment from the table  
2. Click __Rename__ to edit its name and description

!!! Note
    Additional fields can be edited using the [API](https://app.run.ai/api/docs#tag/Environment)

## Copying & Editing an environment

To copy & edit an environment:

1. Select the project you want to duplicate  
2. Click __COPY & EDIT__. 
3. Update the environment and click __SAVE__.

## Deleting an environment

To delete an environment:

1. Select the environment you want to delete  
2. Click __DELETE__  
3. On the dialog, click __DELETE__ to confirm the deletion

!!! Note
    It is not possible to delete an environment being used by an existing workload and template.

## Using API

Go to the [Environment](https://app.run.ai/api/docs#tag/Environment) API reference to view the available actions

