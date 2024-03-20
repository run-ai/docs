---
title: Self Hosted installation over OpenShift - Preparations
---
# Preparing for a Run:ai OpenShift installation

The following section provides IT with the information needed to prepare for a Run:ai installation.

## Prerequisites
See the Prerequisites section [above](prerequisites.md).

## Software artifacts

=== "Connected"
    You should receive a file: `runai-reg-creds.yaml` from Run:ai Customer Support. The file provides access to the Run:ai Container registry.

    SSH into a node with `oc` access (`oc` is the OpenShift command line) to the cluster and `Docker` installed.

    Run the following to enable image download from the Run:ai Container Registry on Google cloud:

    ```
    oc apply -f runai-gcr-secret.yaml -n runai-backend
    ```

=== "Airgapped"
    You should receive a single file `runai-<version>.tar` from Run:ai customer support

    Run:ai assumes the existence of a Docker registry for images. Most likely installed within the organization. The installation requires the network address and port for the registry (referenced below as `<REGISTRY_URL>`). 

    SSH into a node with `oc` access (`oc` is the OpenShift command line) to the cluster and `Docker` installed.

    To extract Run:ai files, replace `<VERSION>` in the command below and run: 

    ```
    tar xvf runai-<VERSION>.tar.gz
    cd deploy
    ```
    __Upload images__

    Upload images to a local Docker Registry. Set the Docker Registry address in the form of `NAME:PORT` (do not add `https`):

    ```
    export REGISTRY_URL=<Docker Registry address>
    ```

    Run the following script (you must have at least 20GB of free disk space to run): 

    ```  
    sudo -E ./prepare_installation.sh
    ```

    (If docker is configured to [run as non-root](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user){target=_blank} then `sudo` is not required).

    The script should create a file named custom-env.yaml which will be used by the control-plane installation.

### Private Docker Registry (optional)

To access the organization's docker registry it is required to set the registry's credentials (imagePullSecret)

Create the secret named `runai-reg-creds` based on your existing credentials. For more information, see [Allowing pods to reference images from other secured registries](https://docs.openshift.com/container-platform/latest/openshift_images/managing_images/using-image-pull-secrets.html#images-allow-pods-to-reference-images-from-secure-registries_using-image-pull-secrets){target=_blank}.

## Configure your environment

### Create OpenShift project

The Run:ai control plane uses a namespace (or _project_ in OpenShift terminology) name `runai-backend`. You must create it before installing:

```
oc new-project runai-backend
```

### Local Certificate Authority (air-gapped only)
In Air-gapped environments, you must prepare the public key of your local certificate authority as described [here](../../config/org-cert.md). It will need to be installed in Kubernetes for the installation to succeed.

### Mark Run:ai system workers (optional)

You can **optionally** set the Run:ai control plane to run on specific nodes. Kubernetes will attempt to schedule Run:ai pods to these nodes. If lacking resources, the Run:ai nodes will move to another, non-labeled node.  

To set system worker nodes run:

```
kubectl label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
```

!!! Warning
    Do not select the Kubernetes master as a `runai-system` node. This may cause Kubernetes to stop working (specifically if Kubernetes API Server is configured on 443 instead of the default 6443).

## Additional permissions

As part of the installation, you will be required to install the [Control plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/){target=_blank}. The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts.

## Validate prerequisites

Once you believe that the Run:ai prerequisites and preperations are met, we highly recommend installing and running the Run:ai [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

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

Continue with installing the [Run:ai Control Plane](backend.md).
