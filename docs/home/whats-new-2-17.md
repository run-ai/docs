---
title: Version 2.17
summary: This article describes new features and functionality in the version.
authors:
    - Jason Novich
date: 2024-Mar-10
---

## Release Content - April 8, 2024

### Researcher

#### Scheduler

* <!-- RUN-14094/RUN-14095/RUN-10891/RUN-10892/RUN-12686/RUN-12687/RUN-12688/RUN-12689/RUN-13654/RUN-13655 Over provisioning -->Added functionality to configure over provisioning ratios for node pools running any kind of workload. 

* <!-- RUN-15071/RUN-15680 -- Demo Run:ai integration with OpenShift AI -->Added the ability to set Run:ai as the default scheduler for any project or namespace. This provides the administrator the ability to ensure that all workloads in a project or namespace are scheduled using the Run:ai scheduler. For more information, see [Setting Run:ai as default scheduler](../admin/admin-ui-setup/project-setup.md).

#### Jobs, Workloads, and Workspaces

<!-- RUN-10855/RUN-10856  full status (with new mechanism) for DistributedWorkloads - Not sure what this is. No descriptions int the ticket. -->

* <!-- RUN-11488/RUN-16508/RUN-17720 - Workloads view - Metrics per GPU per pod with RUN-16234 -->Added to the workload details the ability to filter by pod. You can now filter metrics and logs per pod or all the pods. In addition, the *Workloads* table now has additional columns including connections and preemtability. In addition, using the *Copy & edit* button, you can submit a new workload based on the selected workload. For more information, see [Workloads](../admin/workloads/README.md#workloads-view).

<!-- RUN-14524/RUN-14525 - Asset-based deployments -->Added *Inference* to workload types. The *Deployments* workload type has been deprecated, and replaced with *Inference* workloads. *Inference* workloads can now be created and managed from the unified *Workloads* table. For more information, see [Inference](../admin/workloads/inference-overview.md) and for submitting an *Inference* workload, see [Submitting workloads](../admin/workloads/submitting-workloads.md).

* <!-- RUN-16435/RUN-16668 - Delete workspaces, trainings and jobs views -->Added a unified workloads submission pane. Now you can submit workloads by pressing *+New workloads* in the *Workloads* table. You can submit the following workloads from this table:

      * Workspace
      * Training
      * Inference

This improvement phases out the previous version's *Workspace* and *Jobs* tables. The *Jobs* table and submission forms have been deprecated and can be reactivated. To reenable the *Jobs* table and forms, press *Tools & settings*, then *General*, then *Workloads*, and then Toggle the *Jobs view* and the *Jobs submission* buttons. For more information, see [Submitting workloads](../admin/workloads/submitting-workloads.md).

<!-- RUN-15153/ RUN-15154 Create catalog inference workload from workload grid -->

* <!-- RUN-16281/16799 - Kubernetes workload readiness probe -->Added the ability to configure a Kubernetes readiness probe. The readiness probe detects resources and workloads that are ready to receive traffic.

#### Assets

* <!-- RUN14616/RUN-14759/RUN-14758/RUN14761/RUN-14772/RUN-14773 - Add configmap as data source, control by policy, CLI -->Added the capability to use a ConfigMap as a data source. The ability to use a ConfigMap as a data source can be configured in the *Data sources* UI, the CLI, and as part of a policy. For more information, see [Configure a ConfigMap as a data source](../Researcher/user-interface/workspaces/create/create-ds.md#create-a-configmap-data-source), [Configure a ConfigMap as a volume using the CLI](../Researcher/cli-reference/runai-submit.md#-configmap-volume-namepath), or [ConfigMap Resource description fields]().<!--ADDLINK for policies here -->

* <!-- RUN-16242/RUN-16243/RUN-14596/RUN-14742/RUN-14577/ RUN-14743 PVC status Add status table for credentials, ConfigMap-DS, PVC-ds -->Added a *Status* column to the *Credentials* table, and the *Data sources* table. The *Status* column displays the state of the resource and provides troubleshooting information. For more information, see the [Credentials table](../admin/admin-ui-setup/credentials-setup.md#credentials-table) and the [Data sources table](../Researcher/user-interface/workspaces/create/create-ds.md#data-sources-table).

* <!-- RUN-15725/RUN-16236 - Validate all tree scopes for version compatibility for assets creations -->Added functionality for asset creation that validates based on version compatibility for the cluster or the control plane within a specific scope. Invalid scopes will appear greyed out and will show a pop-up with the reason for the invalidation. This improvement is designed to increase the confidence that an asset is to be created properly and successfully.

* <!-- RUN-15718/RUN-16235 - Omit the global cluster filter in asset creation forms -->Improved asset creation forms to remove the cluster filter from the top bar. This is only applicable if the cluster version is 2.17 and above.

### Run:ai Administrator

#### Configuration and Administration

* <!-- RUN-12250/ RUN-12253 NEw settings module -->Introducing a new *Tools & Settings* menu. The new *Tools & Settings* menu provides a streamlined UI for administrators to adjust the configuration of the Run:ai environment. The new UI is broken down into categories that easily identify the ares where the administrator will want to change settings. the new categories include:

    * Analytics&mdash;features related to analysis and metrics.
    * Resources&mdash;features related to resource configuration and allocation.
    * Workloads&mdash;features related to configuration and submission of workloads.
    * Security&mdash;features related to configuration of SSO (Single Sign On).
    * Notifications&mdash;used for system notifications.
    * Cluster authentication&mdash;snippets related to Researcher authentication.
  
Features in the categories are now labeled either *Experimental* or *Legacy*. *Experimental* features are new features in the environment, that may have certain instabilities and may not perform as expected. *Legacy* features are features that are in the process of being deprecated, and may be removed in future versions.

#### Clusters

* <!-- RUN-14431/RUN-14432 New columns on cluster table-->Added new columns to the *Clusters* table to show Kubernetes distribution and version to enable administrators to view potential compatibility issues that may arise.

* <!-- RUN-16237/RUN16238 - Remove cluster filter from top bar in assets -->Added a new *Cluster* filter to the top bar of the following tables:
  
    * Data sources
    * Environments
    * Computer resources
    * Templates
    * Credentials

* <!-- RUN-15619/RUN-16391 - Prevent multi-cluster scope & enable single-cluster scope (for all assets including policies & templates) -->Added functionality that prevents the account from being selected as the scope when creating assets. This improvement in the UI removes the global cluster filter in the header. Enforcing a cluster specific scope increases the confidence that an asset is created properly and successfully. This is only applicable if the cluster version is 2.17 and above.

#### Monitoring and Analytics

* <!-- RUN-12901/RUN-16507 - Dashboard improvements MVP -->New GPU Overview dashboard that provides rich and extensive GPU allocation and performance data. The GPU Overview dashboard now contains interactive tiles that provide direct links to the *Nodes*, *Workloads*, and *Departments* tables. Hover over tiles with graphs to show rich data in the selected time frame filter. Tiles with graphs can be downloaded as CSV files. The new dashboard is enabled by default. Use the *Go back to legacy view* to return to the previous dashboard style. For more information, see [Dashboard analysis](../admin/admin-ui-setup/dashboard-analysis.md#overview-dashboard).

* <!-- RUN-15878/RUN-16796 omit Knative metrics -->

* <!-- RUN-11488/RUN-17720 deprecation of direct metrics in favor of API -->

#### Authentication and Authorization

* <!-- RUN-15585/RUN-15586 -  View & Edit SSO settings - SAML -->Added new functionality to SAML 2 SSO configuration to assist with troubleshooting login or permissions issues that may arise. Now administrators have the ability to:

    * View and edit SSO settings.
    * Upload or download a settings XML file.

For more information, see [SSO UI configuration](../admin/runai-setup/authentication/sso.md#step-1-ui-configuration).


#### Policies

### Control and Visibility

## Deprecation Notifications

Deprecation notifications allow you to plan for future changes in the Run:ai Platform. Deprecated features will be available for **two** versions ahead of the notification. For questions, see your Run:ai representative.
