---
title: Self Hosted installation over Kubernetes - Cluster Setup
---

## Prerequisites
Install prerequisites as per [System Requirements](../../cluster-setup/cluster-prerequisites.md) document.

!!! Note
    For self-hosted deployments, [Kubernetes Ingress Controller](../../cluster-setup/cluster-prerequisites.md#kubernetes-ingress-controller) and Cluster [Fully Qualified Domain Name (FQDN)](../../cluster-setup/cluster-prerequisites.md#fully-qualified-domain-name-fqdn) requirements are only necessary when the Run:ai Control Plane and Run:ai Cluster reside on seperate Kuebrnetes clusters.

## Install Cluster
=== "Connected"
    Perform the cluster installation instructions explained [here](../../cluster-setup/cluster-install.md).

=== "Airgapped"
    Perform the cluster installation instructions explained [here](../../cluster-setup/cluster-install.md).

    On the second tab of the cluster wizard, when copying the helm command for installation, you will need to use the pre-provided installation file instead of using helm repositories. As such:

    * Do not add the helm repository and do not run `helm repo update`.
    * Instead, edit the `helm upgrade` command. 
        * Replace `runai/runai-cluster` with `runai-cluster-<version>.tgz`. 
        * Add  `--set global.image.registry=<Docker Registry address>` where the registry address is as entered in the [preparation section](./preparations.md#software-artifacts)
    
    The command should look like the following:
    
    ```
    helm upgrade -i runai-cluster runai-cluster-<version>.tgz \
        --set controlPlane.url=... \
        --set controlPlane.clientSecret=... \
        --set cluster.uid=... \
        --set cluster.url=... --create-namespace \
        --set global.image.registry=registry.mycompany.local \

    ```

!!! Tip
    Use the  `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details see [Understanding cluster access roles](../../config/access-roles.md).

## (Optional) Customize Installation
To customize specific aspects of the cluster installation see [customize cluster installation](../../cluster-setup/customize-cluster-install.md).




