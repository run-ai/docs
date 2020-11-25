## Introduction

Researchers are submitting workloads via The Run:AI CLI, Kubeflow or similar. To streamline resource allocation and create priorities, Run:AI introduced the concept of __Projects__. Projects are quota entities that associate a Project name with GPU allocation and preferences. 

A researcher submitting a workload needs to associate a Project with a workload request. The Run:AI scheduler will compare the request against the current allocations and the Project and determine whether the workload can be allocated resources or whether it should remain in a pending state.

Administrators manage Projects as detailed [here](Working-with-Projects.md).

At some organizations, Projects may not be enough, this is because:

* There are simply too many individual entities that are attached with a quota.
* There are organizational quotas at a higher level. 


## Departments

__Departments__ create a second hierarchy of resource allocation:

* A Project is associated with a single Department. Multiple Projects can be associated with the same Department.
* A Department, like a Project is associated with a Quota. 
* A Department quota supersedes a Project quota. 

### Overquota behavior

Consider an example from an academic use case: the Computer Science Department and the GeoPhysics Department have each purchased 10 DGXs with 80 GPUs, totaling a cluster of 160 GPUs. The two Departments do not mind sharing GPUs as long as they always get their 80 GPUs when they truly need it. As such, there could be many Projects in the GeoPhysics Department, totaling an allocation of 100 GPUs, but anything above 80 GPUs will be considered by the Run:AI scheduler as over-quota. For more details on over-quota scheduling see: [The Run AI Scheduler](../../Researcher/Scheduling/The-Run-AI-Scheduler.md).

__Important best practice:__ As a rule, the sum of the Department allocation should be equal to the number of GPUs in the cluster.


## Creating and Managing Departments 

### Enable Departments

Departments are disabled by default. To start working with Departments:

* Go to Settings | General
* Enable Departments 

Once Departments are enabled, the menu will have a new item named "Departments".

<img src="../img/department-menu.png" alt="department-menu" width="200"/>


Under __Departments__ there will be a single Department named __default__. All Projects created before the Department feature was enabled will belong to the __default__ Department.


### Adding Departments

You can add new Departments by pressing the __Add New Department__ at the top right of the Department view.

<img src="../img/new-department.png" alt="new-department" width="400"/>

Add Department name and quota allocation.

### Assigning Projects to Departments

Under __Projects__ edit an existing Project, you will see a new __Department__ drop down with which you can associate a Project with a Department.

