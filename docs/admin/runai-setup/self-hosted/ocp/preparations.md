---
title: Self Hosted installation over OpenShift - Preparations
---
# Preparing for a Run:AI OpenShift Installation

The following section provides IT with the information needed to prepare for a Run:AI installation. This includes Third-party dependencies which must be met as well as access control that must be granted for Run:AI components. 




## Create OpenShift Projects

Run:AI uses three projects. One for the control plane (`runai-backend`) and two for the cluster itself (`runai`, `runai-resources`).
The project `gpu-operator-resources` is used by the _GPU Opeator_ dependency described above. 

```
oc new-project runai
oc new-project runai-resources
oc new-project runai-backend
oc new-project gpu-operator-resources
```

## Prepare Run:AI Installation Artifacts

### Run:AI Software Files

SSH into a node with `oc` access (`oc` is the OpenShift command-line) to the cluster and `Docker` installed.


=== "Connected"
    Run the following to enable image download from the Run:AI Container Registry on Google cloud:

    ```
    oc apply -f runai-gcr-secret.yaml
    ```

=== "Airgapped" 

    To extract Run:AI files, replace `<VERSION>` in the command below and run: 

    ```
    tar xvf runai-<version>.tar.gz
    cd deploy
    ```

    Upload images to Docker Registry. Set the Docker Registry address in the form of `NAME:PORT` (do not add `https`):

    ```
    export REGISTRY_URL=<Docker Registry address>
    ```
    
    Run the following script (you must have at least 20GB of free disk space to run): 

    ```  
    sudo -E ./prepare_installation.sh
    ```

    (If docker is configured to [run as non-root](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user){target=_blank} then `sudo` is not required).

### Run:AI Administration CLI

=== "Connected"
    Install the Run:AI Administrator Command-line Interface by following the steps [here](../../config/cli-admin-install.md).

=== "Airgapped" 
    Install the Run:AI Administrator Command-line Interface by following the steps [here](../../config/cli-admin-install.md). Use the image under `deploy/runai-admin-cli-<version>-linux-amd64.tar.gz`

## Install Helm

If helm v3 does not yet exist on the machine, install it now:

=== "Connected"
    See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank} on how to install Helm. Run:AI works with Helm version 3 only (not helm 2).

=== "Airgapped"
    ```
    tar xvf helm-<version>-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/
    ```  

## Mark Run:AI System Workers

The Run:AI Control plane should be installed on a set of dedicated Run:AI system worker nodes rather than GPU worker nodes. To set system worker nodes run:

```
oc label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
```

Currently, this setting cannot be changed after the control plane is installed.

## Additional Permissions

As part of the installation you will be required to install the [Control plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/){target=_blank}. The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts. 

## Next Steps

Continue with installing the [Run:AI third-party dependencies](ocp-dependencies.md).
