---
title: Changelog Version 2.16
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.
authors:
    - Jason Novich
date: 2024-Feb-26
---

The following is a list of the known and fixed issues for Run:ai V2.16.

## Version 2.16.21

| Internal ID | Description |
|--|--|
| RUN-16463 | Fixed an issue after a cluster upgrade to v2.16, where some metrics of pre-existing workloads were displayed incorrectly in the *Overview* Dashboard. |

## Version 2.16.18

| Internal ID | Description |
|--|--|
| RUN-16486 | Fixed an issue in the *Workloads* creation form where the GPU fields of the compute resource tiles were showing no data. |

## Version 2.16.16

| Internal ID | Description |
|--|--|
| RUN-16340 | Fixed an issue in the *Workloads* table where filters were not saved correctly. |

## Version 2.16.15

### Release content

* <!-- RUN-12664 - [Control-plane] Implement get workload/pods API -->Implemented a new Workloads API to support the *Workloads* feature.

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-16070 | Fixed an issue where missing metrics caused the *Nodepools* table to appear empty. |

## Version 2.16.14

### Release content

*<!-- RUN-16108 | Reduce the frequency of fetching metrics from 10 sec to 30 sec -->Improved overall performance by slowing down metrics updates from 10 seconds to 30 seconds.

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-16255 | Fixed an issue in the *Analytics* dashboard where the *GPU Allocation per Node* and *GPU Memory Allocation per Node* panels were displaying incorrect data. |
| RUN-16035 | Fixed an issue in the *Workloads* table where completed pods continue to be counted in the requested resources column. |

## Version 2.16.12

### Fixed issues

| Internal ID | Description |
|--|--|
| RUN-16110 | Fixed an issue where creating a training workload (single or multi-node) with a new PVC or Volume, resulted in the *Workloads* table showing the workload in the Unknown/Pending status. |
| RUN-16086 | Fixed an issue in airgapped environments where incorrect installation commands were shown when upgrading to V2.15. |

## Version 2.16.11

N/A

## Version 2.16.9

N/A

## Version 2.16.8

### Release content

N/A

## Version 2.16.7

### Release content

* <!-- | RUN-12664 | [Control-plane] Implement get workload/pods API | -->Added an API endpoint that retrieves data from a workloads's pod.

### Fixed issues

N/A

## Version 2.16.6

N/A
