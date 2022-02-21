---
title: Self Hosted installation over Kubernetes - Prerequisites
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

## Kubernetes

Run:AI requires Kubernetes 1.19 or above. Kubernetes 1.21 is recommended (as of September 2021). Kubernetes 1.22 is __not__ supported. 

If you are using __OpenShift__, please refer to our [OpenShift installation instructions](../ocp/prerequisites.md). 

Run:AI Supports Kubernetes [Pod Security Policy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} if used. 

## NVIDIA Prerequisites

Run:AI requires the installation of NVIDIA software. See installation details [here](../../../cluster-setup/cluster-prerequisites#nvidia)
## Kubernetes Dependencies

### Prometheus 

The Run:AI Cluster installation installs [Prometheus](https://prometheus.io/){target=_blank}. However, it can also connect to an existing Prometheus installed by the organization. In the latter case, it's important to:

* Verify that both [Prometheus Node Exporter](https://prometheus.io/docs/guides/node-exporter/){target=_blank} and [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics){target=_blank} are installed. Both are part of the default Prometheus installation.
* Understand how Prometheus has been installed. Whether [directly](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus) or using the [Prometheus Operator](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack). The distinction will become important during the Run:AI Cluster installation.


### Feature Discovery

The Run:AI Cluster installation installs Kubernetes [Node Feature Discovery (NFD)](https://github.com/kubernetes-sigs/node-feature-discovery){target=_blank} and NVIDIA [GPU Feature Discovery (GFD)](https://github.com/NVIDIA/gpu-feature-discovery){target=_blank}. If your cluster has these dependencies already installed, you can use installation flags to prevent Run:AI from installing these dependencies.

<!-- 
## Nodes

* __Operating System__. Run:AI can be installed on any modern Linux. 
* __NVIDIA CUDA Toolkit__ is installed for machines with GPUs (verify by running the command `nvidia-smi`). 

You can use the [NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html){target=_blank}, as an alternative to the NVIDIA CUDA Toolkit.  -->


## Network

* __Shared Storage__. Network address and a path to a folder in a Network File System
* All Kubernetes cluster nodes should be able to mount NFS folders. Usually, this requires the installation of the `nfs-common` package on all machines (`sudo apt install nfs-common` or similar)
* __IP Address__. An available, internal IP Address that is accessible from Run:AI Users' machines (referenced below as `<RUNAI_IP_ADDRESS>`)
* __DNS entry__ Create a DNS A record such as `runai.<company-name>` or similar. The A record should point to `<RUNAI_IP_ADDRESS>` 
* A __certificate__ for the endpoint. The certificate(s) must be signed by the organization's root CA. 

## Installer Machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.


## Other

* (Airgapped installation only)  __Private Docker Registry__. Run:AI assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 
* (Optional) __SAML Integration__. 



## Pre-install Script

Once you believe that the Run:AI prerequisites are met, we highly recommend installing and running the Run:AI  [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

* Tests the below requirements as well as additional failure points related to Kubernetes, NVIDIA, storage, and networking.
* Looks at additional components installed and analyzes their relevancy to a successful Run:AI installation. 

To use the script [download](https://github.com/run-ai/preinstall-diagnostics/releases){target=_blank} the latest version of the script and run:

```
chmod +x preinstall-diagnostics-<platform>
./preinstall-diagnostics-<platform> --domain <dns-entry>
```

If the script fails, or if the script succeeds but the Kubernetes system contains components other than Run:AI, locate the file `runai-preinstall-diagnostics.txt` in the current directory and send it to Run:AI technical support. 

For more information on the script including additional command-line flags, see [here](https://github.com/run-ai/preinstall-diagnostics){target=_blank}.

