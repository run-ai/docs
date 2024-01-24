---
title: Policies
summary: This article contains details about Policies in the Run:ai platform.
authors:
    - Jason Novich
date: 2023-Dec-12
---

## Introduction

*Policies* allow administrators to impose restrictions and set default values for researcher workloads. Restrictions and default values can be placed on CPUs, GPUs, and other resources or entities. Enabling the *New Policy Manager* provides information about resources that are non-compliant to applied policies. Resources that are non-compliant will appear greyed out. To see how a resource is not compliant, press on the clipboard icon in the upper right hand corner of the resource.

!!! Note
    Policies from Run:ai versions 2.15 or lower will still work after enabling the *New Policy Manager*. However, showing non-compliant policy rules will not be available. For more information about policies for version 2.15 or lower, see [What are Policies](policies.md#what-are-policies).

For example, an administrator can create and apply a policy that will restrict researchers from requesting more than 2 GPUs, or less than 1GB of memory per type of workload.

Another example is an administrator who wants to set different amounts of CPU, GPUs and memory for different kinds of workloads. A training workload can have a default of 1 GB of memory, or an interactive workload can have a default amount of GPUs.

Policies are created for each Run:ai project (Kubernetes namespace). When a policy is created in the `runai` namespace, it will take effect when there is no project-specific policy for the workloads of the same kind.

In interactive workloads or workspaces, applied policies will only allow researchers access to resources that are permitted in the policy. This can include compute resources as well as node pools and node pool priority.

To enable the new *Policy Manager*:

1. Press the *Tools and Settings* icon, then press *General*.
2. Toggle the *New Policy Manager* switch to on.

To return to the previous *Policy Manager* toggle the switch off.

## Run:ai Policies vs. Kyverno Policies

Kyverno runs as a dynamic admission controller in a Kubernetes cluster. Kyverno receives validating and mutating admission webhook HTTP callbacks from the Kubernetes API server and applies matching policies to return results that enforce admission policies or reject requests. Kyverno policies can match resources using the resource kind, name, label selectors, and much more. For more information, see [How Kyverno Works](https://kyverno.io/docs/introduction/#how-kyverno-works){target=_blank}.

Explain Run:ai policies and why they are better.

## Policy Types

When you configure a policy, you need to specify the workload type. The following workload types are available:

* [**Training**](training-policy.md)&mdash;places policy restrictions on [trainings](../../../Researcher/user-interface/trainings.md#trainings).
* [**Workspace**](workspaces-policy.md)&mdash;places policy restrictions on [Workspaces](../../../Researcher/user-interface/workspaces/overview.md#getting-familiar-with-workspaces).

### Policy Inheritance

A policy configured to a specific scope, is applied to all elements in that scope. You can add more policy restrictions to individual elements in the scope in order to override the base policy or add more restrictions.

## Policy Format

### Policy Editor UI

Policies are added to the system using the policy editor and are written in YAML format. YAML™ is a human-friendly, cross language, Unicode based data serialization language designed around the common native data types of dynamic programming languages. It is broadly useful for programming needs ranging from configuration files to internet messaging to object persistence to data auditing and visualization. For more information, see [YAML.org](https://yaml.org/){target=_blank}.

### Policy API

Access the *Policy* [API reference](../../../developer/policies/policy-API-page.md) to see how to apply *Policies* in the Run:ai platform.

### Example Policy

The following is an example of a workspace policy you can apply in your platform. Copy the values and paste them into the policy editor in the UI.

```YAML
defaults:
    environment:
      allowPrivilegeEscalation: false
      createHomeDir: true
      environmentVariables:
        - name: MY_ENV
          value: my_value
    workspace:
      allowOverQuota: true
rules:
    compute:
      cpuCoreLimit:
        min: 0
        max: 9
        required: true
      gpuPortionRequest:
        min: 0
        max: 10
    s3:
      url:
        options:
          - displayed: "https://www.google.com"
            value: "https://www.google.com"
          - displayed: "https://www.yahoo.com"
            value: "https://www.yahoo.com"
    environment:
      imagePullPolicy:
        options:
          - displayed: "Always"
            value: "Always"
          - displayed: "Never"
            value: "Never"
        required: true
      runAsUid:
        min: 1
        max: 32700
      createHomeDir:
        canEdit: false
      allowPrivilegeEscalation:
        canEdit: false
    workspace:
      allowOverQuota:
        canEdit: false
    imposedAssets:
      dataSources:
        nfs:
          canAdd: false
```
