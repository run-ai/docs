# Integrate Run:AI with KubeFlow

[KubeFlow](https://www.kubeflow.org/){target=_blank} is a platform for data scientists who want to build and experiment with ML pipelines. Kubeflow is also for ML engineers and operational teams who want to deploy ML systems to various environments for development, testing, and production-level serving.

This document describes the process of using KubeFlow in conjunction with Run:AI. KubeFlow submits jobs that are scheduled via Run:AI.

KubeFlow is a set of technologies. This document discusses [KubeFlow Notebooks](https://www.kubeflow.org/docs/components/notebooks/){target=_blank} and [KubeFlow Pipelines](https://www.kubeflow.org/docs/components/pipelines/){target=_blank}.


## Install KubeFlow

Use the default installation to install KubeFlow.


## Install Run:AI Cluster

When installing Run:AI, [customize the cluster installation](../../Cluster-Setup/customize-cluster-install) as follows:

* Set `mpi` to `false` as it conflicts with KubeFlow.
* Set `createNamespaces` to `false`, as KubeFlow uses its on namespace convention.


## Create Run:AI Projects 

KubeFlow uses the namespace convension `kubeflow-<username>`. Use the 4 steps [here](../../Cluster-Setup/customize-cluster-install#manual-creation-of-namespaces) to set up Run:AI projects and link them with Kubeflow namespaces. 

Verify that the association has worked by running:

```
kubectl get rolebindings -n <KUBEFLOW-NAMESPACE>
```

See that role bindings starting with `runai-` were created.

## KubeFlow, Users and Kubernetes Namespaces

Kubeflow has a multi-user architecture. A user has a _KubeFlow profile_ which maps to a Kubernetes Namespace. This is similar to the Run:AI concept where a Run:AI Project is mapped to a Kubernetes namespace.

## KubeFlow Notebooks

When [starting a KubeFlow Notebook](https://www.kubeflow.org/docs/components/notebooks/setup/){target=_blank}, you select a `Kubeflow configuration`. A KubeFlow configuration allows you to inject additional settings into the notebook, such as environment variables. To use KubeFlow with Run:AI you will use configurations to inject:

* The name of the Run:AI project
* Allocation of a fraction of a GPU, if required

### Whole GPUs
To use Run:AI with whole GPUs (no fractions), apply the following configuration:

``` YAML
apiVersion: kubeflow.org/v1alpha1
kind: PodDefault
metadata:
  name: runai-non-fractional
  namespace: <KUBEFLOW-NAMESPACE>
spec:
  desc: "Use Run:AI scheduler (whole GPUs)"
  env:
    - name: RUNAI_PROJECT 
      value: "<PROJECT>"
  selector:
    matchLabels:
      runai-non-fractional: "true"  # key must be identical to metadata.name
```

Where `<KUBEFLOW-NAMESPACE>` is the name of the namespace associated with the Kubeflow user and `<PROJECT>` is the name of the Run:AI project.

Within the KubeFlow Notebook creation form, select the new configuration as well as the number of GPUs required.

### Fractions

The KubeFlow Notebook creation form only allows the selection of 1, 2, 4, or 8 GPUs. It is not possible to select a portion of a GPU (e.g. 0.5).
As such, within the form, select `None` in the GPU box together with the following configuration:

``` YAML
apiVersion: kubeflow.org/v1alpha1
kind: PodDefault
metadata:
  name: runai-half-gpu
  namespace: <KUBEFLOW-NAMESPACE>
spec:
  desc: "Allocate 0.5 GPUs via Run:AI scheduler"
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

## KubeFlow Pipelines

[Kubeflow Pipelines](https://www.kubeflow.org/docs/components/pipelines/overview/pipelines-overview/){target=_blank} is a platform for building and deploying portable, scalable machine learning (ML) workflows based on Docker containers.

As with Kubeflow Notebooks, the goal of this section is to run pipelines jobs within the context of Run:AI.

To create a Kubeflow pipeline, you:

* Write code using the [Kubeflow Pipeline SDK](https://www.kubeflow.org/docs/components/pipelines/sdk/install-sdk/){target=_blank}. 
* Package it into a single compressed file.
* Upload the file into Kubeflow and set it up.

The example code provided [here](https://github.com/run-ai/docs/tree/master/integrations/kubeflow){target=_blank} shows how to augment pipeline code to use Run:AI

### Whole GPUs

To the pipeline code add:

``` python
_training = training_op()
...
_training.add_pod_label('runai', 'true')
_training.add_pod_label('project', '<PROJECT>')
```

Where `<Project>` is the Run:AI project name. See example code [here](https://github.com/run-ai/docs/blob/master/integrations/kubeflow/kubeflow-runai-one-gpu.py){target=_blank}

Compile the code by running:

```
dsl-compile --py kubeflow-runai-one-gpu.py --output kubeflow-runai-one-gpu.tar.gz
```
(dsl-compile is part of the Kubeflow Pipeline python SDK).

### Fractions

To allocate half a GPU, add the following to the pipeline code:

``` python
_training = training_op()
...
_training.add_pod_label('runai', 'true')
_training.add_pod_label('project', '<PROJECT>')
_training.add_pod_annotation('gpu-fraction', '0.5')
```

Where `<Project>` is the Run:AI project name. See example code [here](https://github.com/run-ai/docs/blob/master/integrations/kubeflow/kubeflow-runai-half-gpu.py){target=_blank}.

Compile the code as described above. 
