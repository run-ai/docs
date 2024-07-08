---
title: Version 2.18
summary: This article describes new features and functionality in the version.
authors:
    - Jamie Weider
    - Jason Novich
date: 2024-June-14
---

## Release Content - June 30, 2024

* [Deprecation notifications](#deprecation-notifications)
* [Breaking changes](#breaking-changes)

### Researcher

#### Jobs, Workloads, and Workspaces

* <!-- Run-14732/Run-14733 Add backoff limit to workspace & standard training -->Added to UI backoff limit functionality to Training and Workspace workloads. The backoff limit is the maximum number of retry attempts for failed workloads. After reaching the limit, the workload's status will change to `Failed`. The UI will display the default number of retries based on 6 attempts for each pod in the workload. (For example, 6 pods = 36 attempts).

* <!-- RUN-18944/RUN-18945 Changing "Auto-deletion" default and presentation of the default value in the UI -->Updated *Auto-deletion time* default value from **never** to **30 days**. The *Auto-deletion time* count starts when any Run:ai workload reaches a a completed, or failed status will be automatically deleted (including logs). This change only affects new or cloned workloads.

* <!-- TODO add doc link RUN-16917/RUN-19363 move to top Expose secrets in workload submission -->Added new *Data sources* of type *Secret* to workload form. *Data sources* of type *Secret* are used to hide 3rd party access credentials when submitting workloads. For more information, see [Workloads]().

* <!-- TODO change link and check the page for correct infoRUN-16830/RUN-16831 -  Graphs & special metrics for inference -->Added new graphs for *Inference* workloads. The new graphs provide more information for *Inference* workloads to help analyze performance of the workloads. New graphs include Latency, Throughput, and number of replicas. For more information, see [Workloads View](../admin/workloads/README.md#workloads-view).

* <!-- TODO add link to doc when ready - get approval for text RUN-16805/RUN-17416 - Provide latency-based metric for autoscaling for requests -->Added latency metric for autoscaling. This feature allows automatic scale-up/down the number of replicas of a Run:ai inference workload based on the threshold set by the ML Engineer. This ensures that response time is kept under the target SLA.

* <!-- TODO Add to inference doc models explanation after autoscaling.  RUN-16872/RUN-18526 Separating ChatUi from model in favor of coherent autoscaling -->Improved autoscaling for inference models by taking out ChatBot UI from models images. By moving ChatBot UI to predefined *Environments*, autoscaling is more accurate by taking into account all types of requests (API, and ChatBot UI). Adding a ChatBot UI environment preset by Run:ai allows AI practitioners to easily connect them to workloads.

* <!-- TODO add this as a section to the "models catalog" doc - wait for release from Lior RUN-16806/RUN-16807 - Hugging face integration Added Hugging Face catalog integration in inference workloads. Run:ai has added Hugging Face integration directly to the inference workload form, providing the ability to add models and data sets directly from the Hugging Face catalog. Hugging Face is a ML platform that helps users build, deploy and train machine learning models. It provides the infrastructure to demo, run and deploy artificial intelligence (AI) in live applications. Users can also browse through models and data sets that other people have uploaded. For more information on how Hugging Face is integrated, see [Hugging Face](link to hugging face in the models doc). -->

#### Command Line Interface

* <!-- TODO verify link to doc post merge to page RUN-14715/RUN-16337 - CLI V2 -->Added an improved researcher focused Command Line Interface (CLI). The improved CLI brings usability enhancements for researcher which include:

    * Support multiple clusters
    * Self upgrade
    * Interactive mode
    * Align CLI to be data consistent with UI and API
    * Improved usability and performance

    This is an early access feature available for customers to use; however be aware that there may be functional gaps versus the legacy CLI.
    For more information about installing and using the Improved CLI, see [Improved CLI](../Researcher/cli-reference/new-cli/runai.md).

#### GPU memory swap

* <!-- TODO verify link to doc post merge to page RUN-12615/RUN-12616 -->Added new GPU to CPU memory swap. To ensure efficient usage of an organization’s resources, Run:ai provides multiple features on multiple layers to help administrators and practitioners maximize their existing GPUs resource utilization.  Run:ai’s GPU memory swap feature helps administrators and AI practitioners to further increase the utilization of existing GPU HW by improving GPU sharing between AI initiatives and stakeholders. This is done by expending the GPU physical memory to the CPU memory which is typically an order of magnitude larger than that of the GPU. For more information see, [GPU Memory Swap](../Researcher/scheduling/gpu-memory-swap.md).

#### YAML Workload Reference table

* <!-- TODO verify doc to upload pdf file RUN-17487/RUN-17656 -->Added a new YAML reference document that contains the value types and workload YAML references. Each table contains the field name, its description and the supported Run:ai workload types. The YAML field details contains information on the value type and currently available example workload snippets. For more information see, [YAML Reference]().

#### Assets

* <!-- RUN-18486/RUN-18469 - Add description field to assets -->Improved UI asset creation form by adding a *Description* field. Now asset creators can add a free text description(max 250 characters) to any asset created. The description field is intended to help explain the nature and goal of the asset, this way AI practitioners will be able to make better decisions when choosing their assets in workload creation.

### Run:ai Administrator

#### Data Sources

* <!-- TODO verify link to doc post merge RUN-16758/RUN-18432 - Data volumes -->Added *Data Volumes* new feature. Data Volumes are snapshots of datasets stored in Kubernetes Persistent Volume Claims (PVCs). They act as a central repository for training data, and offer several key benefits.

    * Managed with dedicated permissions&mdash;Data Admins, a new role within Run.ai, have exclusive control over data volume creation, data population, and sharing.
    * Shared between multiple scopes&mdash;unlike other Run:ai data sources, data volumes can be shared across projects, departments, or clusters. This promotes data reuse and collaboration within your organization.
    * Coupled to workloads in the submission process&mdash;similar to other Run:ai data sources, Data volumes can be easily attached to AI workloads during submission, specifying the data path within the workload environment.
  
    For more information, see [Data Volumes](../developer/admin-rest-api/data-volumes.md).

* <!-- TODO fix doc link RUN-16917/RUN-19363 Expose secrets in workload submission -->Added new data source of type *Secret*. Run:ai now allows you to configure a *Credential* as a data source. A *Data source* of type *Secret* is best used in workloads so that access to 3rd party interfaces and storage used in containers, keep access credentials hidden. For more information, see [Secrets as a data source](../Researcher/user-interface/workspaces/create/create-ds.md#create-a-new-data-source#secret).

#### Credentials

* <!-- TODO add doc link RUN-16917/RUN-19363 Expose secrets in workload submission -->Added new *Generic secret* to *Credentials*. *Credentials* had been used only for access to data sources (S3, Git, etc.). However, AI practitioners need to use secrets to access sensitive data (interacting with 3rd party APIs, or other services) without having to put their credentials in their source code. *Generic secrets* leverage multiple key value pairs which helps reduce the number of Kubernetes resources and simplifies resource management by reducing the overhead associated with maintaining multiple Secrets. *Generic secrets* are best used as a data source of type *Secret* so that they can be used in containers to keep access credentials hidden.

#### Single Sign On

* <!-- TODO Change ticket numbers and description RUN-16859/RUN-16860-->Added support for Single Sign On using OpenShift v4 (OIDC based). When using OpenShift, you must first define OAuthClient which interacts with OpenShift's OAuth server to authenticate users and request access tokens. For more information, see [Single Sign-On](../admin/runai-setup/authentication/sso/).

* <!-- RUN-16788/RUN-16866 - OIDC Scopes -->Added OIDC scopes to authentication requests. OIDC Scopes are used to specify what access privileges are being requested for access tokens. The scopes associated with the access tokens determine what resource are available when they are used to access OAuth 2.0 protected endpoints. Protected endpoints may perform different actions and return different information based on the scope values and other parameters used when requesting the presented access token. For more information, see [UI configuration](../admin/runai-setup/authentication/sso/#step-1-ui-configuration).

#### Ownership protection

* <!-- TODO Need to confirm text RUN-19098/RUN-19557 Need to add link -->Added new ownership protection feature. Run:ai *Ownership Protection* ensures that only authorized users can delete or modify workloads. This feature is designed to safeguard important jobs and configurations from accidental or unauthorized modifications by users who did not originally create the workload. For configuration information, see your Run:ai representative.

#### System notifications

* <!-- TODO verify doc links RUN-12796/ RUN-20001 - Notifications infrastructure at the Control Plane -->Added new system notifications feature. Email Notifications sends alerts for critical workload life cycle changes empowering data scientists to take necessary actions and prevent delays.
  
    * System administrators will need to configure the email notifications. For more information, see [System notifications](docs/admin/runai-setup/notifications/notifications.md).
    * AI Practitioners will need to setup the types of notifications they want to receive. For more information, see [Email notifications](docs/Researcher/best-practices/researcher-notifications.md).

## Deprecation Notifications

Deprecation notifications allow you to plan for future changes in the Run:ai Platform.

### Feature deprecations

Deprecated features will be available for **two** versions ahead of the notification. For questions, see your Run:ai representative.

<!-- * Command Line Interface (CLI)&mdash;from cluster version 2.18 and higher, the *Legacy CLI* is deprecated. The *Legacy CLI* is still available for use on clusters that are 2.18 or higher, but it is recommended that you use the new *Improved CLI*. -->

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
