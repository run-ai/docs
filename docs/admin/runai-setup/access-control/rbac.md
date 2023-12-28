# Role based access control

User authorization to system resources and entities is managed using [Role-based access control (RBAC)](https://en.wikipedia.org/wiki/Role-based_access_control){target=_blank}. RBAC is a policy-neutral access control mechanism defined around roles and privileges. The components of RBAC make it simple to manage access to system resources and entities.

## RBAC components

Run:ai uses the following components for RBAC:

### Subjects

A *Subject* is an entity that receives the rule. *Subjects* are:

* Users
* Applications
* Groups (For tenants that use SSO authentication)

### Roles

A role is a group of permissions that can be granted. Permissions are a set of actions that can be applied to entities. Run:ai supports the following roles:

| Role | Description |
| -- | -- |
Environment administrator | Create, view, edit, and delete *Environments*.<br> View *Jobs*, *Workspaces*, *Dashboards*, *Data sources*, *Compute resources*, and *Templates*. |
| Credentials administrator | Create view, edit, and delete *Credentials*.<br> View *Jobs*, *Workspaces*, *Dashboards*, *Data sources*, *Compute resources, *Templates*, and environments. |
| Data source administrator| Create, view, edit, and delete *Data sources*.<br> View *Jobs*, *Workspaces*, *Dashboards*, *Environments*, *Compute resources*, and *Templates*. |
| Compute resource administrator | Create, view, edit, and delete *Compute resources*.<br> View *Jobs*, *Workspaces*, *Dashboards*, *Environments*, *Data sources*, and *Templates*. |
| System administrator | Controls all aspects of the system. This role has global system control and should be limited to a small group of skilled IT administrators. |
| Department administrator | Create, view, edit, and delete: *Departments* and *Projects*.<br>Assign *Roles (Researcher, ML engineer, Research manager, Viewer) within those departments and projects.<br>View *Dashboards* (including the *Consumption dashboard). |
| Editor | View *Screens* and *Dashboards*<br>Manage *Departments* and *Projects*. |
| Research manager | Create, view, edit, and delete: *Environments*, *Data sources*, *Compute resources*, and *Templates*.<br>View *Projects*, related *Jobs* and *Workspaces*, and *Dashboards*. |
| L1 researcher | Create, view, edit, and delete *Jobs*, *Workspaces*, *Environments*, *Data sources*, *Compute resources*, *Templates*.<br>View *Dashboards*.
| ML engineer | Create, edit, view, and delete *Deployments*.<br>View *Departments*, *Projects*, *Clusters*, *Node-pools*, *Nodes*, *Dashboards*. |
| Viewer | View *Departments*, *Projects*, *Respective subordinates* (Jobs, Deployments, Workspaces, Environments, Data sources, Compute resources, Templates), *Dashboards*.<br> A viewer cannot edit *Configurations*. |
| L2 researcher | Create, view, edit, and delete *Jobs*, *Workspaces*.<br>An L2 researcher cannot create, edit, or delete *Environments*, *Data sources*, *Compute resources*, and *Templates*. |
| Template administrator | Create, view, edit, and delete *Templates*.<br>View *Jobs*, *Workspaces*, *Dashboards*, *Environments*, *Compute resources*, and *Data sources*. |
| Department viewer | View *Departments*, *Projects*, assigned subordinates (*Jobs*, *Deployments*, *Workspaces*, *Environments*, *Data sources*, *Compute resources*, *Templates*), and *Dashboards*. |

!!! Note
    Keep the following in mind when upgrading from versions 2.13 or earlier:

    1. *Admin* becomes *System Admin* with full access to all managed objects and scopes.
    2. *Research Manager* is **not** automatically assigned to all projects but to Projects set by the relevant *Admin* when assigning this role to a user, group, or app.
    3. To preserve backward compatibility, users with the role of *Research Manager* are assigned to all current projects, but not to new projects.
    4. To allow the *Department Admin* to assign a *Researcher* role to a user, group, or app, the *Department Admin* must have **VECD** permissions for **Jobs** and **Workspaces**. This creates a broader span of managed objects.
    5. To preserve backward compatibility, users with the role *Editor*, are assigned to the same scope they had before the upgrade. However, with new user assignments, the *Admin* can limit the scope to only part of the organizational scope.
  
### Scope

A *Scope* is an organizational component which accessible based on assigned roles. *Scopes* include:

* Projects
* Departments
* Clusters
* Tenant (all clusters)

### Asset

RBAC uses [rules](#access-rules) to ensure that only authorized users or applications can gain access to system entities. entities that can have RBAC rules applied are:

* Departments
* Projects
* Deployments
* Workspaces
* Environments
* Quota management dashboard
* Training

### RBAC enforcement

RBAC ensures that user have access to system entities based on the rules that are applied to those entities. Should an asset be part of a larger scope of entities to which the user does not have access. The scope shown to the user will appear to be incomplete because the user is able to access **only** the entities to which they are authorized.

## Access rules

An *Access rule* is the assignment of a *Role* to a *Subject* in a *Scope*. *Access rules* are expressed as follows:

`<subject> is a <role> in a <scope>`.

**For example**:  
User **user@domain.com** is a **department admin** in **Department A**.

### Access Rules Table

The *Access Rules* table provides a list of users that have been assigned access to the platform. Use *Add filter* to add one or more filter results based on the columns that are in the table. In the *Contains* pane, you can use partial or complete text. Filtered text is ***not*** case sensitive. To remove the filter, press *X* next to the filter.

The table contains the following columns:

* **Type**&mdash;the type of user (SSO or other).
* **Subject**&mdash;the user id of the user with role assignments.
* **Role**&mdash;the name of the role assigned to the user.
* **Scope**&mdash;the scope to which the user has rights. Press the name of the scope to see the scope and related children.
* **Athorized by**&mdash;the user who granted the access roles.
* **Creation time**&mdash;the timestamp for when the user was created.
* **Last updated**&mdash;the last time the user information was updated.

### Create or delete rules

To create a new access rule:

1. Press the ![Tools and Settings](../../admin-ui-setup/img/tools-and-settings.svg) icon, then *Access rules & Roles*.
2. Choose the *ACCESS RULES* tab, then press *NEW ACCESS RULE*.
3. Select a subject type from the dropdown. Choose from:

      1. **User**&mdash;a user that has been created in the platform, or a known SSO user listed in your IDP. Enter an email address to select a user.
      2. **SSO Group**&mdash;a known group listed in your IDP server.
    !!! Note
        To add SSO users and groups, you must enter a user id, or group id that is recognized by the configured IDP.
      4. **Application**&mdash;an application that has been created in the platform.

4. Select a [Role] from the dropdown.
5. Press the ![Scope](../../../images/scope-icon.svg) icon and select a scope, and press *SAVE RULE* when done.

!!! Note
    You cannot edit access rules. To change an access rules, you need to delete the rule, then create a new rule to replace it. You can also add multiple rules for the same user.

To delete a rule:

1. Press the ![Tools and Settings](../../admin-ui-setup/img/tools-and-settings.svg) icon, then *Roles and Access rules*.
2. Choose *Access rules*, then select a rule and press *Delete*.
