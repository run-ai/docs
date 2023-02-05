---
title: Upgrade self-hosted Kubernetes installation
---
# Upgrade Run:ai 

## Preparations

=== "Connected"
    No preparation required.

=== "Airgapped" 
    * Ask for a tar file `runai-air-gapped-<new-version>.tar` from Run:ai customer support. The file contains the new version you want to upgrade to. `new-version` is the updated version of the Run:ai control plane.
    * Prepare the installation artifact as described [here](../preparations/#prepare-installation-artifacts) (untar the file and run the script to upload it to the local container registry). 


## Upgrade Control Plane

Run the helm command below. 

=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm get values runai-backend -n runai-backend > be-values.yaml
    helm upgrade runai-backend -n runai-backend runai-backend/runai-backend -f be-values.yaml 
    ```
=== "Airgapped"
    ```
    helm get values runai-backend -n runai-backend > be-values.yaml
    helm upgrade runai-backend runai-backend/runai-backend-<version>.tgz -n \
        runai-backend  -f be-values.yaml
    ```
    (replace `<version>` with the control plane version)


## Upgrade Cluster 

To upgrade the cluster follow the instructions [here](../../cluster-setup/cluster-upgrade.md).


=== "Connected"
    ```
    kubectl apply -f https://raw.githubusercontent.com/run-ai/public/main/<version>/runai-crds.yaml
    helm repo update
    helm get values runai-cluster -n runai > values.yaml
    helm upgrade runai-cluster runai/runai-cluster -n runai -f values.yaml
    ```

=== "Airgapped"
    ```
    kubectl apply -f runai-crds.yaml
    helm get values runai-cluster -n runai > values.yaml
    helm upgrade runai-cluster -n runai runai-cluster-<version>.tgz -f values.yaml
    ```
    (replace `<version>` with the cluster version)
