## Introduction

Researchers submit Jobs. To streamline resource allocation and prioritize work, Run:ai introduces the concept of [Projects](project-setup.md). Projects are the tool to implement resource allocation policies as well as create segregation between different initiatives. A project in most cases represents a team, an individual, or an initiative that shares resources or has a specific resources budget (quota).

A Researcher submitting a Job needs to associate a Project name with the request. The Run:ai scheduler will compare the request against the current allocations and the Project and determine whether the workload can be allocated resources or whether it should remain in the queue for future allocation.

In some organizations, Projects may not be enough, this is because:

* There are simply too many individual entities that are attached with a quota.
* There are organizational quotas at a higher level. 


## Departments

__Departments__ create a secondary hierarchy of resource allocation:

* A Project is associated with a single Department. Multiple Projects can be associated with the same Department.
* A Department, like a Project is associated with a Quota. 
* A Department quota supersedes a Project quota. 

### Overquota behavior

Consider an example from an academic use case: the Computer Science Department and the GeoPhysics Department have each purchased 10 DGXs with 80 GPUs, totaling a cluster of 160 GPUs. The two Departments do not mind sharing GPUs as long as they always get their 80 GPUs when they truly need them. As such, there could be many Projects in the GeoPhysics Department, totaling an allocation of 100 GPUs, but anything above 80 GPUs will be considered by the Run:ai scheduler as over-quota. For more details on over-quota scheduling see: [The Run AI Scheduler](../../Researcher/scheduling/the-runai-scheduler.md).

__Important best practice:__ As a rule, the sum of the Department allocation should be equal to the number of GPUs in the cluster.


## Creating and Managing Departments 

### Enable Departments

Departments are disabled by default. To start working with Departments:

* Go to Settings | General
* Enable Departments 

Once Departments are enabled, the left-side menu will have a new item named "Departments".


Under __Departments__ there will be a single Department named __default__. All Projects created before the Department feature was enabled will belong to the __default__ Department.


### Adding Departments

You can add new Departments by pressing the __Add New Department__ at the top right of the Department view. Add Department name and quota allocation.

### Assigning Projects to Departments

Under __Projects__ edit an existing Project, you will see a new __Department__ drop down with which you can associate a Project with a Department.

