# Install control plane

Before you start, make sure you have followed the control plane [system requirements ](prerequisites.md)and [preparations](preparations.md).

## Helm

Run:ai requires [Helm](https://helm.sh/) 3.14 or later. To install Helm, see [Installing Helm](https://helm.sh/docs/intro/install/). If you are installing an air-gapped version of Run:ai, the Run:ai tar file contains the helm binary.

## Permissions

As part of the installation, you will be required to install the [Run:ai Control Plane](backend.md) and [Cluster](cluster.md) Helm [Charts](https://helm.sh/). The Helm Charts require Kubernetes administrator permissions. You can review the exact permissions provided by using the `--dry-run` on both helm charts.

## Create OpenShift project <a href="#create-openshift-project" id="create-openshift-project"></a>

The Run:ai control plane uses a namespace (or _project_ in OpenShift terminology) name `runai-backend`. You must create it before installing:

```bash
oc new-project runai-backend
```

## TLS certificates <a href="#tls-certificates" id="tls-certificates"></a>

{% hint style="info" %}
TLS certificates apply for Kubernetes only.
{% endhint %}

A TLS private and public keys are required for HTTP access. Create a [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/) named `runai-backend-tls` in the `runai-backend` namespace with the [Fully Qualified Domain Name (FQDN)](https://docs.run.ai/v2.20/admin/runai-setup/cluster-setup/cluster-prerequisites/#domain-name-requirement) private key and cert, by running the following:

```bash
kubectl create secret tls runai-backend-tls -n runai-backend \
    --cert /path/to/fullchain.pem --key /path/to/private.pem
```

## Installation

### Kubernetes

<details>

<summary>Connected</summary>

Run the following command. The `global.domain=<DOMAIN>` should be the one obtained [here](preparations.md#domain-certificate):&#x20;

```bash
bash helm repo add runai-backend 
https://runai.jfrog.io/artifactory/cp-charts-prod helm repo update 
helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane --version "~2.20.0" \ --set global.domain=<DOMAIN>
```

**Note:** To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-backend`.

</details>

<details>

<summary>Airgapped</summary>

Run the following command. Replace the following:

1. `<VERSION>` with the Run:ai control plane version
2. Domain name described here
3. See the Local Certificate Authority instructions below&#x20;
4. `custom-env.yaml` should have been created by the _prepare installation_ script in the previous section

```bash
bash helm upgrade -i runai-backend control-plane-<VERSION>.tgz \ # (1) 
--set global.domain=<DOMAIN> \ # (2) --set global.customCA.enabled=true \ # (3) -n runai-backend -f custom-env.yaml # (4)
```

**Tip:** Use the `--dry-run` flag to gain an understanding of what is being installed before the actual installation.

</details>

### OpenShift

<details>

<summary>Connected</summary>

Run the following command. The `<OPENSHIFT-CLUSTER-DOMAIN>` is subdomain configured for the OpenShift cluster:&#x20;

```bash
helm repo add runai-backend https://runai.jfrog.io/artifactory/cp-charts-prod
helm repo update
helm upgrade -i runai-backend -n runai-backend runai-backend/control-plane --version "~2.20.0" \
    --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ 
    --set global.config.kubernetesDistribution=openshift
```

**Note:** To install a specific version, add `--version <version>` to the install command. You can find available versions by running `helm search repo -l runai-backend`.

**Tip:** Use the `--dry-run` flag to gain an understanding of what is being installed before the actual installation.

</details>

<details>

<summary>Airgapped</summary>

Run the following command. Replace the following:

1. `<VERSION>` with the Run:ai control plane version
2. The domain configured for the OpenShift cluster. To find out the OpenShift cluster domain, run `oc get routes -A`
3. See the Local Certificate Authority instructions below
4. `custom-env.yaml` should have been created by the _prepare installation_ script in the previous section

```bash
helm upgrade -i runai-backend  ./control-plane-<version>.tgz -n runai-backend \
    --set global.domain=runai.apps.<OPENSHIFT-CLUSTER-DOMAIN> \ 
    --set global.config.kubernetesDistribution=openshift \
    --set global.customCA.enabled=true \ 
    -f custom-env.yaml 
```

</details>

## Connect to Run:ai user interface

1. Open your browser and go to:

{% tabs %}
{% tab title="Kubernetes" %}
`https://<domain>`
{% endtab %}

{% tab title="OpenShift" %}
`https://runai.apps.<OpenShift domain>`
{% endtab %}
{% endtabs %}

2. Log in using the default credentials:&#x20;
   * User: `test@run.ai`
   * Password: `Abcd!234`
3.  Click the user icon, then select **Settings**

    &#x20;change the password TBD
