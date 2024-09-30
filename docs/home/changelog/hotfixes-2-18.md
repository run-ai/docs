---
title: Changelog Version 2.18
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.
author:
    - Jamie Weider
date: 2024-Sep-29
---

The following is a list of the known and fixed issues for Run:ai V2.18.

## Version 2.18.46 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-22054 | Fixed an issue where users could not attach to jobs. |
| RUN-22377 | Removed uncached client from accessrule-controller. |
| RUN-21697 | Fixed an issue where client may deadlock on suspension during allocation request. |
| RUN-21404 | Fixed an issue of sporadic failures in consolidation e2e testing. |

## Version 2.18.45 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20073 | Fixed an issue where it wasn't possible to authenticate with user credentials in the CLI. |
| RUN-21957 | Fixed an issue where there was a missing username-loader container in inference workloads. |

## Version 2.18.39 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-22276 | Fixed an issue where Knative external URL was missing from the Connections modal. |
| RUN-22280 | Fixed an issue when setting scale to zero - there was no pod counter in the Workload grid. |
| RUN-19811 | Added an option to set k8s tolerations to run:ai daemonsets (container-toolkit, runai-device-plugin, mig-parted, node-exporter, etc..) . |
| RUN-22128 | Added GID, UID, Supplemental groups to the V1 CLI. |

## Version 2.18.37  

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-21800 | Fixed an issue with old workloads residing in the cluster. |

## Version 2.18.34 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-21907 | Fixed an issue where the SSO user credentials contain supplementary groups as string instead of int. |

## Version 2.18.31

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-21272 | Fixed an issue with multi-cluster credinatils creation, specifically with the same name in different clusters. |

## Version 2.18.29

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20680 | Fixed an issue where workloads page do not present requested GPU. |
| RUN-21200 | Fixed issues with upgrades and connections from v2.13. |

## Version 2.18.27 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20970 | Fixed an issue with PUT APIs. |

## Version 2.18.26 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20927 | Fixed an issue where node affinity was not updated correctly in projects edit. |
| RUN-20084 | Fixed an issue where default department were deleted instead of a message being displayed. |
| RUN-21062 | Fixed issues with the API documentation. |

## Version 2.18.25 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20434 | Fixed an issue when creating a Project/Department with memory resources requires 'units'. |
| RUN-20923 | Fixed an issue with projects/departments page loading slowly. |

## Version 2.18.23 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-19872 | Fixed an issue where the Toolkit crashes and fails to create and replace the publishing binaries. |

## Version 2.18.22

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20861 | Fixed an issue where a pod is stuck on pending due to a missing resource reservation pod. |
| RUN-20842 | Fixed an issue of illegal model name with "." in hugging face integration. |
| RUN-20791 | Fix an issue where notifications froze after startup. |
| RUN-20842 | Fixed an issue of illegal model name with "." in hugging face integration. |
| RUN-20865 | Fixed an issue where default departments are not deleted when a cluster is deleted. |

## Version 2.18.21

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20698 | Fixed an issue where 2 processes requests a device at the same time received the same GPU, causing failures. |

## Version 2.18.18

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20760 | Fixed an issue where workload protection UI shows wrong status. |

## Version 2.18.15

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20612 | Fixed an issue where it was impossible with the use-table-data to hide node pool columns when there is only one default node pool. |
| RUN-20735 | Fixed an issue where nodePool.name is undefined|

## Version 2.18.13

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20722 | Fixed an issue where node pools UI test fails on nodes modal. |

## Version 2.18.12

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20721 | Added error handling to nodes pages. |

## Version 2.18.10 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20578 | Fixed an issue regarding policy enforcement. |
| RUN-20188 | Fixed issue with defining SSO in OpenShift identity provider. |

## Version 2.18.9

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20673 | Fixed an issue where a researcher uses a distributed elastic job, it is possible that in a specific flow it is scheduled on more than one node-pools. |

## Version 2.18.7 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20360 | Fixed an issue where the workload network status was misleading. |
| RUN-22107 | Fixed an issue where passwords containing $ were removed from the configuration. |

## Version 2.18.5 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20510 | Fixed an issue with external workloads - argocd workflow failed to be updated. |

## Version 2.18.4

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20516 | Fixed an issue when after deploying to prod, the cluster-service and authorization-service got multiple OOMKilled every ~1 hour. |


