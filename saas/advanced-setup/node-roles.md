# Node roles

This article explains how to designate specific node roles in a Kubernetes cluster to ensure optimal performance and reliability in production deployments.

For optimal performance in production clusters, it is essential to avoid extensive CPU usage on GPU nodes where possible. This can be done by ensuring the following:

* Run:ai system-level services run on dedicated CPU-only nodes.
* Workloads that do not request GPU resources (e.g. Machine Learning jobs) are executed on CPU-only nodes.

## Prerequisites

To perform these tasks, make sure to install the Run:ai [Administrator CLI](../cli-reference/administrator-cli.md).

## Configure Node Roles

The following node roles can be configured on the cluster:

* **System node:** Reserved for Run:ai system-level services.
* **GPU Worker node:** Dedicated for GPU-based workloads.
* **CPU Worker node:** Used for CPU-only workloads.

### System nodes

Run:ai system nodes run system-level services required to operate. This can be done via the Run:ai [Administrator CLI](../cli-reference/administrator-cli.md).

{% hint style="info" %}
To ensure high availability and prevent a single point of failure, it is recommended to configure at least three system nodes in your cluster.
{% endhint %}

To set a system role for a node in your Kubernetes cluster, follow these steps:

1. Run the `kubectl get nodes` command to list all the nodes in your cluster and identify the name of the node you want to modify.
2.  Run one of the following commands to set or remove a node’s role:

    ```bash
    runai-adm set node-role --runai-system-worker <node-name>
    runai-adm remove node-role --runai-system-worker <node-name>
    ```

The `runai-adm` CLI will label the node and set relevant cluster configurations.

The Run:ai cluster applies [Kubernetes Node Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) using node labels to manage scheduling for cluster services (system).

{% hint style="warning" %}
Do not assign a system node role to the Kubernetes master node. This may disrupt Kubernetes functionality, particularly if the Kubernetes API Server is configured to use port 443 instead of the default 6443.
{% endhint %}

### Worker nodes

Run:ai worker nodes run user-submitted workloads and system-level DeamonSets required to operate. This can be managed via the Run:ai [Administrator CLI](../cli-reference/administrator-cli.md), or [Kubectl](https://kubernetes.io/docs/reference/kubectl/).

#### Run:ai Administrator CLI

To set worker role for a node in your Kubernetes cluster via Run:ai [Administrator CLI](../cli-reference/administrator-cli.md), follow these steps:

1. Use the `kubectl get nodes` command to list all the nodes in your cluster and identify the name of the node you want to modify.
2.  Run one of the following commands to set or remove a node’s role:

    ```bash
     runai-adm set node-role [--gpu-worker | --cpu-worker] <node-name>
     runai-adm remove node-role [--gpu-worker | --cpu-worker] <node-name>
    ```

The `runai-adm` CLI will label the node and set relevant cluster configurations.

{% hint style="info" %}
Use the --all flag to set or remove a role to all nodes.
{% endhint %}

#### Kubectl

To set a worker role for a node in your Kubernetes cluster using Kubectl, follow these steps:

1. Validate the `global.nodeAffinity.restrictScheduling` is set to true in the cluster’s [Configurations](advanced-cluster-configurations.md).
2. Use the `kubectl get nodes` command to list all the nodes in your cluster and identify the name of the node you want to modify.
3.  Run one of the following commands to label the node with its role:

    ```bash
    kubectl label nodes <node-name> [node-role.kubernetes.io/runai-gpu-worker=true | node-role.kubernetes.io/runai-cpu-worker=true]
    kubectl label nodes <node-name> [node-role.kubernetes.io/runai-gpu-worker=false | node-role.kubernetes.io/runai-cpu-worker=false]
    ```
