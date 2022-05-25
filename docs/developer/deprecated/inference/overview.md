
---
title: Inference  Overview (Deprecated)
---

!!! Warning
    Inference API is deprecated. See [Cluster API](../../cluster-api/workload-overview-dev.md) for its replacement.
    To read more about Inference see the new [Inference Overview](../../../admin/workloads/inference-overview.md).

## What is Inference

Machine learning (ML) inference is the process of running live data points into a machine-learning algorithm to calculate an output. 

With Inference, you are taking a trained _Model_ and deploying it into a production environment. The deployment must align with the organization's production standards such as average and 95% response time as well as up-time. 

## Inference and GPUs

The Inference process is a subset of the original Training algorithm on a single datum (e.g. one sentence or one image), or a small batch. As such, GPU memory requirements are typically smaller than a full-blown Training process. 

Given that, Inference lends itself nicely to the usage of Run:ai Fractions. You can, for example, run 4 instances of an Inference server on a single GPU, each employing a fourth of the memory. 

## Inference @Run:ai

Run:ai provides Inference services as an equal part together with the other two Workload types: _Train_ and _Build_.

* Inference is considered a high-priority workload as it is customer-facing. Running an Inference workload (within the Project's quota) will preempt any Run:ai Workload marked as _Training_.

* Inference is implemented as a Kubernetes _Deployment_ with a defined number of replicas. The replicas are load-balanced by Kubernetes so that adding more replicas will improve the overall throughput of the system.

* Multiple replicas will appear in Run:ai as a single Inference workload. The workload will appear in all Run:ai dashboards and views as well as the Command-line interface.

* Inference workloads can be submitted via Run:ai Command-line interface as well as Kubernetes API/YAML. Internally, spawning an Inference workload also creates a Kubernetes _Service_. The service is an end-point to which clients can connect. 


## See Also

* To setup Inference, see [Inference Setup](setup.md)
* For running Inference see [Inference quick-start](../../../Researcher/Walkthroughs/quickstart-inference.md)