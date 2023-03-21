# Workloads Overview

## Workloads

Run:ai schedules __Workloads__. Run:ai workloads contain:

* The _Kubernetes resource_ (Job, Deployment, etc) that is used to launch the container inside which the data science code runs. 
* A set of additional resources that is required to run the Workload. Examples: a service entry point that allows access to the Job, a persistent volume claim to access data on the network and more. 

Run:ai supports the following Workloads types:

|  Workload Type | Kubernetes Name | Description |
|----------------|-----------------|-------------|
| Interactive    | `InteractiveWorkload` | Submit an interactive workload |
| Training       | `TrainingWorkload`| Submit a training workload |
| Distributed Training | `DistributedWorkload` | Submit a distributed training workload using TensorFlow, PyTorch or MPI | 
| Inference      | `InferenceWorkload` | Submit an inference workload |


## Values

A Workload will typically have a list of _values_, such as name, image, and resources. A full list of values is available in the [runai-submit](../../Researcher/cli-reference/runai-submit.md) Command-line reference.  

You can also find the exact YAML syntax run:

```
kubectl explain TrainingWorkload.spec
```

(and similarly for other Workload types).

To get information on a specific value (e.g. `node type`), you can also run:

```
kubectl explain TrainingWorkload.spec.nodeType
```

Result:

```
KIND:     TrainingWorkload
VERSION:  run.ai/v2alpha1

RESOURCE: nodeType <Object>

DESCRIPTION:
     Specifies nodes (machines) or a group of nodes on which the workload will
     run. To use this feature, your Administrator will need to label nodes as
     explained in the Group Nodes guide at
     https://docs.run.ai/admin/researcher-setup/limit-to-node-group. This flag
     can be used in conjunction with Project-based affinity. In this case, the
     flag is used to refine the list of allowable node groups set in the
     Project. For more information consult the Projects guide at
     https://docs.run.ai/admin/admin-ui-setup/project-setup.

FIELDS:
   value	<string>
```


## How to Submit

A Workload can be submitted via various channels:

* The Run:ai [user interface](../../admin/admin-ui-setup/jobs.md).
* The Run:ai command-line interface, via the [runai submit](../../Researcher/cli-reference/runai-submit.md) command.
* The Run:ai [Cluster API](submit-yaml.md).

## Policies

An Administrator can set _Policies_ for Workload submission. Policies serve two purposes:

1. To constrain the values a researcher can specify.
2. To provide default values.

For example, an administrator can,

* Set a maximum of 5 GPUs per Workload. 
* Provide a default value of 1 GPU for each container. 

Each workload type has a matching kind of workload policy. For example, an `InteractiveWorkload` has a matching `InteractivePolicy`

A Policy of each type can be defined _per-project_. There is also a _global_ policy that applies to any project that does not have a per-project policy.

For further details on policies, see [Policies](../../admin/workloads/policies.md).