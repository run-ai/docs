---
title: Self Hosted installation over OpenShift - Preparations
---
# Preparing for a Run:ai OpenShift Installation

The following section provides IT with the information needed to prepare for a Run:ai installation. This includes third-party dependencies which must be met as well as access control that must be granted for Run:ai components. 


## Create OpenShift Projects

Run:ai control plane uses a namespace `runai-backend` (or _project_ in OpenShift terminology). The installation will automatically create the namespace, but if your organization requires manual creation of namespaces, you must create it before installing:

```
oc new-project runai-backend
```


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

## Additional Permissions

As part of the installation, you will be required to install the [Control plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/){target=_blank}. The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts. 

## Next Steps

Continue with installing the [Run:ai Control Plane](backend.md).
