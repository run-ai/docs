---
title: Self Hosted installation over Kubernetes - Create Projects
---
## Introduction

The Administrator creates Run:ai Projects using via the [Run:ai user interface](../../../../admin-ui-setup/project-setup/#create-a-new-project). When enabling [Researcher Authentication](../../authentication/researcher-authentication.md) you also assign users to Projects.

Run:ai Projects are implemented as Kubernetes namespaces. When creating a new Run:ai Project, Run:ai does the following automatically:

* Creates a namespace by the name of `runai-<PROJECT-NAME>`.
* Labels the namespace as _managed by Run:ai_.
* Provides access to the namespace for Run:ai services.
* Associates users with the namespace. 

This process may __need to be altered__ if 

* Researchers already have existing Kubernetes namespaces
* The organization's Kubernetes namespace naming convention does not allow the `runai-` prefix. 
* The organization's policy does not allow the automatic creation of namespaces

## Process

Run:ai allows the __association__ of a Run:ai Project with any existing Kubernetes namespace:

* When [setting up](cluster.md) a Run:ai cluster, Disable namespace creation by setting the cluster flag `createNamespaces` to `false`.
* Using the Run:ai User Interface, create a new Project `<PROJECT-NAME>`
* Assuming an existing namespace `<NAMESPACE>`, associate it with the Run:ai project by running:

```
kubectl label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>
```

!!! Note
    Setting the `createNamespaces` flag to `false` moves the responsibility of creating namespaces to match Run:ai Projects to the administrator. 
