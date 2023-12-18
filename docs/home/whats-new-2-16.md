---
title: What's new - 2.16 February 1, 2024
summary: This article describes new features and functionality in the version.
authors:
    - Jason Novich
date: 2023-Dec-4
---

## Release Content

### Researcher

* <!--  TODO RUN-12597/RUN-12601	TW - Hide IDEs behind runai authentication -->Added a *Private* toggle to the *Environment* card window after selecting a tool to enable Authentication and authorization for Workload URLs. This toggle sets a flag of `isPrivate` in the `connections` section of a policy for the connection type `ExternalUrl`. When enabled, this limits the access of this tool to the creator, or any user in the same scope ad the creator.

#### Jobs, Workloads, and Workspaces

* <!-- TODO ADDLINK RUN-10859/RUN-10860 Presenting Policy in workloads creation forms (V2) -->Added the capability show and change policies directly in the submission form. Pressing on *Policy* will open a window that displays the effective policy.

<!-- TODO  RUN-12619/RUN-14041 Workloads - Reliable data in API and UI -->

<!--  TODO RUN-13270/RUN-13271	TW - Improve error upon UI-V2 workload submission -->

### Run:ai Administrator

* <!--  ADDLINK UN-13296/RUN-13299	TW - Administrator Messages Doc into the "Settings" page - same place where users are setup.-->Added the capability for administrators to configure messages to users when logging into the platform. Messages are configured using the *Message Editor* screen. For more information, see [Administrator Messages]().

#### Monitoring and Analytics

<!--  TODO RUN-12597/RUN-13404 - Additional configurations for Prometheus speak with Guy or Roi - ask Yaron if he added docs to this. -->

<!-- TODO  RUN-12658/RUN-14155	TW - Expose GPU health info  -->

#### Authentication and Authorization

<!--  TODO RUN-13107/RUN-13108 - SSO users visibility-->

<!--  TODO RUN-9473/RUN-9474	TW - SSO Supportability - phase 2 -->

#### Policies

<!-- TODO  RUN-9808/RUN-9810 - Show effective project policy from the UI -->

<!--  TODO RUN-11125/RUN-11746	TW - Policy Sync  -->

#### Node and Node Pools


<!--  TODO RUN-12615/RUN-12616 Dynamic fractions SWAP  -->

### Control and Visibility




### Installation and Configuration

<!--  TODO RUN-7310/RUN-11951 Installation - Protect Cluster installation & Report status -->

#### OpenShift Support

<!-- TODO  RUN-11787/RUN-11788 Support new Kubernetes and OpenShift releases -->

----------------------------------------------------

<!-- TODO  RUN-13470 Update Workload Parameters pages -->

<!--  TODO RUN-12615/RUN-12616	TW - [Playtika] Dynamic fractions SWAP  -->

<!-- TODO  RUN-12089	TW - Re-build settings - Level of control and New UX -->

<!--   RUN-10387/RUN-10388 Product scope for trial 
RUN-10385/RUN-10386	Trial cluster creation 
RUN-9594/RUN-9597	Trial flow from Run:ai website to live tenant -->
