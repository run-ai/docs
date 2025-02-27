---
title: Self Hosted installation over Kubernetes - Cluster Setup
---

# Install cluster

## System and network requirements <a href="#system-and-network-requirements" id="system-and-network-requirements"></a>

Before installing the Run:ai cluster, validate that the [system requirements](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-prerequisites/) and [network requirements](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/network-req/) are met.

Once all the requirements are met, it is highly recommend to use the Run:ai cluster preinstall diagnostics tool to:

* Test the below requirements in addition to failure points related to Kubernetes, NVIDIA, storage, and networking
* Look at additional components installed and analyze their relevance to a successful installation

For more information, see [preinstall diagnostics](https://github.com/run-ai/preinstall-diagnostics). To run the preinstall diagnostics tool, [download](https://runai.jfrog.io/ui/native/pd-cli-prod/preinstall-diagnostics-cli/) the latest version, and run:&#x20;

{% tabs %}
{% tab title="Connected" %}
```
chmod +x ./preinstall-diagnostics-<platform> && \ 
./preinstall-diagnostics-<platform> \
  --domain ${CONTROL_PLANE_FQDN} \
  --cluster-domain ${CLUSTER_FQDN} \
#if the diagnostics image is hosted in a private registry
  --image-pull-secret ${IMAGE_PULL_SECRET_NAME} \
  --image ${PRIVATE_REGISTRY_IMAGE_URL}    
```
{% endtab %}

{% tab title="Airgapped" %}
In an air-gapped deployment, the diagnostics image is saved, pushed, and pulled manually from the organization's registry.

```
#Save the image locally
docker save --output preinstall-diagnostics.tar gcr.io/run-ai-lab/preinstall-diagnostics:${VERSION}
#Load the image to the organization's registry
docker load --input preinstall-diagnostics.tar
docker tag gcr.io/run-ai-lab/preinstall-diagnostics:${VERSION} ${CLIENT_IMAGE_AND_TAG} 
docker push ${CLIENT_IMAGE_AND_TAG}
```

Run the binary with the `--image` parameter to modify the diagnostics image to be used:

```
chmod +x ./preinstall-diagnostics-darwin-arm64 && \
./preinstall-diagnostics-darwin-arm64 \
  --domain ${CONTROL_PLANE_FQDN} \
  --cluster-domain ${CLUSTER_FQDN} \
  --image-pull-secret ${IMAGE_PULL_SECRET_NAME} \
  --image ${PRIVATE_REGISTRY_IMAGE_URL}    
```
{% endtab %}
{% endtabs %}

## Helm

Run:ai requires [Helm](https://helm.sh/) 3.14 or later. To install Helm, see [Installing Helm](https://helm.sh/docs/intro/install/). If you are installing an air-gapped version of Run:ai, the Run:ai tar file contains the helm binary.

## Permissions[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#permissions) <a href="#permissions" id="permissions"></a>

A Kubernetes user with the `cluster-admin` role is required to ensure a successful installation, for more information see [Using RBAC authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

## Run:ai namespace[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#runai-namespace) <a href="#runai-namespace" id="runai-namespace"></a>

Run:ai cluster must be installed in a namespace named `runai`. Create the namespace by running:

```
kubectl create ns runai
```

## Create OpenShift Projects <a href="#create-openshift-projects" id="create-openshift-projects"></a>

Run:ai cluster installation uses several namespaces (or _projects_ in OpenShift terminology). Run the following:

```bash
oc new-project runaioc new-project runai-reservationoc new-project runai-scale-adjust
```

The last namespace (`runai-scale-adjust`) is only required if the cluster is a cloud cluster and is configured for auto-scaling.

## TLS certificates <a href="#tls-certificates" id="tls-certificates"></a>

TBD K8 only and only if installed on separate&#x20;

A TLS private and public keys are required for HTTP access to the cluster. Create a [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/) named `runai-cluster-domain-tls-secret` in the `runai` namespace with the cluster’s [Fully Qualified Domain Name (FQDN)](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-prerequisites/#domain-name-requirement) private and public keys, by running the following:

```
kubectl create secret tls runai-cluster-domain-tls-secret -n runai \    --cert /path/to/fullchain.pem  \ # Replace /path/to/fullchain.pem with the actual path to your TLS certificate    --key /path/to/private.pem # Replace /path/to/private.pem with the actual path to your private key
```

## Installation

### Kubernetes&#x20;

<details>

<summary>Connected</summary>

Follow the steps below to add a new cluster.

**Note:** When adding a cluster for the first time, the New Cluster form automatically opens when you log-in to the Run:ai platform. Other actions are prevented, until the cluster is created.

If this is your first cluster and you have completed the New Cluster form, start at step 3. Otherwise, start at step 1.

1. In the Run:ai platform, go to **Resources**
2. Click **+NEW CLUSTER**
3. Enter a unique name for your cluster
4. Optional: Chose the Run:ai cluster version (latest, by default)
5. Enter the Cluster URL . For more information see [Domain Name Requirement](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-prerequisites/#fully-qualified-domain-name-fqdn)
6. Click **Continue**

#### Installing Run:ai cluster[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#installing-runai-cluster) <a href="#installing-runai-cluster" id="installing-runai-cluster"></a>

In the next Section, the Run:ai cluster installation steps will be presented.

1. Follow the installation instructions and run the commands provided on your Kubernetes cluster.
2. Click **DONE**

The cluster is displayed in the table with the status **Waiting to connect**, once installation is complete, the cluster status changes to **Connected**

**Note:** To customize the installation based on your environment, see [Customize cluster installation](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/customize-cluster-install/).

**Tip:** Use the `--dry-run` flag to gain an understanding of what is being installed before the actual installation.

</details>

<details>

<summary>Airgapped</summary>

Follow the steps below to add a new cluster.

**Note:** When adding a cluster for the first time, the New Cluster form automatically opens when you log-in to the Run:ai platform. Other actions are prevented, until the cluster is created.

If this is your first cluster and you have completed the New Cluster form, start at step 3. Otherwise, start at step 1.

1. In the Run:ai platform, go to **Resources**
2. Click **+NEW CLUSTER**
3. Enter a unique name for your cluster
4. Optional: Chose the Run:ai cluster version (latest, by default)
5. Enter the Cluster URL . For more information see [Domain Name Requirement](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-prerequisites/#fully-qualified-domain-name-fqdn)
6. Click **Continue**

#### Installing Run:ai cluster[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#installing-runai-cluster) <a href="#installing-runai-cluster" id="installing-runai-cluster"></a>

In the next Section, the Run:ai cluster installation steps will be presented.

1. Follow the installation instructions and run the commands provided on your Kubernetes cluster.
2.  On the second tab of the cluster wizard, when copying the helm command for installation, you will need to use the pre-provided installation file instead of using helm repositories. As such:

    * Do not add the helm repository and do not run `helm repo update`.
    * Instead, edit the `helm upgrade` command.
      * Replace `runai/runai-cluster` with `runai-cluster-<version>.tgz`.
      * Add `--set global.image.registry=<Docker Registry address>` where the registry address is as entered in the preparation section

    The command should look like the following:

    ```bash
    helm upgrade -i runai-cluster runai-cluster-<version>.tgz \
        --set controlPlane.url=... \
        --set controlPlane.clientSecret=... \
        --set cluster.uid=... \
        --set cluster.url=... --create-namespace \
        --set global.image.registry=registry.mycompany.local 
    ```
3. Click **DONE**

The cluster is displayed in the table with the status **Waiting to connect**, once installation is complete, the cluster status changes to **Connected**

**Note:** To customize the installation based on your environment, see [Customize cluster installation](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/customize-cluster-install/).

**Tip:** Use the `--dry-run` flag to gain an understanding of what is being installed before the actual installation. For more details see [Understanding cluster access roles](../../config/access-roles.md). TBD

</details>

### OpenShift

<details>

<summary>Connected</summary>

When creating a new cluster, select the **OpenShift** target platform.

Follow the steps below to add a new cluster.

**Note:** When adding a cluster for the first time, the New Cluster form automatically opens when you log-in to the Run:ai platform. Other actions are prevented, until the cluster is created.

If this is your first cluster and you have completed the New Cluster form, start at step 3. Otherwise, start at step 1.

1. In the Run:ai platform, go to **Resources**
2. Click **+NEW CLUSTER**
3. Enter a unique name for your cluster
4. Optional: Chose the Run:ai cluster version (latest, by default)
5. Enter the Cluster URL . For more information see [Domain Name Requirement](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-prerequisites/#fully-qualified-domain-name-fqdn)
6. Click **Continue**

#### Installing Run:ai cluster[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#installing-runai-cluster) <a href="#installing-runai-cluster" id="installing-runai-cluster"></a>

In the next Section, the Run:ai cluster installation steps will be presented.

1. Follow the installation instructions and run the commands provided on your Kubernetes cluster.
2. Click **DONE**

The cluster is displayed in the table with the status **Waiting to connect**, once installation is complete, the cluster status changes to **Connected**

**Note:** To customize the installation based on your environment, see [Customize cluster installation](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/customize-cluster-install/).

**Note:** To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-cluster`. TBD

</details>

<details>

<summary>Airgapped</summary>

When creating a new cluster, select the **OpenShift** target platform.

Follow the steps below to add a new cluster.

**Note:** When adding a cluster for the first time, the New Cluster form automatically opens when you log-in to the Run:ai platform. Other actions are prevented, until the cluster is created.

If this is your first cluster and you have completed the New Cluster form, start at step 3. Otherwise, start at step 1.

1. In the Run:ai platform, go to **Resources**
2. Click **+NEW CLUSTER**
3. Enter a unique name for your cluster
4. Optional: Chose the Run:ai cluster version (latest, by default)
5. Enter the Cluster URL . For more information see [Domain Name Requirement](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-prerequisites/#fully-qualified-domain-name-fqdn)
6. Click **Continue**

#### Installing Run:ai cluster[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#installing-runai-cluster) <a href="#installing-runai-cluster" id="installing-runai-cluster"></a>

In the next Section, the Run:ai cluster installation steps will be presented.

1. Follow the installation instructions and run the commands provided on your Kubernetes cluster.
2.  On the second tab of the cluster wizard, when copying the helm command for installation, you will need to use the pre-provided installation file instead of using helm repositories. As such:

    * Do not add the helm repository and do not run `helm repo update`.
    * Instead, edit the `helm upgrade` command.
      * Replace `runai/runai-cluster` with `runai-cluster-<version>.tgz`.
      * Add `--set global.image.registry=<Docker Registry address>` where the registry address is as entered in the [preparation section](https://docs.run.ai/v2.20/admin/runai-setup/self-hosted/ocp/preparations/#software-artifacts)
      * Add `--set global.customCA.enabled=true` and perform the instructions for [local certificate authority](https://docs.run.ai/v2.20/admin/config/org-cert/).

    The command should look like the following:

    ```bash
    helm upgrade -i runai-cluster runai-cluster-<version>.tgz \
        --set controlPlane.url=... \
        --set controlPlane.clientSecret=... \
        --set cluster.uid=... \
        --set cluster.url=... --create-namespace \
        --set global.image.registry=registry.mycompany.local \
        --set global.customCA.enabled=true
    ```
3. Click **DONE**

The cluster is displayed in the table with the status **Waiting to connect**, once installation is complete, the cluster status changes to **Connected**

**Note:** To customize the installation based on your environment, see [Customize cluster installation](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/customize-cluster-install/).

**Note:** To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-cluster`.&#x20;



</details>

### (Optional) Customize Installation

To customize specific aspects of the cluster installation, see [customize cluster installation](https://app.gitbook.com/s/QtPkBj3GaBS74eJqoraO/saas-installation/installation/customized-installation).

### Troubleshooting[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#troubleshooting) <a href="#troubleshooting" id="troubleshooting"></a>

If you encounter an issue with the installation, try the troubleshooting scenario below.

#### Installation[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#installation_1) <a href="#installation_1" id="installation_1"></a>

If the Run:ai cluster installation failed, check the installation logs to identify the issue. Run the following script to print the installation logs:

```
curl -fsSL https://raw.githubusercontent.com/run-ai/public/main/installation/get-installation-logs.sh
```

#### Cluster status[¶](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-install/#cluster-status) <a href="#cluster-status" id="cluster-status"></a>

If the Run:ai cluster installation completed, but the cluster status did not change its status to Connected, check the cluster [troubleshooting scenarios](https://docs.run.ai/v2.20/admin/troubleshooting/troubleshooting/#cluster-health)

