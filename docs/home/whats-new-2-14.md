# Run:ai version 2.14

## Version 2.14.0

### Release date

August 2023

#### Release content

This version contains features and fixes from previous versions starting with 2.9. Refer to the prior versions for specific features and fixes. For information about features, functionality, and fixed issues in previous versions see:

* [What's new 2.13](whats-new-2-13.md)
* [What's new 2.12](whats-new-2-12.md)
* [What's new 2.10](whats-new-2-10.md)
<!-- TODO RBAC RUN-7510/9002 and lots of others -->

##### Role based access control

Stating in this version, Run:ai had updated the authorization system to Role Based Access Control (RBAC). RBAC is a policy-neutral access control mechanism defined around roles and privileges. For more information, see [Role based access control](../admin/runai-setup/access-control/rbac.md#role-based-access-control).

When upgrading the system, previous access and authorizations that were configured will be migrated to the new RBAC roles. See the table below for role conversions:

| Previous user type | RBAC role |
| -- | -- |
| Admin | [System admin](../admin/runai-setup/access-control/rbac.md#roles) |
| next one | [next one](../admin/runai-setup/access-control/rbac.md#roles) |

<!-- RUN-8586/RUN-11777 -->
<!-- TODO add RUN-11777 docs to here and to the correct page as there are more config options -->

<!-- RUN-10235/RUN-10485  Support multi service types in the CLI submission -->
* We are pleased to announce new functionality in our CLI that allows the submitting a workload with multiple service types at the same time in a CSV style format. Both the CLI and the UI now provide the same functionality.

<!-- RUN-9808/RUN-9810 Show effective project policy from the UI -->
* We are pleased to announce an enhancement to the Projects table where users now have the ability to view policies from within a project. For more information, see [Projects]().

<!--RUN-9958/RUN-10061 Ephemeral volumes in workspaces -->

<!-- RUN-9868/RUN-10087 support per user scheduling events notifications (slack/email) -->
* We are pleased to announce new functionality where users can now receive notifications from scheduling events. Researchers using Run:ai can now receive notifications via email and is configured so that each user will only get the events relevant to their workloads. For more information, see [email notifications]().

<!-- RUN-10335/RUN-10510 Node port command line -->

<!-- RUN-10575/RUN-10579 Add numeric rules in the policy to GPU memory, CPU memory & CPU -->

<!-- RUN-11421/RUN-11508 Consumption report cost and bugs -->
* We are pleased to announce that we have added an additional table to the Consumption dashboard. This table contains the consumption per department and the cost per department. For more information, see [Consumption dashboard]()

<!-- RUN-8586/RUN-11777 Auto delete completed/failed jobs -->


#### Fixed issues

| Internal ID | Description  |
| ---------------------------- | ---- |
