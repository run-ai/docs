# Workloads Overview

## Workloads

Run:ai schedules __Workloads__. Workloads is a relatively new terminology in Run:ai which encompasses:

* The "Kubernetes object" that eventually create a container that runs.
* Any other resources required to run the Job. Examples: a service entry point that allows access to the Job, a persistent volume claim to access data on the network and more. 

Run:AI currently supports the following Workloads types:

* `InteractiveWorkload`: For submission of interactive workloads.
* `TrainingWorkload`: For submission of training workloads.
* `InferenceWorkload`: For submission of inference workloads.
* `DeploymentWorkload`: For submission of inference workloads. For backward compatibility XXXXXX


## Values

A Workload will typically have a list of _values_, such as name, image and resources. A full list of values is available XXXXX

## How to Submit

A Workload can be submitted via various channels:

* The Run:ai [user interface](../../admin/admin-ui-setup/jobs.md)
* The Run:ai command-line interface, via the [runai submit](../../Researcher/cli-reference/runai-submit.md) command
* The Run:ai researcher API

The focus of this section is the Researcher API

## Policies

An Administrator can set _Policies_ for Workload submission. 

Policies serve two purposes:

1) To impose guidelines on the values a researcher can specify for each parameter.
2) To provide default values to various parameters.

For example, and administrator can,

* Impose a maximum of 5 GPUs per Workload. 
* Provide a default value of 1 GPU for each container. 

Each workload type has a matching kind of workload policy. For example, an `InteractiveWorkload` has a matching `InteractivePolicy`

Policy of each type can be defined _per-project_. There is also a _global_ policy which applies to any project that does not have a per-project policy.


 XXXXX Further details about policies can be found in the [policies guide]    XXX (../../admin/researcher-setup/policies.md).