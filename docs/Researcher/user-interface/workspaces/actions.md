
# Workspaces actions and use cases

## Creating a new workspace
A Workspace is assigned to a project and is affected by the project’s quota just like any other workload is. A workspace is shared with all project members for collaboration.
To create a workspace, you must have:

* At least one project 
* A data scientist assigned to at least one project


In order to create a workspace, the data scientist must select the building blocks. There are two ways of selecting building blocks:

* Creating a workspace “from scratch” - that allows you to either select an existing building block or create them on the spot (if permissions are allowed).
* Creating a workspace from template - which preconfigure the workspace with all setup and building blocks defined in the template.

To create a workspace press new workspace and select a project for the new workspace. Each project time contains information about the project such as how much of the quota is being allocated and indicates the likelihood of the workspace to be scheduled or left in the queue

![](img/proj-select.png)

In order to create a workspace, the data scientist must select the building blocks for the workspace’s building blocks. For that there are 2 methods for the data scientist’s convenience:
Creating a workspace “from scratch” - which allows to either select existing building block or create them on the spot
Creating a workspace from template - which preconfigure the workspace with all setup and building blocks defined in the template

## Creating a new workspace “from scratch”

![](img/proj-create.png)

Creating a new worksapce for scratch is highly easy for data scientisets as they only interact with existing building blocks.

!!! Note
    The building block can also be created (and then selected) directly  from within the worksapce creation form.

### Selecting an Environment for a new workspace

Selecting an environment for the workspace is a mandatory step. If environments are created for the project, those will be offered to data scientists in the form of a gallery view (see also [Creating a new environment](#xxx)). Each tile shows the tools and as well as the image. When selecting an environment, the command, arguments and environment variables defined in the environment are visible for review. The data scientist can edit (delete or add new) arguments and environment variables that are very specific to his/hers use and that are not part of the common shared environment. In some cases it would even be expected that the data scientist will provide an additional information (for example, values for an environment variables) in order to successfully create the workspace (see also [Create new environment](#xxx)).

![](img/env-var.png)


In the environment you can also decide whether the workspace is preemptable or not (see also create a preemtable worksapce). By default, interactive sessions are limited to use the project’s GPU, meaning that they can only be scheduled (and activated) when there is an available and sufficient GPU quota.  With the following parameter the data scientist can determine whether the workspace is allowed to go over quota with the understanding that it can be preempted if other projects would demand back their quota.

### Selecting a compute resource for a new workspace

Selecting compute resources for the workspace is a mandatory step. If compute resources are created for the project (see also [creating a new compute resource](#xxx)), those will be offered to data scientists in the form of a gallery view. Each tile shows the amount of GPU, CPU and Memory in the request.


![](img/select-cr.png)

### Selecting a data source for a new workspace

Selecting a data source for the workspace is a non-mandatory step. If data sources are created for the project (see also [creating a new compute resource](#xxx)), those will be offered to data scientists in the form of a gallery view. Each tile shows the unique name of the building block and the type of the data source.


## Creating a new workspace from template

Templates ease the way of creating a new workspace in few clicks. In contrast to creating a workspace from scratch (selecting manually which building blocks to use in your workspace), a template aggregates all building blocks under a single entity for data scientists to use for creation of worksapces.

![](img/proj-create.png)


A Template consists of the building blocks and other parameters that are exposed in a workspace creation form. Templates can be fully defined to a point data scientist can select and create the workspace without providing any additional information or partially defined, hence, leaving some degree of freedom in the creation of the workspace via the template. This can help in cases where only part of the configuration is selected in the template and the rest isaxpected to be provided by the user creating a workspace fro the template. 

Few example: 

* A temples can have the value of an environment variable empty for the data scientist to edit later during the workpacwe creation.
* A template can consist of an environment with a tool which requests for a custom URL. This URL field stays empty until the data scientists fills it upon creating the workspace

For collabariotation response, templates are assigned to a specific project and are shared with all project’s members by design (see also [Creating a new template](#xxx)).

## Creating a preemptible workspace

For better experience, workspaces, as they are built for interactive research, are designed to not be preempted (because the researches actively interact with GPU resources). Thus, non-preemptable workspaces can be only scheduled if the project has sufficient vacant quota. However, if that’s not the case (the project does not have a sufficient vacant quota) and the data scientist still need to create and activate a workspace (if cluster resources are available) he/she can allow the workspace to go over quota, thus be scheduled, but with the cost of preemption without prior notice.

![](img/preempt-toggle.png)

