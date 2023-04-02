---
title: Self Hosted installation over Kubernetes - Preparations
---

## Prerequisites 

See Prerequisites section [above](prerequisites.md).


## Prepare Installation Artifacts

### Run:ai Software Files

SSH into a node with `kubectl` access to the cluster and `Docker` installed.


=== "Connected"
    Run the following to enable image download from the Run:ai Container Registry on Google cloud:

    ``` bash
    kubectl create namespace runai-backend
    kubectl apply -f runai-gcr-secret.yaml
    ```

=== "Airgapped" 
    To extract Run:ai files, replace `<VERSION>` in the command below and run: 

    ``` bash
    tar xvf runai-air-gapped-<version>.tar.gz
    cd deploy

    kubectl create namespace runai-backend
    ```
 
### Upload images (Airgapped only)

Upload images to a local Docker Registry. Set the Docker Registry address in the form of `NAME:PORT` (do not add `https`):

```
export REGISTRY_URL=<Docker Registry address>
```

Run the following script (you must have at least 20GB of free disk space to run): 

```  
sudo -E ./prepare_installation.sh
```

If Docker is configured to [run as non-root](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user){target=_blank} then `sudo` is not required.
<!-- ### Run:ai Administration CLI

=== "Connected"
    Install the Run:ai Administrator Command-line Interface by following the steps [here](../../config/cli-admin-install.md).

=== "Airgapped" 
    Use the Run:ai Administrator Command-line Interface located in the `deploy` folder. To allow running the binary, run: 
    
    ```
    chmod +x runai-adm
    ```  -->
    


## Mark Run:ai System Workers

=== "Version 2.9"
    In previous versions, you set nodes that were dedicated to Run:ai software:

    * Setting the nodes was mandatory.
    * Run:ai was confined to these nodes. If the selected nodes failed or lacked resources, Run:ai would stop working.  

    In version 2.9, 
    
    * There is no need to set nodes for Run:ai.
    * You can __optionally__ set the Run:ai control plane to run on specific nodes. 
    * Run:ai is no longer confined to these notes. Instead, Kubernetes will attempt to schedule Run:ai pods to these nodes. If lacking resources, the Run:ai nodes will move to another, non-labeled node.  

    To set system worker nodes run:

    ```
    kubectl label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
    ```

    If you want to preserve the previous functionality, please contact Run:ai customer support.

    !!! Note
        The new functionality is limited to the Run:ai control plane and has not yet been implemented in the Run:ai cluster. 
    
    
=== "Version 2.8 or below"
    The Run:ai control plane should be installed on a set of dedicated Run:ai system worker nodes rather than GPU worker nodes. To set system worker nodes run:

    ```
    kubectl label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
    ```

    To avoid single-point-of-failure issues, we recommend assigning more than one node in production environments. 

!!! Warning
    Do not select the Kubernetes master as a runai-system node. This may cause Kubernetes to stop working (specifically if Kubernetes API Server is configured on 443 instead of the default 6443).

## Additional Permissions

As part of the installation, you will be required to install the [Run:ai Control Plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/){target=_blank}. The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts. 


## Next Steps

Continue with installing the [Run:ai Control Plane](backend.md).
