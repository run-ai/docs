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

#### Command Line Interface

* <!-- TODO verify link to doc post merge to page RUN-14715/RUN-16337 - CLI V2 -->Added an improved researcher focused Command Line Interface (CLI). The improved CLI brings useablity enhancements for researcher which include:

    * Support multiple clusters
    * Self upgrade
    * Interactive mode
    * Align CLI to be data consistent with UI and API
    * Improved usability and performance

    For more information about installing and using the Improved CLI, see [Improved CLI](../Researcher/cli-reference/new-cli/runai.md).

### Run:ai Administrator

* <!-- TODO verify link to doc post merge RUN-16758/RUN-18432 - Data volumes -->Added *Data Volumes* new feature. Data Volumes are snapshots of datasets stored in Kubernetes Persistent Volume Claims (PVCs). They act as a central repository for training data, and offer several key benefits.

    * Managed with dedicated permissions&mdash;Data admins, a new role within Run.ai, have exclusive control over data volume creation, data population, and sharing.
    * Shared between multiple scopes&mdash;Unlike other Run:ai data sources, data volumes can be shared across projects, departments, or clusters. This promotes data reuse and collaboration within your organization.
    * Coupled to workloads in the submission process&mdash; Similar to other Run:ai data sources, Data volumes can be easily attached to AI workloads during submission, specifying the data path within the workload environment.
  
  For more information, see [Data Volumes](../developer/admin-rest-api/data-volumes.md).

## Deprecation Notifications

Deprecation notifications allow you to plan for future changes in the Run:ai Platform.


## Breaking changes

Breaking changes notifications allow you to plan around potential changes that may interfere your current workflow when interfacing with the Run:ai Platform.


