# Authentication & Authorization


Run:ai Authentication & Authorization enables a streamlined experience for the user with precise controls covering the data each user can see and the actions each user can perform in the Run:ai platform.

Authentication verifies user identity during login, and Authorization assigns the user with specific permissions according to the assigned access rules.

Authenticated access is required to use all aspects of the Run:ai interfaces, including the Run:ai platform, the Run:ai Command Line Interface (CLI) and APIs.

## Authentication

There are multiple methods to authenticate and access Run:ai.

### Single Sign-On (SSO)

Single Sign-On (SSO) is the preferred authentication method by large organizations, as it avoids the need to manage duplicate sets of user identities.

Run:ai offers SSO integration, enabling users to utilize existing organizational credentials to access Run:ai without requiring dedicated credentials.

Run:ai supports three methods to set up SSO:

* [SAML](sso/saml.md) 
* [OpenID Connect (OIDC)](sso/openidconnect.md)  
* [OpenShift](sso/openshift.md)

When using SSO, it is highly recommended to manage at least one local user, as a breakglass account (an emergency account), in case access to SSO is not possible.

### Username and password

Username and password access can be used when SSO integration is not possible.

### Secret key (for Application programmatic access)

Secret is the authentication method for Applications. Applications use the Run:ai APIs to perform automated tasks including scripts and pipelines based on its assigned access rules.

## Authorization

The Run:ai platform uses Role Base Access Control (RBAC) to manage authorization.

Once a user or an application is authenticated, they can perform actions according to their assigned access rules.

### Role Based Access Control (RBAC) in Run:ai

While Kubernetes RBAC is limited to a single cluster, Run:ai expands the scope of Kubernetes RBAC, making it easy for administrators to manage access rules across multiple clusters.

RBAC at Run:ai is configured using access rules.

An access rule is the assignment of a role to a subject in a scope: \<Subject\> is a \<Role\> in a \<Scope\>.

* **Subject**  
  * A user, a group, or an application assigned with the role  
* **Role**  
  * A set of permissions that can be assigned to subjects  
  * A permission is a set of actions (view, edit, create and delete) over a Run:ai entity (e.g. projects, workloads, users)  
    * For example, a role might allow a user to create and read Project, but not update or delete them  
    * Roles at Run:ai are system defined and cannot be created, edited or deleted  
* **Scope**  
  * A set of resources that are accessible to a subject for a specific role  
  * A scope is a part of an organization that can be accessed based on assigned roles. Scopes include Projects, Departments, Clusters, Account (all clusters)

An example of an access rule: **username@company.com** is a **Department admin** in **Department: A**

![](img/auth-rbac.png)


