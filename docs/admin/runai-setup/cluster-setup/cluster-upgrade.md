This article explains how to upgrade Run:ai cluster version.

## Before upgrade

There are a number of matters to consider prior to upgrading the Run:ai cluster version.

### Backup your cluster data

Review the Backup & Restore [guide](././admin/config/dr.md) and ensure you know how to backup your data if needed.

### System and network requirements

Before upgrading the Run:ai cluster, validate that the latest [system requirements](./cluster-prerequisites.md) and [network requirements](./network-req.md) are met, as they can change from time to time.

!!! Important
    It is highly recommended to upgrade the Kubernetes version together with the Run:ai cluster version, to ensure compatibility with latest supported version of your Kubernetes distribution

### Helm

The latest releases of the Run:ai cluster require [Helm 3.14](https://helm.sh/docs/helm/helm_install/) or above.

## Upgrade

Follow the instructions to upgrade using Helm. The Helm commands to upgrade the Run:ai cluster version may differ between versions. The steps below describe how to get the instructions from the Run:ai UI.

### Getting the installation instructions

Follow the setup and installation instructions below to get the installation instructions to upgrade the Run:ai cluster.

#### Setup

1. In the Run:ai UI, go to **Clusters**  
2. Select the cluster you want to upgrade  
3. Click **INSTALLATION INSTRUCTIONS**  
4. Optional: Select the Run:ai cluster version (latest, by default)  
5. Click **CONTINUE**

#### Installation instructions

1. Follow the installation instructions (See the additional instructions below when [upgrading to v2.13](#upgrade-to-runai-cluster-version-213-old-release))  
   run the Helm commands provided on your Kubernetes cluster (see the troubleshooting below if installation fails)  
2. Click **DONE**  
3. Once installation is complete, validate the cluster is **Connected** and listed with the new cluster version (see the cluster troubleshooting scenarios). Once you have done this, the cluster is upgraded to the latest version.

!!! Note
    To upgrade to a specific version, modify the `--version` flag by specifying the desired `<version-number>`. You can find all available versions by using the `helm search repo` command.

## Upgrade to Run:ai cluster version 2.13 (old release)

Run:ai cluster version 2.13 (old release) does not support migration of the configured Helm values. If you have customized configurations you want to migrate, follow the additional steps below:

1. Download the Run:ai Helm values file by running the command provided in your terminal  
2. Run the following command to save existing cluster Helm values into `old-values.yaml`

``` bash
helm get values runai-cluster -n runai > old-values.yaml
```

4.   
   Identify configured custom values that you want to migrate  
5. Manually merge the values from `old-values.yaml` into the new values file

## Troubleshooting

If you encounter an issue with the cluster upgrade, use the troubleshooting scenario below.

??? "Installation fails"
    If the Run:ai cluster upgrade fails, check the installation logs to identify the issue.

    Run the following script to print the installation logs:

    ```
    curl -fsSL https://raw.githubusercontent.com/run-ai/public/main/installation/get-installation-logs.sh
    ```

??? "Cluster status"
    If the Run:ai cluster upgrade completes, but the cluster status does not show as **Connected**, refer to the [cluster troubleshooting scenarios](../../config/clusters.md#troubleshooting)
. 

