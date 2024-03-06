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
| RUN-14062 | Fixed an issue where the Running Workload per Type Graph box content is too big for the frame. |

## Version 2.15.2 - February 5, 2024

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-14434 | Fixed an issue where `runai_allocated_gpu_count_per_gpu` was multiplied by seven. |
| RUN-14425 | Fixed an issue when calculating deserved quota metrics for project, nodepool, or cluster causing unlimited quotas to display -1. |
| RUN-13401 | Fixed an issue where there was no accurate error information when a predicate fails (was `not found`). |


## Version 2.15.1 - December 17, 2023

### Release content

* <!-- RUN-14077 - [runai-cli] allow configuring client burst and QPS -->Added support for customizable QPS and burst support using environment variables.

* <!-- RUN-13968 - Prometheus high availability -- allow changing # of replicas -->Added support for running multiple Prometheus replicas.

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-14292 | Fixed an issue where Bright installation was failing due to missing `create cluster` permissions. |
| RUN-14289 | Fixed an issue where metrics were not working due to incorrect parameter in the cluster-config file. |
| RUN-14202 | Fixed an issue where the cluster-installer fails to install if the `runaiconfig` CRD does not exist. |
| RUN-14198 | Fixed an issue where multi nodepool jobs are not scheduled due to an unassigned nodepool by improving internal services performance. |
| RUN-14191 | Fixed an issue where consolidation failure would cause unnecessary evictions. |
| RUN-14154 | Fixed an issue where the cluster wizard dropdown lists versions that are incompatible with the installed control plane. |
| RUN-13956 | Fixed an issue where editing templates failed.. |
| RUN-13891 | Fixed an issue where Ray jobs status is shown as empty. |
| RUN-13825 | Fixed an issue where GPU sharing configmaps were not deleted. |
| RUN-13628 | Fixed an issue where the pre-install pod fails to run pre-install tasks due to the request being denied (Unauthorized). |
| RUN-13550 | Fixed an issue when recovering from node restart due to missing GPU runtime class for containerized nodes. |
| RUN-11895 | Fixed an issue where the wrong GPU memory usage is shown (is now MB). |
| RUN-11681 | Fixed an issue when using OpenShift, some metrics are not shown on dashboards when installing the GPU Operator from the RedHat marketplace. |

## Version 2.15.0

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-13456 | Fixed an issue where the Researcher L1 role doesn't have permissions for to create and manage credentials. |
| RUN-13282 | Fixed an issue where Workspace logs crash unexpectedly after restarting the container due to overloading of the log file. |
| RUN-13121 | Fixed an issue where an upgrade overrides a change in keycloak for an application which has a custom mapping to an email, and therefore cannot launch jobs using the API. |
| RUN-13103 | Fixed an issue where the Workspaces and Trainings grids action buttons were not greyed out for users with only the view role. |
| RUN-12993 | Fixed an issue where Prometheus is reporting metrics even though the cluster is disconnected. |
| RUN-12978 | Fixed an issue where after upgrade permissions fail to sync to a project due to missing application name in the CRD. |
| RUN-12900 | Fixed an issue where the Projects page sorts projects incorrectly (was alphabetically, now numerically) when sorting by *Allocated GPUs*. |
| RUN-12846 | Fixed an issue where GPU, CPU, Memory Cost fields (Consumption Reports) are missing after a control-plane upgrade when not using Grafana. |
| RUN-12824 | Fixed an issue where airgapped environments try to pull an image from gcr.io (Internet).  |
| RUN-12769 | Fixed an issue where SSO users were unable to see Projects in Job Form unless the group they belong to is added to Project. Now, SSO users can be added directly to the project. |
| RUN-12602 | Fixed an issue where the WorkloadServices configuration in `runaiconfig` didn't work based on the documentation. Now, the documentation reflects the correct configuration. |
| RUN-12528 | Fixed an issue where the Workspace duration scheduling rule was suspending workspaces regardless of the duration listed in the rule. |
| RUN-12298 | Fixed an issue where the API does not sanitize project name when creating a project causing it not to be shown in the UI. |
| RUN-12157 | Fixed an issue where querying pods completion time returns a negative number. |
| RUN-10560 | Fixed an issue where the Prometheus alert `RunaiDaemonSetRolloutStuck` is misconfigured resulting in no alert being sent. |
