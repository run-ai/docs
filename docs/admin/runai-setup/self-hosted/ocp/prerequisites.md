---
title: Self Hosted installation over OpenShift - Prerequisites
---

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 
## Hardware Requirements

(Production only) Run:AI System Nodes: To reduce downtime and save CPU cycles on expensive GPU Machines, we recommend that production deployments will contain two or more worker machines, designated for Run:AI Software. The nodes do not have to be dedicated to Run:AI, but for Run:AI purposes we would need:

* 4 CPUs
* 8GB of RAM
* 120GB of Disk space

The control plane (backend) installation of Run:AI will require the configuration of  Kubernetes Persistent Volumes of a total size of 110GB.  

## Run:AI Software Prerequisites

=== "Connected"
    You should receive a file: `runai-gcr-secret.yaml` from Run:AI Customer Support. The file provides access to the Run:AI Container registry.

=== "Airgapped"
    You should receive a single file `runai-<version>.tar` from Run:AI customer support

## OpenShift 

Run:AI requires OpenShift 4.6 or above. OpenShift 4.9 is not yet supported. 


!!! Important
    * _Entitlement_ is the RedHat OpenShift licensing mechanism. Without entitlement, __you will not be able to install the NVIDIA drivers__ used by the GPU Operator. For further information see: [here](https://www.openshift.com/blog/how-to-use-entitled-image-builds-to-build-drivercontainers-with-ubi-on-openshift){target=_blank}. 
    * If you are planning to use NVIDIA A100 with CoreOS, you will need the latest GPU Operator (version 1.8).


## Download Third-Party Dependencies

An OpenShift installation of Run:AI has third-party dependencies that must be pre-downloaded to an Airgapped environment. These are the _NVIDIA GPU Operator_ and _Kubernetes Node Feature Discovery Operator_ 


=== "Connected"
    No additional work needs to be performed. We will use the _Red Hat Certified Operator Catalog (Operator Hub)_ during the installation. 

=== "Airgapped"
    Download the [NVIDIA GPU Operator pre-requisites](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/install-gpu-operator-air-gapped.html#install-gpu-operator-air-gapped){target=_blank}. These instructions also include the download of the Kubernetes Node Feature Discovery Operator.
## Installer Machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.

## Other

* (Airgapped installation only) __Private Docker Registry__. Run:AI assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 


## Pre-install Script

Once you believe that the Run:AI prerequisites are met, we highly recommend installing and running the Run:AI  [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

* Tests the below requirements as well as additional failure points related to Kubernetes, NVIDIA, storage, and networking.
* Looks at additional components installed and analyzes their relevancy to a successful Run:AI installation. 

To use the script [download](https://github.com/run-ai/preinstall-diagnostics/releases){target=_blank} the latest version of the script and run:

```
chmod +x preinstall-diagnostics-<platform>
./preinstall-diagnostics-<platform> 
```

If the script fails, or if the script succeeds but the Kubernetes system contains components other than Run:AI, locate the file `runai-preinstall-diagnostics.txt` in the current directory and send it to Run:AI technical support. 

For more information on the script including additional command-line flags, see [here](https://github.com/run-ai/preinstall-diagnostics){target=_blank}.

