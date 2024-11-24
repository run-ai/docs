---
title: Changelog Version 2.19
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.

---

The following is a list of the known and fixed issues for Run:ai V2.19.

## Hotfixes

| Internal ID | Hotfix # | Description |
| :---- | :---- | :---- |
| RUN-23385 | 2.19.20 | Fixed an issue where calls to api/v1/notifications/config/notifications would return 502 |
| RUN-23382 | 2.19.20 | Fixed an issue where all nodepools were deleted on cluster upgrade |
| RUN-23374 | 2.19.20 | Fixed an issue where "ghost" nodepool in project settings prevents workload creation via UI/API |
| RUN-23291 | 2.19.20 | CLI - change text to be user friendly |
| RUN-23283 | 2.19.20 | Fixed a permissions issue with the Analytics dashboard post upgrade for SSO Users |
| RUN-23208 | 2.19.20 | Upload the source map to sentry only |
| RUN-22642 | 2.19.20 | infw-controller service tests for the reconcile |
| RUN-23373 | 2.19.19 | Fixed an issue where a new data source couldn't be created from the "New Workload" form. |
| RUN-23368 | 2.19.19 | Fixed an issue where the getProjects v1 API returned a list of users which was not always in the same order. |
| RUN-23333 | 2.19.19 | Fixed an issue where node pool with overProvisioningRatio greater than 1 cannot be created. |
| RUN-23215 | 2.19.18 | Fixed an issue where metrics requests from backend to mimir failed for certain tenants. |
| RUN-23334 | 2.19.17 | Updated some dockerfiles to the latest ubi9 image for security vulnerabilities. |
| RUN-23318 | 2.19.16 | Fixed an issue where some projects held faulty data which caused the getProjectById API to fail |
| RUN-23140 | 2.19.16 | Fixed an issue where distributed workloads were created with the wrong types |
| RUN-22069 | 2.19.16 | Fixed an isuue where JWT parse with claims failed to parse token without Keyfunc. |
| RUN-23321 | 2.19.15 | Fixed and issue where the GetProjectById wrapper API of the org-unit client in the runai-common-packages ignored errors |
| RUN-23296 | 2.19.15 | Fixed an issue in the CLI where runai attach did not work with auto-complete |
| RUN-23282 | 2.19.15 | CLI documentation fixes |
| RUN-23245 | 2.19.15 | Fixed an issue where ther binder service didn't update the pod status |
| RUN-23057 | 2.19.15 | OCP 2.19 upgrade troubleshooting |
| RUN-22138 | 2.19.15 | Fixed an issue where private URL user(s) input was an email and not a string. |
| RUN-23243 | 2.19.14 | Fixed an issue where the scope tree wasn't calculating permissions correctly |
| RUN-23208 | 2.19.14 | Upload the source map to sentry only |
| RUN-23198 | 2.19.14 | Fixed an issue where external-workload-integrator sometimes crashed for RayJob |
| RUN-23191 | 2.19.13 | Fixed an issue where creating workloads in the UI returned only the first 50 projects |
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
| RUN-23083 | 2.19.11 | Fixed an issue where workload actions were blocked in the UI when the cluster had any issues |
| RUN-22771 | 2.19.11 | Fixed an issue where the getClusterById API with metadata verbosity returned zero values |



## Version 2.19.0 Fixes

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-21756 | Fixed an issue where the NFS mount path doesn’t accept “{}” characters |
| RUN-21475 | Fixed an issue where users failed to select the compute resource from UI if the compute resource is last in the list and has a long name |
