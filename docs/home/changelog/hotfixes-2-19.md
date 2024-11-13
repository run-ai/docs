---
title: Changelog Version 2.19
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.

---

The following is a list of the known and fixed issues for Run:ai V2.19.

## Hotfixes

| Internal ID | Hotfix # | Description |
| :---- | :---- | :---- |
| RUN-23334 | 2.19.17 | Updated some dockerfiles to the latest ubi9 image for security vulnerabilities. |
| RUN-23142 | 2.19.12 | Fixed an issue where advanced GPU metrics per-gpu did not have gpu label |
| RUN-23139 | 2.19.12 | Fixed an issue where inference workload showed wrong status. |
| RUN-23027 | 2.19.12 | Deprecated migProfiles API fields |
| RUN-23001 | 2.19.12 | Fixed an issue of false overcommit on out-of-memory kills in the Swap feature. |
| RUN-22851 | 2.19.12 | Fixed an issue where client may get stuck on device lock acquired during “swap” out-migration  |
| RUN-22771 | 2.19.12 | Fixed an issue where get cluster by id with metadata verbosity returned zero values |
| RUN-22742 | 2.19.12 | Fixed user experience issue in inference autoscaling |
| RUN-22725 | 2.19.12 | Fixed an issue where the cloud operator failed to get pods in nodes UI. |
| RUN-22720 | 2.19.12 | Fixed an issue where the cloud operator failed to get projects in node pools UI. |
| RUN-22700 | 2.19.12 | Added auto refresh to the overview dashboard, Pods modal in the Workloads page, and Event history page |
| RUN-22544 | 2.19.12 | Updated Grafana version for security vulnerabilities. |

## Version 2.19.0 Fixes

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-21756 | Fixed an issue where the NFS mount path doesn’t accept “{}” characters |
| RUN-21475 | Fixed an issue where users failed to select the compute resource from UI if the compute resource is last in the list and has a long name |
