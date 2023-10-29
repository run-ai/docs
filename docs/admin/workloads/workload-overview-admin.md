# Workloads Overview

## Workloads

Run:ai schedules __Workloads__. Run:ai workloads are comprised of:

* The _Kubernetes object_ (Job, Deployment, etc) which is used to launch the container, inside which the data science code runs. 
* A set of additional resources that are required to run the Workload. Examples: a service entry point that allows access to the Job, a persistent volume claim to access data on the network, and more. 

All of these components are created together and deleted together when the Workload ends. 

Run:ai currently supports the following Workloads types:

|  Workload Type | Kubernetes Name | Description |
|----------------|-----------------|-------------|
| Interactive    | `InteractiveWorkload` | Submit an interactive workload |
| Training       | `TrainingWorkload`| Submit a training workload |
| Distributed Training | `DistributedWorkload` | Submit a distributed training workload using TensorFlow, PyTorch or MPI | 
| Inference      | `InferenceWorkload` | Submit an inference workload |

## Values

A Workload will typically have a list of _values_ (sometimes called _flags_), such as name, image, and resources. A full list of values is available in the [runai-submit](../../Researcher/cli-reference/runai-submit.md) Command-line reference.

## How to Submit

A Workload can be submitted via various channels:

* The Run:ai [user interface](../../admin/admin-ui-setup/jobs.md).
* The Run:ai command-line interface, via the [runai submit](../../Researcher/cli-reference/runai-submit.md) command.
* The Run:ai [Cluster API](../../developer/cluster-api/workload-overview-dev.md).

## Workload Policies

As an administrator, you can set _Policies_ on Workloads.  Policies allow administrators to _impose restrictions_ and set _default values_ for Researcher Workloads. For more information see [Workload Policies](policies.md).

