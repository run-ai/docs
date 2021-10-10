---
title: Self Hosted installation over OpenShift - Prerequisites
---

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 
## Hardware Requirements

(Production only) Run:AI System Nodes: To reduce downtime and save CPU cycles on expensive GPU Machines, we recommend that production deployments will contain two or more worker machines, designated for Run:AI Software. The nodes do not have to be dedicated to Run:AI, but for Run:AI purposes we would need:

* 4 CPUs
* 8GB of RAM
* 100GB of Disk space

(Production only) Run:AI requires a Kubernetes Persistent Volume of 110GB. This is typically done via network file storage. 

## Run:AI Software Prerequisites

=== "Airgapped"
    You should receive a single file `runai-<version>.tar` from Run:AI customer support

=== "Connected"
    You should receive a file: `runai-gcr-secret.yaml` from Run:AI Customer Support. The file provides access to the Run:AI Container registry.


## OpenShift 

Run:AI requires OpenShift 4.6 or later. 


!!! Important
    * _Entitlement_ is the RedHat OpenShift licensing mechanism. Without entitlement, __you will not be able to install the NVIDIA drivers__ used by the GPU Operator. For further information see: [here](https://www.openshift.com/blog/how-to-use-entitled-image-builds-to-build-drivercontainers-with-ubi-on-openshift){target=_blank}. 
    * If you are planning to use NVIDIA A100 with CoreOS, you will need the latest GPU Operator (version 1.8).


## Download Third-Party Dependencies

An OpenShift installation of Run:AI has third-party dependencies that must be pre-downloaded to an Airgapped environment. These are the _NVIDIA GPU Operator_ and _Kubernetes Node Feature Discovery Operator_ 

=== "Airgapped"
    Download the [NVIDIA GPU Operator pre-requisites](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/install-gpu-operator-air-gapped.html#install-gpu-operator-air-gapped){target=_blank}. These instructions also include the download of the Kubernetes Node Feature Discovery Operator.

=== "Connected"
    No additional work needs to be performed. We will use the _Red Hat Certified Operator Catalog (Operator Hub)_ during the installation. 


## Installer Machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.

## Other

* (Airgapped installation only) __Private Docker Registry__. Run:AI assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 
