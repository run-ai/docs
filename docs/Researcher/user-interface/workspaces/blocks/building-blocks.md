

# Workspace Building Blocks


Workspace building blocks are a layer that abstracts complex containers and Kubernetes concepts and provides __simple__ and __reusable__ tools to quickly allocate resources to the workspace. This way researchers need to interact only with the building blocks, and do not need to be aware of technical setups and configurations.

Workspaces are built from the following building blocks:

1. [Environment](environments.md)
2. [Data source](datasources.md)
3. [Compute resource](compute.md)



![](img/3-bbs.png)

When a workspace is created, the researcher chooses from preconfigured building blocks or can create a new one on the fly. For example, a workspace can be composed of the following blocks:

* Environment: _Jupyter, Tensor Board and Cuda 11.2_
* Compute resource: _0.5 GPU, 8 cores and 200 Megabytes of CPU memory_
* Data source: _A Git branch with the relevant dataset needed_


![](img/4-workspace-form.png)


A building block has a _scope_. The scope links a building block to a specific Run:ai project or to all projects:   

* When a building block scope is a specific project. It can be viewed and used only within the project.
* A building block scope can also be set to _all projects_ (current projects and also any future ones).


![](img/5-prj.png)


Typically, building blocks are created by the administrator and then assigned to a project. You can grant permission to the researchers to create their own building blocks. These building blocks will only be available to the projects that are assigned to the researcher that created them.


## Next Steps

Read about the various building blocks [Environments](environments.md), [Compute Resources](compute.md) and [Data Sources](datasources.md).