## Version 2.18.2 

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20485 | Changed policy flags to Beta. |

## Version 2.18.1

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20005 | Fixed an issue where a sidecar container failure failed the workload. |
| RUN-20169 | Fixed an issue allowing the addition of annotations and labels to workload resources. |
| RUN-20108 | Fixed an issue exposing service node ports to workload status. |
| RUN-20160 | Fixed an issue with version display when installing a new cluster in an airgapped environment. |
| RUN-19874 | Fixed an issue when copying and editing a workload with group access to a tool and the group wasn't removed when selecting users option. |
| RUN-19893 | Fixed an issue when using a float number in the scale to zero inactivity value - custom which sometimes caused the submission to fail. |
| RUN-20087 | Fixed an issue where inference graphs should be displayed only for minimum cluster versions. |
| RUN-10733 | Fixed an issue where we needed to minify and obfuscate our code in production. |
| RUN-19962 | Fixed an issue to fix sentry domains regex and map them to relevant projects. |
| RUN-20104 | Fixed an issue where frontend Infinite loop on keycloak causes an error. |
| RUN-19906 | Fixed an issue where inference workload name validation fails with 2.16 cluster. |
| RUN-19605 | Fixed an issue where authorized users should support multiple users (workload-controller) . |
| RUN-19903 | Fixed an issue where inference chatbot creation fails with 2.16 cluster. |
| RUN-20409 | Fixed an issue where clicking on create new compute during the runai model flow did nothing. |
| RUN-11224 | Fixed an issue where ruani-adm collect all logs was not collecting all logs. |
| RUN-20478 | Improved workloads error status in overview panel. |
| RUN-19850 | Fixed an issue where an application administrator could not submit a job with CLI. |
| RUN-19863 | Fixed an issue where department admin received 403 on get tenants and cannot login to UI. |
| RUN-19904 | Fixed an issue when filtering by allocatedGPU in get workloads with operator returns incorrect result. |
| RUN-19925 | Fixed an issue when upgrade from v2.16 to v2.18 failed on worklaods migrations. |
| RUN-19887 | Fixed an issue in the UI when there is a scheduling rule of timeout, the form opened with the rules collapsed and written "none". |
| RUN-19941 | Fixed an issue where completed and failed jobs were shown in view pods in nodes screen. |
| RUN-19940 | Fixed an issue where setting gpu quota failed because the department quota was taken from wrong department. |
| RUN-19890 | Fixed an issue where editing a project by removing its node-affinity stuck updating. |
| RUN-20120 | Fixed an issue where project update fails when there is no cluster version. |
| RUN-20113 | Fixed an issue in the Workloads table where a researcher does not see other workloads once they clear their filters. |
| RUN-19915 | Fixed an issue when turning departments toggles on on cluster v2.11+ the gpu limit is -1 and there is ui error. |
| RUN-20178 | Fixed an issue where dashboard CPU tabs appeared in new overview. |
| RUN-20247 | Fixed an issue where you couldn't create a workload with namespace of a deleted project. |
| RUN-20138 | Fixed an issue where the system failed to create node-type on override-backend env. |
| RUN-18994 | Fixed an issue where some limitations for department administrator are not working as expected. |
| RUN-19830 | Fixed an issue where resources (GPU, CPU, Memory) units were added to k8s events that are published by run:ai scheduler making our messages more readable. |

## Version 2.18.0

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-20734 | Fixed an issue where the enable/disable toggle for the feature was presenting wrong info. |
| RUN-19895 | Fixed an issue of empty state for deleted workloads which is incorrect. |
| RUN-19507 | Fixed an issue in V1 where get APIs are missing required field in swagger leading to omit empty. |
| RUN-20246 | Fixed an issue in Departments v1 org unit where if unrecognizable params are sent, an error is returned. |
| RUN-19947 | Fixed an issue where pending multi-nodepool podgroups got stuck after cluster upgrade. |
| RUN-20047 | Fixed an issue where Workload status shows as "deleting" rather than "deleted" in side panel. |
| RUN-20163 | Fixed an issue when a DV is shared with a department and a new project is added to this dep - no pvc/pv is created. |
| RUN-20484 | Fixed an issue where Create Projects Requests Returned 500 - services is not a valid ResourceType. |
| RUN-20354 | Fixed an issue when deleting a department with projects resulted in projects remaining in environment with the status NotReady. |

