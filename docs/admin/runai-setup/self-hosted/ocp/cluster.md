---
title: Self-Hosted installation over OpenShift - Cluster Setup
---


## Prerequisites

Before installing Run:ai, you must install NVIDIA software on your OpenShift cluster to enable GPUs.
NVIDIA has provided [detailed documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/openshift/introduction.html){target=_blank}.
Follow the instructions to install the two operators `Node Feature Discovery` and `NVIDIA GPU Operator` from the OpenShift web console.

When done, verify that the GPU Operator is installed by running:

```
oc get pods -n nvidia-gpu-operator
```

(the GPU Operator namespace may differ in different operator versions).

!!! Note
    You must have Cluster Administrator rights to install these dependencies.

## Create OpenShift Projects

Run:ai cluster installation uses several namespaces (or *projects* in OpenShift terminology). Run the following:

```
oc new-project runai
oc new-project runai-reservation
oc new-project runai-scale-adjust
```

The last namespace (`runai-scale-adjust`) is only required if the cluster is a cloud cluster and is configured for auto-scaling.

## Cluster Installation

=== "Connected"
    Perform the cluster installation instructions explained [here](../../cluster-setup/cluster-install.md#install-runai). When creating a new cluster, select the **OpenShift**  target platform.

    !!! Info
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-cluster`.

=== "Airgapped"
    Perform the cluster installation instructions explained [here](../../cluster-setup/cluster-install.md#install-runai). When creating a new cluster, select the **OpenShift**  target platform.

    On the second tab of the cluster wizard, when copying the helm command for installation, you will need to use the pre-provided installation file instead of using helm repositories. As such:

    * Do not add the helm repository and do not run `helm repo update`.
    * Instead, edit the `helm upgrade` command. 
        * Replace `runai/runai-cluster` with `runai-cluster-<version>.tgz`. 
        * Add  `--set global.image.registry=<Docker Registry address>` where the registry address is as entered in the [preparation section](./preparations.md#runai-software-files)
        * Add `--set global.customCA.enabled=true` and perform the instructions for [local certificate authority](../../config/org-cert.md).
    
    The command should look like the following:
    ```
    helm upgrade -i runai-cluster runai-cluster-<version>.tgz \
        --set controlPlane.url=... \
        --set controlPlane.clientSecret=... \
        --set cluster.uid=... \
        --set cluster.url=... --create-namespace \
        --set global.image.registry=registry.mycompany.local \
        --set global.customCA.enabled=true

    ```

## (Optional) Customize Installation

To customize specific aspects of the cluster installation see [customize cluster installation](../../cluster-setup/customize-cluster-install.md).

## Next Steps

Continue to [create Run:ai Projects](project-management.md).
