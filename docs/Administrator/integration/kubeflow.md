# Integrate Run:AI with KubeFlow

[KubeFlow](https://www.kubeflow.org/){target=_blank} is a platform for data scientists who want to build and experiment with ML pipelines. Kubeflow is also for ML engineers and operational teams who want to deploy ML systems to various environments for development, testing, and production-level serving.

This document describes the process of using KubeFlow in conjunction with Run:AI. KubeFlow submits jobs which are scheduled via Run:AI.

KubeFlow is a set of technologies. This document discusses [KubeFlow Notebooks](https://www.kubeflow.org/docs/components/notebooks/){target=_blank} and [KubeFlow Pipelines](https://www.kubeflow.org/docs/components/pipelines/){target=_blank}.


## Install KubeFlow

Use the default installation to install KubeFlow.


## Install Run:AI Cluster

When installation Run:AI, [customize the cluster installation](../../Cluster-Setup/customize-cluster-install) as follows:

* Set `mpi` to `false` as it conflicts with KubeFlow.
* Set `createNamespaces` to `false`, as KubeFlow uses its on namespace convention.


## Create Run:AI Projects 

KubeFlow uses the namespace conversion `kubeflow-<username>`. Use the 4 steps [here](../../Cluster-Setup/customize-cluster-install#manual-creation-of-namespaces)

Verify that the association has worked by running:

```
kubectl get rolebindings -n <NAMESPACE>
```

See that there exist role bindings starting with `runai-`


## Usage

### KubeFlow Notebooks

xxx 

### KubeFlow Pipelines

xxx

## See Also

xxx 