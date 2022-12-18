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
    tar xvf runai-<version>.tar.gz
    cd deploy

    kubectl create namespace runai-backend
    ```
 

### Run:ai Administration CLI

=== "Connected"
    Install the Run:ai Administrator Command-line Interface by following the steps [here](../../config/cli-admin-install.md).

=== "Airgapped" 
    Use the Run:ai Administrator Command-line Interface located in the `deploy` folder. To allow running the binary, run: 
    
    ```
    chmod +x runai-adm
    ``` 
    


## Install Helm

If helm v3 does not yet exist on the machine, install it now:


=== "Connected"
    See [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/){target=_blank} on how to install Helm. Run:ai works with Helm version 3 only (not helm 2).


=== "Airgapped"
    The Helm installation image is under the `deploy` directory. Run:
    ```
    tar xvf helm-<version>-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/
    ```  


## Mark Run:ai System Workers

The Run:ai control plane should be installed on a set of dedicated Run:ai system worker nodes rather than GPU worker nodes. To set system worker nodes run:

```
kubectl label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
```

To avoid single-point-of-failure issues, we recommend assigning more than one node in production environments. 

!!! Warning
    Do not select the Kubernetes master as a runai-system node. This may cause Kubernetes to stop working (specifically if Kubernetes API Server is configured on 443 instead of the default 6443).

## Additional Permissions

As part of the installation you will be required to install the [Run:ai Control Plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/){target=_blank}. The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts. 


## Next Steps

Continue with installing the [Run:ai Control Plane](backend.md).
