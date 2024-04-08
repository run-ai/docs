---
title: Version 2.17
summary: This article describes new features and functionality in the version.
authors:
    - Jason Novich
date: 2024-Mar-10
---

## Release Content - April 8, 2024

### Researcher

#### Jobs, Workloads, and Workspaces

* <!-- ADDLINK RUN-11488/RUN-16508 - Workloads view - Metrics per GPU per pod with RUN-16234 -->Added to the workload details the ability to filter by pod. You can now filter metrics and logs per pod or all the pods. In addition, the *Workloads* table now has additional columns including connections and preemtability. In addition, using the *Copy & edit* button, you can submit a new workload based on the selected workload. For more information, see [Workloads](../admin/workloads/README.md#workloads-view).

<!-- RUN-14524/RUN-14525 - Asset-based deployments -->Added *Inference* to workload types. The *Deployments* workload type has been deprecated, and replaced with *Inference* workloads. *Inference* workloads can now be created and managed from the unified *Worklodas* table. For more information, see [Submitting workloads](../admin/workloads/submitting-workloads.md).

* <!-- RUN-16435/RUN-16668 - Delete workspaces, trainings and jobs views -->Added a unified workloads submission pane. Now you can submit workloads by pressing *+New workloads* in the *Workloads* table. You can submit the following workloads from this table:

      * Workspace
      * Training
      * Inference

This improvement phases out the previous version's *Workspace* and *Jobs* tables. The *Jobs* table and submission forms have been deprecated and can be reactivated. To reenable the *Jobs* table and forms, press *Tools & settings*, then *General*, then *Workloads*, and then Toggle the *Jobs view* and the *Jobs submission* buttons. For more information, see [Submitting workloads](../admin/workloads/submitting-workloads.md).

#### Assets

* <!-- RUN14616/RUN-14759 - Add configmap as data source -->Added the capability to use a ConfigMap as a data source. For more information, see [Configure a ConfigMap as a data source](../Researcher/user-interface/workspaces/create/create-ds.md#create-a-configmap-data-source).

* <!-- RUN-16242/RUN-16243 Add status table for credentials, ConfigMap-DS, PVC-ds -->Added a status column to the *Credentials* table, and the *Data sources* table. The *status* column displays the state of the resource and provides troubleshooting information.

* <!-- RUN-15725/RUN-16236 - Validate all tree scopes for version compatibility for assets creations -->Added functionality for asset creation that validates based on version compatibility for the cluster or the control plane within a specific scope. Invalid scopes will appear greyed out and will show a pop-up with the reason for the invalidation. This improvement is designed to increase the confidence that an asset is to be created properly and successfully.

* <!-- RUN-15718/RUN-16235 - Omit the global cluster filter in asset creation forms -->Improved asset creation forms to remove the cluster filter from the top bar. This is only applicable if the cluster version is 2.17 and above.

### Run:ai Administrator

#### Clusters

* <!-- RUN-14431/RUN-14432 New columns on cluster table-->Added new columns to the *Clusters* table to show Kubernetes distribution and version.

* <!-- RUN-16237/RUN16238 - Remove cluster filter from top bar in assets -->Added a new *Cluster* filter to the top bar of the following tables:
  
    * Data sources
    * Environments
    * Computer resources
    * Templates
    * Credentials

* <!-- RUN-15619/RUN-16391 - Prevent multi-cluster scope & enable single-cluster scope (for all assets including policies & templates) -->Added functionality that prevents the account from being selected as the scope when creating assets. This improvement in the UI removes the global cluster filter in the header. Enforcing a cluster specific scope increases the confidence that an asset is created properly and successfully. This is only applicable if the cluster version is 2.17 and above.

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
