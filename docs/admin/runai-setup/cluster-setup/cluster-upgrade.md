  
This article explains how to upgrade Run:ai cluster version.

## Before upgrade

There are a number of matters to consider prior to upgrading the Run:ai cluster version using Helm.

### System and network requirements

Before upgrading the Run:ai cluster, validate that the latest [system requirements](./cluster-prerequisites.md) and [network requirements](./network-req.md) are met as they can change from time to time.

!!! Important
    It is highly recommended to upgrade the Kubernetes version together with the Run:ai cluster version, to ensure compatibility with latest supported version of your [Kubernetes distribution](cluster-prerequisites.md#kubernetes-distribution)

### Helm

The latest releases of the Run:ai cluster require Helm 3.14 or above. To install latest Helm release, see [Helm Install](https://helm.sh/docs/helm/helm_install/).

## Upgrade

Follow these instructions to upgrade using Helm. The Helm commands to upgrade the Run:ai cluster version may differ from one version to another, and therefore are obtained in the Run:ai Platform.

### Obtaining installation instructions

Follow the steps below to obtain the installation instructions to upgrade the Run:ai cluster.

1. In the Run:ai platform, go to `Clusters`  
2. Select the cluster you want to upgrade  
3. Click __INSTALLATION INSTRUCTIONS__  
4. (Optional) Chose the Run:ai cluster version (latest, by default)  
5. Click Continue

??? "Upgrade to Run:ai cluster version 2.13 (old release)"
    Run:ai cluster version 2.13 (old release) does not support migration of the configured Helm values, therefore if you have customized configurations your would like to migrate follow the additional steps below:

    * Download the Run:ai Helm values file by running the command provided 

    * Run the following command to save existing cluster Helm values into old-values.yaml
    
    ``` bash
    helm get values runai-cluster -n runai > old-values.yaml
    ```

    * Identify configured custom values that you want to migrate

    * Manually merge the values from old-values.yaml into the new values file

!!! Note
    To upgrade to a specific version, modify the `--version` flag by specifying the desired `<version-number>`. You can find all available versions by using the `helm search repo` command.

### Upgrading Run:ai cluster

In the next section, the Run:ai cluster installation steps are presented.

1. Follow the installation instructions and run the Helm commands provided on your Kubernetes cluster.  
2. Click __DONE__

Once installation is complete, validate the cluster is Connected and listed with the new cluster version. Once you have done this, the cluster is upgraded to the latest version.

## Troubleshooting

If you encounter an issue with the cluster upgrade, use the troubleshooting scenario below.

### Installation fails

If the Run:ai cluster upgrade fails, check the installation logs to identify the issue.

Run the following script to print the installation logs:

``` bash
curl -fsSL https://raw.githubusercontent.com/run-ai/public/main/installation/get-installation-logs.sh
```

### Cluster status

If the Run:ai cluster upgrade completes, but the cluster status is not Connected, check the [cluster troubleshooting scenarios](../config/clusters.md#troubleshooting)

