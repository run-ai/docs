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

#### Fixed issues

| Internal ID | Description  |
| ---------------------------- | ---- |
