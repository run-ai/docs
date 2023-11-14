---
title: Self Hosted installation over Kubernetes - Cluster Setup
---



## Prerequisites

Install prerequisites as per [cluster prerequisites](../../cluster-setup/cluster-prerequisites.md) document.  


## Install Cluster

=== "Connected"
    Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai).

=== "Airgapped"
    Perform the cluster installation instructions explained [here](../../../cluster-setup/cluster-install/#step-3-install-runai).

    On the second tab of the cluster wizard, when copying the helm command for installation, you will need to use the pre-provided installation file instead of using helm repositories. As such:

    * Do not add the helm repository and do not run `helm repo update`.
    * Instead, edit the `helm upgrade` command. 
        * Replace `runai/runai-cluster` with `runai-cluster-<version>.tgz`. 
        * Add  `--set global.image.registry=<Docker Registry address>` where the registry address is as entered in the [preparation section](./preparations.md#runai-software-files)
    
    The command should look like the following:
    ```
    helm upgrade -i runai-cluster runai-cluster-<version>.tgz \
        --set global.image.registry=registry.mycompany.local \
        -n runai --set controlPlane.url...
    ```

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details see [Understanding cluster access roles](../../../config/access-roles/).

## (Optional) Customize Installation

To customize specific aspects of the cluster installation see [customize cluster installation](../../cluster-setup/customize-cluster-install.md).




