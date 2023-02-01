---
title: Self Hosted installation over OpenShift - Preparations
---
# Preparing for a Run:ai OpenShift Installation

The following section provides IT with the information needed to prepare for a Run:ai installation. This includes third-party dependencies which must be met as well as access control that must be granted for Run:ai components. 


## Create OpenShift Projects

Run:ai uses three projects. One for the control plane (`runai-backend`) and two for the cluster itself (`runai`, `runai-reservation`). 

```
oc new-project runai
oc new-project runai-reservation
oc new-project runai-backend
oc new-project runai-scale-adjust
```

The last namespace (`runai-scale-adjust`) is only required if the cluster is a cloud cluster and is configured for auto-scaling. 

## Prepare Run:ai Installation Artifacts

### Run:ai Software Files

SSH into a node with `oc` access (`oc` is the OpenShift command line) to the cluster and `Docker` installed.


=== "Connected"
    Run the following to enable image download from the Run:ai Container Registry on Google cloud:

    ```
    oc apply -f runai-gcr-secret.yaml -n runai-backend
    ```

=== "Airgapped" 

    To extract Run:ai files, replace `<VERSION>` in the command below and run: 

    ```
    tar xvf runai-<version>.tar.gz
    cd deploy
    ```
### Run:ai Administration CLI

=== "Connected"
    Install the Run:ai Administrator Command-line Interface by following the steps [here](../../config/cli-admin-install.md).

=== "Airgapped" 
    Install the Run:ai Administrator Command-line Interface by following the steps [here](../../config/cli-admin-install.md). Use the image under `deploy/runai-admin-cli-<version>-linux-amd64.tar.gz`

## Install Helm

If helm v3 does not yet exist on the machine, install it now:

=== "Connected"
    See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank} on how to install Helm. Run:ai works with Helm version 3 only (not helm 2).

=== "Airgapped"
    ```
    tar xvf helm-<version>-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/
    ```  

## Mark Run:ai System Workers

The Run:ai Control plane should be installed on a set of dedicated Run:ai system worker nodes rather than GPU worker nodes. To set system worker nodes run:

```
oc label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
```

To avoid single-point-of-failure issues, we recommend assigning more than one node in production environments. 

!!! Warning
    Do not select the Kubernetes master as a runai-system node. This may cause Kubernetes to stop working (specifically if Kubernetes API Server is configured on 443 instead of the default 6443).

## Install NVIDIA Dependencies


!!! Note
    You must have Cluster Administrator rights to install these dependencies. 

Before installing Run:ai, you must install NVIDIA software on your OpenShift cluster to enable GPUs. 
NVIDIA has provided [detailed documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/openshift/introduction.html){target=_blank}. 
Follow the instructions to install the two operators `Node Feature Discovery` and `NVIDIA GPU Operator` from the OpenShift web console. 

When done, verify that the GPU Operator is installed by running:

```
oc get pods -n nvidia-gpu-operator
```

(the GPU Operator namespace may differ in different operator versions).


## Additional Permissions

As part of the installation, you will be required to install the [Control plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/){target=_blank}. The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts. 

## Next Steps

Continue with installing the [Run:ai Control Plane](backend.md).
