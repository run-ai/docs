---
title: Self Hosted installation over OpenShift - Prerequisites
---

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 

## Control-plane and clusters

As part of the installation process you will install:

* A control-plane managing cluster
* One or more clusters

Both the control plane and clusters require Kubernetes. Typically the control plane and first cluster are installed on the same Kubernetes cluster but this is not a must. 

!!! Important
    In OpenShift environments, adding a cluster connecting to a __remote__ control plane currently requires the assistance of customer support.  

## Hardware Requirements

See Cluster prerequisites [hardware](../../cluster-setup/cluster-prerequisites.md#hardware-requirements) requirements.


## Run:ai Software

=== "Connected"
    You should receive a file: `runai-gcr-secret.yaml` from Run:ai Customer Support. The file provides access to the Run:ai Container registry.

=== "Airgapped"
    You should receive a single file `runai-<version>.tar` from Run:ai customer support


## Run:ai Software Prerequisites

### Operating System

OpenShift has specific operating system requirements that can be found in the RedHat documentation. 

### OpenShift 

Run:ai supports OpenShift. Supported versions are 4.10 through 4.11. 

* OpenShift must be configured with a trusted certificate. Run:ai installation relies on OpenShift to create certificates for subdomains. 
* OpenShift must have a configured [identity provider](https://docs.openshift.com/container-platform/4.9/authentication/understanding-identity-provider.html){target=_blank} (Idp). If you are planning to connect multiple Run:ai clusters (on multiple OpenShift clusters), then all OpenShift clusters must be configured with the __same__ IdP. 
* OpenShift must have _Entitlement_. Entitlement is the RedHat OpenShift licensing mechanism. Without entitlement, __you will not be able to install the NVIDIA drivers__ used by the GPU Operator. For further information see [here](https://www.openshift.com/blog/how-to-use-entitled-image-builds-to-build-drivercontainers-with-ubi-on-openshift){target=_blank}, or the equivalent [NVIDIA documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/archive/1.9.0/openshift/cluster-entitlement.html){target=_blank}. Entitlement is [not required anymore](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/openshift/steps-overview.html#entitlement-free-supported-versions){target=_blank} if you are using OpenShift 4.9.9 or above


### NVIDIA Prerequisites

See Run:ai Cluster prerequisites [installing NVIDIA dependencies in OpenShift](cluster.md#prerequisites).

The Run:ai control plane, when installed without a Run:ai cluster, does not require the NVIDIA prerequisites.

Information on how to download the GPU Operator for air-gapped installation can be found in the [NVIDIA GPU Operator pre-requisites](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/install-gpu-operator-air-gapped.html#install-gpu-operator-air-gapped){target=_blank}. 


### (Optional) Inference Prerequisites 

See Run:ai Cluster prerequisites [Inference](../../cluster-setup/cluster-prerequisites.md#inference) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the Inference prerequisites. 

### Helm

Run:ai requires [Helm](https://helm.sh/){target=_blank}. To install Helm, see [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank}. If you are installing an air-gapped version of Run:ai, The Run:ai tar file contains the helm binary. 

## Installer Machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.

## Other

* (Airgapped installation only) __Private Docker Registry__. Run:ai assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 


## Pre-install Script

Once you believe that the Run:ai prerequisites are met, we highly recommend installing and running the Run:ai [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

* Tests the below requirements as well as additional failure points related to Kubernetes, NVIDIA, storage, and networking.
* Looks at additional components installed and analyzes their relevancy to a successful Run:ai installation. 

To use the script [download](https://github.com/run-ai/preinstall-diagnostics/releases){target=_blank} the latest version of the script and run:

```
chmod +x preinstall-diagnostics-<platform>
./preinstall-diagnostics-<platform> 
```

If the script fails, or if the script succeeds but the Kubernetes system contains components other than Run:ai, locate the file `runai-preinstall-diagnostics.txt` in the current directory and send it to Run:ai technical support. 

For more information on the script including additional command-line flags, see [here](https://github.com/run-ai/preinstall-diagnostics){target=_blank}.

