
# Upgrading a Cluster Installation

## Find out Run:ai Cluster version 

To find the Run:ai cluster version, run:

```
helm list -n runai -f runai-cluster
```

and record the chart version in the form of `runai-cluster-<version-number>`

## Upgrade Run:ai cluster 

### Upgrade from version 2.9 or later


Run:

```
helm get values runai-cluster -n runai > old-values.yaml
```

1. Review the file `old-values.yaml` and see if there are any changes performed during the last installation.
2. Follow the instructions for [Installing Run:ai](cluster-install.md#install-runai) to download a new values file. 
3. Merge the changes from Step 1 into the new values file.
4. Run `helm upgrade` as per the instructions in the link above. 


!!! Note
    To upgrade to a __specific__ version of the Run:ai cluster, add `--version <version-number>` to the `helm upgrade` command. You can find the relevant version with `helm search repo` as described above. 

### Upgrade from version 2.8 or earlier

The process of upgrading from 2.7 or 2.8 requires [uninstalling](./cluster-delete.md) and then [installing](./cluster-install.md) again. No data is lost during the process. 

!!! Note
    The reason for this process is that Run:ai 2.9 cluster installation no longer installs pre-requisites. As such ownership of dependencies such as Prometheus will be undefined if a `helm upgrade` is run.

The process:

* Delete the Run:ai cluster installation according to these [instructions](cluster-delete.md) (do not delete the Run:ai cluster __object__ from the user interface).
* The following commands should be executed __after__ running the helm uninstall command 
    ```
    kubectl -n runai delete all --all
    kubectl -n runai delete cm --all
    kubectl -n runai delete secret --all
    kubectl -n runai delete roles --all
    kubectl -n runai delete rolebindings --all
    kubectl -n runai delete ingress --all
    kubectl -n runai delete servicemonitors --all
    kubectl -n runai delete podmonitors --all
    kubectl delete validatingwebhookconfigurations.admissionregistration.k8s.io -l app=runai
    kubectl delete mutatingwebhookconfigurations.admissionregistration.k8s.io -l app=runai
    kubectl delete svc -n kube-system runai-cluster-kube-prometh-kubelet
    ``` 
* Install the mandatory Run:ai [prerequisites](cluster-prerequisites.md):
    * If you have previously installed the SaaS version of Run:ai version 2.7 or below, you will need to install both [Ingress Controller](cluster-prerequisites.md#ingress-controller) and [Prometheus](cluster-prerequisites.md#prometheus).
    * If you have previously installed the SaaS version of Run:ai version 2.8 or any Self-hosted version of Run:ai, you will need to install [Prometheus](cluster-prerequisites.md#prometheus) only.


* Install Run:ai cluster as described [here](cluster-install.md)

## Verify Successful Installation

See [Verify your installation](cluster-install.md#verify-your-installation) on how to verify a Run:ai cluster installation



