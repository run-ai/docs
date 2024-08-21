---
title:   V2 Policies
summary: This article outlines what is a  policy and details the variables that are used in the policy.

---

## Enabling the Policy Manager

To use V2 Policies you need to enable the *New Policy Manager*. The policy manager provides information about resources that are non-compliant with the applied policies.  


To enable the new *Policy Manager*:

1. Press the *Tools and Settings* icon, then press *General*.
2. Toggle the *New Policy Manager* switch to on.

To return to the previous *Policy Manager* toggle the switch off.

!!! Note
    Using the new, API-based Policies, will not disable the older [YAML-based](./policies.md) policies. 


## Viewing Policy compliance

A Policy places resource restrictions and defaults on Workloads in the Run:ai platform. Restrictions and default values can be placed on CPUs, GPUs, and other resources or entities.

Non-compliant resources (e.g. data sources, compute resources) will appear greyed out. To see how a resource is not compliant, press on the clipboard icon in the upper right-hand corner of the resource.


## Example Policy

Below is an example policy you can use in your platform.

!!! Note

    * Not all the configurable fields available are listed in the example below. 
    * Replace the values listed in the example below with values that match your platform requirements.

```YAML
defaults:
    environment:
      allowPrivilegeEscalation: false
      createHomeDir: true
      environmentVariables:
        - name: MY_ENV
          value: my_value
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
          - displayed: "Google"
            value: "https://www.google.com"
          - displayed: "Yahoo"
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
    imposedAssets:
      dataSources:
        nfs:
          canAdd: false
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