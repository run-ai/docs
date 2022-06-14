## Introduction

Jobs can be started via Kubeflow, Run:ai CLI, Rancher or via direct Kubernetes API. When Jobs are finished (successfully or failing), their resource allocation is taken away, but they remain in the system. You can see old Jobs by running the command:

    runai list jobs

![mceclip0.png](img/mceclip0.png)

You can delete the Job manually by running:

    runai delete job run3

But this may not be scalable for a production system.

It is possible to flag a Job for automatic deletion sometime after it finishes.

!!! Important note 
    Deleting a Job, deletes the container behind it, and with it all related information such as Job logs. Data that was saved by the Researcher on a shared drive is not affected. The Job is also __not__ deleted from the Run:ai user interface

## Enable Automatic Deletion in Cluster (Admin only)

In order for automatic deletion to work, the on-prem Kubernetes cluster needs to be modified. The feature relies on a Kubernetes feature gate "<a href="https://kubernetes.io/docs/concepts/workloads/controllers/ttlafterfinished/" target="_self">TTLAfterFinished</a>"

__Note__: different Kubernetes distributions have different locations and methods to add feature flags. The instructions below are an example based on [Kubespray](https://github.com/kubernetes-sigs/kubespray){target=_blank}. Refer to the documentation of your Kubernetes distribution.

*   Open a shell on the Kubernetes __master__
*   cd to/etc/kubernetes/manifests
*   vi kube-apiserver.yaml
*   add `--feature-gates=TTLAfterFinished=true` to the following location:

``` yaml
spec:
    containers:
    - command:
    - kube-apiserver
        .....
    - --feature-gates=TTLAfterFinished=true
```

*   vi kube-controller-manager.yaml
*   add `--feature-gates=TTLAfterFinished=true` to the following location:

``` yaml
spec:
    containers:
    - command:
    - kube-controller-manager
        .....
    - --feature-gates=TTLAfterFinished=true
```    


## Automatic Deletion

When starting the Job, add the flag `--ttl-after-finish duration`. duration is the duration, post Job finish, after which the Job is automatically deleted. Example durations are 5s, 2m, 3h, 4d, etc. For example, the following call will delete the Job 2 hours after the Job finishes:

```
runai submit myjob1 --ttl-after-finish 2h
```

## Using Policies to set Automatic Deletion as Default

You can use Run:ai policies to set auto-delete to be the default. See [template configuration](../../admin/workloads/policies.md) for more information on how to make this flag a part of the default template.