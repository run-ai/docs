---
title: Changelog Version 2.19
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.

---

The following is a list of the known and fixed issues for Run:ai V2.19.

## Hotfixes

| Internal ID | Hotfix # | Description |
| :---- | :---- | :---- |
| RUN-26994 | 2.19.111 | Fixed an issue where session timeouts occurred when using the CLI. |
| RUN-27944 | 2.19.111 | Fixed a security vulnerability in `github.com.golang-jwt.jwt.v4` related to CVE-2025-30204 with severity HIGH. |
| RUN-28097 | 2.19.111 | Fixed an issue where the `allocated_gpu_count_per_gpu` metric displayed incorrect data for fractional pods. |
| RUN-27837 | 2.19.110 | Fixed an issue where a node pool’s placement strategy stopped functioning correctly after being edited. |
| RUN-27628 | 2.19.109 | Fixed an issue where a node pool could remain stuck in Updating status in certain cases. |
| RUN-27640 | 2.19.109 | Fixed a security vulnerability in `github.com.golang-jwt.jwt.v5` related to CVE-2025-30204 with severity HIGH. |
| RUN-27893 | 2.19.109 | Fixed an issue where workloads submitted with an invalid node port range would get stuck in Creating status. |
| RUN-27309 | 2.19.105 | Fixed an issue where workloads configured with a multi node pool setup could fail to schedule on a specific node pool in the future after an initial scheduling failure, even if sufficient resources later became available. |
| RUN-27636 | 2.19.103 | Fixed a security vulnerability in `golang.org.x.crypto` related to CVE-2025-22869 with severity HIGH. |
| RUN-24627 | 2.19.101 | Fixed an issue where GPU_ALLOCATION metric in workloads returned an empty value. |
| RUN-27247 | 2.19.100 | Fixed security vulnerabilities in Spring framework used by `db-mechanic service` - CVE-2021-27568, CVE-2021-44228, CVE-2022-22965, CVE-2023-20873, CVE-2024-22243, CVE-2024-22259 and CVE-2024-22262. |
| RUN-26359 | 2.19.99 | Fixed an issue in CLI v2 where using the `--toleration` option required incorrect mandatory fields. |
| RUN-27088 | 2.19.88 | Fixed a security vulnerability in tar-fs related to CVE-2024-12905 with severity HIGH. |
| RUN-27309 | 2.19.88 | Fixed an issue where workloads configured with a multi node pool setup could fail to schedule on a specific node pool in the future after an initial scheduling failure, even if sufficient resources later became available. |
| RUN-24016 | 2.19.86 | Fixed an issue where workloads could be submitted with non-positive memory quantity values. |
| RUN-27075 | 2.19.86 | Fixed an issue where, in some cases, creating a project through the API with partial parameters would return an error when the "Limit projects from exceeding department quota" setting was enabled. |
| RUN-27159 | 2.19.86 | Fixed an issue where allocated GPU memory for workloads was presented in MB but the value was in MiB. |
| RUN-27196 | 2.19.86 | Fixed an issue where workloads could be submitted with invalid memory quantity values. |
| RUN-27269 | 2.19.86 | Fixed an issue where the OKE environment was not correctly identified by the operator, causing it to behave incorrectly and not support fractional GPU allocations. |
| RUN-26956 | 2.19.85 | Fixed an issue where resources used by pods in the "Initializing" phase were not considered allocated. |
| RUN-27035 | 2.19.85 | Fixed an issue where, on very rare occasions, a small subset of metrics was missing. |
| RUN-26878 | 2.19.85 | Fixed an issue where, in some cases, previous inference request errors caused subsequent successful requests to report latency as NaN (Not a Number) instead of the actual value. As a result, these requests were not displayed in the UI latency graph, and the API returned NaN. |
| RUN-26324 | 2.19.84 | Fixed an issue in the documentation where the toleration name was incorrectly marked as mandatory. Also fixed an issue in CLI v2 where the required fields were incorrect: name is no longer mandatory, and key is now required. |
| RUN-26800 | 2.19.84 | Fixed an issue where the `runai list nodes` command in CLI v1 did not display the correct number of free GPUs when using GPU memory. |
| RUN-26955 | 2.19.84 | Fixed an issue where duplicate results appeared in some cases for node metrics. |
| RUN-26691 | 2.19.76 | Fixed a security vulnerability in axios related to CVE-2025-27152 with severity HIGH. |
| RUN-26764 | 2.19.76 | Fixed an issue where in some cases, a node pool was stuck in "Creating" phase. |
| RUN-26688 | 2.19.76 | Fixed an issue where node pools could get stuck in Updating state. |
| RUN-26684 | 2.19.76 | Fixed an issue where default node pools were deleted. |
| RUN-25382 | 2.19.74 | Fixed an issue where invalid min/max policy values caused an error in the policy pod. |
| RUN-25987 | 2.19.74 | Updated all workload APIs to accurately reflect that both creating and deleting workloads return a 202 status code in the API documentation. |
| RUN-26479 | 2.19.74 | CLI v2: Fixed an issue where using the wrong workload type in the workload describe command did not display an error. |
| RUN-26240 | 2.19.74 | CLI v2: Fixed an issue in the install script, where setting the install path environment variable did not install all the files in the correct path. |
| RUN-26272 | 2.19.73 | Fixed an issue where connecting to the SMTP server without credentials was not allowed. |
| RUN-26308 | 2.19.73 | CLI v2: Fixed several text mismatches in `runai training list --help` and deprecated messages.|
| RUN-26355 | 2.19.72 | Fixed an issue where collecting metrics on distributed workload did not start properly.  |
| RUN-26249 | 2.19.72 | Fixed an issue where creating a policy with the fields `tty` and `stdin` resulted in a validation error. |
| RUN-26304 | 2.19.71 | Fixed an issue where quota numbers was incorrectly displayed in the reclaim message. |
| RUN-26248 | 2.19.70 | CLI v2: Fixed an issue where submitting an interactive workload with attach was not possible after the workload started running. |
| RUN-25323 | 2.19.68 | Fixed an issue in CLI v2 where “stopping the workload” event was missing when workloads reached the project’s running time limit. |
| RUN-25946 | 2.19.68 | Fixed an issue where the Update Inference Spec API did not enforce a minimum cluster version returning a 400 Bad Request for versions below 2.19. |
| RUN-25921 | 2.19.68 | Fixed an issue where the Workspaces, Trainings and Distributed APIs did not enforce a minimum cluster version returning a 400 Bad Request for versions below 2.18. |
| RUN-25571 | 2.19.66 | Reduced memory consumption to improve stability and increase scaling. |
| RUN-25912 | 2.19.65 | Fixed an issue where pod terminations in PyTorch jobs did not apply the back-off limit attribute, causing jobs to fail. |
| RUN-25552 | 2.19.64 | Fixed an issue where clicking on "View Access Rules" in the Users table displayed only the first group if a user belonged to multiple groups. |
| RUN-25558 | 2.19.59 | Fixed a memory issue when handling external workloads (deployments, ray etc.) which when scaled caused ETCD memory to increase. |
| RUN-25249 | 2.19.58 | Fixed an issue where submitting a workload using a yaml file with a port but without service type would use ClusterIP as the default service type. If no host port is provided, the target port will be used as the host. |
| RUN-24700 | 2.19.57 |  CLI v2: Workload describe command no longer requires type or framework flags. |
| RUN-25511 | 2.19.57 | Fixed an issue where deleting a workload in the CLI v2 caused an error due to a missing response body. The CLI now correctly receives and handles the expected response body. |
| RUN-24858 | 2.19.56 | Fixed high vulnerability CVE-2024-56344 for third party open source 'systeminformation'. |
| RUN-25466 | 2.19.56 | Fixed an issue where an environment variable with the value SECRET was not valid as only SECRET:xxx was accepted. |
| RUN-17284 | 2.19.49 | Fixed an issue where workloads were suspended when set with the termination after preemption option. |
| RUN-25290 | 2.19.49 | Fixed a security vulnerability in golang.org/x/net v0.33.0 with CVE-2024-45338 with severity HIGH. |
| RUN-25234 | 2.19.49 | Fixed security vulnerabilities by updating oauth2 proxy image to the latest. |
| RUN-25234 | 2.19.48 | Fixed an authentication issue in CLI V1. |
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
