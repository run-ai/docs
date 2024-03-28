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

#### Assets

* <!-- RUN14616/RUN-14759 - Add configmap as data source -->Added the capability to use a configmap as a data source. For more information, see [Configure a configmap as a data source](../Researcher/user-interface/workspaces/create/create-ds.md#create-a-configmap-data-source).

* <!-- RUN-16242/RUN-16243 Add status table for credentials, configmap-DS, PVC-ds -->Added a status column to the *Credentials* table, and the *Data sources* table. The *status* column displays the state of the resource and provides troubleshooting information.

### Run:ai Administrator

#### Clusters

* <!-- RUN-14431/RUN-14432 New columns on cluster table-->Added new columns to the *Clusters* table to show Kubernetes distribution and version.

* <!-- RUN-16237/RUN16238 - Remove cluster filter from top bar in assets -->Added a new *Cluster* filter to the top bar of the following tables:
  
    * Data sources
    * Environments
    * Computer resources
    * Templates
    * Credentials

#### Monitoring and Analytics
* <!-- TODO @lavianalon RUN-11488/RUN-16508 - Workloads view - Metrics per GPU per pod with RUN-16234 --> renamed the metrics, for details see:
As of cluster version 2.17, we will support metrics through Run:ai API.

#### Authentication and Authorization

#### Policies

### Control and Visibility

## Deprecation Notifications

Deprecation notifications allow you to plan for future changes in the Run:ai Platform. Deprecated features will be available for **two** versions ahead of the notification. For questions, see your Run:ai representative.

