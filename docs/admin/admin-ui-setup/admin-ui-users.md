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

1. Login to the Users area of the Run:ai User interface at `company-name.run.ai`.
2. On the top right, select "Add New Users".
3. Choose a User name and email.
4. Select Roles. More than one role can be selected. The available roles are:
    * **Administrator**: Can manage Users and install Clusters.
    * **Editor**: Can manage Projects and Departments.
    * **Viewer**: View-only access to the Run:ai User Interface.
    * **Researcher**: Can submit ML workloads. Setting a user as a *Researcher* also requires [assigning the user to projects](../project-setup/#create-a-new-project.md).
    * **Research Manager**: Can act as *Researcher* in all projects, including new ones to be created in the future.
    * **ML Engineer**: Can view and manage deployments and cluster resources. Available only when [Inference module is installed](../workloads/inference-overview.md).
    * **Department Administrator**: Can manage Departments, descendent Projects and Workloads.
5. (Optional) Select Cluster(s). This determines what Clusters are accessible to this User.
6. Press "Save".

You will get the new user credentials and have the option to send the credentials by email.
