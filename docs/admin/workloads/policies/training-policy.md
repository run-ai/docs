---
title: Training Policy
summary: This article outlines what is a training policy and details the variables that are used in the policy.
authors:
    - Jason Novich
date: 2023-Dec-18
---

A *Training* policy places resource restrictions and defaults on training worloads in the Run:ai platform. Restrictions and default values can be placed on CPUs, GPUs, and other resources or entities.

## Example

Below is an example policy you can use in your platform. 

!!! Note

    * Not all the configurable fields available are listed in the example below. 
    * Replace the values listed in the example below with values that match your platform requirements.

```yml

# insert example here

```

## Viewing or Edit a Policy

To view or edit a policy:

1. Press *Tools and Settings*.
2. Press *Policies*. The policy grid is displayed.
3. Select a policy from the list. If there are no policies, then [create a new policy](#creating-a-new-policy).
4. Pres *Edit* to view the policy details, then press *Edit Policy* to edit the YAML file.
5. When done, press *Apply*.

## Creating a New Policy

To create a policy:

1. Press *Tools and Settings*.
2. Press *Policies*. The policy grid is displayed.
3. Press *New Policy*.
4. Select a scope for the policy.
5. Select a workload type using the dropdown.
6. In the *Policy YAML* pane, press *+ POLICY YAML* to open the policy editor.
7. Enter your policy in the policy editor. Add policy properties and variables in YAML format. When complete, press *APPLY*.
8. When done, press *SAVE POLICY*.

!!! Note
    After saving, the form will wait for the policy to sync with the cluster.

--8<-- "../docs/snippets/snippets-policies.md:1:170"

#### Training

--8<-- "../docs/snippets/snippets-policies.md:172:775"

#### Training

--8<-- "../docs/snippets/snippets-policies.md:777:843"