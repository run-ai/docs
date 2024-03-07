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
| RUN-15296 | Fixed an issue where the `resources` parameter was deprecated in the *Projects* and *Departments* API . |

## Version 2.15.4 - January 5, 2024

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-15026 |Fixed an issue when building workloads on a cluster that does not support the NFS field in the workload. |
| RUN-14907 | Fixed an issue where after an upgrade, the Analytics Dashboard is missing the time ranges from before the upgrade.|
| RUN-14903 | Fixed an issue where internal operations were exposed to the customer audit log. |
| RUN-14062 | Fixed an issue in the Overview dashboard, where the Running Workload per Type panel content does not fit in the panel. |

## Version 2.15.2 - February 5, 2024

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-14434 | Fixed an issue where the *Allocated GPUs* metric was multiplied by seven. |

## Version 2.15.1 - December 17, 2023

### Release content

* <!-- RUN-14077 - [runai-cli] allow configuring client burst and QPS -->Added support for customizable QPS and burst support using environment variables.

* <!-- RUN-13968 - Prometheus high availability -- allow changing # of replicas -->Added support for running multiple Prometheus replicas.

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-14292 | Fixed an issue where Bright installation was failing due to missing `create cluster` permissions. |
| RUN-14289 | Fixed an issue where metrics were not working due to an incorrect parameter in the cluster-config file. |
| RUN-14198 | Fixed an issue in services where multi nodepool jobs were not scheduled due to an unassigned nodepool status. |
| RUN-14191 | Fixed an issue where consolidation failure would cause unnecessary evictions. |
| RUN-14154 | Fixed an issue where the cluster wizard dropdown, listed versions that are incompatible with the installed control plane. |
| RUN-13956 | Fixed an issue where were not edited successfully. |
| RUN-13891 | Fixed an issue where Ray jobs statuses were shown as empty. |
| RUN-13825 | Fixed an issue where GPU sharing configmaps were not deleted. |
| RUN-13628 | Fixed an issue where the `pre-install` pod failed to run `pre-install` tasks due to the request being denied (Unauthorized). |
| RUN-13550 | Fixed an issue where environments were not recovering from node restart due to missing GPU runtime class for containerized nodes. |
| RUN-11895 | Fixed an issue where the wrong amount of GPU memory usage was shown (is now MB). |
| RUN-11681 | Fixed an issue in OpenShift environments where some metrics were not shown on dashboards when the GPU Operator from the RedHat marketplace was installed. |

## Version 2.15.0

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-13456 | Fixed an issue where the Researcher L1 role did not have permissions to create and manage credentials. |
| RUN-13282 | Fixed an issue where Workspace logs crashed unexpectedly after restarting the container due to overloading of the log file. |
| RUN-13121 | Fixed an issue where an upgrade over rode a change in keycloak for an application which has a custom mapping to an email, which resulted in not being able to launch jobs using the API. |
| RUN-13103 | Fixed an issue where the Workspaces and Trainings grids action buttons were not greyed out for users with only the view role. |
| RUN-12993 | Fixed an issue where Prometheus was reporting metrics even though the cluster was disconnected. |
| RUN-12978 | Fixed an issue where after an upgrade, permissions fail to sync to a project due to a missing application name in the CRD. |
| RUN-12900 | Fixed an issue where the Projects page sorted projects incorrectly (was alphabetically, now numerically) when sorting by *Allocated GPUs*. |
| RUN-12846 | Fixed an issue where GPU, CPU, and Memory Cost fields (Consumption Reports) were missing after a control-plane upgrade when not using Grafana. |
| RUN-12824 | Fixed an issue where airgapped environments tried to pull an image from gcr.io (Internet).  |
| RUN-12769 | Fixed an issue where SSO users were unable to see projects in *Job* Form unless the group they belong to is added to the project. Now, SSO users can be added directly to the project. |
| RUN-12602 | Fixed an issue in the documentation where the `WorkloadServices` configuration in the `runaiconfig` file was incorrect. |
| RUN-12528 | Fixed an issue where the *Workspace* duration scheduling rule was suspending workspaces regardless of the duration listed in the rule. |
| RUN-12298 | Fixed an issue where the API does not sanitize the project name when creating a project, which caused it not to be shown in the UI. |
| RUN-12157 | Fixed an issue where querying pods completion time returned a negative number. |
| RUN-10560 | Fixed an issue where the Prometheus alert `RunaiDaemonSetRolloutStuck` was misconfigured which resulted in no alert being sent. |
