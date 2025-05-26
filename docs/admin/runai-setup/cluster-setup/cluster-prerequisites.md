The Run:ai Cluster is a Kubernetes application.

This article explains the required hardware and software system requirements for the Run:ai cluster.


Set out below are the system requirements for the Run:ai cluster.

## Hardware Requirements

The following hardware requirements are for the Kubernetes Cluster nodes’. By default, all Run:ai cluster services run on all available nodes. For production deployments, you may want to [Set Node Roles](../../config/node-roles.md), to separate between system and worker nodes, reduce downtime and save CPU cycles on expensive GPU Machines.

### Run:ai Cluster - system nodes

This configuration is the minimum requirement you need to install and use Run:ai Cluster.

| Component | Required Capacity |
| :---- | :---- |
| CPU | 10 cores |
| Memory | 20GB |
| Disk space | 50GB |

### Run:ai Cluster - Worker nodes

The Run:ai Cluster supports x86 and ARM (see the below note) CPUs, and NVIDIA GPUs from the T, V, A, L, H, B and GH architecture families. For the list of supported GPU models, see [Supported NVIDIA Data Center GPUs and Systems](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/platform-support.html#supported-nvidia-data-center-gpus-and-systems){target=_blank}.

!!! Note
    For ARM CPUs installation, contact Run:ai Support. 

The following configuration represents the minimum hardware requirements for installing and operating the Run:ai cluster on worker nodes. Each node must meet these specifications:

| Component | Required Capacity |
| :---- | :---- |
| CPU | 2 cores |
| Memory | 4GB |

### Shared storage

Run:ai workloads must be able to access data from any worker node in a uniform way, to access training data and code as well as save checkpoints, weights, and other machine-learning-related artifacts.

Typical protocols are Network File Storage (NFS) or Network-attached storage (NAS). Run:ai Cluster supports both, for more information see [Shared storage](../../config/shared-storage.md).

## Software requirements

The following software requirements must be fulfilled on the Kubernetes cluster.

### Operating system

* Any **Linux** operating system supported by both Kubernetes and NVIDIA GPU Operator  
* Run:ai cluster on Google Kubernetes Engine (GKE) supports both Ubuntu and Container Optimized OS (COS). COS is supported only with NVIDIA GPU Operator 24.6 or newer, and Run:ai cluster version 2.19 or newer.
Run:ai cluster on Oracle Kubernetes Engine (OKE) supports only Ubuntu.
* Internal tests are being performed on **Ubuntu 22.04** and **CoreOS** for OpenShift.

### Kubernetes distribution

Run:ai Cluster requires Kubernetes. The following Kubernetes distributions are supported:

* Vanilla Kubernetes  
* OpenShift Container Platform (OCP)  
* NVIDIA Base Command Manager (BCM)  
* Elastic Kubernetes Engine (EKS)  
* Google Kubernetes Engine (GKE)  
* Azure Kubernetes Service (AKS)
* Oracle Kubernetes Engine (OKE)
* Rancher Kubernetes Engine (RKE1)  
* Rancher Kubernetes Engine 2 (RKE2)

!!! Important
    The latest release of the Run:ai cluster supports **Kubernetes 1.29 to 1.32** and **OpenShift 4.14 to 4.17**

For existing Kubernetes clusters, see the following Kubernetes version support matrix for the latest Run:ai cluster releases:

| Run:ai version | Supported Kubernetes versions | Supported OpenShift versions |
| :---- | :---- | :---- |
| v2.13 | 1.23 to 1.28 | 4.10 to 4.13 |
| v2.16 | 1.26 to 1.28 | 4.11 to 4.14 |
| v2.17 | 1.27 to 1.29 | 4.12 to 4.15 |
| v2.18 | 1.28 to 1.30 | 4.12 to 4.16 |
| v2.19 | 1.28 to 1.31 | 4.12 to 4.17 |
| v2.20 (latest) | 1.29 to 1.32 | 4.14 to 4.17 |


For information on supported versions of managed Kubernetes, it's important to consult the release notes provided by your Kubernetes service provider. There, you can confirm the specific version of the underlying Kubernetes platform supported by the provider, ensuring compatibility with Run:ai. For an up-to-date end-of-life statement see [Kubernetes Release History](https://kubernetes.io/releases/){target=_blank} or [OpenShift Container Platform Life Cycle Policy](https://access.redhat.com/support/policy/updates/openshift){target=_blank}

### Container Runtime
Run:ai supports the following [container runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/){target=_blank}:

* [Containerd](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd){target=_blank}  (default in Kubernetes)
* [CRI-O](https://cri-o.io/){target=_blank} (default in OpenShift)

Ensure your Kubernetes cluster is configured with one of these runtimes.

### Kubernetes Pod Security Admission

Run:ai v2.15 and above supports `restricted` policy for [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){target=_blank} (PSA) on OpenShift only. Other Kubernetes distributions are only supported with `privileged` policy.

For Run:ai on OpenShift to run with PSA `restricted` policy:

* Label the `runai` namespace as described in [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){target=_blank} with the following labels:

```
pod-security.kubernetes.io/audit=privileged
pod-security.kubernetes.io/enforce=privileged
pod-security.kubernetes.io/warn=privileged
```

*  The workloads submitted through Run:ai should comply with the restrictions of PSA restricted policy, This can be enforced using Policies.

### Kubernetes Ingress Controller

Run:ai cluster requires [Kubernetes Ingress Controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/){target=_blank} to be installed on the Kubernetes cluster.

* OpenShift, RKE and RKE2 come pre-installed ingress controller.  
* Internal tests are being performed on NGINX, Rancher NGINX, OpenShift Router, and Istio.  
* Make sure that a default ingress controller is set.

There are many ways to install and configure different ingress controllers. A simple example to install and configure NGINX ingress controller using [helm](https://helm.sh/){target=_blank}:

=== "Vanilla Kubernetes"

    Run the following commands:

    ``` bash
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm upgrade -i nginx-ingress ingress-nginx/ingress-nginx \
        --namespace nginx-ingress --create-namespace \
        --set controller.kind=DaemonSet \
        --set controller.service.externalIPs="{<INTERNAL-IP>,<EXTERNAL-IP>}" # Replace <INTERNAL-IP> and <EXTERNAL-IP> with the internal and external IP addresses of one of the nodes
    ```

=== "Managed Kubernetes (EKS, GKE, AKS)"

    Run the following commands:

    ``` bash
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install nginx-ingress ingress-nginx/ingress-nginx \
        --namespace nginx-ingress --create-namespace
    ```

=== "Oracle Kubernetes Engine (OKE)"

    Run the following commands:

    ``` bash
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


### NVIDIA GPU Operator

Run:ai Cluster requires NVIDIA GPU Operator to be installed on the Kubernetes Cluster, supports version 22.9 to 25.3.

See the [Installing the NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html){target=_blank}, followed by notes below:

* Use the default `gpu-operator` namespace . Otherwise, you must specify the target namespace using the flag `runai-operator.config.nvidiaDcgmExporter.namespace` as described in customized cluster installation.  
* NVIDIA drivers may already be installed on the nodes. In such cases, use the NVIDIA GPU Operator flags `--set driver.enabled=false`. [DGX OS](https://docs.nvidia.com/dgx/dgx-os-6-user-guide/release_notes.html){target=_blank} is one such example as it comes bundled with NVIDIA Drivers.  
*   For distribution-specific additional instructions see below:

??? "OpenShift Container Platform (OCP)"
    The Node Feature Discovery (NFD) Operator is a prerequisite for the NVIDIA GPU Operator in OpenShift. Install the NFD Operator using the Red Hat OperatorHub catalog in the OpenShift Container Platform web console. For more information see [Installing the Node Feature Discovery (NFD) Operator](https://docs.nvidia.com/datacenter/cloud-native/openshift/latest/install-nfd.html){target=_blank}

??? "Elastic Kubernetes Service (EKS)"

    * When setting-up the cluster, do **not** install the NVIDIA device plug-in (we want the NVIDIA GPU Operator to install it instead).  
    * When using the [eksctl](https://eksctl.io/){target=_blank} tool to create a cluster, use the flag `--install-nvidia-plugin=false` to disable the installation.

    For GPU nodes, EKS uses an AMI which already contains the NVIDIA drivers. As such, you must use the GPU Operator flags: `--set driver.enabled=false`

??? "Google Kubernetes Engine (GKE)"

    Before installing the GPU Operator, create the `gpu-operator` namespace by running

    ```
    kubectl create ns gpu-operator
    ```

    create the following file:

    ``` yaml title="resourcequota.yaml"
    
    apiVersion: v1
    kind: ResourceQuota
    metadata:
    name: gcp-critical-pods
    namespace: gpu-operator
    spec:
    scopeSelector:
        matchExpressions:
        - operator: In
        scopeName: PriorityClass
        values:
        - system-node-critical
        - system-cluster-critical
    ```

    And then run:

    ```
    kubectl apply -f resourcequota.yaml
    ```

??? "Rancher Kubernetes Engine 2 (RKE2)"


    Make sure to specify the `CONTAINERD_CONFIG` option exactly as outlined in the [documentation](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html#rancher-kubernetes-engine-2) and [custom configuration guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/install-gpu-operator.html#custom-configuration-for-runtime-containerd), using the path `/var/lib/rancher/rke2/agent/etc/containerd/config.toml.tmpl`. **Do not create the file manually** if it does not already exist. The GPU Operator will handle this configuration during deployment.

??? "Oracle Kubernetes Engine (OKE)"

    * During cluster setup, [create a nodepool](https://docs.oracle.com/en-us/iaas/tools/python/latest/api/container_engine/models/oci.container_engine.models.NodePool.html#oci.container_engine.models.NodePool.initial_node_labels){target=_blank}, and set `initial_node_labels` to include `oci.oraclecloud.com/disable-gpu-device-plugin=true` which disables the NVIDIA GPU device plugin.
    * For GPU nodes, OKE defaults to Oracle Linux, which is incompatible with NVIDIA drivers. To resolve this, use a custom Ubuntu image instead.

For troubleshooting information, see the [NVIDIA GPU Operator Troubleshooting Guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/troubleshooting.html){target=_blank}.

### Prometheus

Run:ai Cluster requires Prometheus to be installed on the Kubernetes cluster.

* OpenShift comes pre-installed with prometheus  
* For RKE2 see [Enable Monitoring](https://ranchermanager.docs.rancher.com/how-to-guides/advanced-user-guides/monitoring-alerting-guides/enable-monitoring){target=_blank} instructions to install Prometheus

There are many ways to install Prometheus. A simple example to install the community [Kube-Prometheus Stack](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack){target=_blank} using [helm](https://helm.sh/){target=_blank}, run the following commands:

``` bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack \
    -n monitoring --create-namespace --set grafana.enabled=false
```

## Optional software requirements

Optional Run:ai capabilities, Distributed Training and Inference require additional Kubernetes applications (frameworks) to be installed on the cluster.

### Distributed training

Distributed training enables training of AI models over multiple nodes. This requires installing a distributed training framework on the cluster. The following frameworks are supported:

* [TensorFlow](https://www.tensorflow.org/){target=_blank}  
* [PyTorch](https://pytorch.org/){target=_blank}  
* [XGBoost](https://xgboost.readthedocs.io/){target=_blank}  
* [MPI v2](https://docs.open-mpi.org/){target=_blank}

There are several ways to install each framework. A simple method of installation example is the [Kubeflow Training Operator](https://www.kubeflow.org/docs/components/training/installation/){target=_blank} which includes TensorFlow, PyTorch, and XGBoost.

It is recommended to use **Kubeflow Training Operator v1.8.1**, and **MPI Operator v0.6.0 or later** for compatibility with advanced workload capabilities, such as [Stopping a workload](../../../platform-admin/workloads/overviews/managing-workloads.md#stopping-a-workload) and [Scheduling rules](../../../platform-admin/aiinitiatives/org/scheduling-rules.md).

* To install the Kubeflow Training Operator for TensorFlow, PyTorch and XGBoost frameworks, run the following command:

``` bash
kubectl apply -k "github.com/kubeflow/training-operator.git/manifests/overlays/standalone?ref=v1.8.1"
```

* To install the MPI Operator for MPI v2, run the following command:

``` bash
kubectl apply --server-side -f https://raw.githubusercontent.com/kubeflow/mpi-operator/v0.6.0/deploy/v2beta1/mpi-operator.yaml
```
!!! Note

    If you require both the MPI Operator and Kubeflow Training Operator, follow the steps below:

    * Install the Kubeflow Training Operator as described above.  
    * Disable and delete MPI v1 in the Kubeflow Training Operator by running:

    ``` bash
    kubectl patch deployment training-operator -n kubeflow --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args", "value": ["--enable-scheme=tfjob", "--enable-scheme=pytorchjob", "--enable-scheme=xgboostjob"]}]'
    kubectl delete crd mpijobs.kubeflow.org
    ```

    * Install the MPI Operator as described above.

### Inference

Inference enables serving of AI models. This requires the [Knative Serving](https://knative.dev/docs/serving/){target=_blank} framework to be installed on the cluster and supports Knative versions 1.11 to 1.16.

Follow the [Installing Knative](https://knative.dev/docs/install/){target=_blank} instructions. After installation, configure Knative to use the Run:ai scheduler and features, by running:

```
kubectl patch configmap/config-autoscaler \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"enable-scale-to-zero":"true"}}' && \
kubectl patch configmap/config-features \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"kubernetes.podspec-schedulername":"enabled","kubernetes.podspec-nodeselector": "enabled", 
  "kubernetes.podspec-affinity":"enabled","kubernetes.podspec-tolerations":"enabled","kubernetes.podspec-volumes-emptydir":"enabled","kubernetes.podspec-securitycontext":"enabled","kubernetes.containerspec-addcapabilities":"enabled","kubernetes.podspec-persistent-volume-claim":"enabled","kubernetes.podspec-persistent-volume-write":"enabled","multi-container":"enabled","kubernetes.podspec-init-containers":"enabled"}}'
```

### Knative Autoscaling

Run:ai allows for autoscaling a deployment according to the below metrics:

* Latency (milliseconds)
* Throughput (requests/sec)
* Concurrency (requests)

Using a custom metric (for example, Latency) requires installing the [Kubernetes Horizontal Pod Autoscaler (HPA)](https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/#install-optional-serving-extensions){target=_blank}. Use the following command to install. Make sure to update the VERSION in the below command with a [supported Knative version](#inference).

```
kubectl apply -f https://github.com/knative/serving/releases/download/knative-{VERSION}/serving-hpa.yaml
```

## Domain Name Requirement
The following requirement must be followed for naming the domain.

### Fully Qualified Domain Name (FQDN)

You must have a Fully Qualified Domain Name (FQDN) to install Run:ai Cluster (ex: `runai.mycorp.local`). This cannot be an IP. The domain name must be accessible inside the organization only. You also need a TLS certificate (private and public) for HTTPS access.

