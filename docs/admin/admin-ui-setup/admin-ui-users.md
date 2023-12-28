---
title: Adding, Updating and Deleting Users
summary: This article describes how to add, update and delete users in the Run:ai platform.
authors:
    - Jason Novich
date: 2023-Dec-28
---

## Introduction

The Run:ai UI allows the creation of Run:ai **local** users. Local users are users that are only in the Run:ai platform. Users are assigned levels of access to all aspects of the UI including submitting jobs on the cluster.

!!! Tip
    It is possible to connect the Run:ai UI to the organization's directory and use single sign-on (SSO). This allows you to set Run:ai roles for users and groups from the organizational directory. For further information see [single sign-on configuration](../runai-setup/authentication/sso.md).

## Working with Users

You can create local users, as well as update and delete local users.

### Create a User

!!! Note

    * To be able to review, add, update and delete users, you must have *System Administrator* access. To upgrade your access, contact a system administrator.
    * When SSO is enabled, users created using the procedure below will be local users only. You cannot create new SSO users. 

To create a new user:

1. Login to the Run:ai UI at `company-name.run.ai`.
2. Press the ![Tools and Settings](img/tools-and-settings.svg) icon, then select *Users*.
3. Press *New user* and enter the user's email address, then press *Create*.
4. Review the new user information and note the temporary password that has been assigned. To send the user an introductory email, select the checkbox.
5. Press *Done* when complete.

## Users Table

The *Users* table displays a list of users who are authorized to login to the Run:ai platform.

!!! Note
    SSO users who have not logged into the Run:ai platform will not appear in the table until they do.

The *Users* table contains informtion about users who have logged into the Run:ai Platform. The table includes columns for:

* **User**&mdash;the email and user ID of the user.
* **Type**&mdash;the type of user (local or SSO).
* **Last login**&mdash;the last time the user logged into the platform.
* **Access rule(s)**&mdash;press *VIEW* to view the access rule(s) assigned to the user.
* **Created by**&mdash;indicates who created the user in the able.
* **Creation time**&mdash;the timestamp for when the user was created.
* **Last updated**&mdash;the last time the user information was updated.

When you press *View* in the *Access rule(s)* column, a pop-up will appear that displays the rules assigned to the user. In the popup are the following columns:

* **Role**&mdash;the name of the role assigned to the user.
* **Scope**&mdash;the scope to which the user has rights.
* **Type**&mdash;the type of user (SSO or other)
* **Group**&mdash;the group to which the user is assigned. (Applies only to SSO users)
* **Athorized by**&mdash;the user who granted the access roles.
* **Creation time**&mdash;the timestamp for when the user was created.
* **Last updated**&mdash;the last time the user information was updated.

## Assigning access rules to users

Once you have created the users you can assign them *Access rules*. This provides the needed authorization to access system assets and resources.

### Roles and permissions

Roles provide a way for administrators to group and identify collections of permissions that administrators assign to [subjects](../runai-setup/access-control/rbac.md#subjects). Permissions define the actions that can be performed on managed entities. The [Roles](../runai-setup/access-control/rbac.md#roles) table shows the default roles and permissions that come with the syste. See [Role based access control](../runai-setup/access-control/rbac.md) for more information.

To add an *Access rule* to a user:

1. Select the user, then press *Access rules*, then press *+Access rule*.
2. Select a *Role* from the dropdown.
3. Press ![Scope](../../images/scope-icon.svg) then select a scope for the user. You can select multiple scopes.
4. After selecting all the required scopes, press *Save rule*.
5. To add another rule, use the *+Access rule*.
6. Press *Done* when all the rules are configured.
