---
title: Changelog Version 2.18
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.
author:
    - Jamie Weider
date: 2024-Sep-29
---

The following is a list of the known and fixed issues for Run:ai V2.18.

## Hotfixes 

| Internal ID | Hotfix # | Description |
| :---- | :---- | :---- |
| RUN-25558 | 2.18.88 |  Fixed a memory issue when handling external workloads (deployments, ray etc.) which when they were scaled caused ETCD memory to increase. |
| RUN-25466 | 2.18.88 | Fixed an issue where an environment variable with the value SECRET was not valid as only SECRET:xxx was accepted. |
| RUN-24700 | 2.18.88 |  CLI v2: Workload describe command no longer requires type or framework flags. |
| RUN-25499 | 2.18.87 | Fixed an issue where policy update request would fail to sync to the cluster" perhaps mention the cluster version. |
| RUN-25303 | 2.18.85 | Fixed an issue where submitting with the --attach flag was supported only in a workspace workload. |
| RUN-25061 | 2.18.84 | Fixed a security vulnerability in github.com.go-git.go-git.v5 with CVE CVE-2025-21613 with severity HIGH. |
| RUN-24857 | 2.18.84| Fixed a security vulnerability in golang.org.x.net with CVE CVE-2024-45338 with severity HIGH. |
| RUN-17284 | 2.18.84 | Fixed an issue where workloads were suspended when set with the termination after preemption option. |
| RUN-24521 | 2.18.83 | Fixed a security vulnerability in golang.org.x.crypto with CVE CVE-2024-45337 with severity HIGH. |
| RUN-24733 | 2.18.83 | Fixed an issue where department admins were unable to load the quota management page. |
| RUN-25094 | 2.18.82 | Fixed an issue where OpenShift could not be upgraded due to a broken 3rd binary. |
| RUN-24921 | 2.18.80 | Fixed a security vulnerability in golang.org.x.net and golang.org.x.crypto. |
| RUN-24632 | 2.18.80 | Fixed an issue where an existing monitoring Prometheus setup deployed in an unexpected namespace was reported as missing, causing Run:ai installation to fail on the cluster. The installation mechanism now searches for the monitoring prerequisite in additional relevant namespaces. |
| RUN-24693 | 2.18.80 | Fixed an issue where users were unable to provide metric store authentication details using secret references. |
| RUN-24752 | 2.18.79 | Fixed an issue where a workload would move to a failed state when created with a custom NodePort that was already allocated. |
| RUN-24649 | 2.18.79 | Fixed an issue where submitting a workload with `existingPvc=false` and not providing a `claimName` resulted in auto-generating a `claimName` that included both upper and lower case letters. Since Kubernetes rejects uppercase letters, the workload would fail. The behavior has been updated to generate names using only lowercase letters. |
| RUN-24595 | 2.18.78 | Fixed an issue where the new CLI did not parse master and worker commands/args simultaneously for distributed workloads. |
| RUN-23914 | 2.18.78 | Fixed an issue where unexpected behavior could occur if an application was capturing a graph while memory was being swapped in as part of the GPU memory swap feature. |
| RUN-24020 | 2.18.77 | Fixed a security vulnerability in k8s.io.kubernetes with CVE CVE-2024-0793. |
| RUN-24021 | 2.18.77 | Fixed a security vulnerability in pam with CVE CVE-2024-10963. |
| RUN-23798 | 2.18.75 | Fixed an issue in distributed PyTorch workloads where the worker pods are deleted immediately after completion, not allowing logs to be viewed. |
| RUN-23838 | 2.18.74 | Fixed an issue where the command-line interface could not access resources when configured as single-sign on in a self-hosted environment. |
| RUN-23561 | 2.18.74 | Fixed an issue where the frontend in airgapped environment attempted to download font resources from the internet. |
| RUN-23789 | 2.18.73 | Fixed an issue where in some cases, it was not possible to download the latest version of the command line interface. |
| RUN-23790 | 2.18.73 | Fixed an issue where in some cases it was not possible to download the Windows version of the command line interface. |
| RUN-23855 | 2.18.73 | Fixed an issue where the pods list in the UI showed past pods. |
| RUN-23909 | 2.18.73 | Fixed an issue where users based on group permissions cannot see dashboards. |
| RUN-23857 | 2.18.72 | Dashboard to transition from Grafana v9 to v10. |
| RUN-24010 | 2.18.72 | Fixed an infinite loop issue in the cluster-sync service. |
| RUN-23040 | 2.18.72 | Fixed an edge case where the Run:ai container toolkit hangs when user is spawning hundreds of sub-processes. |
| RUN-23802 | 2.18.70 | Fixed an issue where new scheduling rules were not applied to existing workloads, if those new rules were set on existing projects which had no scheduling rules before. |
| RUN-23211 | 2.18.70 | Fixed an issue where workloads were stuck at "Pending" when the command-line interface flag --gpu-memory was set to zero. |
| RUN-23778 | 2.18.68 | Fixed an issue where in single-sign-on configuration, the mapping of UID and other properties would sometimes disappear. |
| RUN-23762 | 2.18.68 | Fixed an issue where the wrong version of a Grafana dashboard was displayed in the UI. |
| RUN-21198 | 2.18.66 | Fixed an issue where creating a training workload via yaml (kubectl apply -f) and specifying spec.namePrefix, created infinite jobs. |
| RUN-23541 | 2.18.65 | Fixed an issue where in some cases workload authorization did not work properly due to wrong oidc configuration. |
| RUN-23283 | 2.18.64 | Fixed a permissions issue with the Analytics dashboard post upgrade for SSO Users |
| RUN-23420 | 2.18.63 | Replaced Redis with Keydb |
| RUN-23140 | 2.18.63 | Fixed an issue where distributed workloads were created with the wrong types |
| RUN-23130 | 2.18.63 | Fixed an issue where inference-workload-controller crashed when WorkloadOwnershipProtection was enabled |
| RUN-23334 | 2.18.62 | Updated core Dockerfiles to ubi9 |
| RUN-23296 | 2.18.62 | Fixed an issue in the CLI where runai attach did not work with auto-complete |
| RUN-23215 | 2.18.62 | Fixed an issue where metrics requests from backend to mimir failed for certain tenants. |
| RUN-22138 | 2.18.62 | Fixed an issue where private URL user(s) input was an email and not a string. |
| RUN-23282 | 2.18.61 | CLI documentation fixes |
| RUN-23055 | 2.18.60 | Fixed unified Distributed and Training CLI commands |
| RUN-23243 | 2.18.59 | Fixed an issue where the scope tree wasn't calculating permissions correctly |
| RUN-22463 | 2.18.59 | Fixed an error in CLI bash command |
| RUN-22314 | 2.18.59 | Fixed distributed framework filtering in API commands |
| RUN-23142 | 2.18.58 | Fixed an issue where advanced GPU metrics per-gpu don't have gpu label |
| RUN-23001 | 2.18.58 | Fixed an issue of false overcommit on out-of-memory killed in the “swap” feature. |
| RUN-22851 | 2.18.58 | Fixed an issue where client may get stuck on device lock acquired during “swap” out-migration  |
| RUN-22758 | 2.18.58 | Fixed an issue where inference workload showed wrong status when submission failed. |
| RUN-22544 | 2.18.58 | Updated Grafana version for security vulnerabilities. |
| RUN-23055 | 2.18.57 | Fixed the unified Distributed and Training CLI commands |
| RUN-23014 | 2.18.56 | Fixed an issue where node-scale-adjuster might not create a scaling pod if it is in cool-down and the pod was not updated after that. |
| RUN-22660 | 2.18.56 | Fixed an issue where workload charts have an unclear state |
| RUN-22457 |2.18.55 | Fixed an issue where in rare edge cases the cluster-sync pod was out of memory. |
| RUN-21825 |2.18.55 | Fixed all CVEs in Run:ai's Goofys-based image used for S3 integration. |
| RUN-22871 |2.18.55 | Fixed an issue in runai-container-toolkit where in certain cases when a process is preempted, OOMKill metrics were not published correctly. |
| RUN-22250 |2.18.55 | Fixed an issue where workloads trying to use an ingress URL which is already in use were behaving inconsistentyly instead of failing immediately. |
| RUN-22880 |2.18.55 | Fixed an issue where the minAvailable field for training-operator CRDs did not consider all possible replica specs. |
| RUN-22073 |2.18.55 | Fixed an issue where runai-operator failed to parse cluster URLs ending with '/'. |
| RUN-22453 |2.18.55 | Fixed an issue where in rare edge cases the workload-overseer pod experienced a crash. |
| RUN-22763 |2.18.55 | Fixed an issue where in rare edge cases an 'attach' command from CLI-V2 caused a crash in the cluster-api service. |
| RUN-21948 | 2.18.49 | Fixed an issue where in rare edge cases workload child resources could have duplicate names, causing inconsistent behavior.  |
| RUN-22623 | 2.18.49 | Fixed an issue in Openshift where workloads were not suspended when reaching their idle GPU time limit. |
| RUN-22600 | 2.18.49 | Fixed an issue in AWS EKS clusters where the V1-CLI returned an empty table when listing all projects as an administrator. |
| RUN-21878 | 2.18.49 | Added a label to disable container toolkit from running on certain nodes `run.ai/container-toolkit-enabled`. |
| RUN-22452 | 2.18.47 | Fixed an issue where the scheduler has signature errors if TopologySpreadConstraints was partially defined. |
| RUN-22570 | 2.18.47 | Updated git-sync image to version v4.3.0. |
| RUN-22054 | 2.18.46 | Fixed an issue where users could not attach to jobs. |
| RUN-22377 | 2.18.46 | Removed uncached client from accessrule-controller. |
| RUN-21697 | 2.18.46 | Fixed an issue where client may deadlock on suspension during allocation request. |
| RUN-20073 | 2.18.45 | Fixed an issue where it wasn't possible to authenticate with user credentials in the CLI. |
| RUN-21957 | 2.18.45 | Fixed an issue where there was a missing username-loader container in inference workloads. |
| RUN-22276 | 2.18.39 | Fixed an issue where Knative external URL was missing from the Connections modal. |
| RUN-22280 | 2.18.39 | Fixed an issue when setting scale to zero - there was no pod counter in the Workload grid. |
| RUN-19811 | 2.18.39 | Added an option to set k8s tolerations to run:ai daemonsets (container-toolkit, runai-device-plugin, mig-parted, node-exporter, etc..) . |
| RUN-22128 | 2.18.39 | Added GID, UID, Supplemental groups to the V1 CLI. |
| RUN-21800 | 2.18.37 | Fixed an issue with old workloads residing in the cluster. |
| RUN-21907 | 2.18.34 | Fixed an issue where the SSO user credentials contain supplementary groups as string instead of int. |
| RUN-21272 | 2.18.31 | Fixed an issue with multi-cluster credinatils creation, specifically with the same name in different clusters. |
| RUN-20680 | 2.18.29 | Fixed an issue where workloads page do not present requested GPU. |
| RUN-21200 | 2.18.29 |  Fixed issues with upgrades and connections from v2.13. |
| RUN-20970 | 2.18.27 | Fixed an issue with PUT APIs. |
| RUN-20927 | 2.18.26 | Fixed an issue where node affinity was not updated correctly in projects edit. |
| RUN-20084 | 2.18.26 | Fixed an issue where default department were deleted instead of a message being displayed. |
| RUN-21062 | 2.18.26 | Fixed issues with the API documentation. |
| RUN-20434 | 2.18.25 | Fixed an issue when creating a Project/Department with memory resources requires 'units'. |
| RUN-20923 | 2.18.25 | Fixed an issue with projects/departments page loading slowly. |
| RUN-19872 | 2.18.23 | Fixed an issue where the Toolkit crashes and fails to create and replace the publishing binaries. |
| RUN-20861 | 2.18.22 | Fixed an issue where a pod is stuck on pending due to a missing resource reservation pod. |
| RUN-20842 | 2.18.22 | Fixed an issue of illegal model name with "." in hugging face integration. |
| RUN-20791 | 2.18.22 | Fix an issue where notifications froze after startup. |
| RUN-20865 | 2.18.22 | Fixed an issue where default departments are not deleted when a cluster is deleted. |
| RUN-20698 | 2.18.21 | Fixed an issue where 2 processes requests a device at the same time received the same GPU, causing failures. |
| RUN-20760 | 2.18.18 | Fixed an issue where workload protection UI shows wrong status. |
| RUN-20612 | 2.18.15 | Fixed an issue where it was impossible with the use-table-data to hide node pool columns when there is only one default node pool. |
| RUN-20735 | 2.18.15 | Fixed an issue where nodePool.name is undefined|
| RUN-20721 | 2.18.12 | Added error handling to nodes pages. |
| RUN-20578 | 2.18.10 | Fixed an issue regarding policy enforcement. |
| RUN-20188 | 2.18.10 | Fixed issue with defining SSO in OpenShift identity provider. |
| RUN-20673 | 2.18.9 | Fixed an issue where a researcher uses a distributed elastic job, it is possible that in a specific flow it is scheduled on more than one node-pools. |
| RUN-20360 | 2.18.7 | Fixed an issue where the workload network status was misleading. |
| RUN-22107 | 2.18.7 | Fixed an issue where passwords containing $ were removed from the configuration. |
| RUN-20510 | 2.18.5 | Fixed an issue with external workloads - argocd workflow failed to be updated. |
| RUN-20516 | 2.18.4 | Fixed an issue when after deploying to prod, the cluster-service and authorization-service got multiple OOMKilled every ~1 hour. |
| RUN-20485 | 2.18.2 | Changed policy flags to Beta. |
| RUN-20005 | 2.18.1 | Fixed an issue where a sidecar container failure failed the workload. |
| RUN-20169 | 2.18.1 | Fixed an issue allowing the addition of annotations and labels to workload resources. |
| RUN-20108 | 2.18.1 | Fixed an issue exposing service node ports to workload status. |
| RUN-20160 | 2.18.1 | Fixed an issue with version display when installing a new cluster in an airgapped environment. |
| RUN-19874 | 2.18.1 | Fixed an issue when copying and editing a workload with group access to a tool and the group wasn't removed when selecting users option. |
| RUN-19893 | 2.18.1 | Fixed an issue when using a float number in the scale to zero inactivity value - custom which sometimes caused the submission to fail. |
| RUN-20087 | 2.18.1 | Fixed an issue where inference graphs should be displayed only for minimum cluster versions. |
| RUN-10733 | 2.18.1 | Fixed an issue where we needed to minify and obfuscate our code in production. |
| RUN-19962 | 2.18.1 | Fixed an issue to fix sentry domains regex and map them to relevant projects. |
| RUN-20104 | 2.18.1 | Fixed an issue where frontend Infinite loop on keycloak causes an error. |
| RUN-19906 | 2.18.1 | Fixed an issue where inference workload name validation fails with 2.16 cluster. |
| RUN-19605 | 2.18.1 | Fixed an issue where authorized users should support multiple users (workload-controller) . |
| RUN-19903 | 2.18.1 | Fixed an issue where inference chatbot creation fails with 2.16 cluster. |
| RUN-20409 | 2.18.1 | Fixed an issue where clicking on create new compute during the runai model flow did nothing. |
| RUN-11224 | 2.18.1 | Fixed an issue where ruani-adm collect all logs was not collecting all logs. |
| RUN-20478 | 2.18.1 | Improved workloads error status in overview panel. |
| RUN-19850 | 2.18.1 | Fixed an issue where an application administrator could not submit a job with CLI. |
| RUN-19863 | 2.18.1 | Fixed an issue where department admin received 403 on get tenants and cannot login to UI. |
| RUN-19904 | 2.18.1 | Fixed an issue when filtering by allocatedGPU in get workloads with operator returns incorrect result. |
| RUN-19925 | 2.18.1 | Fixed an issue when upgrade from v2.16 to v2.18 failed on worklaods migrations. |
| RUN-19887 | 2.18.1 | Fixed an issue in the UI when there is a scheduling rule of timeout, the form opened with the rules collapsed and written "none". |
| RUN-19941 | 2.18.1 | Fixed an issue where completed and failed jobs were shown in view pods in nodes screen. |
| RUN-19940 | 2.18.1 | Fixed an issue where setting gpu quota failed because the department quota was taken from wrong department. |
| RUN-19890 | 2.18.1 | Fixed an issue where editing a project by removing its node-affinity stuck updating. |
| RUN-20120 | 2.18.1 | Fixed an issue where project update fails when there is no cluster version. |
| RUN-20113 | 2.18.1 | Fixed an issue in the Workloads table where a researcher does not see other workloads once they clear their filters. |
| RUN-19915 | 2.18.1 | Fixed an issue when turning departments toggles on on cluster v2.11+ the gpu limit is -1 and there is ui error. |
| RUN-20178 | 2.18.1 | Fixed an issue where dashboard CPU tabs appeared in new overview. |
| RUN-20247 | 2.18.1 | Fixed an issue where you couldn't create a workload with namespace of a deleted project. |
| RUN-20138 | 2.18.1 | Fixed an issue where the system failed to create node-type on override-backend env. |
| RUN-18994 | 2.18.1 | Fixed an issue where some limitations for department administrator are not working as expected. |
| RUN-19830 | 2.18.1 | Fixed an issue where resources (GPU, CPU, Memory) units were added to k8s events that are published by run:ai scheduler making our messages more readable. |

## Version 2.18.0 Fixes

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

