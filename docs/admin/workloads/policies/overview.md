---
title: Policies
summary: This article contains details about Policies in the Run:ai platform.
authors:
    - Jason Novich
date: 2023-Dec-12
---

## Introduction

*Policies* allow administrators to impose restrictions and set default values for researcher workloads. Restrictions and default values can be placed on CPUs, GPUs, and other resources or entities. 

Examples:

* An administrator can create and apply a policy that will restrict researchers from requesting more than 2 GPUs, or less than 1GB of memory per type of workload.
* An administrator who wants to set different amounts of CPU, GPUs and memory for different kinds of workloads. A training workload can have a default of 1 GB of memory, or an interactive workload can have a default amount of GPUs.

Policies are created for each Run:ai project (Kubernetes namespace). When a policy is created in the `runai` namespace, it will take effect when there is no project-specific policy for workloads of the same kind.

When using workspaces, applied policies will only allow researchers access to resources that are permitted in the policy. This can include compute resources as well as node pools and node pool priority.

## Older and Newer Policy technologies

Run:ai provides two policy technologies.

[**YAML-Based policies**](policies.md) are the older policies. These policies:

* Require access to Kubernetes to view or change.
* Do not manifest themselves in the Run:ai user interface and can thus create unexpected side effects.

[**API-based policies**](workspaces-policy.md) which are the newer policies. These are:

* Show in the Run:ai user interface
* Can be viewed and modified via the user interface and the Control-plane API
* Only available with Run:ai clusters of version 2.18 and up. 


## Run:ai Policies vs. Kyverno Policies

Kyverno runs as a dynamic admission controller in a Kubernetes cluster. Kyverno receives validating and mutating admission webhook HTTP callbacks from the Kubernetes API server and applies matching policies to return results that enforce admission policies or reject requests. Kyverno policies can match resources using the resource kind, name, label selectors, and much more. For more information, see [How Kyverno Works](https://kyverno.io/docs/introduction/#how-kyverno-works){target=_blank}.



## Policy Inheritance

A policy configured with a specific `scope`. The policy is applied to all elements in that scope. You can add more policy restrictions to individual elements in the scope to override the base policy or add more restrictions.

