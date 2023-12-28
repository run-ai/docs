---
title: What's new - 2.16 January 5, 2024
summary: This article describes new features and functionality in the version.
authors:
    - Jason Novich
date: 2023-Dec-4
---

## Release Content

### Researcher

* <!--  TODO ADDLINK RUN-12597/RUN-12601	TW - Hide IDEs behind runai authentication -->Added a *Private* toggle to the *Environment* card window after selecting a tool to enable Authentication and authorization for Workload URLs. This toggle sets a flag of `isPrivate` in the `connections` section of a policy for the connection type `ExternalUrl`. When enabled, this limits the access of this tool to only the creator, or any user in the same scope as the creator. The *Private* toggle appears on any form that requires an *Environment* to be selected. <!-- maybe adds links here to the environment, trainings, workloads pages. -->

#### Jobs, Workloads, and Workspaces

* <!-- TODO ADDLINK RUN-10859/RUN-10860 Presenting Policy in workloads creation forms (V2) -->Added the capability show and change policies directly in the submission form. Pressing on *Policy* will open a window that displays the effective policy.

* <!-- TODO ADDLINK RUN-12619/RUN-14041 Workloads - Reliable data in API and UI Workloads redesign-->Improved Run:ai *Workloads* so that it is specifically designed and optimized for AI and data science workloads, enhancing Kubernetes management of containerized applications. The Workloads view provides a more advanced UI than the previous Jobs UI. The new table format provides:

      * Changing of the layout of the *Workloads* table by pressing *Columns* to add or remove columns from the table.
      * Download the table to a CSV file by pressing *More*, then pressing *Download as CSV*.
      * Search for a workload by pressing *Search* and entering the name of the workload.
      * Advanced workload management.
      * Added workload statuses for better tracking of workload flow.

    For more information, see [Workloads Overview]().

### Run:ai Administrator

* <!-- DONE check link RUN-13296/RUN-13299	TW - Administrator Messages - Doc gap, there is no page for settings.-->Added the capability for administrators to configure messages to users when they log into the platform. Messages are configured using the *Message Editor* screen. For more information, see [Administrator Messages](../admin/admin-ui-setup/overview.md#administrator-messages).

#### Monitoring and Analytics

* <!-- TODO ADDLINK RUN-12658/RUN-14155	TW - Expose GPU health info  -->Added to the dashboard updated GPU and CPU resource availability.

      * Added a chart displaying the number of free GPUs per node. Free GPU are GPUs that have not been allocated to a workload.
      * Added a dashlet that displays the total vs. ready resources for GPUs and CPUs. The dashlet indicates how many total nodes are in the platform, and how many are available. 

    For more information, see [Dashboards]().

* <!--  ADDLINK RUN-14703 - Additional columns to consumption report -->Added three columns to the consumption report for both *Projects* *Departments* tables. The new columns are:
  
    * GPU Idle allocated hours&mdash;the portion of time the GPUs spend idle from the total allocation hours.
    * CPU usage hours&mdash;the actual usage time of CPU.
    * Memory usage time&mdash;the actual usage time of CPU memory.

#### Authentication and Authorization

<!--  TODO RUN-13107/RUN-13108 - SSO users visibility-->

#### Policies

* <!--  TODO ADDLINK RUN-11125/RUN-11746	TW - Policy Sync - Catch all for the new policies pages and features. -->Added a new policy manager. Enabling the *New Policy Manager* provides new tools to discover how resources are not compliant. Non-compliant resources and will appear greyed out and cannot be selected. To see how a resource is not compliant, press on the clipboard icon in the upper right hand corner of the resource. Policies can also be applied to specific scopes within the Run:ai platform. For more information, see [Policies](../admin/workloads/policies/README.md).

* <!-- TODO  RUN-9808/RUN-9810 - Show effective project policy from the UI -->Add support to see how policies affect resources in a project. Press the clipboard icon on a resource card to see a pop-up with details as to how that resource is affected by an applied policy.

### Control and Visibility

* <!--  TODO RUN-7310/RUN-11951 Installation - Cluster visibility -->Added new dashboards that report on the state of the cluster.

### Installation and Configuration



#### OpenShift Support

<!-- TODO  RUN-11787/RUN-11788 Support new Kubernetes and OpenShift releases -->

----------------------------------------------------

<!-- TODO  RUN-13470 Update Workload Parameters pages -->

<!--   RUN-10387/RUN-10388 Product scope for trial 
RUN-10385/RUN-10386	Trial cluster creation 
RUN-9594/RUN-9597	Trial flow from Run:ai website to live tenant -->
