---
title: Changelog Version 2.19
summary: This article lists the fixed and known issues in the patch versions as well as additional new features that were added in each patch version.

---

This section provides details on all hotfixes available for version 2.20. Hotfixes are critical updates released between our major and minor versions to address specific issues or vulnerabilities. These updates ensure the system remains secure, stable, and optimized without requiring a full version upgrade. 

## Hotfixes


| Version | Date | Internal ID | Description |
|--|--|--|--|
| 2.20.62 | 05/08/2025| RUN-28377 | Fixed an issue where the CLI cache folder was created in a location where the user might not have sufficient permissions, leading to failures. The cache folder is now created in the same directory as the config file. |
| 2.20.60 | 01/08/2025 | RUN-29092 | Fixed an issue where project quota could not be changed due to scheduling rules being set to 0 instead of null. |
| 2.20.60  | 01/08/2025 | RUN-30746 | Fixed an issue where workloads could not be scheduled if the combined length of the project name and node pool name was excessively long. |
| 2.20.60  | 01/08/2025 | RUN-31039 | Fixed a base image security vulnerability in `libxml2` related to CVE-2025-49796 with severity HIGH. |
| 2.20.60  | 01/08/2025 | RUN-31263 | Fixed an issue where setting defaults for servingPort fields failed and incorrectly required the container port default as well. |
| 2.20.60  | 01/08/2025 | RUN-31265 | Fixed a security vulnerability related to CVE-2025-30749 with severity HIGH. |
| 2.20.60 | 01/08/2025 | RUN-31305 | Fixed a security vulnerability related to CVE-2025-22868 with severity HIGH. |
| 2.20.59 | 14/07/2025 | RUN-28377 | Fixed an issue where the CLI cache folder was created in a location where the user might not have sufficient permissions, leading to failures. The cache folder is now created in the same directory as the config file. |
| 2.20.58 | 14/07/2025 | RUN-28189 | Fixed a security vulnerability in `github.com.golang-jwt.jwt.v5` related to CVE-2025-30204 with severity HIGH. |
| 2.20.57 | 13/07/2025 | RUN-30713 | Fixed an issue where configuring an incorrect Auth URL during CLI installation could lead to connectivity issues. To prevent this, the option to set the Auth URL during installation has been removed. The install script now automatically sets the control plane URL based on the script's source. |
| 2.20.56 | 08/07/2025 | RUN-30673 | Fixed an issue where users with create permissions on one scope and read-only permissions on another were incorrectly allowed to create projects in both scopes. |
| 2.20.56 | 08/07/2025 | RUN-29879 | Fixed an issue where updating the ClusterPolicy did not apply changes to the binder configuration unless the component was manually restarted. |
| 2.20.56 | 08/07/2025 | RUN-29879 | Fixed a security vulnerability in `DOMPurify` related to CVE-2024-24762 with severity HIGH. |
| 2.20.53 | 29/06/2025 | RUN-25883 | Fixed a security vulnerability in `io.netty:netty-handler` related to CVE-2025-24970 with severity HIGH. |
| 2.20.53 | 29/06/2025 | RUN-29049 | Fixed a security vulnerability in `github.com.golang.org.x.crypto` related to CVE-2025-22869 with severity HIGH. |
| 2.20.53 | 29/06/2025 | RUN-30674 | Fixed an issue where, on rare occasions, running the `runai upgrade` command deleted all files in the current directory. |
| 2.20.52 | 24/06/2025 | RUN-29768 | Fixed an issue where the Get token request returned a 500 error when the email mapper failed. |
| 2.20.52 | 24/06/2025 | RUN-29143 | Fixed an issue where nodes could become unschedulable when workloads were submitted to a different node pool. |
| 2.20.51 | 24/06/2025 | RUN-29323 | Fixed an issue where Prometheus failed to send metrics for OpenShift. |
| 2.20.49 | 11/06/2025 | RUN-29548 | Fixed an issue in CLI v2 where the update server did not receive the terminal size during exec commands requiring TTY support. The terminal size is now set once upon session creation, ensuring proper behavior for interactive sessions. |
| 2.20.49 | 11/06/2025 | RUN-26361 | Fixed an issue where Prometheus remote-write credentials were not properly updated on OpenShift clusters. |
| 2.20.46 | 26/05/2025 | RUN-28286 | Fixed an issue where CPU-only workloads incorrectly triggered idle timeout notifications intended for GPU workloads. |
| 2.20.46 | 26/05/2025 | RUN-28851 | Fixed an issue in CLI v2 where the port-forward command terminated SSH connections after 15–30 seconds due to an idle timeout. |
| 2.20.45 | 21/05/2025 | RUN-28608 | Fixed an issue where users with the ML Engineer role were unable to delete multiple inference jobs at once. |
| 2.20.44 | 20/05/2025 | RUN-28665 | Fixed an issue where using serving port authorization fields in the Create Inference API on unsupported clusters did not return an error. |
| 2.20.43 | 15/05/2025 | RUN-27295 | Fixed an issue in CLI v2 where the `--node-type` flag for inference workloads was not properly propagated to the pod specification. |
| 2.20.43 | 15/05/2025 | RUN-27375| Fixed an issue where projects were not visible in the legacy job submission form, preventing users from selecting a target project. |
| 2.20.43 | 15/05/2025 | RUN-27841 | Fixed an issue where workloads without a memory request failed validation in the workload-controller webhook. |
| 2.20.42 | 13/05/2025 | RUN-27514 | Fixed an issue with incorrect calculation of the `ALLOCATED_CPU_MEMORY_BYTES` telemetry metric. |
| 2.20.42 | 13/05/2025 | RUN-27521 | Fixed an issue where disabling CPU quota in the General settings did not remove existing CPU quotas from projects and departments. |
| 2.20.42 | 13/05/2025 | RUN-28380 | Fixed a security vulnerability in `github.com.golang.org.x.crypto` related to CVE-2025-22869 with severity HIGH. |
| 2.20.41 | 06/05/2025 | RUN-28241 | Fixed a security vulnerability in `github.com.golang-jwt.jwt.v5` related to CVE-2025-30204 with severity HIGH. |
| 2.20.41 | 06/05/2025 | RUN-28097 | Fixed an issue where the `ALLOCATED_GPU_COUNT_PER_GPU` metric displayed incorrect data for fractional pods. |
| 2.20.41 | 06/05/2025  | RUN-28006 | Fixed an issue where tokens became invalid for the API server after one hour. |
| 2.20.41 | 06/05/2025  | RUN-27638 | Fixed a security vulnerability in axios related to CVE-2025-27152 with severity HIGH. |
| 2.20.40 | 30/04/2025 | RUN-27837 | Fixed an issue where a node pool’s placement strategy stopped functioning correctly after being edited.|
| 2.20.40 | 30/04/2025 | RUN-27628 | Fixed an issue where a node pool could remain stuck in Updating status in certain cases. |
| 2.20.40 | 30/04/2025 | RUN-27893 | Fixed an issue where workloads submitted with an invalid node port range would get stuck in Creating status. |
| 2.20.39 | 24/04/2025 | RUN-26359 | Fixed an issue in CLI v2 where using the `--toleration` option required incorrect mandatory fields. |
| 2.20.39 | 24/04/2025 | RUN-27088 | Fixed a security vulnerability in tar-fs related to CVE-2024-12905 with severity HIGH. |
| 2.20.39 | 24/04/2025 | RUN-26608 | Fixed an issue by adding a flag to the `cli config set` command and the CLI install script, allowing users to set a cache directory. |
| 2.20.39 | 24/04/2025 | RUN-27247 | Fixed security vulnerabilities in Spring framework used by `db-mechanic service` - CVE-2021-27568, CVE-2021-44228, CVE-2022-22965, CVE-2023-20873, CVE-2024-22243, CVE-2024-22259 and CVE-2024-22262. |
| 2.20.39 | 24/04/2025 | RUN-27309 | Fixed an issue where workloads configured with a multi node pool setup could fail to schedule on a specific node pool in the future after an initial scheduling failure, even if sufficient resources later became available. |
| 2.20.37 | 14/04/2025 | RUN-27233 | Fixed an issue where PVCs were unexpectedly deleted. A validation request is now performed before deletion to ensure the PVC asset has already been removed from the system. |
| 2.20.36 | 09/04/2025 | RUN-24016 | Fixed an issue where workloads could be submitted with non-positive memory quantity values. |
| 2.20.36 | 09/04/2025 | RUN-27075 | Fixed an issue where, in some cases, creating a project through the API with partial parameters would return an error when the "Limit projects from exceeding department quota" setting was enabled. |
| 2.20.36 | 09/04/2025 | RUN-27159 | Fixed an issue where allocated GPU memory for workloads was presented in MB but the value was in MiB. |
| 2.20.36 | 09/04/2025 | RUN-27196 | Fixed an issue where workloads could be submitted with invalid memory quantity values. |
| 2.20.35 | 03/04/2025 | RUN-26878 | Fixed an issue where, in some cases, previous inference request errors caused subsequent successful requests to report latency as NaN (Not a Number) instead of the actual value. As a result, these requests were not displayed in the UI latency graph, and the API returned NaN. |
| 2.20.34 | 02/04/2025 | RUN-26671 | Fixed an issue where compute resource assets configured with multiple whole GPUs (e.g., 3 GPUs at 100%) were incorrectly submitted as a single GPU. |
| 2.20.34 | 03/04/2025 | RUN-27035 | Fixed an issue where, on very rare occasions, a small subset of metrics was missing. |
| 2.20.33 | 31/03/2025 | RUN-26955 | Fixed an issue where duplicate results appeared in some cases for node metrics. |
| 2.20.32 | 26/03/2025 | RUN-25985 | Fixed a bug that caused the deletion of a workload in the UI to fail when ownership protection was enabled and the workload was originally created via the CLI. |
| 2.20.32 | 26/03/2025 | RUN-26641 | Fixed an issue where CLI usage could be blocked even when the CLI version and control plane version were aligned. |
| 2.20.31 | 25/03/2025 | RUN-26324 | Fixed an issue in the documentation where the toleration name was incorrectly marked as mandatory. Also fixed an issue in CLI v2 where the required fields were incorrect: name is no longer mandatory, and key is now required. |
| 2.20.29 | 20/03/2025 | RUN-26062 | Fixed an issue where a new API, intended for clusters running version 2.18 and above, was not disabled for older clusters, causing unintended workload operations — such as creation, deletion, resumption, or stoppage — after upgrading from versions below 2.18 to 2.18 or higher. |
| 2.20.29 | 20/03/2025 | RUN-26691 | Fixed a security vulnerability in axios related to CVE-2025-27152 with severity HIGH. |
| 2.20.29 | 20/03/2025 | RUN-26772 | Fixed an issue where a GET request for a non-existent workload returned an unexpected response format. |
| 2.20.28 | 17/03/2025 | RUN-26630 | Fixed an issue that prevented updating tenant-scoped data sources. |
| 2.20.28 | 17/03/2025 | RUN-26688 | Fixed an issue where node pools could get stuck in Updating state. |
| 2.20.28 | 17/03/2025 | RUN-26684 | Fixed an issue where default node pools were deleted. |
| 2.20.26 | 09/03/2025 | RUN-25987 | Updated all workload APIs to accurately reflect that both creating and deleting workloads return a 202 status code in the API documentation. |
| 2.20.26 | 09/03/2025 | RUN-26240 | CLI v2: Fixed an issue in the install script, where setting the install path environment variable did not install all the files in the correct path. |
| 2.20.26 | 09/03/2025 | RUN-26479  | CLI v2: Fixed an issue where using the wrong workload type in the workload describe command did not display an error. | |
| 2.20.25 | 06/03/2025 | RUN-26253 | CLI v2 list project now supports limit and offset flags. |
| 2.20.25 | 06/03/2025 | RUN-26310 | Fixed an issue where Docker registry credentials/secrets were not found when adding environment variables. |
| 2.20.25 | 06/03/2025 | RUN-26355 | Fixed an issue where collecting metrics on distributed workloads did not start properly. |
| 2.20.25 | 06/03/2025 | RUN-26356 | Fixed an issue where Lowest for over quota weight did not appear as 0. |
| 2.20.25 | 06/03/2025 | RUN-26272 | Fixed an issue where connecting to the SMTP server without credentials was not allowed. |
| 2.20.25 | 06/03/2025 | RUN-26249 | Fixed an issue where creating a policy with the fields `tty` and `stdin` resulted in a validation error. |
| 2.20.25 | 06/03/2025 | RUN-26308 | CLI v2: Fixed several text mismatches in `runai training list --help` and deprecated messages. |
| 2.20.24 | 28/02/2025 | RUN-26304 | Fixed an issue where quota numbers were incorrectly displayed in the reclaim message. |
| 2.20.24 | 28/02/2025 | RUN-25984 | Fixed an issue where api/v1/me/password was missing a validation message when changing a password. | 
| 2.20.23 | 27/02/2025 | RUN-25895 | Fixed an issue where projects that were updated due to changes in their department override fields were not always updated in the cluster. |
| 2.20.23 | 27/02/2025 | RUN-25969 | Fixed an issue where the UI incorrectly rejected valid toleration key inputs during validation checks. |
| 2.20.23 | 27/02/2025 | RUN-25982 | CLI v2: Fixed an issue where interactive mode did not return an error for invalid control plane/Authentication URLs and timeout duration. |
| 2.20.23 | 27/02/2025 | RUN-26135 | Fixed an issue which prevented enabling/disabling email notifications. |
| 2.20.23 | 27/02/2025 | RUN-26178 | Fixed an issue where the upgrade to 2.20 failed to migrate departments and projects if the job to validate the default department to clusters ran first.  |
| 2.20.23 | 27/02/2025 | RUN-26248 | CLI v2: Fixed an issue where submitting an interactive workload with attach was not possible after the workload started running. |
| 2.20.22 | 20/02/2025 | RUN-23048 | Improved error handling to display meaningful messages from the CLI upgrade command. |
| 2.20.22 | 20/02/2025 | RUN-25323 | Fixed an issue in CLI v2 where “stopping the workload” event was missing when workloads reached the project’s running time limit. |
| 2.20.22 | 20/02/2025 | RUN-25511 | Fixed an issue where deleting a workload in CLI v2 caused an error due to a missing response body. The CLI now correctly receives and handles the expected response body. |
| 2.20.22 | 20/02/2025 | RUN-25552 | Fixed an issue where clicking on "View Access Rules" in the Users table displayed only the first group if a user belonged to multiple groups. |
| 2.20.22 | 20/02/2025 | RUN-25571 | Reduced memory consumption to improve stability and increase scaling. |
| 2.20.22 | 20/02/2025 | RUN-25659 | CLI v2: Fixed an issue where min and max replicas  were able to be submitted using TensorFlow. | 
| 2.20.22 | 20/02/2025 | RUN-25946  | Fixed an issue where the Update Inference Spec API did not enforce a minimum cluster version returning a 400 Bad Request for versions below 2.19. |
| 2.20.22 | 20/02/2025 | RUN-25921 | Fixed an issue where the Workspaces, Trainings and Distributed APIs did not enforce a minimum cluster version returning a 400 Bad Request for versions below 2.18. |
| 2.20.21 | 20/02/2025 | RUN-25730 | Fixed an issue where upgrading from 2.19 to 2.20 caused workspaces to be deleted if the project was recreated during the upgrade. |
| 2.20.20 | 20/02/2025 | RUN-25912 | Fixed an issue where pod terminations in PyTorch jobs did not apply the back-off limit attribute causing jobs to fail. |
| 2.20.19 | 20/02/2025  | RUN-25249 | Fixed an issue where submitting a workload using a yaml file with a port but without service type would use ClusterIP as the default service type. If no host port is provided, the target port will be used as the host. |
| 2.20.19 | 20/02/2025 | RUN-25558 | Fixed a memory issue when handling external workloads (deployments, ray etc.) which when scaled caused ETCD memory to increase. |
| 2.20.18 | 03/02/2025 | RUN-24700 | CLI v2: Workload describe command no longer requires type or framework flags. |
| 2.20.17 | 30/01/2025 | RUN-25534 | Fixed range of generated reports to 30 days. |
| 2.20.17 | 30/01/2025 | RUN-25466 | Fixed an issue where an environment variable with the value SECRET was not valid as only SECRET:xxx was accepted. |
| 2.20.16 | 28/01/2025 | RUN-24858 | Fixed High vulnerability CVE-2024-56344 for third party open source 'systeminformation'. |
| 2.20.16 | 28/01/2025 | RUN-25405 | CLI v1: Fixed an issue where the generated PVC was not created properly. |
| 2.20.15 | 24/01/2025 | RUN-24354 | Fixed an issue where migrating workloads failed due to slow network connection. |
| 2.20.14 | 23/01/2025 | RUN-24754 | Fixed an issue where the status of training and interactive workloads was not updated correctly. |
| 2.20.14 | 23/01/2025 | RUN-24838 | Fixed an issue where an environment asset could not be created if it included an environment variable with no value specified. |
| 2.20.11 | 21/01/2025 | RUN-25303 | Fixed an issue where submitting with the --attach flag was supported only in a workspace workload. |
| 2.20.11 | 21/01/2025 | RUN-25291 | Fixed a security vulnerability in golang.org/x/net v0.33.0 with CVE-2024-45338 with severity HIGH. |
| 2.20.10 | 20/01/2025 | RUN-25234 | Fixed an authentication issue in CLI V1. |
| 2.20.9 | 19/01/2025 | RUN-25032 | Fixed an issue where inference workloads with large container sizes skipped the Initializing state. |
| 2.20.9 | 19/01/2025 | RUN-24752 | Fixed an issue where a workload would move to a failed state when created with a custom NodePort that was already allocated. |
| 2.20.9 | 19/01/2025 | RUN-25031 | Fixed an issue in the Templates form where existing credentials in the environment variables section were not displayed. |
| 2.20.5 | 14/01/2025 | RUN-25061 | Fixed a security vulnerability in github.com.go-git.go-git.v5 with CVE CVE-2025-21613 with severity HIGH. |


