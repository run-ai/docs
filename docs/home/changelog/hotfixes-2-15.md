---
title: Changelog Version 2.15
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.
authors:
    - Jason Novich
date: 2024-Feb-25
---

The following is a list of the known and fixed issues for Run:ai V2.15.

## Version 2.15.9 - February 5, 2024

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-15296 | Fixed an issue where the `resources` parameter was deprecated in the *Projects* and *Departments* API. |

## Version 2.15.4 - January 5, 2024

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-15026 | Fixed an issue in workloads that were built on a cluster that does not support the NFS field. |
| RUN-14907 | Fixed an issue after an upgrade where the *Analytics* dashboard was missing the time ranges from before the upgrade. |
| RUN-14903 | Fixed an issue where internal operations were exposed to the customer audit log. |
| RUN-14062 | Fixed an issue in the *Overview* dashboard where the content for the *Running Workload per Type* panel did not fit. |

## Version 2.15.2 - February 5, 2024

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-14434 | Fixed an issue where the *Allocated GPUs* metric was multiplied by seven. |

## Version 2.15.1 - December 17, 2023

### Release content

* <!-- RUN-14077 - [runai-cli] allow configuring client burst and QPS -->Added environment variables for customizable QPS and burst support.

* <!-- RUN-13968 - Prometheus high availability -- allow changing # of replicas -->Added the ability to support running multiple Prometheus replicas.

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-14292 | Fixed an issue where BCM installations were failing due to missing `create cluster` permissions. |
| RUN-14289 | Fixed an issue where metrics were not working due to an incorrect parameter in the cluster-config file. |
| RUN-14198 | Fixed an issue in services where multi nodepool jobs were not scheduled due to an unassigned nodepool status. |
| RUN-14191 | Fixed an issue where a consolidation failure would cause unnecessary evictions. |
| RUN-14154 | Fixed an issue in the *New cluster* form, whefre the dropdown listed versions that were incompatible with the installed control plane. |
| RUN-13956 | Fixed an issue in the *Jobs* table where templates were not edited successfully. |
| RUN-13891 | Fixed an issue where Ray job statuses were shown as empty. |
| RUN-13825 | Fixed an issue where GPU sharing configmaps were not deleted. |
| RUN-13628 | Fixed an issue where the `pre-install` pod failed to run `pre-install` tasks due to the request being denied (Unauthorized). |
| RUN-13550 | Fixed an issue where environments were not recovering from a node restart due to a missing GPU runtime class for containerized nodes. |
| RUN-11895 | Fixed an issue where the wrong amount of GPU memory usage was shown (is now MB). |
| RUN-11681 | Fixed an issue in OpenShift environments where some metrics were not shown on dashboards when the GPU Operator from the RedHat marketplace was installed. |

## Version 2.15.0

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-13456 | Fixed an issue where the Researcher L1 role did not have permissions to create and manage credentials. |
| RUN-13282 | Fixed an issue where *Workspace* logs crashed unexpectedly after restarting. |
| RUN-13121 | Fixed an issue in not being able to launch jobs using the API after an upgrade overrode a change in keycloak for applications which have a custom mapping to an email. |
| RUN-13103 | Fixed an issue in the *Workspaces* and *Trainings* table where the action buttons were not greyed out for users with only the view role. |
| RUN-12993 | Fixed an issue where Prometheus was reporting metrics even though the cluster was disconnected. |
| RUN-12978 | Fixed an issue after an upgrade, where permissions fail to sync to a project due to a missing application name in the CRD. |
| RUN-12900 | Fixed an issue in the *Projects* table, when sorting by *Allocated GPUs*, the projects were displayed alphabetically and not numerically. |
| RUN-12846 | Fixed an issue after a control-plane upgrade, where GPU, CPU, and Memory Cost fields (in the Consumption Reports) were missing when not using Grafana. |
| RUN-12824 | Fixed an issue where airgapped environments tried to pull an image from gcr.io (Internet).  |
| RUN-12769 | Fixed an issue where SSO users were unable to see projects in *Job* Form unless the group they belong to was added directly to the project. |
| RUN-12602 | Fixed an issue in the documentation where the `WorkloadServices` configuration in the `runaiconfig` file was incorrect. |
| RUN-12528 | Fixed an issue where the *Workspace* duration scheduling rule was suspending workspaces regardless of the configured duration. |
| RUN-12298 | Fixed an issue where projects were not shown in the *Projects* table due to the API not sanitizing the project name at time of creation. |
| RUN-12157 | Fixed an issue where querying pods completion time returned a negative number. |
| RUN-10560 | Fixed an issue where no Prometheus alerts were sent due to a misconfiguration of the parameter `RunaiDaemonSetRolloutStuck`. |
