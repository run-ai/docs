---
title: Version 2.17
summary: This article describes new features and functionality in the version.
authors:
    - Jason Novich
date: 2024-Apr-14
---

## Release Content - April 14, 2024

* [Deprecation notifications](#deprecation-notifications)
* [Breaking changes](#breaking-changes)

### Researcher

#### Scheduler

* <!-- RUN-14094/RUN-14095/RUN-10891/RUN-10892/RUN-12686/RUN-12687/RUN-12688/RUN-12689/RUN-13654/RUN-13655 Over provisioning -->Added functionality to configure over provisioning ratios for node pools running any kind of workload. Over provisioning assumes that workloads are either under utilizing or intermittently using GPUs. This indicates that the real utilization is lower than the actual GPU allocation requested. Over provisioning allows the administrator to condense more workloads on a single GPU than what the workload required. For more information, see [Optimize performance with Node Level Scheduler](../Researcher/scheduling/node-level-scheduler.md).
  
* Added the *GPU Resource Optimization* feature to the UI. Now you can enable and configure *GPU Portion (Fraction) limit* and *GPU Memory Limit* from the UI. For more information, see [Compute resources UI with Dynamic Fractions](../Researcher/scheduling/dynamic-gpu-fractions.md#compute-reources-ui-with-dynamic-fractions-support). <!-- ADDLINK verify this is working-->

* <!-- RUN-15071/RUN-15680 -- Demo Run:ai integration with OpenShift AI -->Added the ability to set Run:ai as the default scheduler for any project or namespace. This provides the administrator the ability to ensure that all workloads in a project or namespace are scheduled using the Run:ai scheduler. For more information, see [Setting Run:ai as default scheduler](../admin/admin-ui-setup/project-setup.md).

#### Jobs, Workloads, and Workspaces

<!-- RUN-10855/RUN-10856  full status (with new mechanism) for DistributedWorkloads - Not sure what this is. No descriptions int the ticket. -->

* <!-- RUN-11488/RUN-16508/RUN-17720 - Workloads view - Metrics per GPU per pod with RUN-16234 -->Added to the workload details view, the ability to filter by pod. You can now filter metrics and logs per pod or all the pods. Also, the *Workloads* table now has additional columns including connections and preemtability adding more at a glance information about the workload. In addition, using the *Copy & edit* button, you can submit a new workload via CLI based on the selected workload. For more information, see [Workloads](../admin/workloads/README.md#workloads-view).

* <!-- RUN-14524/RUN-14525/RUN-16113/RUN-16488/RUN-15153/RUN-15154 - Asset-based deployments added note for unsupported features -->Added *Inference* to workload types. *Inference* workloads can now be created and managed from the unified *Workloads* table. The *Deployments* workload type has been deprecated, and replaced with *Inference* workloads which are submitted using the workload form. For more information, see [Inference](../admin/workloads/inference-overview.md) and for submitting an *Inference* workload, see [Submitting workloads](../admin/workloads/submitting-workloads.md).

* <!-- RUN-16435/RUN-16668 - Delete workspaces, trainings and jobs views -->Added functionality that supports a single workloads submission selection. Now you can submit workloads by pressing *+ New workloads* in the *Workloads* table. You can submit the following workloads from this table:

      * Workspace
      * Training
      * Inference

    This improvement phases out the previous version's *Workspace* and *Jobs* tables. The *Jobs* table and submission forms have been deprecated and can be reactivated. To reenable the *Jobs* table and forms, press *Tools & settings*, then *General*, then *Workloads*, and then Toggle the *Jobs view* and the *Jobs submission* buttons. For more information, see [Submitting workloads](../admin/workloads/submitting-workloads.md).

* <!-- RUN-16281/16799 - Kubernetes workload readiness probe -->Added the ability to configure a Kubernetes readiness probe. The readiness probe detects resources and workloads that are ready to receive traffic.

#### Assets

* <!-- RUN14616/RUN-14759/RUN-14758/RUN14761/RUN-14772/RUN-14773 - Add configmap as data source, control by policy, CLI -->Added the capability to use a ConfigMap as a data source. The ability to use a ConfigMap as a data source can be configured in the *Data sources* UI, the CLI, and as part of a policy. For more information, see [Setup a ConfigMap as a data source](../Researcher/user-interface/workspaces/create/create-ds.md#create-a-configmap-data-source), [Setup a ConfigMap as a volume using the CLI](../Researcher/cli-reference/runai-submit.md#-configmap-volume-namepath), or [Setup a ConfigMap Resource description fields](../admin/workloads/policies/training-policy.md#configmap-resource-description-fields) in training policies.

* <!-- RUN-16242/RUN-16243/RUN-14596/RUN-14742/RUN-14577/RUN-14743/RUN-16427/RUN-16428 PVC status Add status table for credentials, ConfigMap-DS, PVC-ds -->Added a *Status* column to the *Credentials* table, and the *Data sources* table. The *Status* column displays the state of the resource and provides troubleshooting information about that asset. For more information, see the [Credentials table](../admin/admin-ui-setup/credentials-setup.md#credentials-table) and the [Data sources table](../Researcher/user-interface/workspaces/create/create-ds.md#data-sources-table).

* <!-- RUN-15725/RUN-16236 - Validate all tree scopes for version compatibility for assets creations -->Added functionality for asset creation that validates the asset based on version compatibility of the cluster or the control plane within a specific scope. At time of asset creation, invalid scopes will appear greyed out and will show a pop-up with the reason for the invalidation. This improvement is designed to increase the confidence that an asset is created properly and successfully.

### Run:ai Administrator

#### Configuration and Administration

* <!-- RUN-12250/ RUN-12253 NEw settings module -->Introducing a new *Tools & Settings* menu. The new *Tools & Settings* menu provides a streamlined UI for administrators to configure the Run:ai environment. The new UI is divided into categories that easily identify the areas where the administrator can change settings. The new categories include:

    * Analytics&mdash;features related to analytics and metrics.
    * Resources&mdash;features related to resource configuration and allocation.
    * Workloads&mdash;features related to configuration and submission of workloads.
    * Security&mdash;features related to configuration of SSO (Single Sign On).
    * Notifications&mdash;used for system notifications.
    * Cluster authentication&mdash;snippets related to Researcher authentication.
  
    Some features are now labeled either *Experimental* or *Legacy*. *Experimental* features are new features in the environment, that may have certain instabilities and may not perform as expected. *Legacy* features are features that are in the process of being deprecated, and may be removed in future versions.

#### Clusters

* <!-- RUN-14431/RUN-14432 New columns on cluster table-->Added new columns to the *Clusters* table to show Kubernetes distribution and version. This helps administrators view potential compatibility issues that may arise.

* <!-- RUN-16237/RUN-16238 - Remove cluster filter from top bar in assets RUN-15619/RUN-16391 - Prevent multi-cluster scope & enable single-cluster scope (for all assets including policies & templates) RUN-15718/RUN-16235/RUN-16237/RUN-16238 - Omit the global cluster filter in asset creation forms and grids RUN-16127/RUN- 16128-->Improved the location of the cluster filter. The cluster filter has been relocated to filter bar and the drop down cluster filter in the header of the page has been removed. This improvement creates the following:

    * Filter assets by cluster in the following tables:

        * Data sources
        * Environments
        * Computer resources
        * Templates
        * Credentials

    * Creating a new asset, will automatically display only the scope of the selected cluster.
    * Prevention of account (top most level in the *Scope*) from being selected when creating assets.
    * Enforcement a cluster specific scope. This increases the confidence that an asset is created properly and successfully.
  
    !!! Note
        This feature is only applicable if the all the clusters are version 2.17 and above.

#### Monitoring and Analytics

* <!-- RUN-12901/RUN-16507 - Dashboard improvements MVP -->Improved GPU Overview dashboard. This improvement provides rich and extensive GPU allocation and performance data and now has interactive tiles that provide direct links to the *Nodes*, *Workloads*, and *Departments* tables. Hover over tiles with graphs to show rich data in the selected time frame filter. Tiles with graphs can be downloaded as CSV files. The new dashboard is enabled by default. Use the *Go back to legacy view* to return to the previous dashboard style. For more information, see [Dashboard analysis](../admin/admin-ui-setup/dashboard-analysis.md#overview-dashboard).

* <!-- RUN-15878/RUN-16796/RUN-15878/RUN-16085 omit Knative metrics and update supported metrics and hpa autoscaler -->Updated the knative and autoscaler metrics. Run:ai currently supports the following metrics:

    * Throughput
    * Concurrency
  
    For more information, see [Autoscaling metrics](../admin/workloads/inference-overview.md#autoscaling).
  
* <!-- RUN-11488/RUN-17720 deprecation of direct metrics in favor of API -->Improved availability of metrics by using Run:ai APIs. Using the API endpoints is now the preferred method to retrieve metrics for use in any application. For more information, see [Metrics](../developer/metrics/metrics.md#changed-metrics-and-api-mapping).

#### Authentication and Authorization

* <!-- RUN-15585/RUN-15586 -  View & Edit SSO settings - SAML -->Added new functionality to SAML 2 in the *SSO configuration* in the *Security* category* of the *Tools & Settings* menu. The added functionality assists with troubleshooting login or permissions issues that may arise. Now administrators now have the ability to:

    * View and edit SSO settings.
    * Upload or download a settings XML file.

For more information, see [SSO UI configuration](../admin/runai-setup/authentication/sso.md#step-1-ui-configuration).

<!-- #### Policies - 
no new stories here

### Control and Visibility

no new stories here -->

## Deprecation Notifications

Deprecation notifications allow you to plan for future changes in the Run:ai Platform.

### Feature deprecations

Deprecated features will be available for **two** versions ahead of the notification. For questions, see your Run:ai representative. The following features have been marked for deprecation:

* Jobs&mdash;the *Jobs* feature (submission form and view) has been moved to the category of *Legacy*. To enable them, go to *Tools & Settings*, *General*, open the *Workloads* pane, and then toggle the *Jobs view* and *Job submission* switch to the enabled position.
* Deployments&mdash;the *Deployments* feature has been removed. It has been replaced by *Inference* workloads. For more information, see [Jobs, Workloads, and Workspaces](#jobs-workloads-and-workspaces) above.
* Workspaces view&mdash;the *Workspaces* menu has been removed. You can now submit a *Workspace* workload using the *+ New workload* form from the *Workloads* table.

### API support and endpoint deprecations

The endpoints and parameters specified in the API reference are the ones that are officially supported by Run:ai. For more information about Run:ai's API support policy and deprecation process, see [Developer overview](../developer/overview-developer.md#overview-developer-documentation).

#### Deprecated APIs and API fields

The following list of API endpoints and fields that have been marked for deprecation:

##### Jobs and Pods API

| Deprecated | Replacement |
| -- | -- |
| /v1/k8s/clusters/{uuid}/jobs | /api/v1/workloads |
| /v1/k8s/clusters/{uuid}/jobs/count | /api/v1/workloads/count |
| /v1/k8s/clusters/{uuid}/jobs/{jobId}/pods | /api/v1/workloads/{workloadId}/pods |
| /v1/k8s/clusters/{uuid}/pods | /api/v1/workloads/pods |

##### Clusters API

| Deprecated | Replacement |
| -- | -- |
| /v1/k8s/clusters/{clusterUuid}/metrics | /api/v1/clusters/{clusterUuid}/metrics |

##### Authorization and Authentication API

| Deprecated | Replacement |
| -- | -- |
| /v1/k8s/auth/token/exchange | /api/v1/token |
| /v1/k8s/auth/oauth/tokens/refresh | /api/v1/token |
| /v1/k8s/auth/oauth/apptoken | /api/v1/token |
| /v1/k8s/users/roles | /api/v1/authorization/roles |
| /v1/k8s/users | /api/v1/users |
| /v1/k8s/users/{userId} | /api/v1/users/{userId} |
| /v1/k8s/users/{userId}/roles | /api/v1/authorization/access-rules |
| /v1/k8s/apps | /api/v1/apps |
| /v1/k8s/apps/{clientId} | /api/v1/apps/{appId} |
| /v1/k8s/groups | /api/v1/authorization/access-rules |
| /v1/k8s/groups/{groupName} | /api/v1/authorization/access-rules |
| /v1/k8s/clusters/{clusterId}/departments/{department-id}/access-control | /api/v1/authorization/access-rules |
| /api/v1/authorization/access-rules - `subjectIdFilter` field | Use `filterBy` / `sortBy` fields |
| /api/v1/authorization/access-rules - `scopeType` field | Use `filterBy` / `sortBy` fields |
| /api/v1/authorization/access-rules - `roleId` field | Use `filterBy` / `sortBy` fields |

##### Projects API

| Deprecated | Replacement |
| -- | -- |
| /v1/k8s/clusters/{clusterId}/projects - `permissions` field | /api/v1/authorization/access-rules |
| /v1/k8s/clusters/{clusterId}/projects - `resources` field | Use `nodePoolResources` field |
| /v1/k8s/clusters/{clusterId}/projects - `deservedGpus` field | Use `nodePoolResources` field |
| /v1/k8s/clusters/{clusterId}/projects - `maxAllowedGpus` field | Use `nodePoolResources` field |
| /v1/k8s/clusters/{clusterId}/projects - `gpuOverQuotaWeight` field | Use `nodePoolResources` field |

##### Departments API

| Deprecated | Replacement |
| -- | -- |
| /v1/k8s/clusters/{clusterId}/departments - `resources` field | Use `nodePoolResources` field |
| /v1/k8s/clusters/{clusterId}/departments - `deservedGpus` field | Use `nodePoolResources` field |
| /v1/k8s/clusters/{clusterId}/departments - `allowOverQuota` field | Use `nodePoolResources` field |
| /v1/k8s/clusters/{clusterId}/departments - `maxAllowedGpus` field | Use `nodePoolResources` field |

##### Policy API

| Deprecated | Replacement |
| -- | -- |
| /api/v1/policy/workspace | /api/v2/policy/workspaces |
| /api/v1/policy/training | /api/v2/policy/trainings |

#### Removed APIs and API fields (completed deprecation)

The following list of API endpoints and fields that have completed their deprecation process and therefore will be changed as follows:

##### Assets API

| Endpoint | Change |
| -- | -- |
| /api/v1/asset/compute | `gpuRequest` field was removed and is replaced by the following fields `gpuDevicesRequest`, `gpuRequestType`, `gpuPortionRequest`, `gpuPortionLimit`, `gpuMemoryRequest`, `gpuMemoryLimit`, `migProfile` |

### Metrics deprecations

The following metrics are deprecated and replaced by API endpoints. For details about the replacement APIs, see [Changed Metrics](../developer/metrics/metrics.md#changed-metrics-and-api-mapping):

| Metric |
| -- |
| runai\_active\_job\_cpu\_requested\_cores |
| runai\_active\_job\_memory\_requested\_bytes |
| runai\_cluster\_cpu\_utilization |
| runai\_cluster\_memory\_utilization |
| runai\_gpu\_utilization\_per\_pod\_per\_gpu |
| runai\_gpu\_utilization\_per\_workload |
| runai\_job\_requested\_gpu\_memory |
| runai\_gpu\_memory\_used\_mebibytes\_per\_workload |
| runai\_gpu\_memory\_used\_mebibytes\_per\_pod\_per\_gpu |
| runai\_active\_job\_cpu\_limits |
| runai\_job\_cpu\_usage |
| runai\_active\_job\_memory\_limits |
| runai\_job\_memory\_used\_bytes |

## Breaking changes

Breaking changes notifications allow you to plan around potential changes that may interfere your current workflow when interfacing with the Run:ai Platform.

### Metrics

Be aware that some names of metrics have been changed. For more information, see [Changed Metrics](../developer/metrics/metrics.md#changed-metrics-and-api-mapping).
