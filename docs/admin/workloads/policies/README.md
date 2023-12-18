---
title: Policies
summary: This article contains details about Policies in the Run:ai platform.
authors:
    - Jason Novich
date: 2023-Dec-12
---

## Introduction

*Policies* allow administrators to impose restrictions and set default values for researcher workloads. Restrictions and default values can be placed on CPUs, GPUs, and other resources or entities.

For example, an administrator can create and apply a policy that will restrict researchers from requesting more than 2 GPUs, or less than 1GB of memory per type of workload.

Another example is, an administrator who wants to set different amounts of CPU, GPUs and memory for different kinds of workloads. A training workload can have a default of 1 GB of memory, or an interactive workload can have a default amount of GPUs.

Policies are created per Run:ai project (Kubernetes namespace). When a policy is created in the `runai` namespace, it will take effect when there is no project-specific policy for the workloads of the same kind.

In interactive workloads or workspaces, applied policies will only allow researchers access to resources that are permitted in the policy. This can include compute resources as well as node pools and node pool priority.

To use the new *Policy Manager*:

1. Press the *Tools and Settings* icon, then press *General*.
2. Toggle the *New Policy Manager* switch to on.

To return to the previous *Policy Manager* toggle the switch off.

!!! Warning
    Policy files from Run:ai version 2.15 and lower are not supported in the *New Policy Manager*. You will need to generate new policy files, or see your Run:ai representative to help you convert your current policy files.

## Policy Types

When you configure a policy, you need to specify the workload type.

| Policy Type | Affected Workload |
| --- |  --- |
| [Workspace](workspaces-policy.md){target=_blank} | Interactive |
| [Training](training-policy.md){target=_blank} | Training |

## Viewing or Edit a Policy

This section describes how to view policies that have been applied in the Run:ai platform.

### User Interface

To view a policy:

1. Press *Tools and Settings*
2. Press *Policies*. The policy grid is displayed.
3. Select a policy from the list. If there are no policies, then [create a new policy]().
4. Pres *Edit* to view the policy details, then press *Edit Policy* to edit the YAML file.
5. When done, press *Apply*.

### Using the API

## Creating a New Policy

### User Interface

To create a policy:

1. Press *Tools and Settings*
2. Press *Policies*. The policy grid is displayed.
3. Press *New Policy*.
4. Select a scope for the policy.
5. Select a workload type using the dropdown.
6. Press *Save Policy*. The policy editor will open.
7. Pres *Edit Policy* to edit the YAML file. Add policy properties and variables in YAML format.
8. When done, press *Apply*.

### Using the API


## Example Policy

The following is an example of a policy you can apply in your platform. (not working well)

```YAML
meta:
  name: pol-d-1
  departmentId: "1"
  scope: department
policy:
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
      gpuPortion:
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
        required: true
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

## API Reference

Access the *Policy* [API reference ](./policy-API-page.md){target=_blank} to see how to apply *Policies* in the Run:ai platform.

