# (Optional) Customize Cluster Installation

The Run:ai cluster creation wizard requires the download of a _Helm values file_ `runai-<cluster-name>.yaml`. The file may be edited to customize the cluster installation.


## Configuration Flags

|  Key     |  Default  | Description |
|----------|----------|-------------| 
| `runai-operator.config.project-controller.createNamespaces` | `true` | Set to `false`if unwilling to provide Run:ai the ability to create namespaces. When set to false, will requires an additional manual step when creating new Run:ai Projects | 
| `runai-operator.config.project-controller.clusterWideSecret` | `true` | Set to `false` when using PodSecurityPolicy or OpenShift | 
| `runai-operator.config.mps-server.enabled` | `false` | Set to `true` to allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads  | 
| `runai-operator.config.global.runtime` | `docker` | Defines the container runtime of the cluster (supports `docker` and `containerd`). Set to `containerd` when using Tanzu | 
| `runai-operator.config.global.nvidiaDcgmExporter.namespace` | `gpu-operator` | The namespace where dcgm-exporter (or gpu-operator) was installed |
| `runai-operator.config.global.nvidiaDcgmExporter.installedFromGpuOperator` | `true` | Indicated whether the dcgm-exporter was installed via gpu-operator or not |
| `kube-prometheus-stack.enabled` |  `true`  | (Version 2.8 or lower)  Set to `false` when the cluster has an existing Prometheus installation that is __not based__ on the Prometheus __operator__. This setting requires Run:ai customer support |
| `kube-prometheus-stack.prometheusOperator.enabled` |  `true`  | (Version 2.8 or lower)  Set to `false` when the cluster has an existing Prometheus installation __based__ on the Prometheus __operator__ and Run:ai should use the existing one rather than install a new one | 
| `prometheus-adapter.enabled` | `false` | (Version 2.8 or lower) Install Prometheus Adapter. Used for Inference workloads using a custom metric for autoscaling. Set to `true` if __Prometheus Adapter__ is not already installed in the cluster |
| `prometheus-adapter.prometheus` |   The address of the default Prometheus Service | (Version 2.8 or lower) If you installed your own custom Prometheus Service, set this field accordingly with `url` and `port` |


<!-- | `runai-operator.config.project-controller.createRoleBindings` | `true` | Set to `false` when using OpenShift. When set to false, will require an additional manual step when assigning users to Run:ai Projects |  -->

### Prometheus

=== "Version 2.9 or higher"
    Not relevant

=== "Version 2.8 or lower"
    The Run:ai Cluster installation uses [Prometheus](https://prometheus.io/){target=_blank}. There are 3 alternative configurations:

    1. Run:ai installs Prometheus (default).
    2. Run:ai uses an existing Prometheus installation based on the Prometheus operator.
    3. Run:ai uses an existing Prometheus installation based on a regular Prometheus installation.

    For option 2, disable the flag `kube-prometheus-stack.prometheusOperator.enabled`. For option 3, please contact Run:ai Customer support. 

    For options 2 and 3, if you enabled `prometheus-adapter`, please configure it as described in the Prometheus Adapter [documentation](https://github.com/prometheus-community/helm-charts/blob/97f23f1ff7ca62f33ab4dd339cc62addec7eccde/charts/prometheus-adapter/values.yaml#L34)


## Understanding Custom Access Roles

To review the access roles created by the Run:ai Cluster installation, see [Understanding Access Roles](../config/access-roles.md).

<!-- 
## Add a Proxy

Allow outbound internet connectivity in a proxied network environment. See [Installing Run:ai with an Internet Proxy Server](proxy-server.md). -->

## Manual Creation of Namespaces

Run:ai Projects are implemented as Kubernetes namespaces. By default, the administrator creates a new Project via the Administration user interface which then triggers the creation of a Kubernetes namespace named `runai-<PROJECT-NAME>`.
There are a couple of use cases that customers will want to disable this feature:

* Some organizations prefer to use their internal naming convention for Kubernetes namespaces, rather than Run:ai's default `runai-<PROJECT-NAME>` convention.
* Some organizations will not allow Run:ai to automatically create Kubernetes namespaces. 


Follow these steps to achieve this:

1. Disable the namespace creation functionality. See the  `runai-operator.config.project-controller.createNamespaces` flag above.
2. [Create a Project](../../../admin-ui-setup/project-setup/#create-a-new-project) using the Run:ai User Interface. 
3. Create the namespace if needed by running: `kubectl create ns <NAMESPACE>`. The suggested Run:ai default is `runai-<PROJECT-NAME>`.
4. Label the namespace to connect it to the Run:ai Project by running `kubectl label ns <NAMESPACE>  runai/queue=<PROJECT_NAME>`, where `<PROJECT_NAME>` is the name of the project you have created in the Run:ai user interface above and `<NAMESPACE>` is the name you chose for your namespace.


