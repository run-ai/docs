---
title: Inference overview
summary: This article summarizes machine learning inference workloads.
authors:
    - Jason Novich
date: 2024-Mar-29
---

## What is Inference

Machine learning (ML) inference is the process of running live data points into a machine-learning algorithm to calculate an output.

With *Inference* workloads, you are taking a trained *Model* and deploying it into a production environment. The deployment must align with the organization's production standards such as average and 95% response time as well as up-time.

## Inference and GPUs

The *Inference* process is a subset of the original Training algorithm on a single datum (e.g. one sentence or one image), or a small batch. As such, GPU memory requirements are typically smaller than a full-blown Training process.

Given that, *Inference* lends itself nicely to the usage of Run:ai Fractions. You can, for example, run 4 instances of an *Inference* server on a single GPU, each employing a fourth of the memory.

## Inference @Run:ai

Run:ai provides *Inference* services as an equal part together with the other two Workload types: *Train* and *Build*.

* *Inference* is considered a high-priority workload as it is customer-facing. Running an *Inference* workload (within the Project's quota) will preempt any Run:ai Workload marked as *Training*.

* *Inference* workloads will receive priority over *Train* and *Build* workloads during scheduling.

* *Inference* is implemented as a Kubernetes *Deployment* object with a defined number of replicas. The replicas are load-balanced by Kubernetes so adding more replicas will improve the overall throughput of the system.

* Multiple replicas will appear in Run:ai as a single *Inference* workload. The workload will appear in all Run:ai dashboards and views as well as the Command-line interface.

* Inference workloads can be submitted via Run:ai user interface as well as [Run:ai API](../../developer/cluster-api/workload-overview-dev.md). Internally, spawning an Inference workload also creates a Kubernetes *Service*. The service is an end-point to which clients can connect.

## Autoscaling

To withstand SLA, *Inference* workloads are typically set with *auto scaling*. Auto-scaling is the ability to add more computing power (Kubernetes pods) when the load increases and shrink allocated resources when the system is idle.
There are several ways to trigger autoscaling. Run:ai supports the following:

| Metric          | Units        |
|-----------------|--------------|
| Latency         | Millisecond  |
| Throughput      | Requests/sec |
| Concurrency     | Requests     | 

The Minimum and Maximum number of replicas can be configured as part of the autoscaling configuration.

Autoscaling also supports a scale-to-zero policy with *Throughput* and *Concurrency* metrics, meaning that given enough time under the target threshold, the number of replicas will be scaled down to 0.

This has the benefit of conserving resources at the risk of a delay from "cold starting" the model when traffic resumes.

## Rolling inference updates

When deploying models and running inference workloads, you may need to update the workload configuration in a live manner, without impacting the important services that are provided by the workload.

This means you can submit updates to an existing inference workload whether it is currently running, pending, or any other status.

The following are a few examples of updates that can be implemented:

* Changing the container image to deploy a new version of the model  
* Changing different parameters (such as environment variables)  
* Changing compute resources to improve performance  
* Changing the number of replicas and scale plan to adapt to requirement changes and scales

During the update and until its successful completion, the service that the workload provides is not jeopardized as these are production-grade workloads. Hence, consumers can continue using the model (interact with the LLM) during the update process.

During the update process of an inference workload, a new revision of pod(s) is created. This revision is the new desired specification of the workload. Although several updates can be submitted consecutively even if the process of the previous update is not complete, the target goal is always according to the last submitted update. This means, the previous updates are ignored.

Once the new revision is created completely and is up and running, the entire traffic of requests is navigated to the new revision, the original revision is terminated and the resources are sent back to the shared pool. Only then is the update process considered complete.

It is important to note that:

* To finish the inference workload update successfully, the project must have sufficient free GPU quota in favor of the update. For example:  

    * The existing workload uses 3 replicas: A running inference workload with 3 replicas, assuming that each replica is equal to 1 GPU, means the project is already using 3 GPUs of its quota. For the sake of simplicity, we will refer to this revision as revision #1.

    * The workload is updated to use 8 replicas: This means, to complete the update, an additional 8 GPUs of free quota is needed. Only when the update is complete, the 3 GPUs used for the initial revision (revision #1) are reclaimed.

* In the UI, the **Workloads table** displays the configuration of the latest submitted update. For example, if you change the container image, the **image** column in the **running / requested pods** will display the name of updated image. The **status** of the workload continues to reflect  the operational state of the service the workload exposes, as it was originally requested. For instance, during an update, the workload status remains "Running" if the service is still being delivered to consumers. Hovering over the workload's **status** in the grid will display the phase message for the update, offering additional insights into its update state.

* The submission of inference updates is currently possible only via API. The following are the API fields that can be updated:  

    * Command  
    * Args  
    * Image  
    * imagePullPolicy  
    * workingDir  
    * createHomeDir  
    * Probes  
    * environmentVariables  
    * Autoscaling

* As long as the update process is not completed, GPUs are not allocated to the replicas of the new revision. This prevents the allocation of idle GPUs so others will not be deprived using them.
* If the update process is not completed within the default time limit of 10 minutes, it will automatically stop. At that point, all replicas of the new revision will be removed, and the original revision will continue to run normally.
* The default time limit for updates is configurable. Consider setting a longer duration if your workload requires extended time to pull the image due to its size, if the workload takes additional time to reach a 'READY' state due to a long initialization process, or if your cluster depends on autoscaling to allocate resources for new replicas. For example, to set the time limit to 30 minutes, you can run the following command:
```
kubectl patch ConfigMap config-deployment -n knative-serving --type='merge' -p '{"data": {"progress-deadline": "1800s"}}'
```

### Inference workloads with Knative new behavior in v2.19

Starting in version 2.19, all pods of a single Knative revision are grouped under a single Pod-Group. This means that when a new Knative revision is created:

* It either succeeds in allocating the minimum number of pods; or 
* It fails and moves into a pending state, to retry again later to allocate all pods with their resources. 

The resources (GPUs, CPUs) are not occupied by a new Knative revision until it succeeds in allocating all pods. The older revision pods are then terminated and release their resources (GPUs, CPUs) back to the cluster to be used by other workloads.

## See Also

* To set up *Inference*, see [Cluster installation prerequisites](../../admin/runai-setup/cluster-setup/cluster-prerequisites.md#inference).
* For running *Inference* see [Inference quick-start](../../Researcher/Walkthroughs/quickstart-inference.md).
* To run *Inference* using API see [Workload overview](../../developer/cluster-api/workload-overview-dev.md).
