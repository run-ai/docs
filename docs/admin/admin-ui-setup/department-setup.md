# Introduction

Researchers submit Jobs. To streamline resource allocation and prioritize work, Run:ai introduces the concept of [Projects](project-setup.md). Projects are the tool to implement resource allocation policies as well as create segregation between different initiatives. A project in most cases represents a team, an individual, or an initiative that shares resources or has a specific resources budget (quota).

A Researcher submitting a Job needs to associate a Project name with the request. The Run:ai scheduler will compare the request against the current allocations and the Project and determine whether the workload can be allocated resources or whether it should remain in the queue for future allocation.

In some organizations, Projects may not be enough, this is because:

* There are simply too many individual entities that are attached to a quota.
* There are organizational quotas at a higher level.

## Departments

**Departments** create a secondary hierarchy of resource allocation:

* A Project is associated with a single Department. Multiple Projects can be associated with the same Department.
* A Department, like a Project is associated with a Quota. 
* It is recommended that a Department's quota supersedes the sum of all its associated Projects' quota.

### Node Pools and Quota settings

For detailed information on node pools, see [Using node pools](../../Researcher/scheduling/using-node-pools.md).

By default, all nodes in a cluster are part of the `Default` node pool. The administrator can choose to create new node pools and include a set of nodes in a node pool by associating the nodes with a label.

If the node pools feature is disabled, all GPU and CPU resources are directly associated with the Department's Quota. 

Once an Administrator enables node pools, all GPU and CPU resources will be included in the `Default` node pool and summed up to the Department's overall Quotas.

An administrator can create a new node pool and associate nodes into this pool. Any new pool is automatically associated with all Departments and Projects within a cluster, with a GPU and CPU resource Quota of zero. The Administrator can then change the Quota of any node-pool resource per Department and Project. The Quota of node-pool X within Department Y should be at least the sum of the same node-pool X Quota across all associated Projects. This means an administrator should carefully plan the resource Quota allocation from the Department to its descendent Projects.
The overall Quota of the Department is the sum of all its associated node pools. 

### Over-quota behavior

Consider an example from an academic use case: the Computer Science Department and the GeoPhysics Department have each purchased 10 nodes with 8 GPUs for each node, totaling a cluster of 160 GPUs for both departments. The two Departments do not mind sharing GPUs as long as they always get their 80 GPUs when they truly need them. As such, there could be many Projects in the GeoPhysics Department, totaling an allocation of 100 GPUs, but anything above 80 GPUs will be considered by the Run:ai scheduler as over-quota. For more details on over-quota scheduling see [the Run:ai Scheduler](../../Researcher/scheduling/the-runai-scheduler.md). In case node pools are enabled, the same rule applies per node pool, i.e. if a job tries to use resources that supersede a node pool Department's quota - it will be considered as Over-Quota.

!!! Important
    Best practice: As a rule, the sum of the Departments' Quota allocations should be equal to the number of GPUs in the cluster.

## Creating and Managing Departments

### Enable Departments

Departments are disabled by default. To start working with Departments:

* Go to Settings | General
* Enable Departments

Once Departments are enabled, the left-side menu will have a new item named "Departments".

Under **Departments** there will be a single Department named **default**. All Projects created before the Department feature was enabled will belong to the **default** Department.

### Adding Departments

You can add new Departments by pressing the **Add New Department** at the top right of the Department view. Add Department name and quota allocation.

### Assign Department Administrator role

You can create a new user with the *Department Administrator* role, or add the role to existing users.
To create a new user with this role, see [Create a user](admin-ui-users.md#create-a-user).
To add this role to an existing user:

1. Go to `Settings | Users`.
2. Select a user from the list and then press `Edit User`.
3. Select the `Department Admin` role from the list. (Deselect to remove the role from the user).

After you have created the user with the Department Administrator role, you will need to assign the user to the correct department.

To assign the Department Administrator user to the correct department:

1. Go to `Settings | Departments`.
2. Select a department from the list, then press `Edit`. If you do not have a department, you will need to create one. See [creating a new depart,emt](#adding-departments).
3. Select `Department Administrator`, then select `Users` or `Applications`.
4. If you selected `Users`, select one or more users from the drop down menu.
5. Press save when complete.


### Assigning Projects to Departments

Under **Projects** edit an existing Project. You will see a new **Department** drop-down with which you can associate a Project with a Department.
