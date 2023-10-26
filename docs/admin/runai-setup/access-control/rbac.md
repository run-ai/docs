# Role based access control

User authorization to system resources and assets is managed using [Role-based access control(RBAC)](https://en.wikipedia.org/wiki/Role-based_access_control){target=_blank}. RBAC is a policy-neutral access control mechanism defined around roles and privileges. The components of RBAC make it simple to manage access to system resources and assets.

## RBAC components

Run:ai uses the following components for RBAC:

### Subjects

A *Subject* is an entity that receives the rule. *Subjects* are:

* Users
* Applications
* Groups (SSO only)

### Roles

A role is a combination of entities and actions. The role defines which set of actions (Create, Read, Update, Delete - CRUD) are permitted on the platform entities. Run:ai supports several predefined roles.


| Managed Entity                                                        | System Admin (1) | Department Admin (4) | Editor (5) | Research Manager | Researcher | ML Eng. | Viewer | Researcher L1 | Researcher L2 | Environments Admin | Data Sources Admin | Compute Resources Admin | Templates Admin | Department Viewer |
|-----------------------------------------------------------------------|------------------|----------------------|------------|------------------|------------|---------|--------|---------------|---------------|--------------------|--------------------|-------------------------|-----------------|-------------------|
| Create local users and applications                                   | CRUD             | CRUD                 |            |                  |            |         |        |               |               |                    |                    |                         |                 |                   |
| Assign Users/Groups/Apps to Roles with scopes (Departments, Projects) | CRUD             | CRUD                 | CRUD       |                  |            |         |        |               |               |                    |                    |                         |                 |                   |
| Roles                                                                 | CRUD             | R                    | R          |                  |            |         |        |               |               |                    |                    |                         |                 |                   |
| Departments                                                           | CRUD             | R (6)                | CRUD       |                  |            | R       | R      |               |               | R                  | R                  | R                       | R               | R                 |
| Projects                                                              | CRUD             | CRUD                 | CRUD       | R (2) (3)        | R          | R       | R      | R             | CRUD          | R                  | R                  | R                       | R               | R                 |
| Jobs                                                                  | CRUD             | CRUD                 | CRUD       | R                | CRUD       |         | R      | CRUD          | CRUD          | R                  | R                  | R                       | R               | R                 |
| Deployments                                                           | CRUD             | CRUD                 | R          |                  |            | CRUD    | R      |               |               |                    |                    |                         |                 | R                 |
| Workspaces                                                            | CRUD             | CRUD                 | CRUD       | R                | CRUD       |         | R      | CRUD          | CRUD          | R                  | R                  | R                       | R               | R                 |
| Trainings                                                             | CRUD             | CRUD                 | CRUD       | R                | CRUD       |         | R      | CRUD          |               | R                  | R                  | R                       | R               | R                 |
| Environments                                                          | CRUD             | CRUD                 | CRUD       | CRUD             | CRUD       |         | R      | R             | R             | CRUD               | R                  | R                       | R               | R                 |
| Data Sources                                                          | CRUD             | CRUD                 | CRUD       | CRUD             | CRUD       |         | R      | R             | R             | R                  | CRUD               | R                       | R               | R                 |
| Compute Resources                                                     | CRUD             | CRUD                 | CRUD       | CRUD             | CRUD       |         | R      | R             | R             | R                  | R                  | CRUD                    | R               | R                 |
| Templates                                                             | CRUD             | CRUD                 | CRUD       | CRUD             | CRUD       |         | R      | R             | R             | R                  | R                  | R                       | CRUD            | R                 |
| Policies (7)                                                          | CRUD             | CRUD                 | R          | R                | R          | R       | R      | R             |               | R                  | R                  | R                       | R               | R                 |
| Clusters                                                              | CRUD             | R                    | R          | R                | R          | R       | R      | R             |               | R                  | R                  | R                       | R               | R                 |
| Node Pools                                                            | CRUD             | R                    | R          |                  |            | R       | R      |               |               |                    |                    |                         |                 |                   |
| Nodes                                                                 | R                | R                    | R          |                  |            | R       | R      |               |               |                    |                    |                         |                 |                   |
| Settings.General                                                      | CRUD             |                      |            |                  |            |         |        |               |               |                    |                    |                         |                 |                   |
| Credentials (Settings.Cre...)                                         | CRUD             | R                    | R          | R                | R          | R       | R      | R             |               |                    | R                  |                         |                 |                   |
| Events History                                                        | R                |                      |            |                  |            |         |        |               |               |                    |                    |                         |                 |                   |
| Dashboard.Overview                                                    | R                | R                    | R          | R                | R          | R       | R      | R             | R             | R                  | R                  | R                       | R               | R                 |
| Dashboards.Analytics                                                  | R                | R                    | R          | R                | R          | R       | R      | R             | R             | R                  | R                  | R                       | R               | R                 |
| Dashboards.Consumption                                                | R                | R                    |            |                  |            |         |        | R             | R             |                    |                    |                         |                 |                   |

Permissions:    **C** = Create, **R** = Read, **U** = Update, **D** = Delete

Entities&mdash;granular parts of the pltform that can be controled separately. 


!!!Note
<!-- These notes refer to behavior changes, which is good, but they do not give the context. The context should be general enough so it is valid also if a customer upgrades from a version earlier than 2.14 to any future version. Something like: When upgrading Run:ai control plane from version 2.13 or earlier to version 2.14 or later. Currently the context is missing -->

    1. *Admin* becomes *System Admin* with full access to all managed objects and scopes.
    2. *Research Manager* is **not** automatically assigned to all projects but to Projects set by the relevant *Admin* when assigning this role to a user, group, or app.
    3. To preserve backward compatibility, users with the role of *Research Manager* are assigned to all current projects, but not to new projects.
    4. To allow the *Department Admin* to assign a *Researcher* role to a user, group, or app, the *Department Admin* must have **CRUD** permissions for **Jobs** and **Workspaces**. This creates a broader span of managed objects.
    5. To preserve backward compatibility, users with the role *Editor*, are assigned to the same scope they had before the upgrade. However, with new user assignments, the *Admin* can limit the scope to only part of the organizational scope.
    6. *Department Admin* permissions for **Departments** remain **Read** as long as there is no hierarchy. Once a hierarchy is introduced, permissions need to change to **CRUD** to allow the *Department Admin* to create new Departments under its own department.
    7. Policies are accessible through **Clusters** using YAML files. There is no UI interface, although these policies affect UI elements (for example, Job Forms, Workspaces, Trainings).

### Scope

A *Scope* is an organizational component which accessible based on assigned roles. *Scopes* include:

* Projects
* Departments
* Clusters
* Tenant (all clusters)



### RBAC enforcement

RBAC ensures that user have access to system assets based on the access rules that are applied to those assets. <!-- Not sure I understand the sentense that start after this comment and the reason it was added. What is the point we are trying to make or action that we expect the user to take? --> Should an asset be part of a larger scope of assets to which the user does not have access. The scope shown to the user will appear to be incomplete because the user is able to access **only** the assets to which they are authorized.
<!-- we should add (around here) how to create users ang groups - local user & sso user. As local users need to be created and all the rest just need access rules. In addition we need an explanation of which users are shown in the user grid and under which conndition -->
## Access rules

An *Access rule* is the assignment of a *Role* to a *Subject* in a *Scope*. *Access rules* are expressed as follows:

`<subject> is a <role> in a <scope>`.
<!-- it is important to state that a single subject can have multiple access rules and that the overall permissions of this subject are derived from the sum of all its access rules. A little stating the obvious, but important -->

**For example**:  
User **user@domain.com** is a **department admin** in **Department A**.

### Create or delete rules

To create a new access rule:

1. Press the ![Tools and Settings](../../admin-ui-setup/img/tools-and-settings.svg) icon, then *Roles and Access rules*.
2. Choose *Access rules*, then *New access rule*.
3. Select a user type from the dropdown.
4. Select a role from the dropdown.
5. Press the ![Scope](../../../images/scope-icon.svg) icon and select a scope, and press *Save rule* when done.

!!! Note
    You cannot edit *Access rules*. To change an *Access rule*, you need to delete the rule, create a new rule to replace it. You can also add multiple rules for the same user.

To delete a rule:

1. Press the ![Tools and Settings](../../admin-ui-setup/img/tools-and-settings.svg) icon, then *Roles and Access rules*.
2. Choose *Access rules*, then select a rule and press *Delete*.
