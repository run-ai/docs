# Self-Hosted installation over Kubernetes - Prerequisites

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 

## Run:ai Components

As part of the installation process you will install:

* A control-plane managing cluster
* One or more clusters

Both the control plane and clusters require Kubernetes. Typically the control plane and first cluster are installed on the same Kubernetes cluster but this is not a must. 

!!! Important
    In OpenShift environments, adding a cluster connecting to a __remote__ control plane currently requires the assistance of customer support.  

## Installer machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.

## Cluster hardware requirements

See Cluster prerequisites [hardware](../../cluster-setup/cluster-prerequisites.md#hardware-requirements) requirements.

In addition, the control plane installation of Run:ai requires the configuration of Kubernetes Persistent Volumes of a total size of 110GB. 


## Run:ai software requirements

### Operating system

See Run:ai Cluster prerequisites [operating system](../../cluster-setup/cluster-prerequisites.md#operating-system) requirements.

The Run:ai control plane operating system prerequisites are identical.

### Kubernetes

See Run:ai Cluster prerequisites [Kubernetes](../../cluster-setup/cluster-prerequisites.md#kubernetes) requirements.

The Run:ai control plane operating system prerequisites are identical.

The Run:ai control-plane requires a __default storage class__ to create persistent volume claims for Run:ai storage. The storage class, as per Kubernetes standards, controls the reclaim behavior: whether the Run:ai persistent data is saved or deleted when the Run:ai control plane is deleted. 


!!! Note
    For a simple (nonproduction) storage class example see [Kubernetes Local Storage Class](https://kubernetes.io/docs/concepts/storage/storage-classes/#local){target=_blank}. The storage class will set the directory `/opt/local-path-provisioner` to be used across all nodes as the path for provisioning persistent volumes.

    Then set the new storage class as default:

    ```
    kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    ```

## Install prerequisites

### Helm

Run:ai requires [Helm](https://helm.sh/){target=_blank} 3.10 or later. To install Helm, see [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank}. If you are installing an air-gapped version of Run:ai, The Run:ai tar file contains the helm binary. 

### Ingress Controller

The Run:ai control plane installation assumes an existing installation of NGINX as the ingress controller. You can follow the Run:ai _Cluster_ prerequisites [ingress controller](../../cluster-setup/cluster-prerequisites.md#ingress-controller) installation.

### NVIDIA GPU Operator

See Run:ai Cluster prerequisites [NVIDIA](../../cluster-setup/cluster-prerequisites.md#nvidia) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the NVIDIA prerequisites.

### Prometheus

See Run:ai Cluster prerequisites [Prometheus](../../cluster-setup/cluster-prerequisites.md#prometheus) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the Prometheus prerequisites. 


### Inference (optional)

See Run:ai Cluster prerequisites [Inference](../../cluster-setup/cluster-prerequisites.md#inference) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the Inference prerequisites. 

## Next steps
Continue to [Preparing for a Run:ai Kubernetes Installation
](./preparations.md).