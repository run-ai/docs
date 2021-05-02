# (Optional) Customize Cluster Installation

The Run:AI Admin UI cluster creation wizard requires the download of a _Helm values file_ `runai-<cluster-name>.yaml`. You may need to edit this file. Examples:

* Disable the installation of third-party dependencies which already exist on the Kubernetes cluster
* Security review and pre-installation of Kubernetes cluster-wide access roles
* Add an _ingress_ point
* Add an outbound internet proxy


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
| `gpu-feature-discovery.enabled` | `true`  |  Set to `false` to not install Node Feature Discovery (assumes a prior install outside Run:AI scope) |
| `kube-prometheus-stack.enabled` |  `true`  |  Set to `false` to not install Prometheus (assumes a prior install outside Run:AI scope). Requires additional configuration of Prometheus to add Run:AI related exporter rules |


## Understanding Custom Access Roles

To review the access roles created by the Run:AI Cluster installation, see [Understanding Access Roles](access-roles.md)

## Add an Ingress point

Set aside an IP address for _ingress_ access to containers (e.g. for Jupyter Notebooks, PyCharm, VisualStudio Code). See: [Allow external access to Containers](allow-external-access-to-containers.md). Note that you can access containers via _port forwarding_ without requiring an ingress point. 


## Add a Proxy

Allow outbound internet connectivity in a proxied network environment. See [Installing Run:AI with an Internet Proxy Server](proxy-server.md).

