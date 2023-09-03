# Run:ai version 2.14

## Version 2.14.0

### Release date

August 2023

#### Release content

This version contains features and fixes from previous versions. Refer to the prior versions for specific features and fixes. For information about features, functionality, and fixed issues in previous versions see:

* [What's new 2.13](whats-new-2-13.md)
* [What's new 2.12](whats-new-2-12.md)
* [What's new 2.10](whats-new-2-10.md)

##### Role based access control
<!-- RUN-7510/9002 and lots of others -->
Stating in this version, Run:ai had updated the authorization system to Role Based Access Control (RBAC). RBAC is a policy-neutral access control mechanism defined around roles and privileges. For more information, see [Role based access control](../admin/runai-setup/access-control/rbac.md#role-based-access-control).

<!-- When upgrading the system, previous access and authorizations that were configured will be migrated to the new RBAC roles. See the table below for role conversions:

TODO Add RBAC old--new conversion table here. -->

##### Auto delete jobs
<!-- RUN-8586/RUN-11777 -->
* We are pleased to announce new functionality in our UI and CLI that provides configuration options which automatically delete jobs after a specified amount of time. Auto-deletion provides more efficient use of resources and makes it easier for researchers to manage their jobs. For more configuration options in the UI, see Auto deletion (Step 9) in [Create a new workspace](../Researcher/user-interface/workspaces/create/workspace-v2.md#create-a-new-workspace). For more information on the CLI flag, see [--auto-deletion-time-after-completion](../Researcher/cli-reference/runai-submit.md).

##### Multiple service types
<!-- RUN-10235/RUN-10485  Support multi service types in the CLI submission -->
* We are pleased to announce new functionality in our CLI that allows submitting a workload with multiple service types at the same time in a CSV style format. Both the CLI and the UI now provide the same functionality. For more information see [runai submit](../Researcher/cli-reference/runai-submit.md).

<!-- RUN-9808/RUN-9810 Show effective project policy from the UI 
* We are pleased to announce an enhancement to the Projects table where users now have the ability to view policies from within a project. For more information, see [Projects](). -->

##### Ephemeral volumes
<!--RUN-9958/RUN-10061 Ephemeral volumes in workspaces -->
* We are pleased to announce support for Ephemeral volumes in *Workspaces*. Ephemeral storage is tied to the lifecycle of the *Workspace*. It’s temporary storage that gets wiped out and lost when the workspace is deleted. Ephemeral storage is added to the *Workspace* configuration form in the *Volume* pane. For configuration information, see step 7 in [Create a new workspace](../Researcher/user-interface/workspaces/create/.workspace-v2.md#create-a-new-workspace).

##### Email notifications
<!-- RUN-9868/RUN-10087 support per user scheduling events notifications (slack/email) -->
* We are pleased to announce new functionality where users can now receive notifications from scheduling events. Researchers using Run:ai can now receive notifications via email and is configured so that each user will only get the events relevant to their workloads. For more information, see [email notifications](../admin/researcher-setup/email-messaging.md#email-notifications).

##### CLI improvements
<!-- RUN-10335/RUN-10510 Node port command line -->
* We are pleased to announce improved functionality in the `runai submit` command which now clarifies the port for the container using the `nodeport` flag. For more information, see `runai submit`, [--service-type](../Researcher/cli-reference/runai-submit.md#s----service-type-string) `nodeport`.

##### Policy improvements
<!-- RUN-10575/RUN-10579 Add numeric rules in the policy to GPU memory, CPU memory & CPU -->
* We are pleased to announce increased flexibility when creating policies. The improved flexibility includes the abililty to allocate a `min` and a `max` value for CPU and GPU memory. For configuration information, see [GPU and CPU memory limits](../admin/workloads/policies.md#gpu-and-cpu-memory-limits) in *Configuring policies*.

##### Resource costing
<!-- RUN-11421/RUN-11508 Consumption report cost and bugs -->
* We are pleased to announce that we have added an additional table to the Consumption dashboard. This table contains the consumption per department and the cost per department. For more information, see [Consumption dashboard](../admin/admin-ui-setup/dashboard-analysis.md#consumption-dashboard).

#### Fixed issues

| Internal ID | Description  |
| ---------------------------- | ---- |
