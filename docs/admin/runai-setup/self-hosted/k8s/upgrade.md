---
title: Upgrade self-hosted Kubernetes installation
---
# Upgrade Run:ai 
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

### Upgrade from version 2.9 
Two significant changes to the control-plane installation have happened with version 2.12: _PVC ownership_, _Ingress_ and _installation customization_. 

#### PVC ownership
Run:ai will no longer directly create the PVCs that store Run:ai data (metrics and database). Instead, going forward, 
* Run:ai [requires](prerequisites.md#kubernetes) a Kubernetes storage class to be installed.
* The PVCs are created by the Kubernetes [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){default=_blank}. 

The storage class, as per [Kubernetes standards](https://kubernetes.io/docs/concepts/storage/storage-classes/#introduction){target=_blank}, controls the [reclaim](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy){target=_blank} behavior: whether the data is saved or deleted when the Run:ai control plane is deleted.  

To remove the ownership in an older installation, run:

``` bash
kubectl patch pvc -n runai-backend pvc-thanos-receive  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
kubectl patch pvc -n runai-backend pvc-postgresql  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
```

#### Ingress
Delete the ingress object which will be recreated by the control plane upgrade

``` bash
kubectl delete ing -n runai-backend runai-backend-ingress
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
    helm upgrade runai-backend -n runai-backend runai-backend/control-plane --version "~2.19.0" -f runai_control_plane_values.yaml --reset-then-reuse-values
    ```
=== "Airgapped"

    ``` bash
    helm get values runai-backend -n runai-backend > runai_control_plane_values.yaml
    helm upgrade runai-backend control-plane-<NEW-VERSION>.tgz -n runai-backend  -f runai_control_plane_values.yaml --reset-then-reuse-values
    ```
### Upgrade from version 2.9
* Create a `tls secret` as described in the [control plane installation](backend.md). 
* Upgrade the control plane as described in the [control plane installation](backend.md). During the upgrade, you must tell the installation __not__ to create the two PVCs:

=== "Connected"

    ``` bash
    helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane --version "~2.19.0" \
    --set global.domain=<DOMAIN> \
    --set postgresql.primary.persistence.existingClaim=pvc-postgresql \ 
    --set thanos.receive.persistence.existingClaim=pvc-thanos-receive 
    ```

    !!! Note
        The helm repository name has changed from `runai-backend/runai-backend` to `runai-backend/control-plane`.
 
=== "Airgapped"

    ``` bash
    helm upgrade -i runai-backend control-plane-<NEW-VERSION>.tgz -n runai-backend \
    --set global.domain=<DOMAIN> \
    --set postgresql.primary.persistence.existingClaim=pvc-postgresql \ 
    --set thanos.receive.persistence.existingClaim=pvc-thanos-receive 
    ```

## Upgrade Cluster 

To upgrade the cluster follow the instructions [here](../../cluster-setup/cluster-upgrade.md).