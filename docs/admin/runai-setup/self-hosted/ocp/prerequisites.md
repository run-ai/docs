# Self Hosted installation over OpenShift - prerequisites

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 

## Run:ai components

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

## Run:ai software requirements

### Operating System

OpenShift has specific operating system requirements that can be found in the RedHat documentation. 

### OpenShift 

Run:ai supports OpenShift. OpenShift Versions supported are detailed [here](../../cluster-setup/cluster-prerequisites.md#kubernetes).

* OpenShift must be configured with a trusted certificate. Run:ai installation relies on OpenShift to create certificates for subdomains. 
* OpenShift must have a configured [identity provider](https://docs.openshift.com/container-platform/4.9/authentication/understanding-identity-provider.html){target=_blank} (Idp). 
* If your network is air-gapped, you will need to provide the Run:ai control-plane and cluster with information about the [local certificate authority](../../config/org-cert.md).

## Install prerequisites
### Helm

Run:ai requires [Helm](https://helm.sh/){target=_blank} 3.10 or later. To install Helm, see [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank}. If you are installing an air-gapped version of Run:ai, The Run:ai tar file contains the helm binary. 

### NVIDIA GPU Operator

See Run:ai Cluster prerequisites [installing NVIDIA dependencies in OpenShift](cluster.md#prerequisites).

The Run:ai control plane, when installed without a Run:ai cluster, does not require the NVIDIA prerequisites.

Information on how to download the GPU Operator for air-gapped installation can be found in the [NVIDIA GPU Operator pre-requisites](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/install-gpu-operator-air-gapped.html#install-gpu-operator-air-gapped){target=_blank}. 


### Inference (optional)

See Run:ai Cluster prerequisites [Inference](../../cluster-setup/cluster-prerequisites.md#inference) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the Inference prerequisites. 

## Next steps
Continue to [Preparing for a Run:ai OpenShift Installation
](./preparations.md).