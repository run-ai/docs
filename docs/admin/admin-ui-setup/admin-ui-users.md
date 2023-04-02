# Adding, Updating and Deleting Users

## Introduction

The Run:ai User Interface allows the creation of Run:ai Users. Run:ai Users can receive varying levels of access to the Administration UI and submit Jobs on the Cluster.

!!! Tip
    It is possible to connect the Run:ai user interface to the organization's directory and use single sign-on. This allows you to set Run:ai roles for users and groups from the organizational directory. For further information see [single sign-on configuration](../runai-setup/authentication/sso.md).

## Working with Users

You can create users, as well as update and delete users.

### Create a User

!!! Note
    To be able to review, add, update and delete users, you must have an *Administrator* access. If you do not have such access, please contact an Administrator.

:octicons-versions-24: Department Admin is available in version 2.10 and later.

1. Login to the Users area of the Run:ai User interface at `company-name.run.ai`.
2. On the top right, select "Add New Users".
3. Choose a User name and email.
4. Select Roles. More than one role can be selected. Available roles are:
    * **Administrator**&mdash;Can manage Users and install Clusters.
    * **Editor**&mdash;Can manage Projects and Departments.
    * **Viewer**&mdash;View-only access to the Run:ai User Interface.
    * **Researcher**&mdash;Can submit ML workloads. Setting a user as a *Researcher* also requires [assigning the user to projects](../project-setup/#create-a-new-project.md).
    * **Research Manager**&mdash;Can act as *Researcher* in all projects, including new ones to be created in the future.
    * **ML Engineer**&mdash;Can view and manage deployments and cluster resources. Available only when [Inference module is installed](../workloads/inference-overview.md).
    * **Department Administrator**&mdash;Can manage Departments, descendent Projects and Workloads.

    For more information, [Roles and permissions](#roles-and-permissions).

5. (Optional) Select Cluster(s). This determines what Clusters are accessible to this User.
6. Press "Save".

You will get the new user credentials and have the option to send the credentials by email.

### Roles and permissions

Roles provide a way to group permissions and assign them to either users or user groups. The role identifies the collection of permissions that administrators assign to users or user groups. Permissions define the actions that users can perform on the managed entities. The following table shows the default roles and permissions.

| Managed Entity   /  Roles | Admin | Dep. Admin | Editor | Research Manager | Researcher | ML Eng. | Viewer |
|:--|:--|:--|:--|:--|:--|:--|:--|
| Assign (Settings) Users/Groups/Apps to Roles | CRUD (all roles) | CRUD (Proj. Researchers and ML Engineers only) | N/A | N/A | N/A | N/A | N/A |
| Assign Users/Groups/Apps to Organizations | R (Projects, Departments) | CRUD (Projects only) | CRUD (Projects, Departments) | N/A | N/A | N/A | N/A |
| Departments | R | R | CRUD | N/A | N/A | R | R |
| Projects | R | CRUD | CRUD | R | R | R | R |
| Jobs | R | R | R | R | CRUD | N/A | R |
| Deployments | R | R | R | N/A | N/A | CRUD | R |
| Workspaces | R | R | R | R | CRUD | N/A | N/A |
| Environments | CRUD | CRUD | CRUD | CRUD | CRUD | N/A | N/A |
| Data Sources | CRUD | CRUD | CRUD | CRUD | CRUD | N/A | N/A |
| Compute Resources | CRUD | CRUD | CRUD | CRUD | CRUD | N/A | N/A |
| Templates | CRUD | CRUD | CRUD | CRUD | CRUD | N/A | N/A |
| Clusters | CRUD | N/A | R | N/A | N/A | R | R |
| Node Pools | CRUD | N/A | R | N/A | N/A | R | R |
| Nodes | R | N/A | R | N/A | N/A | R | R |
| Settings (General, Credentials) | CRUD | N/A | N/A | N/A | N/A | N/A | N/A |
| Events History | R | N/A | N/A | N/A | N/A | N/A | N/A |
| Dashboard.Overview | R | R | R | R | R | R | R |
| Dashboards.Analytics | R | R | R | R | R | R | R |
| Dashboards.Consumption | R | N/A | N/A | N/A | N/A | N/A | N/A |

Permissions:    **C** = Create, **R** = Read, **U** = Update, **D** = Delete
