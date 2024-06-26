---
title: Version 2.18
summary: This article describes new features and functionality in the version.
authors:
    - Jamie Weider
date: 2024-June-14
---

## Release Content - June 30, 2024

* [Deprecation notifications](#deprecation-notifications)
* [Breaking changes](#breaking-changes)

### Researcher

#### Jobs, Workloads, and Workspaces

* <!-- TODO ADD LINK TO DOC Run-14732/Run-14733 Add backoff limit to workspace & standard training -->Added backoff limit functionality to Training and Workspace workloads. The backoff limit is the maximum number of retry attempts for failed workloads. After reaching the limit, the workload's status will change to `Failed`.

* <!-- RUN-16830/RUN-16831 - Graphs & special metrics for inference -->Added new graphs for *Inference* workloads. The new graphs provide more information for *Inference* workloads to help analyze performance of the workloads. For more information, see [Workloads View](../admin/workloads/README.md#workloads-view).

* <!-- RUN-18944/RUN-18945 Changing "Auto-deletion" default and presentation of the default value in the UI -->Updated *Auto-deletion time* default value. Previously the default was **90 days** now the default is **30 days**.

* <!-- TODO better explanation RUN-16917/RUN-19363 Expose secrets in workload submission -->Added new data sources to workload to include project secrets.

#### Command Line Interface

* <!-- TODO verify link to doc post merge to page RUN-14715/RUN-16337 - CLI V2 -->Added an improved researcher focused Command Line Interface (CLI). The improved CLI brings usability enhancements for researcher which include:

    * Support multiple clusters
    * Self upgrade
    * Interactive mode
    * Align CLI to be data consistent with UI and API
    * Improved usability and performance

    For more information about installing and using the Improved CLI, see [Improved CLI](../Researcher/cli-reference/new-cli/runai.md).

#### GPU memory swap

* <!-- TODO verify link to doc post merge to page RUN-12615/RUN-12616 -->To ensure efficient usage of an organization’s resources, Run:ai provides multiple features on multiple layers to help administrators and practitioners maximize their existing GPUs resource utilization.  Run:ai’s GPU memory swap feature helps administrators and AI practitioners to further increase the utilization of existing GPU HW by improving GPU sharing between AI initiatives and stakeholders. This is done by expending the GPU physical memory to the CPU memory which is typically an order of magnitude larger than that of the GPU.  For more information see, [GPU Memory Swap](../Researcher/scheduling/gpu-memory-swap.md).

### Run:ai Administrator

#### Data Sources

* <!-- TODO verify link to doc post merge RUN-16758/RUN-18432 - Data volumes -->Added *Data Volumes* new feature. Data Volumes are snapshots of datasets stored in Kubernetes Persistent Volume Claims (PVCs). They act as a central repository for training data, and offer several key benefits.

    * Managed with dedicated permissions&mdash;Data Admins, a new role within Run.ai, have exclusive control over data volume creation, data population, and sharing.
    * Shared between multiple scopes&mdash;unlike other Run:ai data sources, data volumes can be shared across projects, departments, or clusters. This promotes data reuse and collaboration within your organization.
    * Coupled to workloads in the submission process&mdash;similar to other Run:ai data sources, Data volumes can be easily attached to AI workloads during submission, specifying the data path within the workload environment.
  
    For more information, see [Data Volumes](../developer/admin-rest-api/data-volumes.md).

* <!-- TODO better explanation RUN-16917/RUN-19363 Expose secrets in workload submission -->Added new data source type. Run:ai now allows you to configure a *Credential* (Secret) as a data source.

#### Credentials

* <!-- TODO better explanation RUN-16917/RUN-19363 Expose secrets in workload submission -->Added new *Generic secret* to the *Credentials*.

#### SSO

* <!-- TODO Change ticket numbers and description RUN-XXXXX/RUN-XXXXX-->Run:ai now supports SSO using OpenShift v4 (which is based on OIDC). Before using OpenShift, you must first define OAuthClient which interacts with OpenShift's OAuth server to authenticate users and request access tokens. For more information, see [Single Sign-On](../admin/runai-setup/authentication/sso/).

* <!-- RUN-XXXX/RUN-XXXXX - OIDC Scopes -->OIDC scopes have been added to the authentication request. Scopes are used to specify what access privileges are being requested for access tokens. The scopes associated with the access tokens determine what resource are available when they are used to access OAuth 2.0 protected endpoints. Protected endpoints may perform different actions and return different information based on the scope values and other parameters used when requesting the presented access token. For more information, see [UI configuration](../admin/runai-setup/authentication/sso/#step-1-ui-configuration).

## Deprecation Notifications

Deprecation notifications allow you to plan for future changes in the Run:ai Platform.

### Feature deprecations

Deprecated features will be available for **two** versions ahead of the notification. For questions, see your Run:ai representative.

* Command Line Interface (CLI)&mdash;from cluster version 2.18 and higher, the *Legacy CLI* is deprecated. The *Legacy CLI* is still available for use on clusters that are 2.18 or higher, but it is recommended that you use the new *Improved CLI*.

### API support and endpoint deprecations

The endpoints and parameters specified in the API reference are the ones that are officially supported by Run:ai. For more information about Run:ai's API support policy and deprecation process, see [Developer overview](../developer/overview-developer.md#api-support).

#### Deprecated APIs and API fields

##### Departments API

| Deprecated | Replacement |
| --- |  --- |
| /v1/k8s/clusters/{clusterId}/departments | /api/v1/org-unit/departments |
| /v1/k8s/clusters/{clusterId}/departments/{department-id} | /api/v1/org-unit/departments/{departmentId} |
| /v1/k8s/clusters/{clusterId}/departments/{department-id} | /api/v1/org-unit/departments/{departmentId}+PUT/PATCH /api/v1/org-unit/departments/{departmentId}/resources |

##### Projects APi

| Deprecated | Replacement |
| --- |  --- |
| /v1/k8s/clusters/{clusterId}/projects | /api/v1/org-unit/projects |
| /v1/k8s/clusters/{clusterId}/projects/{id} | /api/v1/org-unit/projects/{projectId} |
| /v1/k8s/clusters/{clusterId}/projects/{id} | /api/v1/org-unit/projects/{projectId} + /api/v1/org-unit/projects/{projectId}/resources |

## Breaking changes

Breaking changes notifications allow you to plan around potential changes that may interfere your current workflow when interfacing with the Run:ai Platform.


