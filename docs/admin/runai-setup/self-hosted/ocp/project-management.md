---
title: Self Hosted installation over OpenShift - Create Projects
---
## Introduction

The Administrator creates Run:ai Projects via the [Run:ai User Interface](../../../../admin-ui-setup/project-setup/#create-a-new-project). When enabling [Researcher Authentication](../../authentication/researcher-authentication.md) you also assign users to Projects.

Run:ai Projects are implemented as Kubernetes namespaces. When creating a new Run:ai Project, Run:ai does the following automatically:

1. Creates a namespace by the name of `runai-<PROJECT-NAME>`.
2. Labels the namespace as _managed by Run:ai_.
3. Provides access to the namespace for Run:ai services.
4. Associates users with the namespace. 

This process may __need to be altered__ if, 

* Researchers already have existing Kubernetes namespaces
* The organization's Kubernetes namespace naming convention does not allow the `runai-` prefix. 
* The organization's policy does not allow the automatic creation of namespaces

## Process

Run:ai allows the __association__ of a Run:ai Project with any existing Kubernetes namespace:

* When [setting up](cluster.md#optional-configuration) a Run:ai cluster, Disable namespace creation by setting the cluster flag `createNamespaces` to `false`.
* Using the Run:ai User Interface, create a new Project `<PROJECT-NAME>`. A namespace will __not__ be created. 
* Associate and existing namepace `<NAMESPACE>` with the Run:ai project by running:

```
oc label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>
```

!!! Caution
    Setting the `createNamespaces` flag to `false` moves the responsibility of creating namespaces to match Run:ai Projects to the administrator. 
<!-- 
## Using Existing Namespaces

By default, creating a Project named `<PROJECT-NAME>` Run:ai will create a Kubernetes namespace named `runai-<PROJECT-NAME>`.  However, organizations with an existing Kubernetes practice may already have existing Kubernetes namespaces where they wish to run machine-learning workloads or their Kubernetes namespace naming convention does not allow the `runai-` prefix. As such, Run:ai allows the __association__ of a Run:ai Project with any existing Kubernetes namespace:

* When [setting up](cluster.md) a Run:ai cluster, Disable namespace creation by setting the flag `createNamespaces` to `false`.
* Using the Run:ai User Interface, create a new Project `<PROJECT-NAME>`
* Assuming an existing namespace `<NAMESPACE>`, associate it with the Run:ai project by running:

```
oc label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>
```


## Limiting Run:ai Access Roles 

When installing Run:ai, you are providing Run:ai with various privileges within the Kubernetes cluster. For a detailed explanation of the Kubernetes roles provided to Run:ai, see the article [Understand the Kubernetes Cluster Access provided to Run:ai](../../config/access-roles.md).

Some organizations prefer to limit the assigning of these roles to Run:ai, per an organizational policy. The two roles related to Project creation and maintenance are:

1. The ability of Run:ai to automatically create Kubernetes namespaces.

2. The ability of Run:ai to assign access to Run:ai Services and set the allowed users. 

## 1. Do not allow Run:ai to create namespaces

* When [setting up Run:ai cluster](cluster.md), Disable namespace creation by setting the flag `createNamespaces` to false.
* Using the Run:ai User Interface, create a new Project `<PROJECT-NAME>`
* Create a namespace `<NAMESPACE>` and associate with Run:ai by running:

```
oc create ns <NAMESPACE> 
oc label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>
```

## 2. Do not allow Run:ai to assign roles 

!!! Important Note
    This option is less recommended due to the resulting high maintenance overhead, as described below. 

* When [setting up Run:ai cluster](cluster.md), Disable assigning of access to Run:ai services by setting the flag `createRoleBindings` to `false`.


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

To add a User to __all projects__ as a Viewer run: 

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

You can update all Project properties via the Run:ai administration user interface, except for Project Users.

 -->
