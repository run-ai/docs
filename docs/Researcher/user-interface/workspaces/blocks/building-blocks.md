

# Workspace Building Blocks

A Workspace is built from _building blocks_ called:

1. Environment
2. Data source
3. Compute resource 


The workspace building blocks are a layer that abstracts complex containers and Kubernetes concepts. Run:ai provides tools to simplify the creation of these building blocks. Once created, data scientists need to interact only with the building blocks, without the need to be aware of the technical setup and configuration they abstract 
 
These “building blocks'' consist of everything needed for a workspace to be created & used (See also [Environment introduction](./environments.md), [Compute resource introduction](./compute.md), [Data source introduction](./datasources.md)). 




![](img/bbs.png)




When a data scientist creates a workspace, he/she can choose the building block for their workspace. 
For example, their workspace can be composed of:

* Environment: _Jupyter, Tensor Board & Cuda 11.2_
* Compute resource: _0.5 GPU, 8 cores & 200 [Mb] of CPU memory_
* Data source: _A Git branch with the relevant dataset needed_



![](img/workspace-form.png)



Each building block is created with a scope of relevancy. 
This scope sets to which project a building block is accessible (See also [Create Environment](#xxx),  [Create Compute resource](#xxx), [Create Data source](#xxx)).
When a building block is relevant to a project, the project can view it & use it in its workspaces (the project can not see building blocks that are not in its scope of relevancy). 
The scope of relevancy can be set to be of a specific single project (e.g. “Project A”) or all projects in the tenant (current projects and also any future ones).



![](img/prj.png)

For reasons of context, efficiency, and controlling access, data scientists can view & use only building blocks that are created under projects they are assigned to.

For the creation of building blocks, one option would be that an administrator builds them for data science teams to consume or empower data scientists with the ability to also build. Unless defined otherwise, all data scientists can build building blocks but these are limited to the project they are assigned to.