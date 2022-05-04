# Workloads Overview

:octicons-versions-24: [Version 2.5](../../home/whats-new-2022.md#may-2022-runai-version-25)

## Workloads

Run:ai schedules __Workloads__. Run:ai workloads contain:

* The _Kubernetes object_ (Job, Deployment, etc) is used to launch the container inside which the data science code runs. 
* A set of additional resources required to run the Workload. Examples: a service entry point that allows access to the Job, a persistent volume claim to access data on the network and more. 

Run:ai currently supports the following Workloads types:

|  Workload Type | Kubernetes Name | Description |
|----------------|-----------------|-------------|
| Interactive    | `InteractiveWorkload` | Submit an interactive workload |
| Training       | `TrainingWorkload`| Submit a training workload |
| Inference      | `InferenceWorkload` | Submit an inference workload |
| Old Inference |  `DeploymentWorkload`| Supports the older Inference implementation of Run:ai |


## Values

A Workload will typically have a list of _values_, such as name, image, and resources. A full list of values is available in the [runai-submit](../../Researcher/cli-reference/runai-submit.md) Command-line reference.

## How to Submit

A Workload can be submitted via various channels:

* The Run:ai [user interface](../../admin/admin-ui-setup/jobs.md)
* The Run:ai command-line interface, via the [runai submit](../../Researcher/cli-reference/runai-submit.md) command
* The Run:ai Cluster API

The focus of this section is the Cluster API

## Policies

An Administrator can set _Policies_ for Workload submission. Policies serve two purposes:

1) To impose guidelines on the values a researcher can specify for each parameter.
2) To provide default values to various parameters.

For example, an administrator can,

* Set a maximum of 5 GPUs per Workload. 
* Provide a default value of 1 GPU for each container. 

Each workload type has a matching kind of workload policy. For example, an `InteractiveWorkload` has a matching `InteractivePolicy`

A Policy of each type can be defined _per-project_. There is also a _global_ policy that applies to any project that does not have a per-project policy.

For further details on policies, see [Policies](../../admin/workloads/policies.md).