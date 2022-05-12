
---
title: Inference  Overview 
---
## What is Inference

Machine learning (ML) inference is the process of running live data points into a machine-learning algorithm to calculate an output. 

With Inference, you are taking a trained _Model_ and deploying it into a production environment. The deployment must align with the organization's production standards such as average and 95% response time as well as up-time. 

## Inference and GPUs
 
The Inference process is a subset of the original Training algorithm on a single datum (e.g. one sentence or one image), or a small batch. As such, GPU memory requirements are typically smaller than a full-blown Training process. 

Given that, Inference lends itself nicely to the usage of Run:ai Fractions. You can, for example, run 4 instances of an Inference server on a single GPU, each employing a fourth of the memory. 

## Inference @Run:ai

Run:ai provides Inference services as an equal part together with the other two Workload types: _Train_ and _Build_.

* Inference is considered a high-priority workload as it is customer-facing. Running an Inference workload (within the Project's quota) will preempt any Run:ai Workload marked as _Training_.

* Inference workloads will receive priority over _Train_ and _Build_ workloads during scheduling.

* Inference is implemented as a Kubernetes _Deployment_ object with a defined number of replicas. The replicas are load-balanced by Kubernetes so adding more replicas will improve the overall throughput of the system.

* Multiple replicas will appear in Run:ai as a single Inference workload. The workload will appear in all Run:ai dashboards and views as well as the Command-line interface.

* Inference workloads can be submitted via Run:ai [user interface](../admin-ui-setup/deployments.md) as well as [Run:ai API](../../developer/cluster-api/workload-overview-dev.md). Internally, spawning an Inference workload also creates a Kubernetes _Service_. The service is an end-point to which clients can connect. 

## Auto Scaling

To withstand SLA, Inference workloads are typically set with _auto scaling_. Auto-scaling is the ability to add more computing power (Kubernetes pods) when the load increases and shrink allocated resources when the system is idle.

There are a number of ways to trigger auto-scaling. Run:ai supports the following:

| Metric          | Units        |   Run:ai name   |
|-----------------|--------------|-----------------|
| GPU Utilization |   %          | gpu-utilization |
| CPU Utilization |   %          | cpu-utilization |
| Latency         | milliseconds | latency         |
| Throughput      | requests/second | throughput |
| Concurrency     |              |    concurrency  | 
| Custom metric   |              |    custom       |

The Minimum and Maximum number of replicas can be configured as part of the autoscaling configuration.

Auto Scaling also supports a scale to zero policy with _Throughput_ and _Concurrency_ metrics, meaning that given enough time under the target threshold, the number of replicas will be scaled down to 0.
This has the benefit of conserving resources at the risk of a delay from "cold starting" the model when traffic resumes. 


## See Also

* To set up Inference, see [Cluster installation prerequisites](../runai-setup/cluster-setup/cluster-prerequisites.md#inference).
* For running Inference see [Inference quick-start](../../Researcher/Walkthroughs/quickstart-inference.md).
* To run Inference from the user interface see [Deployments](../admin-ui-setup/deployments.md).
* To run Inference using API see [Workload overview](../../developer/cluster-api/workload-overview-dev.md).
