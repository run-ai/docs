---
title: Self Hosted installation over Kubernetes - Prerequisites
---

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 
## Hardware Requirements

Follow the Hardware requirements [here](../../../cluster-setup/cluster-prerequisites/#hardware-requirements).

## Run:AI Software Prerequisites

=== "Airgapped"
    You should receive a single file `runai-<version>.tar` from Run:AI customer support

=== "Connected"
    You should receive a file: `runai-gcr-secret.yaml` from Run:AI Customer Support. The file provides access to the Run:AI Container registry.

## Kubernetes

Run:AI requires Kubernetes 1.16 or above. Kubernetes 1.20 is recommended (as of April 2021).

If you are using __OpenShift__, please refer to our [OpenShift installation instructions](../ocp/prerequisites.md). 

Run:AI Supports Kubernetes [Pod Security Policy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} if used. 

## NVIDIA Prerequisites

Run:AI requires the installation of NVIDIA software. These can be done in one of two ways:

* (Recommended) Use the _NVIDIA GPU Operator on Kubernetes_. To install the NVIDIA GPU Operator use the [Getting Started guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html){target=blank}. Follow the _Helm_ based Installation.
* For each GPU node in the cluster, install NVIDIA CUDA Drivers, as well as the software stack, described [here](../../../cluster-setup/nvidia/)

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

You can use the [NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html){target=_blank}, as an alternative to the NVIDIA CUDA Toolkit. However, Run:AI uses its own version of one of the NVIDIA GPU Operator components called [NVIDIA device plug-in](https://github.com/NVIDIA/k8s-device-plugin){target=_blank}. There are special instructions on how to disable the default NVIDIA device plug-in. Please contact Run:AI Customer Support.  -->


### Other

* __Docker Registry__. Run:AI assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 
* (Optional) __SAML Integration__. 

## Network

* __Shared Storage__. Network address and a path to a folder in a Network File System
* All Kubernetes cluster nodes should be able to mount NFS folders. Usually, this requires the installation of the `nfs-common` package on all machines (`sudo apt install nfs-common` or similar)
* __IP Address__. An available, internal IP Address that is accessible from Run:AI Users' machines (referenced below as `<RUNAI_IP_ADDRESS>`)
* __DNS entries__ Create 2 DNS A records, all pointing to `<RUNAI_IP_ADDRESS>`:
    * Run:AI Admininstration UI: `runai.<company-name>` or similar
    * Run:AI Researcher UI: `researcher.runai.<company-name>` or similar.
* Create a __certificate__ for the 2 endpoints. The certificate(s) must be signed by the organization's root CA. 

## Installer Machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.
