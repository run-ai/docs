# (Optional) Customize Cluster Installation

The Run:AI Admin UI cluster creation wizard requires the download of a _Helm values file_ `runai-<cluster-name>.yaml`. The file may be edited to customize the cluster installation.


## Configuration Flags

|  Key     |  Default  | Description |
|----------|----------|-------------| 
| `pspEnabled` | `false` | Set to `true` when using [PodSecurityPolicy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} | 
| `runai-operator.config.project-controller.createNamespaces` | `true` | Set to `false`if unwilling to provide Run:AI the ability to create namespaces. When set to false, will requires an additional manual step when creating new Run:AI Projects | 
| `runai-operator.config.project-controller.createRoleBindings` | `true` | Set to `false` when using OpenShift. When set to false, will require an additional manual step when assigning users to Run:AI Projects | 
| `runai-operator.config.project-controller.clusterWideSecret` | `true` | Set to `false` when using PodSecurityPolicy or OpenShift | 
| `runai-operator.config.mps-server.enabled` | `false` | Set to `true` to allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads  | 
| `runai-operator.config.runai-container-toolkit.enabled` | `true` | Controls the usage of __Fractions__.  | 
| `gpu-feature-discovery.enabled` | `true`  |  Set to `false` to not install GPU Feature Discovery (assumes a prior install outside Run:AI scope) |
| `kube-prometheus-stack.enabled` |  `true`  | Set to `false` when the cluster has an existing Prometheus installation. that is __not based__ the Prometheus __operator__ . This setting requires Run:AI customer support. |
| `kube-prometheus-stack.prometheusOperator.enabled` |  `true`  |  Set to `false` when the cluster has an existing Prometheus installation __based__ on the Prometheus __operator__ and Run:AI should use the existing one rather than install a new one | 
|<img width=500/>|||


### Feature Discovery

The Run:AI Cluster installation installs by default two pre-requisites:  Kubernetes [Node Feature Discovery (NFD)](https://github.com/kubernetes-sigs/node-feature-discovery){target=_blank} and [NVIDIA GPU Feature Discovery (GFD)](https://github.com/NVIDIA/gpu-feature-discovery){target=_blank}. 

* If your Kubernetes cluster already has GFD installed, you will want to set `gpu-feature-discovery.enabled` to `false`. 
* NFD is a prerequisite of GFD. If GFD is not installed, but NFD is already installed, you can disable NFD installation by setting `gpu-feature-discovery.nfd.deploy` to `false`. 

### Prometheus

The Run:AI Cluster installation uses [Promethues](https://prometheus.io/){target=_blank}. There are 3 alternative configurations:

1. (The default) Run:AI installs Prometheus.
2. Run:AI uses an existing Prometheus installation based on the Prometheus operator.
3. Run:AI uses an existing Prometheus installation based on a regular Prometheus installation.

For option 2, disable the flag `kube-prometheus-stack.prometheusOperator.enabled`. For option 3, please contact Run:AI Customer support. 


## Understanding Custom Access Roles

To review the access roles created by the Run:AI Cluster installation, see [Understanding Access Roles](../advanced/access-roles.md)

<!-- 
## Add a Proxy

Allow outbound internet connectivity in a proxied network environment. See [Installing Run:AI with an Internet Proxy Server](proxy-server.md). -->

## Manual Creation of Namespaces

Run:AI Projects are implemented as Kubernetes namespaces. By default, the administrator creates a new Project via the Administration user interface which then triggers the creation of a Kubernetes namespace named `runai-<PROJECT-NAME> `.
There are a couple of use cases that customers will want to disable this feature:

* Some organizations prefer to use their internal naming convention for Kubernetes namespaces, rather than Run:AI's default `runai-<PROJECT-NAME>` convention.
* When PodSecurityPolicy is enabled, some organizations will not allow Run:AI to automatically create Kubernetes namespaces. 


Follow the following process to achieve this

1. Disable the namespace creation functionality. See the  `runai-operator.config.project-controller.createNamespaces` flag above.
2. [Create a Project](../../../admin-ui-setup/project-setup/#create-a-new-project) using the Administrator User Interface. 
3. Create the namespace if needed by running: `kubectl create ns <NAMESPACE>`. The suggested Run:AI default is `runai-<PROJECT-NAME>`.
4. Label the namespace to connect it to the Run:AI Project by running `kubectl label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>`

where  `<PROJECT_NAME>` is the name of the project you have created in the Administrator UI above and `<NAMESPACE>` is the name you chose for your namespace.


