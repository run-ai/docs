---
title: Self Hosted installation over Kubernetes - Cluster Setup
---
## Customize Installation

* Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai). 
* __(Optional)__ make the following changes to the configuration file you have downloaded:


|  Key     |  Default  | Description |
|----------|----------|-------------| 
| `pspEnabled` |  `false` | Set to `true` when using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} | 
| `ingress-nginx.podSecurityPolicy.enabled` | Set to `true` when using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank}  | 
| `runai-operator.config.project-controller.createNamespaces` |  `true` | Set to `false` if unwilling to provide Run:AI the ability to create namespaces, or would want to create namespaces manually rather than use the Run:AI convention of `runai-<PROJECT-NAME>`. When set to `false`, will require an additional [manual step](project-management.md) when creating new Run:AI Projects. | 
| `runai-operator.config.project-controller.createRoleBindings` |  `true` | Automatically assign Users to Projects. Set to `false` if unwilling to provide Run:AI the ability to set _RoleBinding_. When set to `false`, will require an additional [manual step](project-management.md) when adding or removing users from Projects.  | 
| `runai-operator.config.project-controller.clusterWideSecret` | `true` | Set to `false` if unwilling to provide Run:AI the ability to create Kubernetes Secrets. When not enabled, automatic [secret propagation](../../../../researcher-setup/use-secrets/#secrets-and-projects) will not be available | 
| `runai-operator.config.mps-server.enabled` |  `false` | Allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads. Requires extra cluster permissions <!-- (../preparations/#cluster-installation) --> | 
| `runai-operator.config.runai-container-toolkit.enabled` | `true` | Controls the usage of __Fractions__. Requires extra cluster permissions <!-- >](../preparations/#cluster-installation) --> | 
| `runai-operator.config.runaiBackend.password` | Default password already set  | [admin@run.ai](mailto:admin.run.ai) password. Need to change only if you have changed the password [here](../backend/#other-changes-to-perform) | 
| `gpu-feature-discovery.enabled` | `true` | Install __Node Feature Discovery__. Set to `false` if already installed in cluster |
| `kube-prometheus-stack.enabled` | `true` | Install Prometheus. Set to `false` if __Prometheus__ is already installed in cluster |
| `mpi-operator.enabled` | `true` | Set to `false` when using PodSecurityPolicy. __MPI__ is the distributed-training operator from KubeFlow. Currently must run with root access |


### Feature Discovery

The Run:AI Cluster installation installs by default two pre-requisites:  Kubernetes [Node Feature Discovery (NFD)](https://github.com/kubernetes-sigs/node-feature-discovery){target=_blank} and [NVIDIA GPU Feature Discovery (GFD)](https://github.com/NVIDIA/gpu-feature-discovery){target=_blank}. 

* If your Kubernetes cluster already has GFD installed, you will want to set `gpu-feature-discovery.enabled` to `false`. 
* NFD is a prerequisite of GFD. If GFD is not installed, but NFD is already installed, you can disable NFD installation by setting `gpu-feature-discovery.nfd.deploy` to `false`. 

### Prometheus 

The Run:AI Cluster installation installs Prometheus by default. If your Kubernetes cluster already has Prometheus installed, set the flag `kube-prometheus-stack.enabled` to `false`.

When using an existing Prometheus installation, you will need to add additional rules to your Prometheus configuration. The rules can be found under `deploy/runai-prometheus-rules.yaml`.

 

### NVIDIA Device Plugin

Run:AI has customized the [NVIDIA device plugin for Kubernetes](https://github.com/NVIDIA/k8s-device-plugin){target=_blank}. If you have installed the NVIDIA GPU Operator or have previously installed this plug-in, run the following to disable the existing plug-in:

```
kubectl -n gpu-operator-resources patch daemonset nvidia-device-plugin-daemonset \
   -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
```

<!-- 
admission-controller:
  args:
    runaiFractionalMinAllocationEnforcementBytes: 1000000  
-->

## Install Cluster


Run:

=== "Connected"
    ```
    helm repo add runai https://run-ai-charts.storage.googleapis.com
    helm repo update

    helm install runai-cluster runai/runai-cluster -n runai \
        -f runai-<cluster-name>.yaml --create-namespace
    ```

    !!! Info
        To install a specific version, add `--version <version>` to the install command.

=== "Airgapped"
    ```
    helm install runai-cluster -n runai  \ 
      runai-cluster-<version>.tgz -f runai-<cluster-name>.yaml --create-namespace
    ```

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details see: [Understanding cluster access foles](../../../advanced/access-roles/).


## Next Steps

Continue to [configure web interfaces](ui.md).

