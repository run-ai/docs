---
title: Self Hosted installation over OpenShift - Create Projects
---

## Introduction

The Administrator creates Run:AI Projects using via the [Administrator user interface](../../../../admin-ui-setup/project-setup/#create-a-new-project). When enabling [Researcher Authentication](../../advanced/researcher-authentication.md) you also assign users to Projects.

Run:AI Projects are implemented as Kubernetes namespaces. When creating a new Run:AI Project, Run:AI automatically does the following:

* Creates the namespace.
* Labels the namespace as _managed by Run:AI_.
* Provides access to the namespace for Run:AI services.
* Associates users with the namespace. 

This process may __need to be altered__ if:

* The organization has an internal naming convention for namespaces. 
* The organization does not allow Run:AI certain privileges which allow the above automation.

The purpose of this document is to explain how to handle these scenarios.


## Using Existing Namespaces

By default, creating a Project named `<PROJECT-NAME>` Run:AI will create a Kubernetes namespace named `runai-<PROJECT-NAME>`.  However, organizations with an existing Kubernetes practice may already have existing Kubernetes namespaces where they wish to run machine-learning workloads or their Kubernetes namespace naming convention does not allow the `runai-` prefix. As such, Run:AI allows the __association__ of a Run:AI Project with any existing Kubernetes namespace:

* When [setting up](cluster.md) a Run:AI cluster, Disable namespace creation by setting the flag `createNamespaces` to `false`.
* Using the Administrator User Interface, create a new Project `<PROJECT-NAME>`
* Assuming an existing namespace `<NAMESPACE>`, associate it with the Run:AI project by running:

```
oc label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>
```


## Limiting Run:AI Access Roles 

When installing Run:AI, you are providing Run:AI with various privileges within the Kubernetes cluster. For a detailed explanation of the Kubernetes roles provided to Run:AI, see the article [Understand the Kubernetes Cluster Access provided to Run:AI](../../advanced/access-roles.md).

Some organizations prefer to limit the assigning of these roles to Run:AI, per an organizational policy. The two roles related to Project creation and maintenance are:

1. The ability of Run:AI to automatically create Kubernetes namespaces.

2. The ability of Run:AI to assign access to Run:AI Services and set the allowed users. 

## 1. Do not allow Run:AI to create namespaces

* When [setting up Run:AI cluster](cluster.md), Disable namespace creation by setting the flag `createNamespaces` to false.
* Using the Administrator User Interface, create a new Project `<PROJECT-NAME>`
* Create a namespace `<NAMESPACE>` and associate with Run:AI by running:

```
oc create ns <NAMESPACE> 
oc label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>
```

## 2. Do not allow Run:AI to assign roles 

!!! Important Note
    This option is less recommended due to the resulting high maintenance overhead, as described below. 

* When [setting up Run:AI cluster](cluster.md), Disable assigning of access to Run:AI services by setting the flag  `createRoleBindings` to `false`.


 When these settings are applied, the administrator must perform additional manual steps as follows:

### Create Roles

Obtain the Project creation template file:

=== "Connected" 
    ```
    wget https://raw.githubusercontent.com/run-ai/docs/master/install/cluster/ocp-project-create.yaml.template
    cp k8s-project-create.yaml.template <NAMESPACE>.yaml
    ```

=== "Airgapped"
    ```
    cp installation-files/cluster/ocp-project-create.yaml.template <NAMESPACE>.yaml
    ```

Edit `<NAMESPACE>.yaml`. Replace `<NAMESPACE>` with the name of the namespace you selected above. Then run:

```
oc apply -f <NAMESPACE>.yaml
```

### Associate Users with the Project 

Users may have 2 roles:

* Viewer - Able to see the Jobs when running `runai list jobs`.
* Executor - Able to submit Jobs, view logs, etc. 

#### User IDs

The following process requires a `<user-id>`. To map the User to its ID, you need to understand what verb OpenShift maps to the user directory (e.g. `sAMAccountName`), then find the Specific User in the directory and look under that verb

#### Viewer Role

To add a User to a __all projects__ as a Viewer run: 

```
oc edit clusterrolebinding runai-job-viewer-manual
```

Under `subjects` add the new User as follows:

``` YAML
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: <user-id>
```

#### Executor Role

To add a User to a Project as an Executor run: 

```
oc edit rolebinding runai-job-executor-manual -n runai-<PROJECT_NAME>
```

Under `subjects` add the new User as follows:


``` YAML
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: <user-id>
```

Additionally, run:

```
oc edit rolebinding runai-cli-index-map-editor -n runai
```

Under `subjects` add the new User as follows:


``` YAML
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: <user-id>
```

!!! Important 
    The command `runai login` does not work in OpenShift environments. To log in, use the OpenShift `oc` command
### Project Update

You can update all Project properties via the Run:AI administration user interface, except for Project Users.


