

The Run:AI Administration User Interface provides a set of dashboards that help you monitor Clusters, Cluster Nodes, Projects, and Jobs. This document provides the key metrics to monitor, how to assess them as well as suggested actions. 

There are 3 dashboards:

* __Overview__ dashboard - Provides information about what is happening right now in the cluster
* __Analytics__ dashboard - Provides long term analysis of cluster behavior
* __Multi-Cluster Overview__ dashboard - Provides a more holistic, multi-cluster view of what is happening right now. The dashboard is intended for organizations that have more than one connected cluster.


## Overview Dashboard

The Overview dashboard provides information about what is happening __right now__ in the cluster.  Administrators can view high-level information on the state of the cluster, including:

* The number of available and allocated resources and their cluster-wide utilization
* The number of running and pending __Jobs__, their utilization, information on Jobs with errors or Jobs with idle GPUs
* Active __Projects__, their assigned and allocated GPU, and number of running and pending Jobs

Cluster administrators can use the Overview dashboard to find issues and fix them. Below are a few examples:


### Jobs with idle GPUs

Locate Jobs with idle GPUs, defined as GPUs with 0% GPU utilization for more than 5 minutes. 

__How to__: view the following panel:

![](img/idle-gpus.png)

__Analysis and Suggested actions__:

| Review  | Analysis  & Actions |
|---------|---------------------|
| Interactive Jobs are too frequently idle | *  Consider setting time limits for interactive Jobs through the Projects tab. <br> *  Consider also reducing GPU quotas for specific Projects to encourage users to run more training Jobs as opposed to interactive Jobs (note that interactive Jobs can not use more than the GPU quota assigned to their Project). |
| Training Jobs are too frequently idle | Identify and notify the right users and work with them to improve the utilization of their training scripts |


### Jobs with an Error

Search for Jobs with an error status. These Jobs may be holding GPUs without actually using them. 

__How to__: view the following panel:

![](img/jobs-with-errors.png)

__Analysis and Suggested actions__:

Search for Jobs with an Error status on the Jobs view and discuss with Job owner. Consider deleting these Jobs in order to free up the resources for other users.

### Jobs with a Long Duration 

View list of 5 longest Jobs. 

__How to__: view the following panel:

![](img/long-jobs.png)

__Analysis and Suggested actions__:

| Review  | Analysis & Actions |
|---------|---------------------|
| Training Jobs run for too long | Ask users to view Job and analyze whether useful work is being done. If needed, stop their Jobs. | 
| Interactive Jobs run for too long | Consider setting time limits for interactive Jobs via the Project editor. |


### Job Queue

Identify queueing bottlenecks.

__How to__: view the following panel:

![](img/queue.png)

__Analysis and Suggested actions__:

| Review  | Analysis & Actions  |
|---------|---------------------|
| Cluster is fully loaded | Go over the table of active Projects and check that fairness between Projects was enforced, by reviewing the number of allocated GPUs for each Project, ensuring each Project was allocated with its fair-share portion of the cluster. |
| Cluster is not fully loaded | Go to the Jobs view to review the resources requested for that Job (CPU, CPU memory, GPU, GPU memory).<br> Go to the Nodes view to verify that there is no Node with enough free resources that can host that Job. |

Also check the command that the user used to submit the job. The Reseracher may have requested a specific Node for that Job.


## Analytics Dashboard

The Analytics dashboard provides means for viewing historical data on cluster information such as:

* Utilization across the cluster
* GPU usage by different __Projects__, including allocation and utilization, broken down into interactive and training Jobs
* Breakdown of running __Jobs__ into interactive, training, and GPU versus CPU-only Jobs, including information on queueing (number of pending Jobs and requested GPUs),
* Status of Nodes in terms of availability and allocated and utilized resources.

The information presented in Analytics can be used in different ways for identifying problems and fixing them. Below are a few examples.


### Node Downtime

View the overall available resources per Node and identify cases where a Node is down and there was a reduction in the number of available resources.

__How to__: view the following panel.

![](img/node-downtime.png)

__Analysis and Suggested actions__:
 
 Filter according to time range to understand for how long the Node is down.


### GPU Allocation

Track GPU allocation across time.

__How to__: view the following panels. 

![](img/gpu-allocation.png)

The panel on the right-hand side shows the cluster-wide GPU allocation and utilization versus time, whereas the panels on the left-hand side show the cluster-wide GPU allocation and utilization averaged across the filtered time range.

__Analysis and Suggested actions__:

If the allocation is too low for a long period of time, work with users to run more workloads and to better utilize the Cluster.


### Track GPU utilization

Track whether Researchers efficiently use the GPU resources they have allocated for themselves. 

__How to__: view the following panel:

![](img/gpu-utilization.png)

__Analysis and Suggested actions__:

If utilization is too low for a long period of time, you will want to identify the source of the problem:

* Go to “Average GPU Allocation & Utilization” 
* Look for Projects with large GPU allocations for interactive Jobs or Projects that poorly utilize their training Jobs. Users tend to poorly utilize their GPUs in interactive sessions because of the dev & debug nature of their work which typically is an iterative process with long idle GPU time. In many occasions users also don’t shut down their interactive Jobs, holding their GPUs idle and preventing others from using them. 

| Review  | Analysis & Actions  |
|---------|---------------------|
| Low GPU utilization is due to interactive Jobs being used too frequently | Consider setting time limits for interactive Jobs through the Projects tab or reducing GPU quotas to encourage users to run more training Jobs as opposed to interactive Jobs (note that interactive Jobs can not use more than the GPU quota assigned to their Project). |
| Low GPU utilization is due to users poorly utilizing their GPUs in training sessions | Identify Projects with bad GPU utilization in training Jobs, notify the users and work with them to improve their code and the way they utilize their GPUs. |

### Training vs. Interactive -- Researcher maturity 

Track number of running Jobs and the breakdown into interactive, training, and CPU-only Jobs. 

__How to__: view the following panel:

![](img/training-interactive.png)


__Analysis and Suggested actions__:

We would want to encourage users to run more training Jobs than interactive Jobs, as it is the key for achieving high GPU utilization across the Cluster:

* Training Jobs run to completion and free up their resources automatically when training ends
* Training Jobs can be preempted, queued, and resumed automatically by the Run:AI system according to predefined policies which increases fairness and Cluster utilization.

### Pending Queue Size

Track how long is the queue for pending Jobs

__How to__: view the following panels:

![](img/pending-jobs.png)

__Analysis and Suggested actions__:

Consider buying more GPUs if, 

* Too many Jobs are waiting in queue for too long 
* With a large number of requested GPUs 
* While the Cluster is fully loaded and well utilized. 


### CPU & Memory Utilization
 
Track CPU and memory Node utilization and identify times where load on specific Nodes is high. 

__How to__: view the following panel:

![](img/cpu-utilization.png)

__Analysis and Suggested actions__:

If the load on specific Nodes is too high, it may cause problems with the proper operation of the Cluster and the way jobs are running. 

Consider adding more CPUs, or adding additional CPU-only nodes for Jobs that do only CPU processing. 


## Multi-Cluster Overview Dashboard

Provides a holistic, aggregated view across Clusters, including information about Cluster and Node utilization, available resources and allocated resources. With this dashboard you can identify Clusters that are down or underutilized and go to the Overview of that Cluster to explore further. 

![](img/multi-cluster-overview.png)