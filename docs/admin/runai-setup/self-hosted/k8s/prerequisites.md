# Self-Hosted installation over Kubernetes - Prerequisites

Before proceeding with this document, please review the [installation types](../../installation-types.md) documentation to understand the difference between _air-gapped_ and _connected_ installations. 

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


### Inference (Optional)

See Run:ai Cluster prerequisites [Inference](../../cluster-setup/cluster-prerequisites.md#inference) requirements.

The Run:ai control plane, when installed without a Run:ai cluster, does not require the Inference prerequisites. 

## Configure your environment

### Domain Certificate

The Run:ai control plane requires a domain name (FQDN). You must supply a domain name as well as a trusted certificate for that domain. 

* When installing the first Run:ai cluster on the same Kubernetes cluster as the control plane, the Run:ai cluster URL will be the same as the control-plane URL.
* When installing the Run:ai cluster on a separate Kubernetes cluster, follow the Run:ai [domain name](../../cluster-setup/cluster-prerequisites.md#cluster-url) requirements. 
* If your network is air-gapped, you will need to provide the Run:ai control-plane and cluster with information about the [local certificate authority](../../config/org-cert.md).


You must provide the domain's private key and crt as a Kubernetes secret in the `runai-backend` namespace. Run: 

```
kubectl create secret tls runai-backend-tls -n runai-backend \
    --cert /path/to/fullchain.pem --key /path/to/private.pem
```
### Local Certificate Authority (air-gapped only) 

In air-gapped environments, you must prepare the public key of your local certificate authority as described [here](../../config/org-cert.md). It will need to be installed in Kubernetes for the installation to succeed. 

## Validate Prerequisites

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

## Next steps
Continue to [Preparing for a Run:ai Kubernetes Installation
](./preparations.md).