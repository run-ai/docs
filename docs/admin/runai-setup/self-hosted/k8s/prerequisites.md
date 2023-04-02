-title: Self-Hosted installation over Kubernetes - Prerequisites
---

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 


## Control-plane and clusters

As part of the installation process you will install:

* A control-plane managing cluster
* One or more Run:ai clusters

Both the control plane and clusters require Kubernetes. Typically the control plane and first cluster are installed on the same Kubernetes cluster but this is not a must. 

## Hardware Requirements

See Cluster prerequisites [hardware](../../cluster-setup/cluster-prerequisites.md#hardware-requirements) requirements.

In addition, the control plane installation of Run:ai requires the configuration of Kubernetes Persistent Volumes of a total size of 110GB. 

## Run:ai Software

=== "Connected"
    You should receive a file: `runai-gcr-secret.yaml` from Run:ai Customer Support. The file provides access to the Run:ai Container registry.

=== "Airgapped"
    You should receive a single file `runai-<version>.tar` from Run:ai customer support

## Run:ai Software Prerequisites

### Operating System

See Run:ai Cluster prerequisites [operating system](../../cluster-setup/cluster-prerequisites.md#operating-system) requirements.

The Run:ai control plane operating system prerequisites are identical.

### Kubernetes

See Run:ai Cluster prerequisites [Kubernetes](../../cluster-setup/cluster-prerequisites.md#kubernetes) requirements.

The Run:ai control plane operating system prerequisites are identical.

The Run:ai control-plane requires a default storage class to create persistent volume claims for Run:ai storage. 

### NVIDIA Prerequisites

See Run:ai Cluster prerequisites [NVIDIA](../../cluster-setup/cluster-prerequisites.md#nvidia) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the NVIDIA prerequisites.

### Prometheus Prerequisites

See Run:ai Cluster prerequisites [Prometheus](../../cluster-setup/cluster-prerequisites.md#prometheus) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the Prometheus prerequisites. 

### (Optional) Inference Prerequisites 

See Run:ai Cluster prerequisites [Inference](../../cluster-setup/cluster-prerequisites.md#inference) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the Inference prerequisites. 

### Helm

Run:ai requires [Helm](https://helm.sh/){target=_blank}. To install Helm, see [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank}. If you are installing an air-gapped version of Run:ai, The Run:ai tar file contains the helm binary. 


## Network Requirements

### Ingress Controller

The Run:ai control plane installation assumes an existing installation of NGINX as the ingress controller. You can follow the Run:ai _Cluster_ prerequisites [ingress controller](../../cluster-setup/cluster-prerequisites.md#ingress-controller) installation.

### Domain name

The Run:ai control plane requires a domain name (FQDN). You must supply a domain name as well as a trusted certificate for that domain. 

* When installing the first Run:ai cluster on the same Kubernetes cluster as the control plane, the Run:ai cluster URL will be the same as the control-plane URL.
* When installing the Run:ai cluster on a separate Kubernetes cluster, follow the Run:ai [domain name](../../cluster-setup/cluster-prerequisites.md#domain-name) requirements. 

## Installer Machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space.
* Docker installed.

## Other

* (Airgapped installation only)  __Private Docker Registry__. Run:ai assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 
* (Optional) __SAML Integration__ as described under [single sign-on](../../authentication/sso.md). 


## Pre-install Script

Once you believe that the Run:ai prerequisites are met, we highly recommend installing and running the Run:ai [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

* Tests the below requirements as well as additional failure points related to Kubernetes, NVIDIA, storage, and networking.
* Looks at additional components installed and analyze their relevance to a successful Run:ai installation. 

To use the script [download](https://github.com/run-ai/preinstall-diagnostics/releases){target=_blank} the latest version of the script and run:

```
chmod +x preinstall-diagnostics-<platform>
./preinstall-diagnostics-<platform> --domain <dns-entry>
```

If the script fails, or if the script succeeds but the Kubernetes system contains components other than Run:ai, locate the file `runai-preinstall-diagnostics.txt` in the current directory and send it to Run:ai technical support. 

For more information on the script including additional command-line flags, see [here](https://github.com/run-ai/preinstall-diagnostics){target=_blank}.

