# Run:ai version 2.14 - September, 18, 2023

## Release content

### Role based access control
<!-- RUN-7510/9002 and lots of others -->
Stating in this version, Run:ai had updated the authorization system to Role Based Access Control (RBAC). RBAC is a policy-neutral access control mechanism defined around roles and privileges. For more information, see [Role based access control](../admin/runai-setup/access-control/rbac.md#role-based-access-control).

<!-- When upgrading the system, previous access and authorizations that were configured will be migrated to the new RBAC roles. See the table below for role conversions:

TODO Add RBAC old--new conversion table here. -->

### Auto delete jobs
<!-- RUN-8586/RUN-11777 -->
* We are pleased to announce new functionality in our UI and CLI that provides configuration options which automatically delete jobs after a specified amount of time. Auto-deletion provides more efficient use of resources and makes it easier for researchers to manage their jobs. For more configuration options in the UI, see *Auto deletion* (Step 9) in [Create a new workspace](../Researcher/user-interface/workspaces/create/workspace-v2.md#create-a-new-workspace). For more information on the CLI flag, see [--auto-deletion-time-after-completion](../Researcher/cli-reference/runai-submit.md).

### Multiple service types
<!-- RUN-10235/RUN-10485  Support multi service types in the CLI submission -->
* We are pleased to announce new functionality in our CLI that allows submitting a workload with multiple service types at the same time in a CSV style format. Both the CLI and the UI now provide the same functionality. For more information see [runai submit](../Researcher/cli-reference/runai-submit.md).

<!-- RUN-9808/RUN-9810 Show effective project policy from the UI 
* We are pleased to announce an enhancement to the Projects table where users now have the ability to view policies from within a project. For more information, see [Projects](). -->

### Ephemeral volumes
<!--RUN-9958/RUN-10061 Ephemeral volumes in workspaces -->
* We are pleased to announce support for Ephemeral volumes in *Workspaces*. Ephemeral storage is tied to the lifecycle of the *Workspace*. It’s temporary storage that gets wiped out and lost when the workspace is deleted. Ephemeral storage is added to the *Workspace* configuration form in the *Volume* pane. For configuration information, see step 7 in [Create a new workspace](../Researcher/user-interface/workspaces/create/.workspace-v2.md#create-a-new-workspace).

### Email notifications
<!-- RUN-9868/RUN-10087 support per user scheduling events notifications (slack/email) -->
* We are pleased to announce new functionality where users can now receive notifications from scheduling events. Researchers using Run:ai can now receive notifications via email and is configured so that each user will only get the events relevant to their workloads. For more information, see [email notifications](../admin/researcher-setup/email-messaging.md#email-notifications).

### CLI improvements
<!-- RUN-10335/RUN-10510 Node port command line -->
* We are pleased to announce improved functionality in the `runai submit` command which now clarifies the port for the container using the `nodeport` flag. For more information, see `runai submit`, [--service-type](../Researcher/cli-reference/runai-submit.md#s----service-type-string) `nodeport`.

### Policy improvements
<!-- RUN-10575/RUN-10579 Add numeric rules in the policy to GPU memory, CPU memory & CPU -->
* We are pleased to announce increased flexibility when creating policies. The improved flexibility includes the ability to allocate a `min` and a `max` value for CPU and GPU memory. For configuration information, see [GPU and CPU memory limits](../admin/workloads/policies.md#gpu-and-cpu-memory-limits) in *Configuring policies*.

### Resource costing
<!-- RUN-11421/RUN-11508 Consumption report cost and bugs -->
* We are pleased to announce that we have added an additional table to the Consumption dashboard. This table contains the consumption per department and the cost per department. For more information, see [Consumption dashboard](../admin/admin-ui-setup/dashboard-analysis.md#consumption-dashboard).

### Deployment improvements
<!-- RUN-11563/RUN-11564 MPS and tolerance -->
* We are pleased to announce improvements to the deployment form which now include support for and *Multi-Process Service (MPS)*. *MPS* is a service which allows the running of parallel processes on the same GPU, which are all run by the same userid. To enable *MPS* support, move the selector switch on the *Deployments* form.

!!! Note
    If you do not use the same userid, the processes will run in serial and could possibly degrade performance.

* We are pleased to announce improvements to the deployment form which now include support for *Tolerations*. *Tolerations* guide the system to which node each pod can be
     scheduled to or evicted by matching between rules and taints defined for each Kubernetes node.

<!-- Configuration procedure added here because the deployments page has no procedure on it. -->  
To configure *Tolerations*:

1. In the left pane menu, press *Deployments*, then press *New deployment*.
2. Complete the required fields in the form, then press *Container definition*.
3. To configure *Tolerations*:

    1. In the *Tolerations* pane, press *Add*.
    2. Enter the *Key* and select and option from the *Operator* drop down.
    3. Select an *Effect* from the drop down.
    4. Enter a *Value* and *Toleration seconds* (optional).

4. When your form is complete press *Deploy*.

### Fixed issues

| Internal ID | Description  |
| ---------------------------- | ---- |
