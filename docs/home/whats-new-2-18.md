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

* <!-- TODO ADDLINK to page RUN-14715/RUN-16337 - CLI V2 -->Added an improved researcher focused Command Line Interface (CLI). The improved CLI brings useablity enhancements for researcher which include:

    * Support multiple clusters
    * Self upgrade
    * Interactive mode
    * Align CLI to be data consistent with UI and API
    * Improved usability and performance

    For more information about installing and using the Improved CLI, see [Improved CLI]().

### Run:ai Administrator
New info here
## Deprecation Notifications

Deprecation notifications allow you to plan for future changes in the Run:ai Platform.


## Breaking changes

Breaking changes notifications allow you to plan around potential changes that may interfere your current workflow when interfacing with the Run:ai Platform.


