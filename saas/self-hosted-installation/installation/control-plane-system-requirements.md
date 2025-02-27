# Control plane system requirements

The Run:ai control plane is a Kubernetes application.

This article explains the required hardware and software system requirements for the Run:ai control plane.

Before you start, make sure to review the [Installation overview](./).

## Installer machine

The machine running the installation script (typically the Kubernetes master) must have:

* At least 50GB of free space
* Docker installed

## Hardware requirements

The following hardware requirements are for the control plane system nodes. By default, all Run:ai control plane services run on all available nodes.

### Run:ai control plane - System nodes

This configuration is the minimum requirement you need to install and use Run:ai control plane:

| Component  | Required Capacity |
| ---------- | ----------------- |
| CPU        | 10 cores          |
| Memory     | 12GB              |
| Disk space | 110GB             |

You can **optionally** set the Run:ai control plane to run on specific nodes. Kubernetes will attempt to schedule Run:ai pods to these nodes. If lacking resources, the Run:ai nodes will move to another, non-labeled node.

To set system nodes run:

```bash
kubectl label node <NODE-NAME> node-role.kubernetes.io/runai-system=true
```

{% hint style="warning" %}
## Important

Do not select the Kubernetes master as a `runai-system` node. This may cause Kubernetes to stop working (specifically if Kubernetes API Server is configured on 443 instead of the default 6443).
{% endhint %}

#### ARM Limitation

{% hint style="info" %}
## Note

This applies for Kubernetes only. ARM is currently not supported on OpenShift.
{% endhint %}

