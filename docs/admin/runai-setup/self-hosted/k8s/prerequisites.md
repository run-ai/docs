---
title: Self Hosted installation over Kubernetes - Prerequisites
---

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 
## Hardware Requirements

(Production only) Run:ai System Nodes: To reduce downtime and save CPU cycles on expensive GPU Machines, we recommend that production deployments will contain two or more worker machines, designated for Run:ai Software. The nodes do not have to be dedicated to Run:ai, but for Run:ai purposes we would need:

* 4 CPUs
* 8GB of RAM
* 120GB of Disk space

The control plane (backend) installation of Run:ai will require the configuration of  Kubernetes Persistent Volumes of a total size of 110GB. 


## Run:ai Software Prerequisites

=== "Connected"
    You should receive a file: `runai-gcr-secret.yaml` from Run:ai Customer Support. The file provides access to the Run:ai Container registry.

=== "Airgapped"
    You should receive a single file `runai-<version>.tar` from Run:ai customer support

## Kubernetes

Run:ai requires Kubernetes. Supported versions are 1.19 through 1.23. 

If you are using __OpenShift__, please refer to our [OpenShift installation instructions](../ocp/prerequisites.md). 

Run:ai Supports Kubernetes [Pod Security Policy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} if used. 

## NVIDIA Prerequisites

Run:ai requires the installation of NVIDIA software. See installation details [here](../../../cluster-setup/cluster-prerequisites#nvidia)
## Kubernetes Dependencies

### Prometheus 

The Run:ai Cluster installation installs [Prometheus](https://prometheus.io/){target=_blank}. However, it can also connect to an existing Prometheus installed by the organization. In the latter case, it's important to:

* Verify that both [Prometheus Node Exporter](https://prometheus.io/docs/guides/node-exporter/){target=_blank} and [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics){target=_blank} are installed. Both are part of the default Prometheus installation.
* Understand how Prometheus has been installed. Whether [directly](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus) or using the [Prometheus Operator](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack). The distinction will become important during the Run:ai Cluster installation.


### Feature Discovery

The Run:ai Cluster installation installs Kubernetes [Node Feature Discovery (NFD)](https://github.com/kubernetes-sigs/node-feature-discovery){target=_blank} and NVIDIA [GPU Feature Discovery (GFD)](https://github.com/NVIDIA/gpu-feature-discovery){target=_blank}. If your cluster has these dependencies already installed, you can use installation flags to prevent Run:ai from installing these dependencies.

<!-- 
## Nodes

* __Operating System__. Run:ai can be installed on any modern Linux. 
* __NVIDIA CUDA Toolkit__ is installed for machines with GPUs (verify by running the command `nvidia-smi`). 

You can use the [NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html){target=_blank}, as an alternative to the NVIDIA CUDA Toolkit. However, Run:ai uses its own version of one of the NVIDIA GPU Operator components called [NVIDIA device plug-in](https://github.com/NVIDIA/k8s-device-plugin){target=_blank}. There are special instructions on how to disable the default NVIDIA device plug-in. Please contact Run:ai Customer Support.  -->


## Network

* __Shared Storage__. Network address and a path to a folder in a Network File System
* All Kubernetes cluster nodes should be able to mount NFS folders. Usually, this requires the installation of the `nfs-common` package on all machines (`sudo apt install nfs-common` or similar)
* __IP Address__. An available, internal IP Address that is accessible from Run:ai Users' machines (referenced below as `<RUNAI_IP_ADDRESS>`)
* __DNS entry__ Create a DNS A record such as `runai.<company-name>` or similar. The A record should point to `<RUNAI_IP_ADDRESS>` 
* A __certificate__ for the endpoint. The certificate(s) must be signed by the organization's root CA. 

## Installer Machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.


## Other

* (Airgapped installation only)  __Private Docker Registry__. Run:ai assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 
* (Optional) __SAML Integration__. 



## Pre-install Script

Once you believe that the Run:ai prerequisites are met, we highly recommend installing and running the Run:ai  [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

* Tests the below requirements as well as additional failure points related to Kubernetes, NVIDIA, storage, and networking.
* Looks at additional components installed and analyzes their relevancy to a successful Run:ai installation. 

To use the script [download](https://github.com/run-ai/preinstall-diagnostics/releases){target=_blank} the latest version of the script and run:

```
chmod +x preinstall-diagnostics-<platform>
./preinstall-diagnostics-<platform> --domain <dns-entry>
```

If the script fails, or if the script succeeds but the Kubernetes system contains components other than Run:ai, locate the file `runai-preinstall-diagnostics.txt` in the current directory and send it to Run:ai technical support. 

For more information on the script including additional command-line flags, see [here](https://github.com/run-ai/preinstall-diagnostics){target=_blank}.

