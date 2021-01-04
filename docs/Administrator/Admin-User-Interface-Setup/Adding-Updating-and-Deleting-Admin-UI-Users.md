# Adding, Updating, and Deleting Users

## Introduction

The Admin User Interface allows:

*   The setup of Kubernetes GPU Clusters.
*   Create, Update, and Delete Users.
*   Create, Update, and Delete Projects & Departments.
*   Review short term and long term dashboards.
*   Review Node and Job status.

This document is about the Creation, Update, and Deletion of Users.

__Notes:__

*   With Run:AI you need to differentiate between the Users of the Admin UI and Researcher Users which submit workloads on the GPU Kubernetes Cluster. This document is about the former.
*   It is possible to connect the Admin UI Users module to the organization's LDAP directory. For further information please contact Run:AI customer support.

## Working with Users

### Create User

!!! Note
    To be able to manipulate Users, you must have _Administrator_ access. if you do not have such access, please contact an Administrator. The list of Administrators is shown on the Users page (see below)

*  Login to the Users area of the Run:AI Administration User interface at [https://app.run.ai/users](https://app.run.ai/users){target=_blank}.
*  On the top right, select "Add New Users".

![mceclip2.png](img/mceclip2.png)

*   Choose a User name and email. Leave password as blank, it will be set by the User
*   Select Roles. Note -- more than one role can be selected. The available roles are:
    *  __Administrator__: Can manage Users and install Clusters. 
    *  __Editor__: Can manage Projects and Departments.
    * __Viewer__: View-only access to Admin UI.
    * __Researcher__: Can run ML workloads using the Run:AI command-line interface, The Researcher user interface or similar. This setting is relevant only if [Researcher Authentication](../Cluster-Setup/researcher-authentication.md) is enabled (subject to the [adding](../Working-with-Projects/#create-a-new-project.md).

*   Select a Cluster. This determines what Clusters are accessible to this User
*   Press "Save"

The User will receive a join mail and will be able to set a password. 

### Update a User

*   Select an existing User. 
*   Right-click and press "Edit".
*   Update the values and press "Save".

### Delete an existing User

*   Select an existing User. 
*   Right-click and press "Delete".

 
