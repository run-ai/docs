---
title: Version 2.16
summary: This article describes new features and functionality in the version.
authors:
    - Jason Novich
date: 2023-Dec-4
---

## Release Content - January 25, 2024

### Researcher

* <!--  DONE RUN-12597/RUN-12601	TW - Hide IDEs behind runai authentication -->Added enterprise level security for researcher tools such as Jupyter Notebooks, VSCode, or any other URL associated with the workload. Using this feature, anyone within the organization requesting access to a specific URL will be redirected to the login page to be authenticated and authorized. This results in protected URLs which cannot be reached from outside the organization. Researchers can enhance the URL privacy by using the *Private* toggle which means that only the researcher who created the workload can is authorized to access it. The Private toggle is available per tool that uses an external URL as a connection type and is located in the workload creation from in the UI in the environment section. This toggle sets a flag of `isPrivate` in the `connections` section of a policy for the connection type `ExternalUrl`. For more information, see [Creating a new Workspace](../Researcher/user-interface/workspaces/create/workspace-v2.md).

#### Jobs, Workloads, and Workspaces

* <!-- DONE RUN-10859/RUN-10860 Presenting Policy in workloads creation forms (V2) -->Added the capability view and edit policies directly in the project submission form. Pressing on *Policy* will open a window that displays the effective policy. For more information, see [Viewing Project Policies](../admin/admin-ui-setup/project-setup.md#viewing-project-policies).
<!-- The URLs addresses only viewing policies and not editing policies, I guess it is still work in porogress (let's also be consistent with the terms here and use "edit" like we use in the product and not "change") -->

* <!-- DONE RUN-12619/RUN-14041 Workloads - Reliable data in API and UI Workloads redesign-->Running machine learning workloads effectively on Kubernetes can be difficult, but Run:ai makes it easy. The new *Workloads* experience introduces a simpler and more efficient way to manage machine learning workloads, which will appeal to data scientists and engineers alike. The *Workloads* experience provides a fast, reliable, and easy to use unified interface.

    * Fast-query of data from the new workloads service.
    * Reliable data retrieval and presentation in the CLI, UI, and API.
    * Easy to use single unified view with all workload types in one place.

    For more information, see [Workloads Overview](../admin/workloads/README.md).

* <!-- RUN-15456/RUN-15457 - Add a default auto deletion time after completion -->Changed the workload default *auto deletion time after completion* value from `Never` to `90 days`. This ensures that environments will be cleaned from old data. This field is editable by default, allowing researchers the ability to change the value while submitting a workload. Using workload policies, administrators can increase, decrease, set the default value to `never`, or even lock access to this value so researchers can not edit it when they submit workloads.

### Run:ai Administrator

* <!-- DONE RUN-13296/RUN-13299	TW - Administrator Messages - Doc gap, there is no page for settings.-->Added the capability for administrators to configure messages to users when they log into the platform. Messages are configured using the *Message Editor* screen. For more information, see [Administrator Messages](../admin/admin-ui-setup/overview.md#administrator-messages).

#### Monitoring and Analytics

* <!-- DONE RUN-12658/RUN-14155	TW - Expose GPU health info  -->Added to the dashboard updated GPU and CPU resource availability.

      * Added a chart displaying the number of free GPUs per node. Free GPU are GPUs that have not been allocated to a workload.
      * Added a dashlet that displays the total vs. ready resources for GPUs and CPUs. The dashlet indicates how many total nodes are in the platform, and how many are available. 

    For more information, see [Total and Ready GPU or CPU Nodes](../admin/admin-ui-setup/dashboard-analysis.md#total-and-ready-gpu-or-cpu-nodes).

* <!--  DONE RUN-14703 - Additional columns to consumption report -->Added additional columns to the consumption report for both *Projects* and *Departments* tables. The new columns are:
  
      * GPU Idle allocated hours&mdash;the portion of time the GPUs spend idle from the total allocation hours.
      * CPU usage hours&mdash;the actual usage time of CPU.
      * Memory usage time&mdash;the actual usage time of CPU memory.

    For more information, see [Consumption Dashboard](../admin/admin-ui-setup/dashboard-analysis.md#consumption-dashboard).

#### Authentication and Authorization

* <!--  DONE RUN-13107/RUN-13108 - SSO users visibility-->SSO users who have logged into the system will now be visible in the *Users* table. In addition, added a column to the *Users* table for the type of user that was created (Local or SSO). For more information, see [Adding, Updating, and Deleting Users](../admin/admin-ui-setup/admin-ui-users.md#adding-updating-and-deleting-users).

#### Policies

* <!--  DONE RUN-11125/RUN-11746	TW - Policy Sync - Catch all for the new policies pages and features. -->Added new *Policy Manager. The new *Policy Manager* provides administrators the ability to impose restrictions and default vaules on system resources. The new *Policy Manager* provides a YAML editor for configuration of the policies. Administrators can easily add both *Workspace* or *Training* policies. The editor makes it easy to see the configuration that has been applied and provides a quick and easy method to edit the policies. The new *Policy Editor* brings other important policy features such as the ability to see non-compliant resources in workloads. For more information, see [Policies](../admin/workloads/policies/README.md#policies).

* <!-- DONE RUN-9808/RUN-9810 - Show effective project policy from the UI -->Added a new policy manager. Enabling the *New Policy Manager* provides new tools to discover how resources are not compliant. Non-compliant resources and will appear greyed out and cannot be selected. To see how a resource is not compliant, press on the clipboard icon in the upper right hand corner of the resource. Policies can also be applied to specific scopes within the Run:ai platform. For more information, see [Viewing Project Policies](../admin/admin-ui-setup/project-setup.md#viewing-project-policies).

### Control and Visibility

* <!--  DONE RUN-7310/RUN-11951 Installation - Cluster visibility IMPROVE HERE!!! -->Improved the clarity of the status column in the *Clusters* view. Now users have more insight about the actual status of Run:ai on the cluster. Users can now see extended details about the state of the Run:ai installation and services on the cluster, and its connectivity state. For more information, see [Cluster status](../admin/runai-setup/cluster-setup/cluster-install.md#cluster-status).

<!-- DONE RUN-11787/RUN-11788 Support new Kubernetes and OpenShift releases

### Installation and Configuration

#### OpenShift Support

* Updated installation prerequisites. For more information, see [Kubernetes support matrix](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#releases). -->
