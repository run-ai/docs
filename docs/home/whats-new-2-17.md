---
title: Version 2.17
summary: This article describes new features and functionality in the version.
authors:
    - Jason Novich
date: 2024-Mar-10
---

## Release Content - March 31, 2024

### Researcher

#### Jobs, Workloads, and Workspaces

* <!-- TODO @lavianalon RUN-11488/RUN-16508 - Workloads view - Metrics per GPU per pod with RUN-16234 -->Added to the workload details the ability to filter by pod. You can now filter metrics and logs per pod or all the pods. In addition, the *Workloads* table now has additional columns including connections and preemtability. In addition, using the *Copy & edit* button, you can submit a new workload based on the selected workload.

#### Assets

* <!-- RUN14616/RUN-14759 - Add configmap as data source -->Added the capability to use a configmap as a data source. For more information, see [Configure a configmap as a data source](../Researcher/user-interface/workspaces/create/create-ds.md#create-a-configmap-data-source).

* <!-- RUN-16242/RUN-16243 Add status table for credentials, configmap-DS, PVC-ds -->Added a status column to the *Credentials* table, and the *Data sources* table. The *status* column displays the state of the resource and provides troubleshooting information.

* <!-- RUN-15725/RUN-16236 - Validate all tree scopes for version compatibility for assets creations -->Added functionality that validates version compatibility for assets such as credentials, PVC and configmap data sources. Invalid assets will appear greyed out and will show a pop up with the reason for the invalidation.

### Run:ai Administrator

#### Clusters

* <!-- RUN-14431/RUN-14432 New columns on cluster table-->Added new columns to the *Clusters* table to show Kubernetes distribution and version.

* <!-- RUN-16237/RUN16238 - Remove cluster filter from top bar in assets -->Added a new *Cluster* filter to the top bar of the following tables:
  
    * Data sources
    * Environments
    * Computer resources
    * Templates
    * Credentials

* <!-- RUN-15619/RUN-16391 - Prevent multi-cluster scope & enable single-cluster scope (for all assets including policies & templates) -->Added functionality that prevents the account to be selected as part of the scope when creating assets, policies, and templates. Assets, polices, and templates that are created are cluster specific, even when the account has multiple clusters setup.

#### Monitoring and Analytics

* <!-- RUN-12901/RUN-16507 - Dashboard improvements MVP -->New GPU Overview dashboard that provides rich and extensive GPU allocation and performance data. The GPU Overview dashboard now contains interactive tiles that provide direct links to the *Nodes*, *Workloads*, and *Departments* tables. Hover over tiles with graphs to show rich data in the selected time frame filter. Tiles with graphs can be downloaded as CSV files. The new dashboard is enabled by default. Use the *Go back to legacy view* to return to the previous dashboard style. For more information, see [Dashboard analysis](../admin/admin-ui-setup/dashboard-analysis.md#overview-dashboard).

#### Authentication and Authorization

* <!-- RUN-15431/RUN-15585 -  View & Edit SSO settings - SAML -->Added new functionality to SAML 2 SSO configuration to assist with troubleshooting login or permissions issues that may arise. Now administrators have the ability to:

    * View and edit SSO settings.
    * Upload or download a settings XML file.

For more information, see [SSO UI configuration](../admin/runai-setup/authentication/sso.md#step-1-ui-configuration).

#### Policies

### Control and Visibility

## Deprecation Notifications

Deprecation notifications allow you to plan for future changes in the Run:ai Platform. Deprecated features will be available for **two** versions ahead of the notification. For questions, see your Run:ai representative.
