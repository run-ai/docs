# (Optional) Customize Cluster Installation

The Run:AI Admin UI cluster creation wizard requires the download of a _Helm values file_ `runai-<cluster-name>.yaml`. The file may be edited to customize the cluster installation.


## Configuration Flags

|  Key     |  Default  | Description |
|----------|----------|-------------| 
| `runai-operator.config.global.openshift` |  `false` |  Set to `true` with OpenShift  |
| `runai-operator.config.init-ca.enabled` | `true` | Set to `false` with OpenShift | 
| `pspEnabled` | `false` | Set to `true` when using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} | 
| `runai-operator.config.project-controller.createNamespacesAndRoleBindings` | `true` | Set to `false` when using PodSecurityPolicy or OpenShift. Requires an additional manual step when creating new Run:AI Projects | 
| `runai-operator.config.project-controller.clusterWideSecret` | `true` | Set to `false` when using PodSecurityPolicy or OpenShift | 
| `runai-operator.config.mps-server.enabled` | `false` | Set to `true` to allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads  | 
| `runai-operator.config.runai-container-toolkit.enabled` | `true` | Controls the usage of __Fractions__.  | 
| `gpu-feature-discovery.enabled` | `true`  |  Set to `false` to not install GPU Feature Discovery (assumes a prior install outside Run:AI scope) |
| `kube-prometheus-stack.enabled` |  `true`  |  Set to `false` to not install Prometheus (assumes a prior install outside Run:AI scope). Requires additional configuration of Prometheus to add Run:AI related exporter rules |


### Feature Discovery

The Run:AI Cluster installation installs by default two pre-requisites:  Kubernetes [Node Feature Discovery (NFD)](https://github.com/kubernetes-sigs/node-feature-discovery){target=_blank} and [NVIDIA GPU Feature Discovery (GFD)](https://github.com/NVIDIA/gpu-feature-discovery){target=_blank}. 

* If your Kubernetes cluster already has GFD installed, you will want to set `gpu-feature-discovery.enabled` to `false`. 
* NFD is a prerequisite of GFD. If GFD is not installed, but NFD is already installed, you can disable NFD installation by setting `gpu-feature-discovery.nfd.deploy` to `false`. 

### Prometheus

The Run:AI Cluster installation installs Prometheus by default. If your Kubernetes cluster already has Prometheus installed, set `kube-prometheus-stack.enabled` to `false`. 

An extra configuration step will be required to add the Run:AI Prometheus rules and to push metrics to the Run:AI Administration User Interface. Please contact Run:AI Customer support. 


## Understanding Custom Access Roles

To review the access roles created by the Run:AI Cluster installation, see [Understanding Access Roles](access-roles.md)

<!-- ## Add an Ingress point

Set aside an IP address for _ingress_ access to containers (e.g. for Jupyter Notebooks, PyCharm, VisualStudio Code). See: [Allow external access to Containers](allow-external-access-to-containers.md). Note that you can access containers via _port forwarding_ without requiring an ingress point.  -->

<!-- 
## Add a Proxy

Allow outbound internet connectivity in a proxied network environment. See [Installing Run:AI with an Internet Proxy Server](proxy-server.md). -->

