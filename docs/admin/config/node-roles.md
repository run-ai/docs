# Node roles

This article explains how to designate specific node roles in a Kubernetes cluster to ensure optimal performance and reliability in production deployments.

For optimal performance in production clusters, it is essential to avoid extensive CPU usage on GPU nodes where possible. This can be done by ensuring the following:

* Run:ai system-level services run on dedicated CPU-only nodes.
* Workloads that do not request GPU resources (e.g. Machine Learning jobs) are executed on CPU-only nodes.

Run:ai services are scheduled on the defined node roles by applying [Kubernetes Node Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity){target=_blank} using node labels .


## Prerequisites

To perform these tasks, make sure to install the Run:ai [Administrator CLI](cli-admin-install.md).

## Configure Node Roles

The following node roles can be configured on the cluster:

* __System node:__ Reserved for Run:ai system-level services.
* __GPU Worker node:__ Dedicated for GPU-based workloads.
* __CPU Worker node:__ Used for CPU-only workloads.

### System nodes

Run:ai system nodes run system-level services required to operate. This can be done via the Kubectl (preferred method) or via Run:ai [Administrator CLI](cli-admin-install.md).

By default, Run:ai applies a node affinity rule to prefer nodes that are labeled with `node-role.kubernetes.io/runai-system` for system services scheduling. You can modify the default node affinity rule by:

* Editing the `spec.global.affinity` configuration parameter as detailed in [Advanced cluster configurations](../config/advanced-cluster-config.md).
* Editing the `global.affinity` configuration as detailed in [Install control plane](../runai-setup/self-hosted/k8s/backend.md) for self-hosted deployments.


!!! Note
    * To ensure high availability and prevent a single point of failure, it is recommended to configure at least three system nodes in your cluster.
    * By default, Kubernetes master nodes are configured to prevent workloads from running on them as a best-practice measure to safeguard control plane stability. While this restriction is generally recommended, certain NVIDIA reference architectures allow adding tolerations to the Run:ai deployment so critical system services can run on these nodes.


#### Kubectl

To set a system role for a node in your Kubernetes cluster using Kubectl, follow these steps:

1. Use the `kubectl get nodes` command to list all the nodes in your cluster and identify the name of the node you want to modify.

2. Run one of the following commands to label the node with its role:
    ```bash
    kubectl label nodes <node-name> node-role.kubernetes.io/runai-system=true
    kubectl label nodes <node-name> node-role.kubernetes.io/runai-system=false
    ```

#### Run:ai Administrator CLI

!!! Note
    The Run:ai Administrator CLI only supports the default node affinity.

To set a system role for a node in your Kubernetes cluster, follow these steps:

1. Run the `kubectl get nodes` command to list all the nodes in your cluster and identify the name of the node you want to modify.
2. Run one of the following commands to set or remove a node’s role
    ```bash
    runai-adm set node-role --runai-system-worker <node-name>
    runai-adm remove node-role --runai-system-worker <node-name>
    ```

The `set node-role` command will label the node and set relevant cluster configurations.


### Worker nodes

Run:ai worker nodes run user-submitted workloads and system-level DeamonSets required to operate. This can be managed via Kubectl (preferred method) or via [Administrator CLI](cli-admin-install.md).

By default, GPU workloads are scheduled on GPU nodes based on the nvidia.com/gpu.present label. When global.nodeAffinity.restrictScheduling is set to true via the [Advanced cluster configurations](../config/advanced-cluster-config.md):

* GPU Workloads are scheduled with node affinity rule to require nodes that are labeled with `node-role.kubernetes.io/runai-gpu-worker`.
* CPU-only Workloads are scheduled with node affinity rule to require nodes that are labeled with `node-role.kubernetes.io/runai-cpu-worker`.

#### Kubectl

To set a worker role for a node in your Kubernetes cluster using Kubectl, follow these steps:

1. Validate the `global.nodeAffinity.restrictScheduling` is set to true in the cluster’s [Configurations](advanced-cluster-config.md).
2. Use the `kubectl get nodes` command to list all the nodes in your cluster and identify the name of the node you want to modify.
3. Run one of the following commands to label the node with its role. Replace the label and value (`true/false`) to enable or disable GPU/CPU roles as needed:
    ```bash
    kubectl label nodes <node-name> node-role.kubernetes.io/runai-gpu-worker=true
    kubectl label nodes <node-name> node-role.kubernetes.io/runai-cpu-worker=false
    ```

#### Run:ai Administrator CLI 

To set worker role for a node in your Kubernetes cluster via Run:ai [Administrator CLI](cli-admin-install.md), follow these steps:

1. Use the `kubectl get nodes` command to list all the nodes in your cluster and identify the name of the node you want to modify.
2. Run one of the following commands to set or remove a node’s role. `<node-role>` must be either `--gpu-worker` or `--cpu-worker`:
    ```bash
    runai-adm set node-role <node-role> <node-name>
    runai-adm remove node-role <node-role> <node-name>
    ``` 

The `set node-role` command will label the node and set cluster configuration `global.nodeAffinity.restrictScheduling` true.

!!! Tip
    Use the --all flag to set or remove a role to all nodes.
