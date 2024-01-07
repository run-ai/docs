---
title: What's new - 2.16 January 5, 2024
summary: This article describes new features and functionality in the version.
authors:
    - Jason Novich
date: 2023-Dec-4
---

## Release Content

### Researcher

* <!--  DONE RUN-12597/RUN-12601	TW - Hide IDEs behind runai authentication -->Added support for secure and private access to researcher tools such as Jupyter Notebook, and others. In order to enable secure and private access, a *Private* toggle has been added to the *Environment* card which enables Authentication and authorization for Workload URLs. This toggle sets a flag of `isPrivate` in the `connections` section of a policy for the connection type `ExternalUrl`. When enabled, this limits the access of this tool to only the creator, or any user in the same scope as the creator. The *Private* toggle appears on any form that requires an *Environment* to be selected. For more information, see [Creating a new Workspace](../Researcher/user-interface/workspaces/create/workspace-v2.md).

#### Jobs, Workloads, and Workspaces

* <!-- DONE RUN-10859/RUN-10860 Presenting Policy in workloads creation forms (V2) -->Added the capability show and change policies directly in the project submission form. Pressing on *Policy* will open a window that displays the effective policy. For more information, see [Projects](../admin/admin-ui-setup/project-setup.md#viewing-project-policies). <!-- The URLs addresses only viewing policies and not editing policies, I guess it is still work in porogress (let's also be consistent with the terms here and use "edit" like we use in the product and not "change") -->

* <!-- DONE RUN-12619/RUN-14041 Workloads - Reliable data in API and UI Workloads redesign--> <!--

Running machine learning workloads effectively on Kubernetes can be difficult, but Run:ai makes it easy. The new Workloads experience introduces a simpler and more efficient way to manage machine learning workloads, which will appeal to data scientists and engineers alike. The new API and UI are not just a cosmetic change; they are the gateway to several enhancements that improve the workload management experience.

The new Workloads experience 
Fast, reliable, and easy-to-use unified interface.
* Fast - Fast-query data from the new workloads service, allowing a slick experience
* Reliable - One source of truth, all clients will use it. CLI, UI, API
* Easy to use - replace 3 grids with one unified view.
* Unified - All workload types in one place


 this section i would move to the dedicated doc, in the ui section
 The new table format provides:

* <!-- DONE RUN-12619/RUN-14041 Workloads - Reliable data in API and UI Workloads redesign-->Improved Run:ai *Workloads* so that it is specifically designed and optimized for AI and data science workloads, enhancing Kubernetes management of containerized applications. The Workloads view provides a more advanced UI than the previous Jobs UI. The new table format provides:
<!-- The following sentence is not clear and sounds a little like fluff. What does "specifically designed and optimized for AI and data science workloads, enhancing Kubernetes management of containerized applications" mean? -->

      * Changing of the layout of the *Workloads* table by pressing *Columns* to add or remove columns from the table.
      * Download the table to a CSV file by pressing *More*, then pressing *Download as CSV*.
      * Search for a workload by pressing *Search* and entering the name of the workload.
      * Advanced workload management.
      * Added workload statuses for better tracking of workload flow.
-->
    For more information, see [Workloads Overview](../admin/workloads/README.md).

### Run:ai Administrator

* <!-- DONE RUN-13296/RUN-13299	TW - Administrator Messages - Doc gap, there is no page for settings.-->Added the capability for administrators to configure messages to users when they log into the platform. Messages are configured using the *Message Editor* screen. For more information, see [Administrator Messages](../admin/admin-ui-setup/overview.md#administrator-messages).

#### Monitoring and Analytics

* <!-- DONE RUN-12658/RUN-14155	TW - Expose GPU health info  -->Added to the dashboard updated GPU and CPU resource availability.

      * Added a chart displaying the number of free GPUs per node. Free GPU are GPUs that have not been allocated to a workload.
      * Added a dashlet that displays the total vs. ready resources for GPUs and CPUs. The dashlet indicates how many total nodes are in the platform, and how many are available. 

    For more information, see [Total and Ready GPU or CPU Nodes](../admin/admin-ui-setup/dashboard-analysis.md#total-and-ready-gpu-or-cpu-nodes).

* <!--  DONE RUN-14703 - Additional columns to consumption report -->Added three columns to the consumption report for both *Projects* *Departments* tables. The new columns are:
  
      * GPU Idle allocated hours&mdash;the portion of time the GPUs spend idle from the total allocation hours.
      * CPU usage hours&mdash;the actual usage time of CPU.
      * Memory usage time&mdash;the actual usage time of CPU memory.

    For more information, see [Consumption Dashboard](../admin/admin-ui-setup/dashboard-analysis.md#consumption-dashboard).

#### Authentication and Authorization

* <!--  DONE RUN-13107/RUN-13108 - SSO users visibility-->Added a column to the *Users* table for the type of user that was created (Local or SSO). You can now also view the user's access role assignments directly from the *Users* table by pressing *VIEW*. In addition, SSO users who have logged into the system will now be visible in the *Users* table. For more information, see [Adding, Updating, and Deleting Users](../admin/admin-ui-setup/admin-ui-users.md#adding-updating-and-deleting-users).

#### Policies

* <!--  TODO ADDLINK RUN-11125/RUN-11746	TW - Policy Sync - Catch all for the new policies pages and features. -->Added a new policy manager. Enabling the *New Policy Manager* provides new tools to discover how resources are not compliant. Non-compliant resources and will appear greyed out and cannot be selected. To see how a resource is not compliant, press on the clipboard icon in the upper right hand corner of the resource. Policies can also be applied to specific scopes within the Run:ai platform. For more information, see [Viewing Project Policies](../admin/workloads/policies/README.md).

* <!-- TODO ADDLINK RUN-9808/RUN-9810 - Show effective project policy from the UI --><!-- Something is not clear here. First "Added". Then what do you mean by "resources"? Is this a term we use? Do you mean "compute resources"? Not sure I fully get it. It looks like something is missing / broken in this sentence -->Add support to see how policies affect resources in a project. Press the clipboard icon on a resource card to see a pop-up with details as to how that resource is affected by an applied policy.

### Control and Visibility

* <!--  TODO ADDLINK RUN-7310/RUN-11951 Installation - Cluster visibility IMPROVE HERE!!! -->Improved the clarity of the status column in the *Clusters* view. Now users have more insight about the actual status of the cluster. Users can now see extended details about each cluster, the state of the cluster services, and if they are connected.  For more information, see [Cluster status](../admin/runai-setup/cluster-setup/cluster-install.md#cluster-status).
<!-- Looks like WIP. If a placeholder for cluster state visibility, then "dashboard" is not the right term to use for this feature -->

The goal of this feature is to provide more clarity to the users about the status of their cluster, by providing extended details about each cluster, including mandatory prerequisites, optional prerequisites, cluster services state, sync with the cluster, metrics, etc.

### Installation and Configuration

#### OpenShift Support

* <!-- DONE RUN-11787/RUN-11788 Support new Kubernetes and OpenShift releases -->Updated installation prerequisites. For more information, see [Supported Kubernetes Versions](../admin/runai-setup/cluster-setup/cluster-prerequisites.md#kubernetes).
  <!-- I followed the link and did not understand where the link is trying to take me. There is a note for OCP about certification, but I did not see any updated installation prerequisites. The epic look like the general epic that we have in each release for new kubernetes and openshift versions support. There is a dedicated place for the supported versions and there is no need to add an item in the RN. Unless there is a change in the prerequisites and then it is super critical to include in the RN. I am not aware of any change and did not see such a change in the epic. Gal would know best -->
