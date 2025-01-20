---
title: Changelog Version 2.19
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.

---

The following is a list of the known and fixed issues for Run:ai V2.19.

## Hotfixes

| Internal ID | Hotfix # | Description |
| :---- | :---- | :---- |
| RUN-25062 | 2.19.45 | Fixed a security vulnerability in github.com.go-git.go-git.v5 with CVE CVE-2025-21614 with severity HIGH. |
| RUN-25061 | 2.19.45 | Fixed a security vulnerability in github.com.go-git.go-git.v5 with CVE CVE-2025-21613 with severity HIGH. |
| RUN-24857 | 2.19.45 | Fixed a security vulnerability in golang.org.x.net with CVE CVE-2024-45338 with severity HIGH. |
| RUN-24733 | 2.19.45 | Fixed an issue where users were unable to load the quota management dashboard. |
| RUN-25094 | 2.19.44 | Fixed an issue where OpenShift could not be upgraded due to a broken 3rd binary. |
| RUN-24026 | 2.19.40 | Fixed a security vulnerability in krb5-libs with CVE CVE-2024-3596. |
| RUN-24649 | 2.19.40 | Fixed an issue where submitting a workload with `existingPvc=false` and not providing a `claimName` resulted in auto-generating a `claimName` that included both upper and lower case letters. Since Kubernetes rejects uppercase letters, the workload would fail. The behavior has been updated to generate names using only lowercase letters. |
| RUN-24632 | 2.19.40 | Fixed an issue where an existing Prometheus monitoring setup deployed in an unexpected namespace was reported as missing, causing Run:ai installation to fail on the cluster. The installation mechanism now searches for the monitoring prerequisite in additional relevant namespaces. |
| RUN-24693 | 2.19.40 | Fixed an issue where users were unable to provide metric store authentication details using secret references. |
| RUN-23744 | 2.19.40 | Fixed an issue where refreshing some pages (such as the settings, policy, and access rules) removed the side navigation. |
| RUN-24715 | 2.19.40 | Fixed an issue in the templates form where selecting Secret as a data source got stuck in an infinite loading page. |
| RUN-24831 | 2.19.40 | Fixed an issue where some edge cases triggered consolidation without it actually being necessary. |
| RUN-24873 | 2.19.40 | Fixed an issue where users were unable to configure email notifications regarding workload statuses. |
| RUN-24921 | 2.19.40 | Fixed a security vulnerability in golang.org.x.net and golang.org.x.crypto. |
| RUN-23914 | 2.19.38 | Fixed an issue where unexpected behavior could occur if an application was capturing a graph while memory was being swapped in as part of the GPU memory swap feature. |
| RUN-24521 | 2.19.36 | Fixed a security vulnerability in golang.org.x.crypto with CVE CVE-2024-45337 with severity HIGH. |
| RUN-24595 | 2.19.36 | Fixed an issue where the new command-line interface did not parse master and worker commands/args simultaneously for distributed workloads. |
| RUN-24565 | 2.19.34 | Fixed an issue where the UI was hanging at times during Hugging Face model memory calculation. |
| RUN-24021 | 2.19.33 | Fixed a security vulnerability in pam with CVE-2024-10963. |
| RUN-24506 | 2.19.33 | Fixed a security vulnerability in krb5-libs with CVE-2024-3596. |
| RUN-24259 | 2.19.31 | Fixed an issue where the option to reset a local user password is sometimes not available.  |
| RUN-23798 | 2.19.30 | Fixed an issue in distributed PyTorch workloads where the worker pods are deleted immediately after completion, not allowing logs to be viewed.  |
| RUN-24184 | 2.19.28 | Fixed an issue in database migration when upgrading from 2.16 to 2.19. |
| RUN-23752 | 2.19.27 | Fixed an issue in the distributed training submission form when a policy on the master pod was applied. |
| RUN-23040 | 2.19.27 | Fixed an edge case where the Run:ai container toolkit hangs when user is spawning hundreds of sub-processes. |
| RUN-23211 | 2.19.27 | Fixed an issue where workloads were stuck at "Pending" when the command-line interface flag --gpu-memory was set to zero.  |
| RUN-23561 | 2.19.27 | Fixed an issue where the frontend in airgapped environment attempted to download font resources from the internet. |
| RUN-23789 | 2.19.27 | Fixed an issue where in some cases, it was not possible to download the latest version of the command-line interface. |
| RUN-23790 | 2.19.27 | Fixed an issue where in some cases it was not possible to download the Windows version of the command-line interface. |
| RUN-23802 | 2.19.27 | Fixed an issue where new scheduling rules were not applied to existing workloads, if those new rules were set on existing projects which had no scheduling rules before. |
| RUN-23838 | 2.19.27 | Fixed an issue where the command-line interface could not access resources when configured as single-sign on in a self-hosted environment. |
| RUN-23855 | 2.19.27 | Fixed an issue where the pods list in the UI showed past pods. |
| RUN-23857 | 2.19.27 | Dashboard to transition from Grafana v9 to v10. |
| RUN-24010 | 2.19.27 | Fixed an infinite loop issue in the cluster-sync service. |
| RUN-23669 | 2.19.25 | Fixed an issue where export function of consumption Grafana dashboard was not showing. |
| RUN-23778 | 2.19.24 | Fixed an issue where mapping of UID and other properties disappears.  |
| RUN-23770 | 2.19.24 | Fixed an issue where older overview dashboard does not filter on cluster, even though a cluster is selected. |
| RUN-23762 | 2.19.24 | Fixed an issue where the wrong version of a Grafana dashboard was displayed in the UI. |
| RUN-23752 | 2.19.24 | Fixed an issue in the distributed training submission form when a policy on the master pod was applied. |
| RUN-23664 | 2.19.24 | Fixed an issue where the GPU quota numbers on the department overview page did not mach the department edit page. |
| RUN-21198 | 2.19.22 | Fixed an issue where creating a training workload via yaml (kubectl apply -f) and specifying spec.namePrefix, created infinite jobs. |
| RUN-23583 | 2.19.21 | Fixed an issue where the new UI navigation bar sometimes showed multiple selections. |
| RUN-23541 | 2.19.21 | Fixed an issue where authorization was not working properly in SaaS due to wrong oidc URL being used. |
| RUN-23376 | 2.19.21 | Fixed an issue where the new command-line interface required re-login after 10 minutes. |
| RUN-23162 | 2.19.21 | Fixed an issue where older audit logs did not show on the new audit log UI. |
| RUN-23385 | 2.19.20 | Fixed an issue where calls to api/v1/notifications/config/notifications would return 502. |
| RUN-23382 | 2.19.20 | Fixed an issue where all nodepools were deleted on cluster upgrade. |
| RUN-23374 | 2.19.20 | Fixed an issue where "ghost" nodepool in project settings prevents workload creation via UI/API. |
| RUN-23291 | 2.19.20 | CLI - change text to be user friendly. |
| RUN-23283 | 2.19.20 | Fixed a permissions issue with the Analytics dashboard post upgrade for SSO Users. |
| RUN-23208 | 2.19.20 | Upload the source map to sentry only. |
| RUN-22642 | 2.19.20 | infw-controller service tests for the reconcile. |
| RUN-23373 | 2.19.19 | Fixed an issue where a new data source couldn't be created from the "New Workload" form. |
| RUN-23368 | 2.19.19 | Fixed an issue where the getProjects v1 API returned a list of users which was not always in the same order. |
| RUN-23333 | 2.19.19 | Fixed an issue where node pool with overProvisioningRatio greater than 1 cannot be created. |
| RUN-23215 | 2.19.18 | Fixed an issue where metrics requests from backend to mimir failed for certain tenants. |
| RUN-23334 | 2.19.17 | Updated some dockerfiles to the latest ubi9 image for security vulnerabilities. |
| RUN-23318 | 2.19.16 | Fixed an issue where some projects held faulty data which caused the getProjectById API to fail. |
| RUN-23140 | 2.19.16 | Fixed an issue where distributed workloads were created with the wrong types |
| RUN-22069 | 2.19.16 | Fixed an issue where JWT parse with claims failed to parse token without Keyfunc. |
| RUN-23321 | 2.19.15 | Fixed and issue where the GetProjectById wrapper API of the org-unit client in the runai-common-packages ignored errors. |
| RUN-23296 | 2.19.15 | Fixed an issue in the CLI where runai attach did not work with auto-complete. |
| RUN-23282 | 2.19.15 | CLI documentation fixes. |
| RUN-23245 | 2.19.15 | Fixed an issue where the binder service didn't update the pod status. |
| RUN-23057 | 2.19.15 | OCP 2.19 upgrade troubleshooting. |
| RUN-22138 | 2.19.15 | Fixed an issue where private URL user(s) input was an email and not a string. |
| RUN-23243 | 2.19.14 | Fixed an issue where the scope tree wasn't calculating permissions correctly. |
| RUN-23208 | 2.19.14 | Upload the source map to sentry only. |
| RUN-23198 | 2.19.14 | Fixed an issue where external-workload-integrator sometimes crashed for RayJob. |
| RUN-23191 | 2.19.13 | Fixed an issue where creating workloads in the UI returned only the first 50 projects. |
| RUN-23142 | 2.19.12 | Fixed an issue where advanced GPU metrics per-gpu did not have gpu label. |
| RUN-23139 | 2.19.12 | Fixed an issue where inference workload showed wrong status. |
| RUN-23027 | 2.19.12 | Deprecated migProfiles API fields. |
| RUN-23001 | 2.19.12 | Fixed an issue of false overcommit on out-of-memory kills in the Swap feature. |
| RUN-22851 | 2.19.12 | Fixed an issue where client may get stuck on device lock acquired during “swap” out-migration.  |
| RUN-22771 | 2.19.12 | Fixed an issue where get cluster by id with metadata verbosity returned zero values. |
| RUN-22742 | 2.19.12 | Fixed user experience issue in inference autoscaling. |
| RUN-22725 | 2.19.12 | Fixed an issue where the cloud operator failed to get pods in nodes UI. |
| RUN-22720 | 2.19.12 | Fixed an issue where the cloud operator failed to get projects in node pools UI. |
| RUN-22700 | 2.19.12 | Added auto refresh to the overview dashboard, Pods modal in the Workloads page, and Event history page. |
| RUN-22544 | 2.19.12 | Updated Grafana version for security vulnerabilities. |
| RUN-23083 | 2.19.11 | Fixed an issue where workload actions were blocked in the UI when the cluster had any issues. |
| RUN-22771 | 2.19.11 | Fixed an issue where the getClusterById API with metadata verbosity returned zero values. |



## Version 2.19.0 Fixes

| Internal ID | Description  |
| ---------------------------- | ---- |
| RUN-21756 | Fixed an issue where the NFS mount path doesn’t accept “{}” characters. |
| RUN-21475 | Fixed an issue where users failed to select the compute resource from UI if the compute resource is last in the list and has a long name. |
