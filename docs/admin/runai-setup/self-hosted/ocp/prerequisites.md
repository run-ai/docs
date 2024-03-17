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

## Configure your environment

### Local Certificate Authority (air-gapped only)
In Air-gapped environments, you must prepare the public key of your local certificate authority as described [here](../../config/org-cert.md). It will need to be installed in Kubernetes for the installation to succeed. 

### Private docker registry (optional)
To access the organization's docker registry it is required to set the registry's credentials (imagePullSecret)

Create the secret named `runai-reg-creds` based on your existing credentials. For more information, see [Allowing pods to reference images from other secured registries](https://docs.openshift.com/container-platform/latest/openshift_images/managing_images/using-image-pull-secrets.html#images-allow-pods-to-reference-images-from-secure-registries_using-image-pull-secrets){target=_blank}.

* Airgapped installation only - Run:ai assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 


## Validate prerequisites

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

## Next steps
Continue to [Preparing for a Run:ai OpenShift Installation
](./preparations.md).