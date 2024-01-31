---
title: Changelog Version 2.13
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch verion.
authors:
    - Jason Novich
date: 2024-Jan-22
---

The following is a list of the known and fixed issues for Run:ai V2.13.

## Version 2.13.37

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-13300 | Fixed an issue where projects will appear with a status of empty while waiting for the project controller to update its status. This was caused because the cluster-sync works faster than the project controller. |

## Version 2.13.31

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-11367 | Fixed an issue where a double click on *SSO Users* redirects to a blank screen. |

## Version 2.13.25

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-13171 | Fixed an issue when a cluster is not connected the actions in the *Workspace* and *Training* p[ages are still enabled. After the corrections, the actions will be disabled. |

## Version 2.13.21

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-12563 | Fixed an issue where users are unable to login after upgrading the control plane from 2.9.16 to 2.13.16. To correct the issue, secrets need to be upgraded manually in keycloak. |

## Version 2.13.20

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-12923 | Fixed an issue in upgrading due to a misconfigured image for airgapped systems in 2.13.19. The helm chart contained an error, and the image is not used even though it is packaged as part of the tar. |
| RUN-12928, </br>RUN-12968 | Fixed an issue in upgrading Prometheus due to a misconfigured image for airgapped systems in 2.13.19. The helm chart contained an error, and the image is not used even though it is packaged as part of the tar. |

## Version 2.13.13

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-11321 | Fixed an issue where metrics always showed CPU Memory Utilization and CPU Compute Utilization as 0. |
| RUN-11307 | Fixed an issue where node affinity might change mid way through a job. Node affinity in now calculated only once at job submission. |
| RUN-11129 | Fixed an issue where CRDs are not automatically upgraded when upgrading from 2.9 to 2.13. |

## Version 2.13.11

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-11408 | Added to the Run:ai job-controller 2 configurable parameters `QPS` and `Burst` which are applied as environment variables in the job-controller Deployment object. |


## Version 2.13.7

### Release date

July 2023

#### Release content

<!-- RUN-10803 -->
* Added filters to the historic quota ratio widget on the *Quota management* dashboard.

#### Fixed issues

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-11080 | Fixed an issue in OpenShift environments where log in via SSO with the `kubeadmin` user, gets blank pages for every page. |
| RUN-11119 | Fixed an issue where values that should be the *Order of priority* column are in the wrong column. |
| RUN-11120 | Fixed an issue where the *Projects* table does not show correct metrics when Run:ai version 2.13 is paired with a Run:ai 2.8 cluster. |
| RUN-11121 | Fixed an issue where the wrong over quota memory alert is shown in the *Quota management* pane in project edit form. |
| RUN-11272 | Fixed an issue in OpenShift environments where the selection in the cluster drop down in the main UI does not match the cluster selected on the login page. |

## Version 2.13.4

### Release date

July 2023

#### Fixed issues

| Internal ID | Description |
|-----------|--------------|
| RUN-11089 | Fixed an issue when creating an environment, commands in the *Runtime settings* pane and are not persistent and cannot be found in other assets (for example in a new *Training*). |

## Version 2.13.1

### Release date

July 2023

#### Release content

<!-- RUN-11024 -->
* Made an improvement so that occurrences of labels that are not in use anymore are deleted.

#### Fixed issues

N/A