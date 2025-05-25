# Upgrade

## Before upgrade
Before proceeding with the upgrade, it's crucial to apply the specific prerequisites associated with your current version of NVIDIA Run:ai and every version in between up to the version you are upgrading to.

## Helm
NVIDIA Run:ai requires Helm 3.14 or later. Before you continue, validate your installed helm client version. To install or upgrade Helm, see Installing Helm.

## Software files
```bash
helm repo add runai-backend https://runai.jfrog.io/artifactory/cp-charts-prod
helm repo update
```

## Upgrade control plane

### System and network requirements
Before upgrading the NVIDIA Run:ai control plane, validate that the latest [system requirements](system-requirements.md) and [network requirements](network-requirements.md) are met, as they can change from time to time.

### Upgrade

```bash
helm get values runai-backend -n runai-backend > runai_control_plane_values.yaml
helm upgrade runai-backend -n runai-backend runai-backend/control-plane --version "<VERSION>" -f runai_control_plane_values.yaml --reset-then-reuse-values
```

!!! Note
    To upgrade to a specific version, modify the --version flag by specifying the desired <VERSION>. You can find all available versions by using the helm search repo command.


## Upgrade cluster

### System and network requirements

Before upgrading the NVIDIA Run:ai cluster, validate that the latest [system requirements](system-requirements.md) and [network requirements](network-requirements.md) are met, as they can change from time to time.

### Getting installation instructions

Follow the setup and installation instructions below to get the installation instructions to upgrade the NVIDIA Run:ai cluster.

#### Setup

1. In the NVIDIA Run:ai UI, go to **Clusters**
2. Select the cluster you want to upgrade
3. Click **INSTALLATION INSTRUCTIONS**
4. Choose the NVIDIA Run:ai cluster version (latest, by default)
5. Select **Same as control plane**
6. Click **Continue**

#### Installation instructions

1. Follow the installation instructions and run the commands provided on your Kubernetes cluster
2. Append `--set global.customCA.enabled=true` to the Helm installation command
3. Click **DONE**


!!! Note
    To upgrade to a specific version, modify the `--version` flag by specifying the desired `<VERSION>`. You can find all available versions by using the `helm search repo` command.

### Troubleshooting

If you encounter an issue with the cluster upgrade, use the troubleshooting scenarios below.

#### Installation fails

If the NVIDIA Run:ai cluster upgrade fails, check the installation logs to identify the issue.
Run the following script to print the installation logs:

```bash
curl -fsSL https://raw.githubusercontent.com/run-ai/public/main/installation/get-installation-logs.sh
```

#### Cluster status

If the NVIDIA Run:ai cluster upgrade completes, but the cluster status does not show as **Connected**, refer to [Troubleshooting scenarios](../../../config/clusters.md#troubleshooting-scenarios).