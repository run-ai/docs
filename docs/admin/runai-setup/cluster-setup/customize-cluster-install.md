# (Optional) Customize Cluster Installation

This document explain how to customize the Run:ai cluster installation

## How to customize

__After__ the cluster is installed, you can edit the `runaiconfig` object to add/change configuration. Use the command:

```
kubectl edit runaconfig runai -n runai
```

All customizations will be saved when upgrading the cluster to a future version. 

## Configurations

|  Key     |  Default  | Description |
|----------|----------|-------------| 
| `spec.project-controller.createNamespaces` | `true` | Set to `false`if unwilling to provide Run:ai the ability to create namespaces. When set to false, will requires an additional manual step when creating new Run:ai Projects as described [below](#manual-creation-of-namespaces) | 
| `spec.project-controller.clusterWideSecret` | `true` | Set to `false` if unwilling to provide Run:ai the ability to create Kubernetes Secrets. When not enabled, automatic [secret propagation](../../workloads/secrets.md#secrets-and-projects) will not be available | 
| `spec.mps-server.enabled` | `false` | Set to `true` to allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads  | 
| `spec.global.runtime` | `docker` | Defines the container runtime of the cluster (supports `docker` and `containerd`). Set to `containerd` when using Tanzu |
| `spec.global.subdomainSupport` | `false` | Set to true to allow researcher tools with a sub domain to be spawned from the Run:ai user interface. For more information see [External access to containers](../config//allow-external-access-to-containers.md#workspaces-configuration) |  
| `spec.global.schedulingservices` <br>  `spec.global.syncServices`<br>  `spec.global.workloadServices` |  | Set requests and limit configurations for CPU and memory for Run:ai containers. For more information see [Large cluster configuration](../config/large-clusters.md) |
| `spec.runai-container-toolkit.enabled` | `true` | Controls the usage of [GPU fractions](../../../Researcher/scheduling/fractions.md). | 
| `spec.researcherService.ingress.tlsSecret` |  | On Kubernetes distributions other than OpenShift, set a dedicated certificate for the researcher service ingress in the cluster. When not set, the certificate inserted when installing the cluster will be used. The value should be a Kubernetes secret  in the runai namespace |
| `spec.researcherService.route.tlsSecret` |  | On OpenShift, set a dedicated certificate for the researcher service route. When not set, the OpenShift certificate will be used.  The value should be a Kubernetes secret  in the runai namespace |

<!-- | `runai-operator.config.project-controller.createRoleBindings` | `true` | Set to `false` when using OpenShift. When set to false, will require an additional manual step when assigning users to Run:ai Projects |  -->


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


