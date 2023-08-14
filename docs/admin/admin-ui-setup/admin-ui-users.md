# Adding, Updating and Deleting Users

## Introduction

The Run:ai UI allows the creation of Run:ai Users. Users are assigned levels of access to the to all aspects of the UI including submitting jobs on the cluster.

!!! Tip
    It is possible to connect the Run:ai UI to the organization's directory and use single sign-on (SSO). This allows you to set Run:ai roles for users and groups from the organizational directory. For further information see [single sign-on configuration](../runai-setup/authentication/sso.md).

## Working with Users

You can create users, as well as update and delete users.

### Create a User

!!! Note
    To be able to review, add, update and delete users, you must have *System Administrator* access. To upgrade your access, contact a system administrator.

To create a new user:

1. Login to the Run:ai UI at `company-name.run.ai`.
2. Press the ![Tools and Settings](img/tools-and-settings.svg) icon, then select *Users*.
3. Press *New user* and enter the user's email address, then press *Create*.
4. Review the new user information and note the temporary password that has been assigned. You can opt to send the user an introductory email by selecting the checkbox.
5. When complete, press *Done*.

## Assigning access rules to users

Once you have created the users you can assign them *Access rules*. This provides the needed authorization to access system assets and resources.

To add an *Access rule* to a user:

1. Select the user, then press *Access rules*, then press *+Access rule*.
2. From the dropdown, select a *Role*.
3. Press on the ![Scope](../../images/scope-icon.svg) and select a scope for the user.
4. After selecting all the required scopes, press *Save rule*.
5. If you want to add another rule, use the *+Access rule*.
6. When all the rules are configured, press *Done*.

### Roles and permissions

Roles provide a way to group permissions and assign them to either users or user groups. The role identifies the collection of permissions that administrators assign to users or user groups. Permissions define the actions that users can perform on the managed entities. The following table shows the default roles and permissions. For more information on roles, see [Role based access control](../runai-setup/access-control/rbac.md).
