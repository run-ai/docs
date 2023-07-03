---
title: Upgrade self-hosted Kubernetes installation
---
# Upgrade Run:ai 


!!! Important
    Run:ai data is stored in Kubernetes persistent volumes (PVs). Prior to Run:ai 2.12, PVs are owned by the Run:ai installation. Thus, uninstalling the `runai-backend` helm chart may delete all of your data. 

    From version 2.12 forward, PVs are owned the customer and are independent of the Run:ai installation. 
## Preparations

=== "Connected"
    No preparation required.

=== "Airgapped" 
    * Ask for a tar file `runai-air-gapped-<new-version>.tar` from Run:ai customer support. The file contains the new version you want to upgrade to. `new-version` is the updated version of the Run:ai control plane.
    * Upload the images as described [here](preparations.md#runai-software-files).


## Specific version instructions
### Upgrade from Version 2.7 or 2.8

Before upgrading the control plane, run: 

``` bash
POSTGRES_PV=$(kubectl get pvc pvc-postgresql -n runai-backend -o jsonpath='{.spec.volumeName}')
THANOS_PV=$(kubectl get pvc pvc-thanos-receive -n runai-backend -o jsonpath='{.spec.volumeName}')
kubectl patch pv $POSTGRES_PV $THANOS_PV -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}'

kubectl delete secret -n runai-backend runai-backend-postgresql
kubectl delete sts -n runai-backend keycloak runai-backend-postgresql
```

Before version 2.9, the Run:ai installation, by default, included NGINX. It was possible to disable this installation. If NGINX is enabled in your current installation, as per the default, run the following 2 lines:

``` bash
kubectl delete ValidatingWebhookConfiguration runai-backend-nginx-ingress-admission
kubectl delete ingressclass nginx 
```
(If Run:ai configuration has previously disabled NGINX installation then these lines should not be run).

Next, install NGINX as described [here](../../cluster-setup/cluster-prerequisites.md#ingress-controller)

Then create a tls secret and upgrade the control plane as described in the [control plane installation](backend.md). Before upgrading, find customizations and merge them as discussed below. 

### Upgrade from version 2.9 or 2.10

Two significant changes to the control-plane installation have happened with version 2.12: _PVC ownership_ and _installation customization_. 

#### PVC Ownership

Run:ai has transferred control of storage to the customer. Specifically, the Kubernetes Persistent Volumes are now owned by the customer and will not be deleted when the Run:ai control-plane is uninstalled. 

To remove the ownership in an older installation, run:

```
kubectl patch pvc -n runai-backend pvc-thanos-receive  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
kubectl patch pvc -n runai-backend pvc-postgresql  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
```

Also, delete the ingress object which will be recreated by the control plane upgrade

```
kubectl delete ing -n runai-backend runai-backend-ingress
```
#### Installation Customization

The Run:ai control-plane installation has been rewritten and is no longer using a _backend values file_. Instead, to customize the installation use standard `--set` flags. If you have previously customized the installation, you must now extract these customizations and add them as `--set` flag to the helm installation:

* Find previous customizations to the control-plane if such exist. Run:ai provides a utility for that here `wget https://raw.githubusercontent.com/run-ai/docs/v2.12/install/backend/create-self-signed.sh`. For information on how to use this utility please contact Run:ai customer support. 
* Search for the customizations you found in the [optional configurations](./backend.md#optional-additional-configurations) table and add them in the new format. 


Then create a `tls secret` and upgrade the control plane as described in the [control plane installation](backend.md). 



## Upgrade Cluster 

=== "Connected"
    To upgrade the cluster follow the instructions [here](../../cluster-setup/cluster-upgrade.md).

=== "Airgapped"
    ```
    helm get values runai-cluster -n runai > values.yaml
    helm upgrade runai-cluster -n runai runai-cluster-<version>.tgz -f values.yaml
    ```
    (replace `<version>` with the cluster version)
