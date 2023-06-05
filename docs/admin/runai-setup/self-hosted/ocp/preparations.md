---
title: Self Hosted installation over OpenShift - Preparations
---
# Preparing for a Run:ai OpenShift Installation

The following section provides IT with the information needed to prepare for a Run:ai installation. 


## Create OpenShift Projects

The Run:ai control plane uses a namespace (or _project_ in OpenShift terminology) name `runai-backend`. You must create it before installing:

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

## (Optional) Mark Run:ai System Workers

You can __optionally__ set the Run:ai control plane to run on specific nodes. Kubernetes will attempt to schedule Run:ai pods to these nodes. If lacking resources, the Run:ai nodes will move to another, non-labeled node.  

To set system worker nodes run:

```
kubectl label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
```
 
!!! Warning
    Do not select the Kubernetes master as a `runai-system` node. This may cause Kubernetes to stop working (specifically if Kubernetes API Server is configured on 443 instead of the default 6443).

## Additional Permissions

As part of the installation, you will be required to install the [Control plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/){target=_blank}. The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts. 

## Next Steps

Continue with installing the [Run:ai Control Plane](backend.md).
