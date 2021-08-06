
## Introduction

Run:AI Projects are implemented as Kubernetes namespaces. When creating a new Run:AI Project, Run:AI needs to be able to:

* Create the namespace and mark the namespace as _managed by Run:AI_.
* Provide access to the namespace for Run:AI services.
* Associate users with the Project. 

By default, these settings are automatically applied when a new Project is [created](../../admin-ui-setup/project-setup/#create-a-new-project) via the Run:AI Administrator user interface. However, 

* Some organizations prefer to use their internal naming convention for Kubernetes namespaces, rather than Run:AI's default `runai-<PROJECT-NAME>` convention.
* When _PodSecurityPolicy_ is enabled, some organizations will not allow Run:AI to automatically create Kubernetes namespaces. As such, there are Cluster installation flags to:
    1. Disable automatic namespace creation and labeling (see the flag `createNamespaces` under [Cluster Installation](cluster.md)).
    2. Disable the assigning of access to Run:AI services (see the flag  `createRoleBindings` under [Cluster Installation](cluster.md)).

 When these settings are applied, the administrator must perform additional manual steps as follows:


## Create a Project

* Create a Project using the Administrator User Interface. See [Create New Project](../../admin-ui-setup/project-setup/#create-a-new-project). 
* When `createRoleBindings` has been set to `true`, assign users to your Project. 
* If set to `false`, users will need to be manually associated with the Project as per the step _Associate Users with the Project_ below.

## Create and Label a Namespace

Run:
```
kubectl create ns <NAMESPACE> 
kubectl label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>
```
Where  `<PROJECT_NAME>` is the name of the project you have created in the Administrator UI above and `<NAMESPACE>` is the name you choose for your namespace (the suggested Run:AI default is `runai-<PROJECT-NAME>`).

## Create Roles

!!! Info
    This step is only relevant when  `createRoleBindings` has been set to `false`.


Obtain the Project creation template file:

=== "Airgapped"
    ```
    cp installation-files/cluster/k8s-project-create.yaml.template <NAMESPACE>.yaml
    ```

=== "Connected" 
    ```
    wget https://raw.githubusercontent.com/run-ai/docs/master/install/cluster/k8s-project-create.yaml.template
    cp k8s-project-create.yaml.template <NAMESPACE>.yaml
    ```

Edit `<NAMESPACE>.yaml`. Replace `<NAMESPACE>` with the name of the namespace you selected above. Then run:

```
kubectl apply -f <NAMESPACE>.yaml
```


## Associate Users with the Project 

!!! Info
    This step is only relevant when  `createRoleBindings` has been set to `false`.

Users may have 2 roles:

* Viewer - Able to see the Jobs when running `runai list jobs`.
* Executor - Able to submit Jobs, view logs, etc. 

### User IDs

The following process requires a `<user-id>`. To map the User to its ID, you need to understand what verb oAuth maps to the user directory (e.g. `sAMAccountName`), then find the Specific User in the directory and look under that verb

### Viewer Role

To add a User to a __all projects__ as a Viewer run: 

```
kubectl edit clusterrolebinding runai-job-viewer-manual
```

Under `subjects` add the new User as follows:

``` YAML
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: <user-id>
```

### Executor Role

To add a User to a Project as an Executor run: 

```
kubectl edit rolebinding runai-job-executor-manual -n runai-<PROJECT_NAME>
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
kubectl edit rolebinding runai-cli-index-map-editor -n runai
```

Under `subjects` add the new User as follows:


``` YAML
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: <user-id>
```

## Project Update

You can update all Project properties via the Run:AI administration user interface, except for Project Users.
