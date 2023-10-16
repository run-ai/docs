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

Run:ai cluster installation uses several namespaces (or _projects_ in OpenShift terminology). Run the following:

```
oc new-project runai
oc new-project runai-reservation
oc new-project runai-scale-adjust
```

The last namespace (`runai-scale-adjust`) is only required if the cluster is a cloud cluster and is configured for auto-scaling. 

## Cluster Installation


=== "Connected"
    Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai). When creating a new cluster, select the __OpenShift__  target platform.

    !!! Info
        To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-cluster`.

=== "Airgapped"
    Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai). When creating a new cluster, select the __OpenShift__  target platform.

    When copying the helm command for installation, you will need to use the pre-provided installation file instead of using helm repositories. As such:

    * Do not add the helm repository and do not run `helm repo update`.
    * Instead, edit the `helm upgrade` command. Replace `runai/runai-cluster` with `runai-cluster-<version>.tgz`. The command should look like the following:

    ```
    helm upgrade -i runai-cluster-<version>.tgz -n runai \
      --set controlPlane.url...
    ```

## (Optional) Customize Installation

To customize specific aspects of the cluster installation see [customize cluster installation](../../cluster-setup/customize-cluster-install.md).

## Next Steps

Continue to [create Run:ai Projects](project-management.md).
