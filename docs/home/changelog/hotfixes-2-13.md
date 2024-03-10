---
title: Changelog Version 2.13
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.
authors:
    - Jason Novich
date: 2024-Jan-22
---

The following is a list of the known and fixed issues for Run:ai V2.13.

## Version 2.13.43 - February 15, 2024

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-14946 | Fixed an issue where Dashboards are displaying the hidden Grafana path. |

## Version 2.13.37

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-13300 | Fixed an issue where projects will appear with a status of empty while waiting for the project controller to update its status. This was caused because the cluster-sync works faster than the project controller. |

## Version 2.13.35 - December 19, 2023

### Release content

* <!-- RUN-14441 Add ability to set node affinity for Prometheus -->Added the ability to set node affinity for Prometheus.

### Fixed issues

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-14472 | Fixed an issue where template updates were not being applied to the workload. |
| RUN-14434 | Fixed an issue where `runai_allocated_gpu_count_per_gpu` was multiplied by seven. |
| RUN-13956 | Fixed an issue when changing an existing template created a `Promise error` on existing job templates. |
| RUN-13825 | Fixed an issue when deleting a job that is allocated a fraction of a GPU, an associated configmap is not deleted. |
| RUN-13343 | Fixed an issue in pod status calculation. |

## Version 2.13.31

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-11367 | Fixed an issue where a double click on *SSO Users* redirects to a blank screen. |

## Version 2.13.25

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-13171 | Fixed an issue when a cluster is not connected the actions in the *Workspace* and *Training* pages are still enabled. After the corrections, the actions will be disabled. |

## Version 2.13.21

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-12563 | Fixed an issue where users are unable to login after upgrading the control plane from 2.9.16 to 2.13.16. To correct the issue, secrets need to be upgraded manually in keycloak. |

## Version 2.13.20 - September 28, 2023

### Release content

* <!-- RUN-12537 hide credentials from the UI when cluster version is not compatible -->Added the prevention of selecting tenant or department scopes for credentials, and the prevention of selecting s3, PVC, and Git data sources if the cluster version does not support these.
* <!--RUN-12349	Enable quota management by default -->Quota management is now enabled by default.

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-12923 | Fixed an issue in upgrading due to a misconfigured Docker image for airgapped systems in 2.13.19. The helm chart contained an error, and the image is not used even though it is packaged as part of the tar. |
| RUN-12928, </br>RUN-12968 | Fixed an issue in upgrading Prometheus due to a misconfigured image for airgapped systems in 2.13.19. The helm chart contained an error, and the image is not used even though it is packaged as part of the tar. |
| RUN-12751 | Fixed an issue when upgrading from 2.9 to 2.13 results with a missing engine-config file. |
| RUN-12717 | Fixed an issue where the user that is logged in as researcher manager can't see the clusters. |
| RUN-12642 | Fixed an issue where assets-sync could not restart due to failing to get token from control plane. |
| RUN-12191 | Fixed an issue where there was a timeout while waiting for the `runai_allocated_gpu_count_per_project` metric to return values. |
| RUN-10474 | Fixed an issue where the `runai-conatiner-toolkit-exporter` DaemonSet fails to start. |

## Version 2.13.19 - September 27, 2023

### Release content

* <!--RUN-12508  Identify and present Kubeflow Notebooks in Jobs table -->Added the ability to identify Kubeflow notebooks and display them in the Jobs table.
* <!-- RUN-12507 Support scheduling of Kubeflow workloads -->Added the ability to schedule Kubelow workloads.
* <!--RUN-12420 Show only logged-in user's jobs -->Added functionality that displays Jobs that only belong to the user that is logged in.
* <!-- RUN-12405 Refine out of the box alerts to run:ai rules --> Added and refined alerts to the state of Run:ai components, schedule latency, and warnings for out of memory on Jobs.
* <!-- RUN-11711 Pod Security Admission issues in control plane -->Added the ability to work with restricted PSA policy.

### Fixed issues

| Internal ID | Description  |
|-------------- | ------------------- |
| RUN-12650 | Fixed an issue that used an incorrect metric in analytics GPU ALLOCATION PER NODE panel. Now the correct allocation is in percentage. |
| RUN-12602 | Fixed an issue in `runaiconfig` where the `WorkloadServices` spec has memory requests/limits and cpu requests/limits and gets overwritten with the system default. |
| RUN-12585 | Fixed an issue where the workload-controller creates a delay in running jobs. |
| RUN-12031 | Fixed an issue when upgrading from 2.9 to 2.13 where the Scheduler pod fails to upgrade due to the change of owner. |
| RUN-11091  | Fixed an issue where the *Departments* feature is disabled, you are not able to schedule non-preemable jobs. |

## Version 2.13.13

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-11321 | Fixed an issue where metrics always showed CPU Memory Utilization and CPU Compute Utilization as 0. |
| RUN-11307 | Fixed an issue where node affinity might change mid way through a job. Node affinity in now calculated only once at job submission. |
| RUN-11129 | Fixed an issue where CRDs are not automatically upgraded when upgrading from 2.9 to 2.13. |

## Version 2.13.12 - August 7, 2023

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-11476 | Fixed an issue with analytics node pool filter in Allocated GPUs per Project panel. |

## Version 2.13.11

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-11408 | Added to the Run:ai job-controller 2 configurable parameters `QPS` and `Burst` which are applied as environment variables in the job-controller Deployment object. |

## Version 2.13.7 - July 2023

### Release content

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

## Version 2.13.1 - July 2023

### Release content

<!-- RUN-11024 -->
* Made an improvement so that occurrences of labels that are not in use anymore are deleted.

#### Fixed issues

N/A
