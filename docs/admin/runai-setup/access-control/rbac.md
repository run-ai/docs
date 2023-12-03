# Role based access control

User authorization to system resources and assets is managed using [Role-based access control (RBAC)](https://en.wikipedia.org/wiki/Role-based_access_control){target=_blank}. RBAC is a policy-neutral access control mechanism defined around roles and privileges. The components of RBAC make it simple to manage access to system resources and assets.

## RBAC components

Run:ai uses the following components for RBAC:

### Subjects

A *Subject* is an entity that receives the rule. *Subjects* are:

* Users
* Applications
* Groups (SSO only)

### Roles

A role is a combination of entities and actions. Run:ai supports the following roles and actions within the user's granted scope:

| Managed Entity | System Admin (1) | Department Admin (4) | Editor (5) | Research Manager |  ML Engineer | Viewer | Researcher L1 | Researcher L2 | Environment Admin | Data Source Admin | Compute Resource Admin | Template Admin | Department Viewer |
|--|--|--|--|--|--|--|--|--|--|--|--|--|--|
| Create local users and applications | VECD | VECD |  |  |  |  |  |  |  |  |  |  |  |  
| Assign Users/Groups/Apps to Roles with scopes (Departments, Projects) | VECD | VECD | VECD |  |    |  |  |  |  |  |  |  |  |
| Roles | VECD | V | V |  |  |  |  |  |  |  |  |  |  |
| Departments | VECD | V (6) | VECD |  | V | V |  |  | V | V | V | V | V |
| Projects | VECD | VECD | VECD | V (2) (3) | V | V | V | VECD | V | V | V | V | V |
| Jobs | VECD | VECD | VECD | V |  | V | VECD | VECD | V | V | V | V | V |
| Deployments | VECD | VECD | V |  | VECD | V |  |  |  |  |  |  | V |
| Workspaces | VECD | VECD | VECD | V | | V | VECD | VECD | V | V | V | V | V |
| Trainings | VECD | VECD | VECD | V | | V | VECD |  | V | V | V | V | V |
| Environments | VECD | VECD | VECD | VECD |   | V | V | V | VECD | V | V | V | V |
| Data Sources | VECD | VECD | VECD | VECD | | V | V | V | V | VECD | V | V | V |
| Compute Resources | VECD | VECD | VECD | VECD |  | V | V | V | V | V | VECD | V | V |
| Templates | VECD | VECD | VECD | VECD | | V | V | V | V | V | V | VECD | V |
| Policies (7) | VECD | VECD | V | V | V | V | V |  | V | V | V | V | V |
| Clusters | VECD | V | V | V | V | V | V |  | V | V | V | V | V |
| Node Pools | VECD | V | V |  | V | V |  |  |  |  |  |  |  |
| Nodes | V | V | V |  | V | V |  |  |  |  |  |  |  |
| Settings.General | VECD |  |  |  |  |  |  |  |  |  |  |  |  |
| Credentials (Settings.Cre...) | VECD | V | V | V | V | V | V |  |  | V |  |  |  |
| Events History | V |  |  |  |  |  |  |  |  |  |  |  |  |
| Dashboards Overview | V | V | V | V |  V | V | V |   | V | V | V | V | V |
| Dashboards Analytics | V | V | V | V | V | V | V |   | V | V | V | V | V |
| Dashboards Consumption | V | V |  |  |  |  | V |   |  |  |  |  |  |

Permissions:     **V** = View, **E** = Edit, **C** = Create, **D** = Delete

!!! Note
    Keep the following in mind when upgrading from versions 2.13 or earlier:

    1. *Admin* becomes *System Admin* with full access to all managed objects and scopes.
    2. *Research Manager* is **not** automatically assigned to all projects but to Projects set by the relevant *Admin* when assigning this role to a user, group, or app.
    3. To preserve backward compatibility, users with the role of *Research Manager* are assigned to all current projects, but not to new projects.
    4. To allow the *Department Admin* to assign a *Researcher* role to a user, group, or app, the *Department Admin* must have **VECD** permissions for **Jobs** and **Workspaces**. This creates a broader span of managed objects.
    5. To preserve backward compatibility, users with the role *Editor*, are assigned to the same scope they had before the upgrade. However, with new user assignments, the *Admin* can limit the scope to only part of the organizational scope.
    6. *Department Admin* permissions for **Departments** remain **Read** as long as there is no hierarchy. Once a hierarchy is introduced, permissions need to change to **VECD** to allow the *Department Admin* to create new Departments under its own department.
    7. Policies are accessible through **Clusters** using YAML files. There is no UI interface, although these policies affect UI elements (for example, Job Forms, Workspaces, Trainings).

### Scope

A *Scope* is an organizational component which accessible based on assigned roles. *Scopes* include:

* Projects
* Departments
* Clusters
* Tenant (all clusters)

### Asset

RBAC uses [rules](#access-rules) to ensure that only authorized users or applications can gain access to system assets. Assets that can have RBAC rules applied are:

* Departments
* Projects
* Deployments
* Workspaces
* Environments
* Quota management dashboard
* Training

### RBAC enforcement

RBAC ensures that user have access to system assets based on the rules that are applied to those assets. Should an asset be part of a larger scope of assets to which the user does not have access. The scope shown to the user will appear to be incomplete because the user is able to access **only** the assets to which they are authorized.

## Access rules

An *Access rule* is the assignment of a *Role* to a *Subject* in a *Scope*. *Access rules* are expressed as follows:

`<subject> is a <role> in a <scope>`.

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
    You cannot edit *Access rules*. To change an *Access rule*, you need to delete the rule, then create a new rule to replace it. You can also add multiple rules for the same user.

To delete a rule:

1. Press the ![Tools and Settings](../../admin-ui-setup/img/tools-and-settings.svg) icon, then *Roles and Access rules*.
2. Choose *Access rules*, then select a rule and press *Delete*.
