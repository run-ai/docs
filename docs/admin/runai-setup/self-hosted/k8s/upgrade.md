---
title: Upgrade self-hosted Kubernetes installation
---
# Upgrade Run:ai 


!!! Warning
    The Run:ai data is stored in a Kubernetes persistent volume, depending on how you installed the Run:ai control plane, uninstalling the `runai-backend` helm chart may delete all your data. 

    The upgrade process described below does not require uninstalling the helm chart. 
## Preparations

=== "Connected"
    No preparation required.

=== "Airgapped" 
    * Ask for a tar file `runai-air-gapped-<new-version>.tar` from Run:ai customer support. The file contains the new version you want to upgrade to. `new-version` is the updated version of the Run:ai control plane.
    * Prepare the installation artifact as described [here](../preparations/#prepare-installation-artifacts) (untar the file and run the script to upload it to the local container registry). 


## Upgrade to Version 2.9

Before upgrading the control plane, run: 

``` bash
kubectl delete --namespace runai-backend --all \
    deployments,statefulset,svc,ing,ServiceAccount,secrets
kubectl delete svc -n kube-system runai-cluster-kube-prometh-kubelet
```

Before version 2.9, the Run:ai installation, by default, included NGINX. It was possible to disable this installation. if NGINX is disabled in your current installation then __do not__ run the following 2 lines. 

``` bash
kubectl delete ValidatingWebhookConfiguration runai-backend-nginx-ingress-admission
kubectl delete ingressclass nginx 
```

Next, install NGINX as described [here](../../cluster-setup/cluster-prerequisites.md#ingress-controller)

Then upgrade the control plane as described in the next section. 

## Upgrade the Control Plane

If you have customized the backend values file in the older version, save it now by running

```
helm get values runai-backend -n runai-backend > old-be-values.yaml
```

Generate a new backend values file as described [here](backend.md#create-a-control-plane-configuration). Change the file with the above customization if relevant.

Run the helm command below. 

=== "Connected"
    ```
    helm repo add runai-backend https://backend-charts.storage.googleapis.com
    helm repo update
    helm upgrade runai-backend -n runai-backend runai-backend/runai-backend -f runai-backend-values.yaml
    ```
=== "Airgapped"
    ```
    helm upgrade runai-backend runai-backend/runai-backend-<version>.tgz -n \
        runai-backend  -f runai-backend-values.yaml
    ```
    (replace `<version>` with the control plane version)


## Upgrade Cluster 

=== "Connected"
    To upgrade the cluster follow the instructions [here](../../cluster-setup/cluster-upgrade.md).

=== "Airgapped"
    ```
    kubectl apply -f runai-crds.yaml
    helm get values runai-cluster -n runai > values.yaml
    helm upgrade runai-cluster -n runai runai-cluster-<version>.tgz -f values.yaml
    ```
    (replace `<version>` with the cluster version)
