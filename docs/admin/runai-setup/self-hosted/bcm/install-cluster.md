# Install the Cluster


## System and Network Requirements 
Before installing the NVIDIA Run:ai cluster, validate that the [system requirements](./system-requirements.md) and [network requirements](./network-requirements.md) are met. Make sure you have the [software artifacts](./preparations.md) prepared.

Once all the requirements are met, it is highly recommend to use the NVIDIA Run:ai cluster preinstall diagnostics tool to:

* Test the below requirements in addition to failure points related to Kubernetes, NVIDIA, storage, and networking
* Look at additional components installed and analyze their relevance to a successful installation

For more information, see [preinstall diagnostics](https://github.com/run-ai/preinstall-diagnostics). To run the preinstall diagnostics tool, [download](https://runai.jfrog.io/ui/native/pd-cli-prod/preinstall-diagnostics-cli/) the latest version, and run:

```bash
chmod +x ./preinstall-diagnostics-<platform> && \ 
./preinstall-diagnostics-<platform> \
  --domain ${CONTROL_PLANE_FQDN} \
  --cluster-domain ${CLUSTER_FQDN} \
#if the diagnostics image is hosted in a private registry
  --image-pull-secret ${IMAGE_PULL_SECRET_NAME} \
  --image ${PRIVATE_REGISTRY_IMAGE_URL}    
```

## Helm

NVIDIA Run:ai requires [Helm](https://helm.sh/) 3.14 or later. To install Helm, see [Installing Helm](https://helm.sh/docs/intro/install/). 

## Permissions 

A Kubernetes user with the `cluster-admin` role is required to ensure a successful installation. For more information, see [Using RBAC authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

## Installation

Follow the steps below to add a new cluster.

!!! Note
    When adding a cluster for the first time, the New Cluster form automatically opens when you log in to the NVIDIA Run:ai platform. Other actions are prevented, until the cluster is created.

If this is your first cluster and you have completed the New Cluster form, start at step 3. Otherwise, start at step 1.

1. In the NVIDIA Run:ai platform, go to **Resources**
2. Click **+NEW CLUSTER**
3. Enter a unique name for your cluster
4. Choose the NVIDIA Run:ai cluster version (latest, by default)
5. Select **Same as control plane**
6. Click **Continue**

**Installing NVIDIA Run:ai Cluster**

In the next Section, the NVIDIA Run:ai cluster installation steps will be presented.

1. Follow the installation instructions and run the commands provided on your Kubernetes cluster
2. Append `--set global.customCA.enabled=true` to the Helm installation command
3. Click **DONE**

The cluster is displayed in the table with the status **Waiting to connect**. Once installation is complete, the cluster status changes to **Connected**.

!!! Tip
    Use the `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details, see see [Understanding cluster access roles.](https://docs.run.ai/v2.19/admin/config/access-roles/).


!!! Note
    To customize the installation based on your environment, see [Customize cluster installation](../../cluster-setup/customize-cluster-install.md).

## Troubleshooting

If you encounter an issue with the installation, try the troubleshooting scenario below.

### Installation

If the NVIDIA Run:ai cluster installation failed, check the installation logs to identify the issue. Run the following script to print the installation logs:

``` bash
curl -fsSL https://raw.githubusercontent.com/run-ai/public/main/installation/get-installation-logs.sh
```

### Cluster Status

If the NVIDIA Run:ai cluster installation completed, but the cluster status did not change its status to Connected, check the cluster [troubleshooting scenarios](../../troubleshooting/troubleshooting.md#cluster-health)

