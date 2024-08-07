---
title: Upgrade self-hosted OpenShift installation
---
# Upgrade Run:ai 


!!! Important
    Run:ai data is stored in Kubernetes persistent volumes (PVs). Prior to Run:ai 2.12, PVs are owned by the Run:ai installation. Thus, uninstalling the `runai-backend` helm chart may delete all of your data. 

    From version 2.12 forward, PVs are owned the customer and are independent of the Run:ai installation. As such, they are subject to storage class [reclaim](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy){target=_blank} policy.

## Preparations

### Helm
Run:ai requires [Helm](https://helm.sh/){target=_blank} 3.14 or later.
Before you continue, validate your installed helm client version.
To install or upgrade Helm, see [Installing Helm](https://helm.sh/docs/intro/install/){target=_blank}.
If you are installing an air-gapped version of Run:ai, The Run:ai tar file contains the helm binary. 

### Software files

=== "Connected"
    Run the helm command below:

    ``` bash
    helm repo add runai-backend https://runai.jfrog.io/artifactory/cp-charts-prod
    helm repo update
    ```

=== "Airgapped" 
    * Ask for a tar file `runai-air-gapped-<NEW-VERSION>.tar.gz` from Run:ai customer support. The file contains the new version you want to upgrade to. `<NEW-VERSION>` is the updated version of the Run:ai control plane.
    * Upload the images as described [here](preparations.md#software-artifacts).

## Before upgrade

Before proceeding with the upgrade, it's crucial to apply the specific prerequisites associated with your current version of Run:ai and every version in between up to the version you are upgrading to.

### Upgrade from version 2.7 or 2.8

Before upgrading the control plane, run: 

``` bash
POSTGRES_PV=$(kubectl get pvc pvc-postgresql -n runai-backend -o jsonpath='{.spec.volumeName}')
kubectl patch pv $POSTGRES_PV -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}'

kubectl delete secret -n runai-backend runai-backend-postgresql
kubectl delete sts -n runai-backend keycloak runai-backend-postgresql
```

Then upgrade the control plane as described [below](#upgrade-control-plane). Before upgrading, find customizations and merge them as discussed below. 

### Upgrade from version 2.9, 2.10 or 2.11

Two significant changes to the control-plane installation have happened with version 2.12: _PVC ownership_ and _installation customization_. 
#### PVC ownership

Run:ai will no longer directly create the PVCs that store Run:ai data (metrics and database). Instead, going forward, 

* Run:ai requires a Kubernetes storage class to be installed.
* The PVCs are created by the Kubernetes [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){default=_blank}. 

The storage class, as per [Kubernetes standards](https://kubernetes.io/docs/concepts/storage/storage-classes/#introduction){target=_blank}, controls the [reclaim](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy){target=_blank} behavior: whether the data is saved or deleted when the Run:ai control plane is deleted.  

To remove the ownership in an older installation, run:

```
kubectl patch pvc -n runai-backend pvc-postgresql  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
```

#### Installation customization

The Run:ai control-plane installation has been rewritten and is no longer using a _backend values file_. Instead, to customize the installation use standard `--set` flags. If you have previously customized the installation, you must now extract these customizations and add them as `--set` flag to the helm installation:

* Find previous customizations to the control plane if such exist. Run:ai provides a utility for that here `https://raw.githubusercontent.com/run-ai/docs/v2.13/install/backend/cp-helm-vals-diff.sh`. For information on how to use this utility please contact Run:ai customer support. 
* Search for the customizations you found in the [optional configurations](./backend.md#additional-runai-configurations-optional) table and add them in the new format.  


## Upgrade Control Plane

### Upgrade from version 2.13, or later

=== "Connected"

    ``` bash
    helm get values runai-backend -n runai-backend > runai_control_plane_values.yaml
    helm upgrade runai-backend -n runai-backend runai-backend/control-plane -f runai_control_plane_values.yaml --reset-then-reuse-values
    ```
=== "Airgapped"

    ``` bash
    helm get values runai-backend -n runai-backend > runai_control_plane_values.yaml
    helm upgrade runai-backend control-plane-<NEW-VERSION>.tgz -n runai-backend  -f runai_control_plane_values.yaml --reset-then-reuse-values
    ```

### Upgrade from version 2.7, 2.8, 2.9, or 2.11

=== "Connected"

    ``` bash
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane  \
    --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ #(1)
    --set global.config.kubernetesDistribution=openshift \
    --set thanos.query.stores={thanos-grpc-port-forwarder:10901} \
    --set postgresql.primary.persistence.existingClaim=pvc-postgresql
    ```

    1. The subdomain configured for the OpenShift cluster.


    !!! Note
        The helm repository name has changed from `runai-backend/runai-backend` to `runai-backend/control-plane`.


=== "Airgapped"

    ``` bash
    helm upgrade -i runai-backend  ./control-plane-<NEW-VERSION>.tgz -n runai-backend \
    --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ #(1)
    --set global.config.kubernetesDistribution=openshift \
    --set thanos.query.stores={thanos-grpc-port-forwarder:10901} \
    --set postgresql.primary.persistence.existingClaim=pvc-postgresql
    ```

    1. The subdomain configured for the OpenShift cluster.

## Upgrade Cluster 

To upgrade the cluster follow the instructions [here](../../cluster-setup/cluster-upgrade.md).
