---
title: Upgrade self-hosted OpenShift installation
---
# Upgrade Run:ai 

## Preparations

=== "Connected"
    No preparation required.

=== "Airgapped" 
    * Ask for a tar file `runai-air-gapped-<new-version>.tar` from Run:ai customer support. The file contains the new version you want to upgrade to. `new-version` is the updated version of the Run:ai control plane.
    * Upload the images as described [here](preparations.md#runai-software-files).

## Upgrade Control Plane

### Upgrade from Version 2.7 or 2.8.

Before upgrading the control plane, run: 

``` bash
POSTGRES_PV=$(kubectl get pvc pvc-postgresql -n runai-backend -o jsonpath='{.spec.volumeName}')
kubectl patch pv $POSTGRES_PV -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}'

kubectl delete secret -n runai-backend runai-backend-postgresql
kubectl delete sts -n runai-backend keycloak runai-backend-postgresql
```

Then upgrade the control plane as described [below](#upgrade-the-control-plane). Before upgrading, find customizations and merge them as discussed below. 

### Upgrade from Version 2.9, 2.10 or 2.11

Two significant changes to the control-plane installation have happened with version 2.12: _PVC ownership_ and _installation customization_. 
#### PVC Ownership

Run:ai will no longer directly create the PVCs that store Run:ai data (metrics and database). Instead, going forward, 

* Run:ai requires a Kubernetes storage class to be installed.
* The PVCs are created by the Kubernetes [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){default=_blank}. 

The storage class, as per [Kubernetes standards](https://kubernetes.io/docs/concepts/storage/storage-classes/#introduction){target=_blank}, controls the [reclaim](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy){target=_blank} behavior: whether the data is saved or deleted when the Run:ai control plane is deleted.  

To remove the ownership in an older installation, run:

```
kubectl patch pvc -n runai-backend pvc-postgresql  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
```

#### Installation Customization

The Run:ai control-plane installation has been rewritten and is no longer using a _backend values file_. Instead, to customize the installation use standard `--set` flags. If you have previously customized the installation, you must now extract these customizations and add them as `--set` flag to the helm installation:

* Find previous customizations to the control plane if such exist. Run:ai provides a utility for that here `https://raw.githubusercontent.com/run-ai/docs/v2.13/install/backend/cp-helm-vals-diff.sh`. For information on how to use this utility please contact Run:ai customer support. 
* Search for the customizations you found in the [optional configurations](./backend.md#optional-additional-configurations) table and add them in the new format.  



Then upgrade the control plane as described [below](#upgrade-the-control-plane). 

### Upgrade Control Plane

=== "Connected"
    ``` bash
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane --version "~2.15.0"   \
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

    helm upgrade -i runai-backend  ./runai-backend-<version>.tgz -n runai-backend \
    --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ #(1)
    --set global.config.kubernetesDistribution=openshift \
    --set thanos.query.stores={thanos-grpc-port-forwarder:10901} \
    --set postgresql.primary.persistence.existingClaim=pvc-postgresql
    ```

    1. The subdomain configured for the OpenShift cluster.

## Upgrade Cluster 

To upgrade the cluster follow the instructions [here](../../cluster-setup/cluster-upgrade.md).
