---
title: Upgrade self-hosted Kubernetes installation
---

# Upgrade

## Preparations

### Helm

for both

Run:ai requires [Helm](https://helm.sh/) 3.14 or later. Before you continue, validate your installed helm client version. To install or upgrade Helm, see [Installing Helm](https://helm.sh/docs/intro/install/). If you are installing an air-gapped version of Run:ai, the Run:ai tar file contains the helm binary.

### Software files

for control plane

{% tabs %}
{% tab title="Connected" %}
Run the helm command below:

```bash
helm repo add runai-backend https://runai.jfrog.io/artifactory/cp-charts-prod
helm repo update
```
{% endtab %}

{% tab title="Airgapped" %}
* Ask for a tar file `runai-air-gapped-<NEW-VERSION>.tar.gz` from Run:ai customer support. The file contains the new version you want to upgrade to. `<NEW-VERSION>` is the updated version of the Run:ai control plane.&#x20;
* Upload the images as described [here](preparations.md#software-artifacts).
{% endtab %}
{% endtabs %}

## Before upgrade

Before proceeding with the upgrade, it's crucial to apply the specific prerequisites associated with your current version of Run:ai and every version in between up to the version you are upgrading to.

## Upgrade control plane

To upgrade from 2.17 or later, run the following:

{% tabs %}
{% tab title="Connected" %}
```bash
helm get values runai-backend -n runai-backend > runai_control_plane_values.yaml
helm upgrade runai-backend -n runai-backend runai-backend/control-plane --version "~2.20.0" -f runai_control_plane_values.yaml --reset-then-reuse-values
```
{% endtab %}

{% tab title="Airgapped" %}
```bash
helm get values runai-backend -n runai-backend > runai_control_plane_values.yaml
helm upgrade runai-backend control-plane-<NEW-VERSION>.tgz -n runai-backend  -f runai_control_plane_values.yaml --reset-then-reuse-values
```
{% endtab %}
{% endtabs %}

## Upgrade Cluster

This article explains how to upgrade Run:ai cluster version.

## Before upgrade

There are a number of matters to consider prior to upgrading the Run:ai cluster version.

### System and network requirements

Before upgrading the Run:ai cluster, validate that the latest [system requirements](broken-reference) and [network requirements](broken-reference) are met, as they can change from time to time.

{% hint style="info" %}
**Important**&#x20;

It is highly recommended to upgrade the Kubernetes version together with the Run:ai cluster version, to ensure compatibility with latest supported version of your [Kubernetes distribution](broken-reference).
{% endhint %}

### Helm

The latest releases of the Run:ai cluster require [Helm 3.14](https://helm.sh/docs/helm/helm_install/) or above.

## Upgrade

Follow the instructions to upgrade using Helm. The Helm commands to upgrade the Run:ai cluster version may differ between versions. The steps below describe how to get the instructions from the Run:ai UI.

### Getting installation instructions

Follow the setup and installation instructions below to get the installation instructions to upgrade the Run:ai cluster.

#### Setup

1. In the Run:ai UI, go to **Clusters**
2. Select the cluster you want to upgrade
3. Click **INSTALLATION INSTRUCTIONS**
4. Optional: Select the Run:ai cluster version (latest, by default)
5. Click **CONTINUE**

#### Installation instructions

1. Follow the installation instructions. Run the Helm commands provided on your Kubernetes cluster. See the below if [installation fails](upgrade.md#installation-fails).
2. Click **DONE**
3. Once installation is complete, validate the cluster is **Connected** and listed with the new cluster version (see the cluster [troubleshooting scenarios](broken-reference)). Once you have done this, the cluster is upgraded to the latest version.

{% hint style="info" %}
To upgrade to a specific version, modify the `--version` flag by specifying the desired `<version-number>`. You can find all available versions by using the `helm search repo` command.
{% endhint %}

## Troubleshooting

If you encounter an issue with the cluster upgrade, use the troubleshooting scenarios below.

### Installation fails

If the Run:ai cluster upgrade fails, check the installation logs to identify the issue.

Run the following script to print the installation logs:

```bash
curl -fsSL https://raw.githubusercontent.com/run-ai/public/main/installation/get-installation-logs.sh
```

### Cluster status

If the Run:ai cluster upgrade completes, but the cluster status does not show as **Connected**, refer to the [cluster troubleshooting scenarios](broken-reference).
