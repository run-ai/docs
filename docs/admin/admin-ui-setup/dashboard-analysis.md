# Introduction

The Run:ai Administration User Interface provides a set of dashboards that help you monitor Clusters, Cluster Nodes, Projects, and Workloads. This document provides the key metrics to monitor, how to assess them as well as suggested actions.

There are 5 dashboards:

* [**Overview**](#overview-dashboard) dashboard&mdash;Provides information about what is happening right now in the cluster.
* [**Quota Management**](#quota-management-dashboard) dashboard&mdash;Provides information about quota utilization.
* [**Analytics**](#analytics-dashboard) dashboard&mdash;Provides long term analysis of cluster behavior.
* [**Multi-Cluster Overview**](#multi-cluster-overview-dashboard) dashboard&mdash;Provides a more holistic, multi-cluster view of what is happening right now. The dashboard is intended for organizations that have more than one connected cluster.
* [**Consumption**](#consumption-dashboard) dashboard&mdash;Provides information about resource consumption.

## Overview Dashboard

The Overview dashboard provides information about what is happening **right now** in the cluster.  Administrators can view high-level information on the state of the cluster, including:

* The number of available and allocated resources and their cluster-wide utilization.
* The number of running and pending **Workloads**, their utilization, information on Workloads with errors or Workloads with idle GPUs or CPUs.
* Active **Projects**, their assigned and allocated GPUs or CPUs and number of running and pending Workloads.

The dashboard has two tabs that change the display to provide a focused view for [GPU Dashboards](#gpu-dashboard) (default view) and [CPU Dashboards](#cpu-dashboard).

The dashboard has a dropdown filter for node pools. From the dropdown, select one or more node pools. The default setting is `all`.

Cluster administrators can use the Overview dashboard to find issues and fix them. Below are a few examples:

### GPU Dashboard

The GPU dashboard displays specific information for GPU based nodes, node-pools, clusters, or tenants. These dashboards also include additional metrics that specific to GPU based environments.

### CPU Dashboard

The CPU dashboards display specific information for CPU based nodes, node-pools, clusters, or tenants. These dashboards also include additional metrics that specific to CPU based environments.

To enable CPU Dashboards:

1. Press the `Settings` icon, then press `General`
2. Toggle the *Show CPU dashboard* switch to enable the feature.

Toggle the switch to `disable` to disable *CPU Dashboards* option.

The following analysis can apply to both GPU and CPU dashboards.

### Total and Ready GPU or CPU Nodes

The *Indicators* panel of the *GPU Overview Dashboard* displays the total number of GPU nodes, the number of ready GPU nodes, the total number of GPUs, and the total number of ready GPUs.

The *Indicators* panel of the *CPU Overview Dashboard* displays the total number of CPU nodes, the number of ready CPU nodes, the total number of CPUs, and the total number of ready CPUs.

These panes help calculate the number of available (unscheduled) resources in the platform.

* **Total GPU/CPU Nodes**&mdash;indicates the sum total of nodes in all clusters connected to the platform.
* **Ready GPU/CPU Nodes**&mdash;indicates the number of nodes that are available to the scheduler. This is calculated by subtracting the number of unscheduled nodes from the total number of nodes.
* **Total GPUs/CPUs**&mdash;indicates ihe total number of GPUs/CPUs in all the clusters that are connected to the platform.
* **Ready GPUs/CPUs**&mdash;indicates the number of GPUs or CPUs that are available to work with the scheduler. This is calculated by subtracting the number of unscheduled GPUs or CPUs from the total number of GPUs or CPUs.

The *Free GPUs* graph displays the number of free GPUs or CPUs on each node.

### Workloads with idle GPUs or CPUs

Locate workloads with idle GPUs or CPUs, defined as GPUs/CPUs with 0% utilization for more than 5 minutes.
<!--
**How to**: view the following panel:

![](img/idle-gpus.png)
-->
**Analysis and Suggested actions**:

| Review  | Analysis  & Actions |
|---------|---------------------|
| Interactive Workloads are too frequently idle | *  Consider setting time limits for interactive Workloads through the Projects tab. <br> *  Consider also reducing GPU/CPU quotas for specific Projects to encourage users to run more training Workloads as opposed to interactive Workloads (note that interactive Workloads can not use more than the GPU/CPU quota assigned to their Project). |
| Training Workloads are too frequently idle | Identify and notify the right users and work with them to improve the utilization of their training scripts |

### Workloads with an Error

Search for Workloads with an error status. These Workloads may be holding GPUs/CPUs without actually using them.
<!--
**How to**: view the following panel:

![](img/jobs-with-errors.png)
-->
**Analysis and Suggested actions**:

Search for workloads with an Error status on the Workloads view and discuss with the Job owner. Consider deleting these Workloads to free up the resources for other users.

### Workloads with a Long Duration

View list of 5 longest Workloads.
<!-- 
**How to**: view the following panel:

![](img/long-jobs.png)
-->
**Analysis and Suggested actions**:

| Review  | Analysis & Actions |
|---------|---------------------|
| Training Workloads run for too long | Ask users to view their Workloads and analyze whether useful work is being done. If needed, stop their Workloads. |
| Interactive Workloads run for too long | Consider setting time limits for interactive Workloads via the Project editor. |

### Job Queue

Identify queueing bottlenecks.
<!-- 
**How to**: view the following panel:

![](img/queue.png)
-->
**Analysis and Suggested actions**:

| Review  | Analysis & Actions  |
|---------|---------------------|
| Cluster is fully loaded | Go over the table of active Projects and check that fairness between Projects was enforced, by reviewing the number of allocated GPUs/CPUs for each Project, ensuring each Project was allocated with its fair-share portion of the cluster. |
| Cluster is not fully loaded | Go to the Workloads view to review the resources requested for that Job (CPU, CPU memory, GPU, GPU memory).<br> Go to the Nodes view to verify that there is no Node with enough free resources that can host that Job. |

Also, check the command that the user used to submit the job. The Researcher may have requested a specific Node for that Job.

## Quota management dashboard

The Quota management dashboard provides an efficient means to monitor and manage resource utilization within the AI cluster. The dashboard is divided into sections with essential metrics and data visualizations to identify resource usage patterns, potential bottlenecks, and areas for optimization. The sections of the dashboard include:

* **Add Filter**
* **Quota / Total**
* **Allocated / Quota**
* **Pending workloads**
* **Quota by node pool**
* **Allocation by node pool**
* **Pending workloads by node pool**
* **Departments with lowest allocation by node pool**
* **Projects with lowest allocation ratio by node pool**
* **Over time allocation / quota**

### Add Filter

Use the *Add Filter* dropdown to select filters for the dashboard. The filters will change the data shown on the dashboard. Available filters are:

* Departments
* Projects
* Nodes

Select a filter from the dropdown, then select a item from the list, and press apply.

!!! Note
    You can create a filter with multiple categories, but you can use each category and item only once.

### Quota / Total

This section shows the number of GPUs that are in the quota based on the filter selection. The quota of GPUs is the number of GPUs that are reserved for use.

### Allocated / Quota

This section shows the number of GPUs that are allocated based on the filter selection. Allocated GPUs are the number of GPUs that are being used.

### Pending workloads

This section shows the number workloads that are pending based on the filter selection. Pending workloads are workloads that have not started.

### Quota by node pool

This section shows the quota of GPUs by node pool based on the filter. The quota is the number of GPUs that are reserved for use. You can drill down into the data in this section by pressing on the graph or the link at the bottom of the section.

### Allocation by node pool

This section shows the allocation of GPUs by node pool based on the filter. The allocation is the number of GPUs that are being used. You can drill down into the data in this section by pressing on the graph or the link at the bottom of the section.

### Pending workloads by node pool

This section shows the number of pending workloads by node pool. You can drill down into the data in this section by pressing on the graph or the link at the bottom of the section.

### Departments with lowest allocation by node pool

This section shows the departments with the lowest allocation of GPUs by percentage relative to the total number of GPUs.

### Projects with lowest allocation ratio by node pool

This section shows the projects with the lowest allocation of GPUS by percentage relative to the total number of GPUs.

### Over time allocation / quota

This section shows the allocation of GPUs from the quota over a period of time.

## Analytics Dashboard

The Analytics dashboard provides means for viewing historical data on cluster information such as:

* Utilization across the cluster
* GPU usage by different **Projects**, including allocation and utilization, broken down into interactive and training Workloads
* Breakdown of running **Workloads** into interactive, training, and GPU versus CPU-only Workloads, including information on queueing (number of pending Workloads and requested GPUs),
* Status of Nodes in terms of availability and allocated and utilized resources.

The dashboard has a dropdown filter for node pools and Departments. From the dropdown, select one or more node pools. The default setting is `all`.

The information presented in Analytics can be used in different ways for identifying problems and fixing them. Below are a few examples.

### Node Downtime

View the overall available resources per Node and identify cases where a Node is down and there was a reduction in the number of available resources.

**How to**: view the following panel.

![](img/node-downtime.png)

**Analysis and Suggested actions**:

 Filter according to time range to understand for how long the Node is down.

### GPU Allocation

Track GPU allocation across time.

**How to**: view the following panels.

![](img/gpu-allocation.png)

The panel on the right-hand side shows the cluster-wide GPU allocation and utilization versus time, whereas the panels on the left-hand side show the cluster-wide GPU allocation and utilization averaged across the filtered time range.

**Analysis and Suggested actions**:

If the allocation is too low for a long period, work with users to run more workloads and to better utilize the Cluster.

### Track GPU utilization

Track whether Researchers efficiently use the GPU resources they have allocated for themselves.

**How to**: view the following panel:

![](img/gpu-utilization.png)

**Analysis and Suggested actions**:

If utilization is too low for a long period, you will want to identify the source of the problem:

* Go to “Average GPU Allocation & Utilization”
* Look for Projects with large GPU allocations for interactive Workloads or Projects that poorly utilize their training Workloads. Users tend to poorly utilize their GPUs in interactive sessions because of the dev & debug nature of their work which typically is an iterative process with long idle GPU time. On many occasions users also don’t shut down their interactive Workloads, holding their GPUs idle and preventing others from using them.

| Review  | Analysis & Actions  |
|---------|---------------------|
| Low GPU utilization is due to interactive Workloads being used too frequently | Consider setting time limits for interactive Workloads through the Projects tab or reducing GPU quotas to encourage users to run more training Workloads as opposed to interactive Workloads (note that interactive Workloads can not use more than the GPU quota assigned to their Project). |
| Low GPU utilization is due to users poorly utilizing their GPUs in training sessions | Identify Projects with bad GPU utilization in training Workloads, notify the users and work with them to improve their code and the way they utilize their GPUs. |

### Training vs. Interactive -- Researcher maturity

Track the number of running Workloads and the breakdown into interactive, training, and CPU-only Workloads.

**How to**: view the following panel:

![](img/training-interactive.png)

**Analysis and Suggested actions**:

We would want to encourage users to run more training Workloads than interactive Workloads, as it is the key to achieving high GPU utilization across the Cluster:

* Training Workloads run to completion and free up their resources automatically when training ends
* Training Workloads can be preempted, queued, and resumed automatically by the Run:ai system according to predefined policies which increases fairness and Cluster utilization.

### Pending Queue Size

Track how long is the queue for pending Workloads

**How to**: view the following panels:

![](img/pending-jobs.png)

**Analysis and Suggested actions**:

Consider buying more GPUs:

* When there are too many Workloads are waiting in queue for too long.
* With a large number of requested GPUs.
* While the Cluster is fully loaded and well utilized.

### CPU & Memory Utilization

Track CPU and memory Node utilization and identify times where the load on specific Nodes is high.

**How to**: view the following panel:

![](img/cpu-utilization.png)

**Analysis and Suggested actions**:

If the load on specific Nodes is too high, it may cause problems with the proper operation of the Cluster and the way workloads are running.

Consider adding more CPUs, or adding additional CPU-only nodes for Workloads that do only CPU processing.

## Multi-Cluster overview dashboard

Provides a holistic, aggregated view across Clusters, including information about Cluster and Node utilization, available resources, and allocated resources. With this dashboard, you can identify Clusters that are down or underutilized and go to the Overview of that Cluster to explore further.

![](img/multi-cluster-overview.png)

## Consumption dashboard

This dashboard enables users and admins to view consumption usage using run:AI services. The dashboard provides views based on configurable filters and timelines. The dashboard also provides costing analysis for GPU, CPU, and memory costs for the system.

![!copnsumption dasboard](img/consumption-dashboard.png)

The dashboard has 4 dashlets for:

* Cumulative GPU allocation per Project or Department
* Cumulative CPU allocation per Project or Department
* Cumulative memory allocation per Project or Department
* Consumption types

Use the drop down menus at the top of the dashboard to apply filters for:

* Project or department
* Per project (single, multiple, or all)
* Per department (single, multiple or all)
* Per cluster (single, multiple, all)

Use cost fields at the top of the dashboard to provides calculated costs for:

* GPU
* CPU
* CPU memory (in GB)

Use the time picker dropdown to select relative time range options and set custom absolute time ranges.
You can change the Timezone and fiscal year settings from the time range controls by clicking the Change time settings button.

!!! Note
     Dashboard data updates once an hour.

![](img/consumption-dashboard-time-picker.png)

You can change the refresh interval using the refresh interval drop down.

The dashboard has a 2 consumption tables that display the total consumption of resources.
Hover over an entry in the table to filter it in or out of the table.

The *Total consumption* table includes consumption details based on the filters selected. Fields include:

* Project
* Department
* GPU hours
* CPU hours
* Memory hours
* GPU cost (only when configured)
* CPU cost (only when configured)
* CPU memory (only when configured)

The *Total department consumption* table includes consumption details for each department, or details for departments selected in the filters. Fields include:

* Department
* GPU hours
* CPU hours
* Memory hours
* GPU cost (only when configured)
* CPU cost (only when configured)
* CPU memory (only when configured)

The dashboard has a graph of the GPU allocation over time.

!![](img/consumption-dashboard-gpu-over-time.png)

The dashboard has a graph of the Project over-quota GPU consumption.

!![](img/consumption-dashboard-project-over-quota-graph.png)
