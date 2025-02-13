# Self-Hosted installation over Kubernetes - Prerequisites

Before proceeding with this document, please review [installation types](../installation/overview.md#installation-types) to understand the difference between **air-gapped** and **connected** installations. 

## Run:ai Components

As part of the installation process you will install:

* A control-plane managing cluster
* One or more clusters

Both the control plane and clusters require Kubernetes. Typically the control plane and first cluster are installed on the same Kubernetes cluster but this is not a must. 

{% hint style="info" %}
In OpenShift environments, adding a cluster connecting to a remote control plane currently requires the assistance of customer support.
{% endhint %}

## Installer machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.


### Helm

Run:ai requires [Helm](https://helm.sh/){target=_blank} 3.14 or later. To install Helm, see [Installing Helm](https://helm.sh/docs/intro/install/){target=_blank}. If you are installing an air-gapped version of Run:ai, The Run:ai tar file contains the helm binary. 

## Cluster hardware requirements

The Run:ai control plane services require the following resources:

| Component | Required Capacity |
| :---- | :---- |
| CPU | 10 cores |
| Memory | 12GB |
| Disk space | 110GB |

If Run:ai cluster is planned to be installed on the same cluster as the Run:ai control plane: Ensure the control plane requirements are in addition to the Run:ai cluster [hardware requirements](../../saas/cluster-installation/system-requirements.md#hardware-requirements).

### ARM Limitation for Kubernetes

The control plane does not support CPU nodes with ARM64k architecture. To schedule the Run:ai control plane services on supported nodes, use the `global.affinity` configuration parameter as detailed in [Additional Run:ai configurations](backend.md#additional-runai-configurations-optional). TBD


## Run:ai software requirements

### Cluster Nodes

See Run:ai Cluster prerequisites [operating system](../../saas/cluster-installation/system-requirements.md#operating-system) requirements. TBD (not in openshift)

Nodes are required to be synchronized by time using NTP (Network Time Protocol) for proper system functionality.

### Kubernetes

See Run:ai Cluster prerequisites [Kubernetes distribution](../../cluster-setup/cluster-prerequisites.md#kubernetes-distribution) requirements.

The Run:ai control plane operating system prerequisites are identical.

The Run:ai control-plane requires a __default storage class__ to create persistent volume claims for Run:ai storage. The storage class, as per Kubernetes standards, controls the reclaim behavior: whether the Run:ai persistent data is saved or deleted when the Run:ai control plane is deleted. 


!!! Note
    For a simple (nonproduction) storage class example see [Kubernetes Local Storage Class](https://kubernetes.io/docs/concepts/storage/storage-classes/#local){target=_blank}. The storage class will set the directory `/opt/local-path-provisioner` to be used across all nodes as the path for provisioning persistent volumes.

    Then set the new storage class as default:

    ```
    kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    ```

## Install prerequisites

### Ingress Controller

The Run:ai control plane installation assumes an existing installation of NGINX as the ingress controller. You can follow the Run:ai _Cluster_ prerequisites [Kubernetes ingress controller](../../cluster-setup/cluster-prerequisites.md#kubernetes-ingress-controller) installation.

### NVIDIA GPU Operator

See Run:ai Cluster prerequisites [NVIDIA GPU operator](../../cluster-setup/cluster-prerequisites.md#nvidia-gpu-operator) requirements.

 > The Run:ai control plane, when installed without a Run:ai cluster, does not require the NVIDIA prerequisites.

### Prometheus

See Run:ai Cluster prerequisites [Prometheus](../../cluster-setup/cluster-prerequisites.md#prometheus) requirements.

 > The Run:ai control plane, when installed without a Run:ai cluster, does not require the Prometheus prerequisites. 


### Inference (optional)

See Run:ai Cluster prerequisites [Inference](../../cluster-setup/cluster-prerequisites.md#inference) requirements.

 > The Run:ai control plane, when installed without a Run:ai cluster, does not require the Inference prerequisites. 

### External Postgres database (optional)

The Run:ai control plane installation includes a default PostgreSQL database. However, you may opt to use an existing PostgreSQL database if you have specific requirements or preferences. Please ensure that your PostgreSQL database is version 16 or higher.


## Next steps
Continue to [Preparing for a Run:ai Kubernetes Installation
](./preparations.md).