

# Workspace Building Blocks


Workspace building blocks are a layer that abstract complex containers and Kubernetes concepts and provide simple tools to quickly allocate resources to the workspace. This way researchers need to interact only with the building blocks, and do not need to be aware of technical setups and configurations.

These “building blocks'' consist of everything needed for a workspace to be created and used (See also [Environment introduction](./environments.md), [Compute resource introduction](./compute.md), [Data source introduction](./datasources.md)). 

Workspaces are built from the following building blocks:

1. Environment
2. Data source
3. Compute resource



![](img/bbs.png)


When a workspace is created, the researcher can choose from preconfigured building blocks.

For example, aworkspace can be composed of the following:

* Environment: _Jupyter, Tensor Board and Cude 11.2_
* Compute resource: _0.5 GPU, 8 cores and 200 [Mb] of CPU memory_
* Data source: _A Git branch with the relevant dataset needed_



![](img/workspace-form.png)



Each building block is created with a scope of relevancy. 
This scope sets to which project a building block is accessible (See also [Create Environment](#xxx),  [Create Compute resource](#xxx), [Create Data source](#xxx)).
When a building block is relevant to a project, the project can view it & use it in its workspaces (the project can not see building blocks that are not in its scope of relevancy). 
The scope of relevancy can be set to be of a specific single project (e.g. “Project A”) or all projects in the tenant (current projects and also any future ones).



![](img/prj.png)

Data scientists can view and use only building blocks that are created under projects they are assigned to.

Typically, building blocks are created by the administrator and then assigned to a project. You can grant permissions to the researchers to create their own building blocks. These building blocks will only be available to the projects that are assigned to the researcher that created them.