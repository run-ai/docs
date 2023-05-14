---
title: Self Hosted installation over Kubernetes - Cluster Setup
---



## Prerequisites

Install prerequisites as per [cluster prerequisites](../../cluster-setup/cluster-prerequisites.md) document.  


## Customize Installation

* Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai). 
* __(Optional)__ make the following changes to the configuration file you have downloaded:


|  Key     |  Default  | Description |
|----------|----------|-------------| 
| `runai-operator.config.project-controller.createNamespaces` |  `true` | Set to `false` if unwilling to provide Run:ai the ability to create namespaces, or would want to create namespaces manually rather than use the Run:ai convention of `runai-<PROJECT-NAME>`. When set to `false`, will require an additional [manual step](project-management.md) when creating new Run:ai Projects. | 
| `runai-operator.config.project-controller.clusterWideSecret` | `true` | Set to `false` if unwilling to provide Run:ai the ability to create Kubernetes Secrets. When not enabled, automatic [secret propagation](../../../workloads/secrets.md#secrets-and-projects) will not be available | 
| `runai-operator.config.mps-server.enabled` |  `false` | Allow the use of __NVIDIA MPS__. MPS is useful with _Inference_ workloads. Requires extra cluster permissions <!-- (../preparations/#cluster-installation) --> | 
| `runai-operator.config.runai-container-toolkit.enabled` | `true` | Controls the usage of __Fractions__. Requires extra cluster permissions <!-- >](../preparations/#cluster-installation) --> | 
| `runai-operator.config.global.runtime` | `docker` | Defines the container runtime of the cluster (supports `docker` and `containerd`). Set to `containerd` when using Tanzu  | 
| `runai-operator.config.runaiBackend.password` | Default password already set  | [admin@run.ai](mailto:admin.run.ai) password. Need to change only if you have changed the password [here](../backend/#other-changes-to-perform) | 

<!-- | `runai-operator.config.project-controller.createRoleBindings` |  `true` | Automatically assign Users to Projects. Set to `false` if unwilling to provide Run:ai the ability to set _RoleBinding_. When set to `false`, will require an additional [manual step](project-management.md) when adding or removing users from Projects.  |  -->

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
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-cluster`.

=== "Airgapped"
    ```
    helm install runai-cluster -n runai  \ 
      runai-cluster-<version>.tgz -f runai-<cluster-name>.yaml --create-namespace
    ```

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details see [Understanding cluster access roles](../../../config/access-roles/).