The control plane does not support CPU nodes with ARM64k architecture. To schedule the Run:ai control plane services on supported nodes, use the `global.affinity` configuration parameter as detailed in [Additional Run:ai configurations](backend.md#additional-runai-configurations-optional).

## Software requirements

The following software requirements must be fulfilled on the Kubernetes cluster.

### Operating system

* Any **Linux** operating system supported by both Kubernetes and NVIDIA GPU Operator
* Run:ai cluster on Google Kubernetes Engine (GKE) supports both Ubuntu and Container Optimized OS (COS). COS is supported only with NVIDIA GPU Operator 24.6 or newer, and Run:ai cluster version 2.19 or newer.
* Internal tests are being performed on **Ubuntu 22.04** and **CoreOS** for OpenShift.

### Network time protocol

Nodes are required to be synchronized by time using NTP (Network Time Protocol) for proper system functionality.

### Kubernetes distribution

Run:ai control plane requires Kubernetes. The following Kubernetes distributions are supported:

* Vanilla Kubernetes
* OpenShift Container Platform (OCP)
* NVIDIA Base Command Manager (BCM)
* Elastic Kubernetes Engine (EKS)
* Google Kubernetes Engine (GKE)
* Azure Kubernetes Service (AKS)
* Oracle Kubernetes Engine (OKE)
* Rancher Kubernetes Engine (RKE1)
* Rancher Kubernetes Engine 2 (RKE2)

{% hint style="info" %}
## Note

The latest release of the Run:ai control plane supports **Kubernetes 1.29 to 1.32** and **OpenShift 4.14 to 4.17**
{% endhint %}

For existing Kubernetes control plane, see the following Kubernetes version support matrix for the latest Run:ai releases:

| Run:ai version | Supported Kubernetes versions | Supported OpenShift versions |
| -------------- | ----------------------------- | ---------------------------- |
| v2.16          | 1.26 to 1.28                  | 4.11 to 4.14                 |
| v2.17          | 1.27 to 1.29                  | 4.12 to 4.15                 |
| v2.18          | 1.28 to 1.30                  | 4.12 to 4.16                 |
| v2.19          | 1.28 to 1.31                  | 4.12 to 4.17                 |
| v2.20(latest)  | 1.29 to 1.32                  | 4.14 to 4.17                 |

For information on supported versions of managed Kubernetes, it's important to consult the release notes provided by your Kubernetes service provider. There, you can confirm the specific version of the underlying Kubernetes platform supported by the provider, ensuring compatibility with Run:ai. For an up-to-date end-of-life statement see [Kubernetes Release History](https://kubernetes.io/releases/) or [OpenShift Container Platform Life Cycle Policy](https://access.redhat.com/support/policy/updates/openshift).

### Default storage class

{% hint style="info" %}
## Note

Default storage class applies for Kubernetes only.
{% endhint %}

The Run:ai control plane requires a **default storage class** to create persistent volume claims for Run:ai storage. The storage class, as per Kubernetes standards, controls the reclaim behavior, whether the Run:ai persistent data is saved or deleted when the Run:ai control plane is deleted.

{% hint style="info" %}
For a simple (non-production) storage class example see [Kubernetes Local Storage Class](https://kubernetes.io/docs/concepts/storage/storage-classes/#local). The storage class will set the directory `/opt/local-path-provisioner` to be used across all nodes as the path for provisioning persistent volumes. Then set the new storage class as default:

```bash
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```
{% endhint %}

### Kubernetes ingress controller

{% hint style="info" %}
## Note

Installing ingress controller applies for Kubernetes only.
{% endhint %}

The Run:ai control plane requires [Kubernetes Ingress Controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) to be installed.

* OpenShift, RKE and RKE2 come pre-installed ingress controller.
* Internal tests are being performed on NGINX, Rancher NGINX, OpenShift Router, and Istio.
* Make sure that a default ingress controller is set.

There are many ways to install and configure different ingress controllers. A simple example to install and configure NGINX ingress controller using [helm](https://helm.sh/):

<details>

<summary>Vanilla Kubernetes</summary>

Run the following commands:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade -i nginx-ingress ingress-nginx/ingress-nginx \
    --namespace nginx-ingress --create-namespace \
    --set controller.kind=DaemonSet \
    --set controller.service.externalIPs="{<INTERNAL-IP>,<EXTERNAL-IP>}" # Replace <INTERNAL-IP> and <EXTERNAL-IP> with the internal and external IP addresses of one of the nodes
```

</details>

<details>

<summary>Managed Kubernetes (EKS, GKE, AKS)</summary>

Run the following commands:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace nginx-ingress --create-namespace
```

</details>

<details>

<summary>Oracle Kubernetes Engine (OKE)</summary>

Run the following commands:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace ingress-nginx --create-namespace \
    --set controller.service.annotations.oci.oraclecloud.com/load-balancer-type=nlb \
    --set controller.service.annotations.oci-network-load-balancer.oraclecloud.com/is-preserve-source=True \
    --set controller.service.annotations.oci-network-load-balancer.oraclecloud.com/security-list-management-mode=None \
    --set controller.service.externalTrafficPolicy=Local \
    --set controller.service.annotations.oci-network-load-balancer.oraclecloud.com/subnet=<SUBNET-ID> # Replace <SUBNET-ID> with the subnet ID of one of your cluster
```

</details>

### Fully Qualified Domain Name (FQDN)

#### Kubernetes

You must have a Fully Qualified Domain Name (FQDN) to install Run:ai control plane (ex: `runai.mycorp.local`). This cannot be an IP. The domain name must be accessible inside the organization only. You also need a TLS certificate (private and public) for HTTPS access.

#### OpenShift

OpenShift must be configured with a trusted certificate. Run:ai installation relies on OpenShift to create certificates for subdomains.

#### Local certificate authority (air-gapped only)

In air-gapped environments, you must prepare the public key of your local certificate authority as described [here.](https://docs.run.ai/latest/admin/config/org-cert/) It will need to be installed in Kubernetes for the installation to succeed.

### External Postgres database (optional)

The Run:ai control plane installation includes a default PostgreSQL database. However, you may opt to use an existing PostgreSQL database if you have specific requirements or preferences. Please ensure that your PostgreSQL database is version 16 or higher.
