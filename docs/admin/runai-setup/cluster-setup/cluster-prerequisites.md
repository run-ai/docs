Below are the prerequisites of a cluster installed with Run:ai.

## Prerequisites in a Nutshell

The following is a checklist of the Run:ai prerequisites:

| Prerequisite | Details |
|--------------|---------|
| [Kubernetes](#kubernetes)          | Verify certified vendor and correct version. |
| [NVIDIA GPU Operator](#nvidia)     | Different Kubernetes flavors have slightly different setup instructions.  <br> Verify correct version. |
| [Ingress Controller](#ingress-controller) | Install and configure NGINX (some Kubernetes flavors have NGINX pre-installed). |
| [Prometheus](#prometheus) | Install Prometheus. |
| [Trusted domain name](#cluster-url) | You must provide a trusted domain name. Accessible only inside the organization |
| (Optional) [Distributed Training](#distributed-training) | Install Kubeflow Training Operator if required. |
| (Optional) [Inference](#inference) | Some third party software needs to be installed to use the Run:ai inference module. |

There are also specific [hardware](#hardware-requirements), [operating system](#operating-system) and [network access](#network-access-requirements) requirements. A [pre-install](#pre-install-script) script is available to test if the prerequisites are met before installation.


## Software Requirements

### Operating System

* Run:ai will work on any __Linux__ operating system that is supported by __both__ Kubernetes and [NVIDIA](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html){target=_blank}.
* An important highlight is that GKE (Google Kubernetes Engine) will only work with Ubuntu, as NVIDIA [does not support](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/google-gke.html#about-using-the-operator-with-google-gke) the default _Container-Optimized OS with Containerd_ image.
* Run:ai performs its internal tests on Ubuntu 20.04 and CoreOS for OpenShift.

### Kubernetes

Run:ai requires Kubernetes. Run:ai is been certified with the following Kubernetes distributions:

| Kubernetes Distribution           | Description | Installation Notes |
|-----------------------------------|-------------|--------------------|
| Vanilla Kubernetes                       |  Using no specific distribution but rather k8s native installation  |  See instructions for a simple (non-production-ready) [Kubernetes Installation](install-k8s.md) script. |
| OCP | OpenShift Container Platform       |   The Run:ai operator is [certified](https://catalog.redhat.com/software/operators/detail/60be3acc3308418324b5e9d8){target=_blank} for OpenShift by Red Hat. |
| EKS | Amazon Elastic Kubernetes Service  |  |
| AKS | Azure Kubernetes Services          |   |
| GKE | Google Kubernetes Engine           |  |
| RKE | Rancher Kubernetes Engine          | When installing Run:ai, select _On Premise_  |
| Bright  | [NVIDIA Bright Cluster Manager](https://www.nvidia.com/en-us/data-center/bright-cluster-manager/){target=_blank}     | In addition, NVIDIA DGX comes [bundled](dgx-bundle.md) with Run:ai  |

Run:ai has been tested with the following Kubernetes distributions. Please contact Run:ai Customer Support for up to date certification details:

| Kubernetes Distribution           | Description | Installation Notes |
|-----------------------------------|-------------|--------------------|
| Ezmeral | HPE Ezmeral Container Platform | See Run:ai at [Ezmeral marketplace](https://www.hpe.com/us/en/software/marketplace/runai.html){target=_blank}  |
| Tanzu | VMWare Kubernetes | Tanzu supports _containerd_ rather than _docker_. See the NVIDIA prerequisites below as well as [cluster customization](customize-cluster-install.md) for changes required for containerd |

Following is a Kubernetes support matrix for the latest Run:ai releases:

| Run:ai version | Supported Kubernetes versions | Supported OpenShift versions |
|----------------|-------------------------------|--------|
| Run:ai 2.9     | 1.21 through 1.26 | 4.8 through 4.11 |
| Run:ai 2.10    | 1.21 through 1.26 (see note below) | 4.8 through 4.11 |
| Run:ai 2.12    | 1.23 through 1.27 (see note below) | 4.10 through 4.12 |
| Run:ai 2.13    | 1.23 through 1.27 (see note below) | 4.10 through 4.13 |

!!! Note
    Run:ai allows scheduling of Jobs with PVCs. See for example the command-line interface flag [--pvc-new](../../../Researcher/cli-reference/runai-submit/#-pvc-new-string). A Job scheduled with a PVC based on a specific type of storage class (a storage class with the property `volumeBindingMode` equals to `WaitForFirstConsumer`) will [not work](https://kubernetes.io/docs/concepts/storage/storage-capacity/){target=_blank} on Kubernetes 1.23 or lower.


For an up-to-date end-of-life statement of Kubernetes see [Kubernetes Release History](https://kubernetes.io/releases/){target=_blank}.

Support for [Pod Security Policy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} has been removed with Run:ai 2.9.

Run:ai does not currently support [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){target=_blank}. When PSA is installed, all Run:ai namespaces as well as project namespaces must be marked as `Privilidged`.

### NVIDIA

Run:ai has been certified on __NVIDIA GPU Operator__  22.9 to 23.3. Older versions (1.10 and 1.11) have a documented [NVIDIA issue](https://github.com/NVIDIA/gpu-feature-discovery/issues/26){target=_blank}.

Follow the [Getting Started guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#install-nvidia-gpu-operator){target=blank} to install the NVIDIA GPU Operator, or see the distribution-specific instructions below:

=== "EKS"

    * When setting up EKS, do not install the NVIDIA device plug-in  (as we want the NVIDIA GPU Operator to install it instead). When using the [eksctl](https://eksctl.io/){target=_blank} tool to create an AWS EKS cluster, use the flag `--install-nvidia-plugin=false` to disable this install.
    * Follow the [Getting Started guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#install-nvidia-gpu-operator){target=blank} to install the NVIDIA GPU Operator. For GPU nodes, EKS uses an AMI which already contains the NVIDIA drivers. As such, you must use the GPU Operator flags: `--set driver.enabled=false`.

=== "GKE"

    Create the `gpu-operator` namespace by running

    ``` bash
    kubectl create ns gpu-operator
    ```

    Before installing the GPU Operator you must create the following file:

    ``` YAML title="resourcequota.yaml"
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

    Then run: `kubectl apply -f resourcequota.yaml`

    !!! Important
        * Run:ai on GKE has only been tested with GPU Operator version 22.9 and up.
        * The above only works for Run:ai 2.7.16 and above. 
<!-- 
=== "RKE2"
    Install the NVIDIA GPU Operator as discussed [here](https://thenewstack.io/install-a-nvidia-gpu-operator-on-rke2-kubernetes-cluster/){target=_blank}.
-->

!!! Notes
    * Use the default namespace `gpu-operator`. Otherwise, you must specify the target namespace using the flag `runai-operator.config.nvidiaDcgmExporter.namespace` as described in [customized cluster installation](customize-cluster-install.md).
    * NVIDIA drivers may already be installed on the nodes. In such cases, use the NVIDIA GPU Operator flags `--set driver.enabled=false`. [DGX OS](https://docs.nvidia.com/dgx/index.html){target=_blank} is one such example as it comes bundled with NVIDIA Drivers.
    <!-- * To work with _containerd_ (e.g. for Tanzu), use the [defaultRuntime](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#chart-customization-options){target=_blank} flag accordingly. -->
    * To use [Dynamic MIG](../../../Researcher/scheduling/fractions.md#dynamic-mig), the GPU Operator must be installed with the flag `mig.strategy=mixed`. If the GPU Operator is already installed, edit the clusterPolicy by running ```kubectl patch clusterPolicy cluster-policy -n gpu-operator --type=merge -p '{"spec":{"mig":{"strategy": "mixed"}}}```


### Ingress Controller

Run:ai requires an ingress controller as a prerequisite. The Run:ai cluster installation configures one or more ingress objects on top of the controller.

There are many ways to install and configure an ingress controller and configuration is environment-dependent. A simple solution is to install & configure _NGINX_:

=== "On Prem"

    ``` bash
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm upgrade -i nginx-ingress ingress-nginx/ingress-nginx   \
        --namespace nginx-ingress --create-namespace \
        --set controller.kind=DaemonSet \
        --set controller.service.externalIPs="{<INTERNAL-IP>,<EXTERNAL-IP>}" # (1)
    ```

    1. External and internal IP of one of the nodes

=== "RKE"
    RKE and RKE2 come pre-installed with NGINX. No further action needs to be taken.


=== "Managed Kubernetes"
    For managed Kubernetes such as EKS:

    ``` bash
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install nginx-ingress ingress-nginx/ingress-nginx \
        --namespace nginx-ingress --create-namespace 
    ```

For support of ingress controllers different than NGINX please contact Run:ai customer support.

!!! Note
    In a self-hosted installation, the typical scenario is to install the first Run:ai cluster on the same Kubernetes cluster as the control plane. In this case, there is no need to install an ingress controller as it is pre-installed by the control plane.
### Cluster URL
<!-- the following anchors are added for backward compatibility for what's new of 2.8  -->
<h3 id="cluster-ip"></h3>
<h3 id="domain-name"></h3>

The Run:ai cluster creation wizard requires a domain name (FQDN) to the Kubernetes cluster as well as a __trusted__ certificate for that domain. The domain name needs to be accessible inside the organization only.

Use an HTTPS-based domain (e.g. [https://my-cluster.com](https://my-cluster.com)) as the cluster URL. Make sure that the DNS is configured with the cluster IP.

In addition, to configure HTTPS for your URL, you must create a TLS secret named `runai-cluster-domain-tls-secret` in the `runai` namespace. The secret should contain a trusted certificate for the domain:

``` bash
kubectl create ns runai
kubectl create secret tls runai-cluster-domain-tls-secret -n runai \
    --cert /path/to/fullchain.pem  \ # (1)
    --key /path/to/private.pem # (2)
```

1. The domain's cert (public key).
2. The domain's private key.

For more information on how to create a TLS secret see: [https://kubernetes.io/docs/concepts/configuration/secret/#tls-secrets](https://kubernetes.io/docs/concepts/configuration/secret/#tls-secrets){target=_blank}.

!!! Note
    In a self-hosted installation, the typical scenario is to install the first Run:ai cluster on the same Kubernetes cluster as the control plane. In this case, the cluster URL need not be provided as it will be the same as the control-plane URL.


### Prometheus

If not already installed on your cluster, install the full `kube-prometheus-stack` through the [Prometheus community Operator](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack){target=_blank}.

!!! Note
    * If Prometheus has been installed on the cluster in the past, even if it was uninstalled (such as when upgrading from Run:ai 2.8 or lower), you will need to update Prometheus CRDs as described [here](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack#upgrading-chart){target=_blank}. For more information on the  Prometheus bug see [here](https://github.com/prometheus-community/helm-charts/issues/2753){target=_blank}.
    * If you are running Kubernetes 1.21, you must install a Prometheus stack version of 45.23.0 or lower. Use the `--version` flag below. Alternatively, use Helm version 3.12 or later. For more information on the related Prometheus bug see [here](https://github.com/prometheus-community/helm-charts/issues/3436){target=_blank}

Then install the Prometheus stack by running:

``` bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack \
    -n monitoring --create-namespace --set grafana.enabled=false # (1)
```

1. The Grafana component is not required for Run:ai.

## Optional Software Requirements

The following software enables specific features of Run:ai
### Distributed Training

Run:ai supports three different methods to distributed-training jobs across multiple nodes:

* MPI
* TensorFlow
* PyTorch

To install all three, run the following:

```
kubectl apply -k "github.com/kubeflow/training-operator/manifests/overlays/standalone?ref=v1.5.0"
```

### Inference

To use the Run:ai inference module you must pre-install [Knative Serving](https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/){target=_blank}. Follow the instructions [here](https://knative.dev/docs/install/){target=_blank} to install. Run:ai is certified on Knative 1.4 to 1.8 with Kubernetes 1.22 or later.  

Post-install, you must configure Knative to use the Run:ai scheduler and allow pod affinity, by running:

```
kubectl patch configmap/config-features \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"kubernetes.podspec-schedulername":"enabled","kubernetes.podspec-affinity":"enabled","kubernetes.podspec-tolerations":"enabled","kubernetes.podspec-volumes-emptydir":"enabled","kubernetes.podspec-securitycontext":"enabled"}}'
```

#### Inference Autoscaling
Run:ai allows to autoscale a deployment according to various metrics:

1. GPU Utilization (%)
2. CPU Utilization (%)
3. Latency (milliseconds)
4. Throughput (requests/second)
5. Concurrency
6. Any custom metric

Additional installation may be needed for some of the metrics as follows:

* Using _Throughput_ or _Concurrency_ does not require any additional installation.
* Any other metric will require installing the [HPA Autoscaler](https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/#install-optional-serving-extensions){target=_blank}.
* Using _GPU Utilization_, _Latency_ or _Custom metric_ will __also__ require the Prometheus adapter. The Prometheus adapter is part of the Run:ai installer and can be added by setting the `prometheus-adapter.enabled` flag to `true`. See [Customizing the Run:ai installation](./customize-cluster-install.md) for further information.

If you wish to use an _existing_ Prometheus adapter installation, you will need to configure it manually with the Run:ai Prometheus rules, specified in the Run:ai chart values under `prometheus-adapter.rules` field. For further information please contact Run:ai customer support.


####  Accessing Inference from outside the Cluster

Inference workloads will typically be accessed by consumers residing outside the cluster. You will hence want to provide consumers with a URL to access the workload. The URL can be found in the Run:ai user interface under the deployment screen (alternatively, run `kubectl get ksvc -n <project-namespace>`).

However, for the URL to be accessible outside the cluster you must configure your DNS as described [here](https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/#configure-dns){target=_blank}.

??? "Alternative Configuration"
    When the above DNS configuration is not possible, you can manually add the `Host` header to the REST request as follows:

    * Get an `<external-ip>` by running `kubectl get service -n kourier-system kourier`. If you have been using _istio_ during Run:ai installation, run:  `kubectl -n istio-system get service istio-ingressgateway` instead. 
    * Send a request to your workload by using the external ip, and place the workload url as a `Host` header. For example

    ```
    curl http://<external-ip>/<container-specific-path>
        -H 'Host: <host-name>'
    ```

## Hardware Requirements

(see picture below)

*   (Production only) __Run:ai System Nodes__: To reduce downtime and save CPU cycles on expensive GPU Machines, we recommend that production deployments will contain __two or more__ worker machines, designated for Run:ai Software. The nodes do not have to be dedicated to Run:ai, but for Run:ai purposes we would need:

    *   8 CPUs
    *   16GB of RAM
    *   50GB of Disk space  

*   __Shared data volume:__ Run:ai uses Kubernetes to abstract away the machine on which a container is running:

    * Researcher containers: The Researcher's containers need to be able to access data from any machine in a uniform way, to access training data and code as well as save checkpoints, weights, and other machine-learning-related artifacts.
    * The Run:ai system needs to save data on a storage device that is not dependent on a specific node.  

    Typically, this is achieved via Kubernetes Storage class  based on Network File Storage (NFS) or Network-attached storage (NAS).

* __Docker Registry:__ With Run:ai, Workloads are based on Docker images. For container images to run on any machine, these images must be downloaded from a docker registry rather than reside on the local machine (though this also is [possible](../../../researcher-setup/docker-to-runai/#image-repository)). You can use a public registry such as [docker hub](https://hub.docker.com/){target=_blank} or set up a local registry on-prem (preferably on a dedicated machine). Run:ai can assist with setting up the repository.

*  __Kubernetes:__ Production Kubernetes installation requires separate nodes for the Kubernetes master. For more details see your specific Kubernetes distribution documentation.

![img/prerequisites.png](img/prerequisites.jpg)

## User requirements

__Usage of containers and images:__ The individual Researcher's work must be based on [container](https://www.docker.com/resources/what-container){target=_blank} images.

## Network Access Requirements

__Internal networking:__ Kubernetes networking is an add-on rather than a core part of Kubernetes. Different add-ons have different network requirements. You should consult the documentation of the specific add-on on which ports to open. It is however important to note that unless special provisions are made, Kubernetes assumes __all__ cluster nodes can interconnect using __all__ ports.

__Outbound network:__ Run:ai user interface runs from the cloud. All container nodes must be able to connect to the Run:ai cloud. Inbound connectivity (connecting from the cloud into nodes) is not required. If outbound connectivity is limited, the following exceptions should be applied:

### During Installation

Run:ai requires an installation over the Kubernetes cluster. The installation access the web to download various images and registries. Some organizations place limitations on what you can pull from the internet. The following list shows the various solution components and their origin:


| Name | Description | URLs | Ports |
|------|-------------|------|-------|
|Run:ai  Repository| Run:ai Helm Package Repository| <a href="http://runai-charts.storage.googleapis.com/">runai-charts.storage.googleapis.com</a> |443 |
| Docker Images Repository | Run:ai images | gcr.io/run-ai-prod |443 |
| Docker Images Repository | Third party Images |<a href="http://hub.docker.com/">hub.docker.com </a> and <a href="http://quay.io/">quay.io</a>  |  443  |
| Run:ai | Run:ai   Cloud instance | <a href="https://app.run.ai">app.run.ai</a> | |443, 53 |




### Post Installation

In addition, once running, Run:ai requires an outbound network connection to the following targets:

| Name | Description | URLs | Ports |
|------|-------------|------|-------|
| Grafana |Grafana Metrics Server | <a href="https://prometheus-us-central1.grafana.net">prometheus-us-central1.grafana.net</a> and <a href="https://runailabs.com">runailabs.com</a> |443 |
| Run:ai | Run:ai   Cloud instance | <a href="https://app.run.ai">app.run.ai</a> |443, 53 |


### Network Proxy

If you are using a Proxy for outbound communication please contact Run:ai customer support

## Pre-install Script

Once you believe that the Run:ai prerequisites are met, we highly recommend installing and running the Run:ai [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

* Tests the below requirements as well as additional failure points related to Kubernetes, NVIDIA, storage, and networking.
* Looks at additional components installed and analyze their relevance to a successful Run:ai installation.

To use the script [download](https://github.com/run-ai/preinstall-diagnostics/releases){target=_blank} the latest version of the script and run:

```
chmod +x preinstall-diagnostics-<platform>
./preinstall-diagnostics-<platform>
```

If the script shows warnings or errors, locate the file `runai-preinstall-diagnostics.txt` in the current directory and send it to Run:ai technical support.

For more information on the script including additional command-line flags, see [here](https://github.com/run-ai/preinstall-diagnostics){target=_blank}.

