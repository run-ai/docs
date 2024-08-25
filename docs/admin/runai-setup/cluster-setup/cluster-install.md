

This article explains the steps required to install the Run:ai cluster on a Kubernetes cluster using Helm.

## Before Installation

There are a number of matters to consider prior to installing using Helm.

### System and Network Requirements

Before installing the Run:ai cluster, validate that the [system requirements](cluster-prerequisites.md) and [network requirements](network-req.md) are met.

Once all the requirements are met, it is highly recommend to use the Run:ai cluster preinstall diagnostics tool to:

* Test the below requirements in addition to failure points related to Kubernetes, NVIDIA, storage, and networking  
* Look at additional components installed and analyze their relevance to a successful installation

To run the preinstall diagnostics tool, [download](https://github.com/run-ai/preinstall-diagnostics/releases) the latest version, and run:


``` bash
chmod +x ./preinstall-diagnostics-darwin-arm64 && \
  ./preinstall-diagnostics-darwin-arm64 \
      --domain ${company-name}.run.ai \
      --cluster-domain ${CLUSTER_FQDN}
```

For more information see [preinstall diagnostics](https://github.com/run-ai/preinstall-diagnostics).

### Helm

Run:ai cluster requires Helm 3.14 or above. To install Helm, see [Helm Install](https://helm.sh/docs/helm/helm\_install/).

### Permissions

A Kubernetes user with the `cluster-admin` role is required to ensure a successful installation, for more information see [Using RBAC authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

### Run:ai namespace

Run:ai cluster must be installed in a namespace named `runai`. Create the namespace by running:


``` bash
kubectl create ns runai
```

### TLS Certificates

A TLS private and public keys are required for HTTP access to the cluster. Create a [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/) named `runai-cluster-domain-tls-secret` in the `runai` namespace with the cluster’s [Fully Qualified Domain Name (FQDN)](cluster-prerequisites.md#domain-name-requirement) private and public keys, by running the following:


``` bash
kubectl create secret tls runai-cluster-domain-tls-secret -n runai \
    --cert /path/to/fullchain.pem  \ # Replace /path/to/fullchain.pem with the actual path to your TLS certificate
    --key /path/to/private.pem # Replace /path/to/private.pem with the actual path to your private key
```

## Installation

Follow these instructions to install using Helm.

### Adding a new cluster

Follow the steps below to add a new cluster.

!!! Note
    When adding a cluster for the first time, the New Cluster form automatically opens when you log-in to the Run:ai platform. Other actions are prevented, until the cluster is created.

If this is your first cluster and you have completed the New Cluster form, start at step 3\. Otherwise, start at step 1\.

1. In the Run:ai platform, go to __Clusters__  
2. Click __+NEW CLUSTER__  
3. Enter a unique name for your cluster  
4. Optional: Chose the Run:ai cluster version (latest, by default)  
5. Enter the Cluster URL . For more information see [Domain Name Requirement](cluster-prerequisites.md#fully-qualified-domain-name-fqdn) 
6. Click __Continue__

### Installing Run:ai cluster

In the next Section, the Run:ai cluster installation steps will be presented.

1. Follow the installation instructions and run the commands provided on your Kubernetes cluster.  
2. Click __DONE__

The cluster is displayed in the table with the status __Waiting to connect__, once installation is complete, the cluster status changes to __Connected__

!!! Note
    To customize the installation based on your environment, see [Customize cluster installation](../../admin/runai-setup/cluster-setup/customize-cluster-install.md).

## Troubleshooting

If you encounter an issue with the installation, try the troubleshooting scenario below.

### Installation

If the Run:ai cluster installation failed, check the installation logs to identify the issue. Run the following script to print the installation logs:

``` bash
curl -fsSL https://raw.githubusercontent.com/run-ai/public/main/installation/get-installation-logs.sh
```

### Cluster status

If the Run:ai cluster installation completed, but the cluster status did not change its status to Connected, check the cluster [troubleshooting scenarios](../../troubleshooting/troubleshooting.md#cluster-health)

