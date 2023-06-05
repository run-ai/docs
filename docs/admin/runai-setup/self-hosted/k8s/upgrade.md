---
title: Upgrade self-hosted Kubernetes installation
---
# Upgrade Run:ai 


!!! Important
    Run:ai data is stored in Kubernetes persistent volumes (PVs). Prior to Run:ai 2.11, PVs are owned by the Run:ai installation. Thus, uninstalling the `runai-backend` helm chart may delete all of your data. 

    From version 2.11 forward, PVs are owned the customer and are independent of the Run:ai installation. 
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
kubectl delete --namespace runai-backend --all \
    deployments,statefulset,svc,ing,ServiceAccount
kubectl delete svc -n kube-system runai-cluster-kube-prometh-kubelet
for secret in `kubectl get secret -n runai-backend | grep -v helm.sh/release.v1 | grep -v NAME | awk '{print $1}'`; do kubectl delete secrets -n runai-backend $secret; done
```

Delete all secrets in the `runai-backend` namespace except the `helm` secret (the secret of type `helm.sh/release.v1`).

Before version 2.9, the Run:ai installation, by default, included NGINX. It was possible to disable this installation. if NGINX is disabled in your current installation then __do not__ run the following 2 lines. 

``` bash
kubectl delete ValidatingWebhookConfiguration runai-backend-nginx-ingress-admission
kubectl delete ingressclass nginx 
```
(If Run:ai configuration has previously disabled NGINX installation then these lines should not be run).

Next, install NGINX as described [here](../../cluster-setup/cluster-prerequisites.md#ingress-controller)

Then create a tls secret and upgrade the control plane as described in the [control plane installation](backend.md). 

### Upgrade from version 2.9 or 2.10

With version 2.11, Run:ai transfers control of storage to the customer. Specifically, the Kubernetes Persistent Volumes are now owned by the customer and will not be deleted when the Run:ai control plane is uninstalled. 

To remove the ownership, run:

```
kubectl patch pvc -n runai-backend pvc-thanos-receive  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
kubectl patch pvc -n runai-backend pvc-postgresql  -p '{"metadata": {"annotations":{"helm.sh/resource-policy": "keep"}}}'
```

Also, delete the ingress object which will be recreated by the control plane upgrade

```
kubectl delete ing -n runai-backend runai-backend-ingress
```

Then create a tls secret and upgrade the control plane as described in the [control plane installation](backend.md). 





## Upgrade Cluster 

=== "Connected"
    To upgrade the cluster follow the instructions [here](../../cluster-setup/cluster-upgrade.md).

=== "Airgapped"
    ```
    helm get values runai-cluster -n runai > values.yaml
    helm upgrade runai-cluster -n runai runai-cluster-<version>.tgz -f values.yaml
    ```
    (replace `<version>` with the cluster version)
