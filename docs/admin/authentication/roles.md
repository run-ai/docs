  
This article explains the available roles in the Run:ai platform.

A role is a set of permissions that can be assigned to a subject in a scope.

A permission is a set of actions (View, Edit, Create and Delete) over a Run:ai entity (e.g. projects, workloads, users).

## Roles in Run:ai

Run:ai supports the following roles:

| Role | Permissions |
| :---- | :---- |
| Environment administrator | Create, view, edit and delete Environments View Jobs, Workspaces, Dashboards, Data sources, Compute resources and Templates |
| Credentials administrator | Create, view, edit and delete Credentials View Jobs, Workspaces, Dashboards, Data sources, Compute resources, Templates and Environments |
| Data source administrator | Create, view, edit and delete Data sources View Jobs, Workspaces, Dashboards, Environments, Compute resources and Templates |
| Compute resource administrator | Create, view, edit and delete Compute resources View Jobs, Workspaces, Dashboards, Environments, Data sources and Templates |
| System administrator | Controls all aspects of the system This role has global system control and should be limited to a small group of skilled IT administrators |
| Department administrator | Create, view, edit and delete Departments, Projects and Data Volumes (including sharing) Assign Roles (Researcher, ML engineer, Research manager, Viewer) within those departments and projects View dashboards (including the Consumption dashboard) |
| Data Volumes administrator | View Account, Department, Project, Jobs, Workloads, Cluster, Overview dashboard, Consumption dashboard, Analytics dashboard, Policies, Workloads, Workspaces, Trainings, Environments, Compute resources, Templates, Data source, Inferences |
| Editor | View Screens and Dashboards Manage Departments and Projects Create Data Volumes |
| Research manager | Create, view, edit and delete Environments, Data sources, Compute resources, Templates, Data Volumes (including sharing) and Projects View related Jobs, Workspaces and Dashboards |
| L1 researcher | Create, view, edit and delete Jobs, Workspaces, Environments, Data sources, Compute resources, Templates, Data volumes and Deployments View Dashboards |
| ML engineer | Create, edit, view ad delete Deployments View Departments, Projects, Clusters, Node pools, Nodes, Dashboards and Data Volumes |
| Viewer | View Departments, Projects, Respective subordinates (Jobs, Deployments, Workspaces, Environments, Data sources, Compute resources, Templates), Dashboards and Data Volumes A viewer cannot edit Configurations |
| L2 researcher | Create, view, edit, and delete Jobs, Workspaces An L2 researcher cannot create, edit, or delete Environments, Data sources, Compute resources, and Templates View Data Volumes |
| Template administrator | Create, view, edit, and delete Templates View Jobs, Workspaces, Dashboards, Environments, Compute resources, and Data sources |
| Department viewer | View Departments, Projects, assigned subordinates (Jobs, Deployments, Workspaces, Environments, Data sources, Compute resources, Templates),Dashboards and Data Volumes (including sharing) |

!!! Notes
    Keep the following in mind when upgrading from versions 2.13 or earlier:

    * The `Administrator` role became `System Administrator` with full access to all managed objects and scopes  
    * Research Manager is not automatically assigned to all projects, but to projects set by the relevant Administrator when assigning this role to a user, group or app  
    * To preserve backward compatibility, users with the role of Research Manager are assigned to all current projects, but not to new projects  
    * To allow the Department Admin to assign a Researcher role to a user, group or app, the Department Admin must have VECD permissions for jobs and workspaces. This creates a broader span of managed objects  
    * To preserve backward compatibility, users with the role of Editor, are assigned to the same scope they had before the upgrade. However, with new user assignments, the Admin can limit the scope to only part of the organizational scope.

## Roles table

The Roles table can be found under Tools & Settings in the Run:ai platform.

The Roles table displays a list of predefined roles available to users in the Run:ai platform. It is not possible to create additional rules or edit or delete existing rules.



![](img/rolestable.png)


The Roles table consists of the following columns:

| Column | Description |
| :---- | :---- |
| Role | The name of the role |
| Created by | The name of the role creator |
| Creation time | The timestamp when the role was created |

### Customizing the table view

* Filter - Click ADD FILTER, select the column to filter by, and enter the filter values  
* Search - Click SEARCH and type the value to search by  
* Sort - Click each column header to sort by  
* Column selection - Click COLUMNS and select the columns to display in the table  
* Download table - Click MORE and then Click Download as CSV

## Reviewing a role

* **Role name** - The name of the role  
* **Permissions** - Displays the available permissions defining the role, as follows:

| Column | Description |
| :---- | :---- |
| Entity | A system-managed object that can be viewed, edited, created or deleted by a user based on their assigned role and scope |
| View | If checked, an assigned user with this role can view instances of this type of entity within their defined scope |
| Edit | If checked, an assigned user with this role can change the settings of an instance of this type of entity within their defined scope |
| Create | If checked, an assigned user with this role can create new instances of this type of entity within their defined scope |
| Delete | If checked, an assigned user with this role can delete instances of this type of entity within their defined scope |

## Using API
  Go to the [Roles](https://app.run.ai/api/docs#tag/Roles) API reference to view the available actions

