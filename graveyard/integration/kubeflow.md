# Integrate Run:ai with Kubeflow

[Kubeflow](https://www.kubeflow.org/){target=_blank} is a platform for data scientists who want to build and experiment with ML pipelines. Kubeflow is also for ML engineers and operational teams who want to deploy ML systems to various environments for development, testing, and production-level serving.

This document describes the process of using Kubeflow in conjunction with Run:ai. Kubeflow submits jobs that are scheduled via Run:ai.

Kubeflow is a set of technologies. This document discusses [Kubeflow Notebooks](https://www.kubeflow.org/docs/components/notebooks/){target=_blank} and [Kubeflow Pipelines](https://www.kubeflow.org/docs/components/pipelines/){target=_blank}.


## Install Kubeflow

Use the default installation to install Kubeflow.


## Install Run:ai Cluster

When installing Run:ai, [customize the cluster installation](../../runai-setup/cluster-setup/customize-cluster-install) as follows:

<!-- * Set `mpi` to `false` as it conflicts with Kubeflow. -->
* Set `createNamespaces` to `false`, as Kubeflow uses its own namespace convention.


## Create Run:ai Projects 

Kubeflow uses the namespace convention `kubeflow-<username>`. Use the 4 steps [here](../../runai-setup/cluster-setup/customize-cluster-install#manual-creation-of-namespaces) to set up Run:ai projects and link them with Kubeflow namespaces. 

Verify that the association has worked by running:

```
kubectl get rolebindings -n <KUBEFLOW-USER-NAMESPACE>
```

See that role bindings starting with `runai-` were created.

## Kubeflow, Users and Kubernetes Namespaces

Kubeflow has a multi-user architecture. A user has a _Kubeflow profile_ which maps to a Kubernetes Namespace. This is similar to the Run:ai concept where a Run:ai Project is mapped to a Kubernetes namespace.

## Kubeflow Notebooks

When [starting a Kubeflow Notebook](https://www.kubeflow.org/docs/components/notebooks/setup/){target=_blank}, you select a `Kubeflow configuration`. A Kubeflow configuration allows you to inject additional settings into the notebook, such as environment variables. To use Kubeflow with Run:ai you will use configurations to inject:

* The name of the Run:ai project
* Allocation of a fraction of a GPU, if required

### Whole GPUs
To use Run:ai with whole GPUs (no fractions), apply the following configuration:

``` YAML
apiVersion: kubeflow.org/v1alpha1
kind: PodDefault
metadata:
  name: runai-non-fractional
  namespace: <KUBEFLOW-USER-NAMESPACE>
spec:
  desc: "Use Run:ai scheduler (whole GPUs)"
  env:
    - name: RUNAI_PROJECT 
      value: "<PROJECT>"
  selector:
    matchLabels:
      runai-non-fractional: "true"  # key must be identical to metadata.name
```

Where `<KUBEFLOW-USER-NAMESPACE>` is the name of the namespace associated with the Kubeflow user and `<PROJECT>` is the name of the Run:ai project.

!!! important
    Jobs should not be submitted within the same namespace where Kubeflow Operator is installed.

Within the Kubeflow Notebook creation form, select the new configuration as well as the number of GPUs required.

### Fractions

The Kubeflow Notebook creation form only allows the selection of 1, 2, 4, or 8 GPUs. It is not possible to select a portion of a GPU (e.g. 0.5).
As such, within the form, select `None` in the GPU box together with the following configuration:

``` YAML
apiVersion: kubeflow.org/v1alpha1
kind: PodDefault
metadata:
  name: runai-half-gpu
  namespace: <KUBEFLOW-USER-NAMESPACE>
spec:
  desc: "Allocate 0.5 GPUs via Run:ai scheduler"
  env:
    - name: RUNAI_PROJECT 
      value: "<PROJECT>"
    - name: RUNAI_GPU_FRACTION
      value: "0.5"
  selector:
    matchLabels:
      runai-half-gpu: "true"  # key must be identical to metadata.name
```
Similar configurations can be created for fractional configurations, other than 0.5. 

## Kubeflow Pipelines

[Kubeflow Pipelines](https://www.kubeflow.org/docs/components/pipelines/overview/pipelines-overview/){target=_blank} is a platform for building and deploying portable, scalable machine learning (ML) workflows based on Docker containers.

As with Kubeflow Notebooks, the goal of this section is to run pipelines jobs within the context of Run:ai.

To create a Kubeflow pipeline, you:

* Write code using the [Kubeflow Pipeline SDK](https://www.kubeflow.org/docs/components/pipelines/sdk/install-sdk/){target=_blank}. 
* Package it into a single compressed file.
* Upload the file into Kubeflow and set it up.

The example code provided [here](https://github.com/run-ai/docs/tree/master/integrations/kubeflow){target=_blank} shows how to augment pipeline code to use Run:ai

### Whole GPUs

To the pipeline code add:

``` python
_training = training_op()
...
_training.add_pod_label('runai', 'true')
_training.add_pod_label('project', '<PROJECT>')
```

Where `<Project>` is the Run:ai project name. See example code [here](https://github.com/run-ai/docs/blob/master/integrations/kubeflow/kubeflow-runai-one-gpu.py){target=_blank}

Compile the code by running:

```
dsl-compile --py kubeflow-runai-one-gpu.py --output kubeflow-runai-one-gpu.tar.gz
```
(dsl-compile is part of the Kubeflow Pipeline Python SDK).

### Fractions

To allocate half a GPU, add the following to the pipeline code:

``` python
_training = training_op()
...
_training.add_pod_label('runai', 'true')
_training.add_pod_label('project', '<PROJECT>')
_training.add_pod_annotation('gpu-fraction', '0.5')
```

Where `<Project>` is the Run:ai project name. See example code [here](https://github.com/run-ai/docs/blob/master/integrations/kubeflow/kubeflow-runai-half-gpu.py){target=_blank}.

Compile the code as described above. 
