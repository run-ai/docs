## Introduction

Researchers submit Jobs. To streamline resource allocation and prioritize work, Run:ai introduces the concept of [Projects](project-setup.md). Projects are the tool to implement resource allocation policies as well as create segregation between different initiatives. A project in most cases represents a team, an individual, or an initiative that shares resources or has a specific resources budget (quota).

A Researcher submitting a Job needs to associate a Project name with the request. The Run:ai scheduler will compare the request against the current allocations and the Project and determine whether the workload can be allocated resources or whether it should remain in the queue for future allocation.

In some organizations, Projects may not be enough, this is because:

* There are simply too many individual entities that are attached to a quota.
* There are organizational quotas at a higher level. 


## Departments

__Departments__ create a secondary hierarchy of resource allocation:

* A Project is associated with a single Department. Multiple Projects can be associated with the same Department.
* A Department, like a Project is associated with a Quota. 
* It is recommended that a Department's quota supersedes the sum of all its associated Projects' quota.

### Node Pools and Quota settings
By default, the Run:ai system associates all nodes with a _Default_ node pool. 
If the `Enable Node Pools` flag is disabled, all GPU and CPU resources are directly associated with the Department's Quotas. Once an Administrator enables the `Enable Node Pools` flag, all GPU and CPU resources will be included in the default node pool and summed up to the Department's overall Quota.

An administrator can create a new node pool and associate nodes with this pool. Any new pool is automatically associated with all Departments and Projects within a cluster, with a GPU and CPU resource Quota of zero. The Administrator can then change the Quota of any node pool resource per Department and Project. The Quota of node pool X within Department Y should be at least the sum of the same node pool X Quota across all associated Projects.

The overall Quota of the Department is the sum of all its associated node pools. 

### Over-quota behavior

Consider an example from an academic use case: the Computer Science Department and the GeoPhysics Department have each purchased 10 nodes with 8 GPUs for each node, totaling a cluster of 160 GPUs for both departments. The two Departments do not mind sharing GPUs as long as they always get their 80 GPUs when they truly need them. As such, there could be many Projects in the GeoPhysics Department, totaling an allocation of 100 GPUs, but anything above 80 GPUs will be considered by the Run:ai scheduler as over-quota. For more details on over-quota scheduling see [the Run:ai Scheduler](../../Researcher/scheduling/the-runai-scheduler.md). In case node pools are enabled, the same rule applies per node pool, i.e. if a job tries to use resources that supersede a node pool Department's quota - it will be considered as Over-Quota.

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

Under __Projects__ edit an existing Project. You will see a new **Department** drop-down with which you can associate a Project with a Department.

