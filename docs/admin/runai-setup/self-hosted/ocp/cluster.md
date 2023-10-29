---
title: Self-Hosted installation over OpenShift - Cluster Setup
---


## Prerequisites

!!! Note
    You must have Cluster Administrator rights to install these dependencies. 

Before installing Run:ai, you must install NVIDIA software on your OpenShift cluster to enable GPUs. 
NVIDIA has provided [detailed documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/openshift/introduction.html){target=_blank}. 
Follow the instructions to install the two operators `Node Feature Discovery` and `NVIDIA GPU Operator` from the OpenShift web console. 

When done, verify that the GPU Operator is installed by running:

```
oc get pods -n nvidia-gpu-operator
```

(the GPU Operator namespace may differ in different operator versions).


## Create OpenShift Projects

Run:ai cluster installation uses several namespaces (or _projects_ in OpenShift terminology). Run the following:

```
oc new-project runai
oc new-project runai-reservation
oc new-project runai-scale-adjust
```

The last namespace (`runai-scale-adjust`) is only required if the cluster is a cloud cluster and is configured for auto-scaling. 

## Cluster Installation



=== "Connected"
    Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai). When creating a new cluster, select the __OpenShift__  target platform.

    !!! Info
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-cluster`.
=== "Airgapped"
    Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai). When creating a new cluster, select the __OpenShift__  target platform. The `helm` install command should use the `runai-cluster` tar file:
    ```
    helm install runai-cluster -n runai  \ 
      runai-cluster-<version>.tgz -f runai-<cluster-name>.yaml  
    ```


### Optional Configuration

Make the following changes to the configuration file you have downloaded:


|  Key     |  Change  | Description |
|----------|----------|-------------| 
| `runai-operator.config.project-controller.createNamespaces` |  `true` | Set to `false` if unwilling to provide Run:ai the ability to create namespaces, or would want to create namespaces manually rather than use the Run:ai convention of `runai-<PROJECT-NAME>`. When set to `false`, will require an additional [manual step](project-management.md) when creating new Run:ai Projects. | 
| `runai-operator.config.project-controller.clusterWideSecret` | `true` | Set to `false` if unwilling to provide Run:ai the ability to create Kubernetes Secrets. When not enabled, automatic [secret propagation](../../../workloads/secrets.md#secrets-and-projects) will not be available | 
| `runai-operator.config.mps-server.enabled` | Default is `false` | Allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads. Requires [extra permissions](../preparations/#cluster-installation) | 
| `runai-operator.config.runai-container-toolkit.enabled` | `true` | Controls the usage of __Fractions__. Requires extra cluster permissions  | 
| `runai-operator.config.runaiBackend.password` | Default password already set  | [admin@run.ai](mailto:admin.run.ai) password. Need to change only if you have changed the password [here](../backend/#other-changes-to-perform) | 

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details see [understanding cluster access roles](../../../config/access-roles/).



### (Optional) Prometheus Adapter for Inference
The Prometheus adapter is required if you are using Inference workloads and require a custom metric for autoscaling. The following additional steps are required for it to work:

1. Copy `prometheus-adapter-prometheus-config` and `serving-certs-ca-bundle` ConfigMaps from `openshift-monitoring` namespace to the `monitoring` namespace
```
kubectl get cm prometheus-adapter-prometheus-config --namespace=openshift-monitoring -o yaml \
  | sed 's/namespace: openshift-monitoring/namespace: monitoring/' \
  | kubectl create -f -
kubectl get cm serving-certs-ca-bundle --namespace=openshift-monitoring -o yaml \
  | sed 's/namespace: openshift-monitoring/namespace: monitoring/' \
  | kubectl create -f -
```
2. Allow Prometheus Adapter `serviceaccount` to create a `SecurityContext` with RunAsUser 10001:
```
oc adm policy add-scc-to-user anyuid system:serviceaccount:monitoring:runai-cluster-prometheus-adapter
```





## Next Steps

Continue to [create Run:ai Projects](project-management.md).
