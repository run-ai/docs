---
title: Self Hosted installation over Kubernetes - Create Projects
---
## Introduction

The Administrator creates Run:ai Projects via the [Run:ai user interface](../../../admin-ui-setup/project-setup.md#create-a-project). When enabling [Researcher Authentication](../../authentication/researcher-authentication.md) you also assign users to Projects.

Run:ai Projects are implemented as Kubernetes namespaces. When creating a new Run:ai Project, Run:ai does the following automatically:

1. Creates a namespace by the name of `runai-<PROJECT-NAME>`.
2. Labels the namespace as *managed by Run:ai*.
3. Provides access to the namespace for Run:ai services.
4. Associates users with the namespace.

This process may **need to be altered** if,

* Researchers already have existing Kubernetes namespaces
* The organization's Kubernetes namespace naming convention does not allow the `runai-` prefix.
* The organization's policy does not allow the automatic creation of namespaces.

## Process

Run:ai allows the **association** of a Run:ai Project with any existing Kubernetes namespace:

* When [setting up](cluster.md#customize-installation) a Run:ai cluster, Disable namespace creation by setting the cluster flag `createNamespaces` to `false`.
* Using the Run:ai User Interface, create a new Project `<PROJECT-NAME>`. A namespace will **not** be created.
* Associate and existing namepace `<NAMESPACE>` with the Run:ai project by running:

```
kubectl label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>
```

!!! Caution
    Setting the `createNamespaces` flag to `false` moves the responsibility of creating namespaces to match Run:ai Projects to the administrator.
