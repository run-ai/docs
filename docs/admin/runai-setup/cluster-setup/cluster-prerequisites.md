Below are the prerequisites of a cluster installed with Run:ai. 

## Prerequisites in a Nutshell

The following is a checklist of the Run:ai prerequisites:

| Prerequisite | Details |
|--------------|---------|
| [Kubernetes](#kubernetes)          | Verify certified vendor and correct version. | 
| [NVIDIA GPU Operator](#nvidia)     | Different Kubernetes flavors have slightly different setup instructions.  <br> Verify correct version. |
| [Ingress Controller](#ingress-controller) | Install and configure NGINX (some Kubernetes flavors have NGINX pre-installed). Version 2.7 or earlier of Run:ai already installs NGINX as part of the Run:ai cluster installation. | 
| [Trusted domain name](#domain-name) | You must provide a trusted domain name (Version 2.7: a cluster IP). Accessible only inside the organization | 
| (Optional) [Distributed Training](#distributed-training) | Install Kubeflow MPI if required. | 
| (Optional) [Inference](#inference) | Some third party software needs to be installed to use the Inference module. | 

There are also specific [hardware](#hardware-requirements), [operating system](#operating-system) and [network access](#network-access-requirements) requirements. A [pre-install](#pre-install-script) script is available to test if the prerequisites are met before installation. 


## Software Requirements

### Operating System

Run:ai will work on any __Linux__ operating system that is supported by both Kubernetes and [NVIDIA](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html){target=_blank}. Having said that, Run:ai performs its internal tests on Ubuntu 20.04 (and CoreOS for OpenShift). The exception is GKE (Google Kubernetes Engine) where Run:ai has only been certified on an Ubuntu image.

### Kubernetes

Run:ai requires Kubernetes. The latest Run:ai version supports Kubernetes versions 1.21 through 1.24. Kubernetes 1.25 is not yet supported. For RedHat OpenShift. Run:ai supports OpenShift 4.8 to 4.10.

Run:ai has been tested with the following Kubernetes distributions: 

| Target Platform                          | Description | Installation Notes | 
|------------------------------------------|-------------|--------------------|
| Vanilla Kubernetes                       |  Using no specific distribution but rather k8s native installation  | |
| OCP | OpenShift Container Platform       | Run:ai Self-hosted only (Run:ai SaaS is not supported). <br> The Run:ai operator is [certified](https://catalog.redhat.com/software/operators/detail/60be3acc3308418324b5e9d8){target=_blank} for OpenShift by Red Hat. | 
| EKS | Amazon Elastic Kubernetes Service  | Run:ai SaaS only (no self-hosted support) |
| AKS | Azure Kubernetes Services          | Run:ai SaaS only (no self-hosted support)  |
| GKE | Google Kubernetes Engine           | Run:ai SaaS only (no self-hosted support) | 
| RKE | Rancher Kubernetes Engine          | When installing Run:ai, select _On Premise_. You must perform the mandatory extra step [here](./customize-cluster-install.md#rke-specific-setup). RKE2 has a defect which requires a specific installation flow. Please contact Run:ai customer support for additional details. |
| Ezmeral | HPE Ezmeral Container Platform | See Run:ai at [Ezmeral marketplace](https://www.hpe.com/us/en/software/marketplace/runai.html){target=_blank}  |
| Tanzu | VMWare Kubernetes | Tanzu supports _containerd_ rather than _docker_. See the NVIDIA prerequisites below as well as [cluster customization](customize-cluster-install.md) for changes required for containerd |

Run:ai provides instructions for a simple (non-production-ready) [Kubernetes Installation](install-k8s.md).


!!! Notes
    * Kubernetes [recommends](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/){target=_blank} the usage of the `systemd` as the [container runtime cgroup driver](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker){target=_blank}. Kubernetes 1.22 and above defaults to `systemd`. 
    * Run:ai Supports Kubernetes [Pos Security Policy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} if used. Pod Security Policy is deprecated and will be removed from Kubernetes (and Run:ai) with the introduction of Kubernetes 1.25. As such, Run:ai will be removing support for PSP in versions higher than 2.8. 
### NVIDIA 

Run:ai requires NVIDIA GPU Operator version 1.9 and 22.9.0. The interim versions (1.10 and 1.11) have a documented issue as per the note below. 

!!! Important
    NVIDIA GPU Operator has a bug that affects metrics and scheduling. The bug affects NVIDIA GPU Operator versions 1.10 and 1.11 but does not exist in 1.9 and is resolved in 22.9.0. For more details see [NVIDIA bug report](https://github.com/NVIDIA/gpu-feature-discovery/issues/26){target=_blank}. 

=== "On Prem"    
    Follow the [Getting Started guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#install-nvidia-gpu-operator){target=blank} to install the __NVIDIA GPU Operator__.

=== "EKS"
    * Do not install the NVIDIA device plug-in  (as we want the NVIDIA GPU Operator to install it instead). When using the [eksctl](https://eksctl.io/){target=_blank} tool to create an AWS EKS cluster, use the flag `--install-nvidia-plugin=false` to disable this install.
    * Follow the [Getting Started guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#install-nvidia-gpu-operator){target=blank} to install the __NVIDIA GPU Operator__. For GPU nodes, EKS uses an AMI which already contains the NVIDIA drivers. As such, you must use the GPU Operator flags: `--set driver.enabled=false`. 

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
        * Run:ai on GKE has only been tested with GPU Operator version 1.11.1 and up.
        * The above only works for Run:ai 2.7.16 and above. 

=== "RKE"
    Install the __NVIDIA GPU Operator__ as discussed [here](https://thenewstack.io/install-a-nvidia-gpu-operator-on-rke2-kubernetes-cluster/){target=_blank}.

!!! Notes
    * Use the default namespace `gpu-operator`. Otherwise, you must specify the target namespace using the flag `runai-operator.config.nvidiaDcgmExporter.namespace` as described in [customized cluster installation](customize-cluster-install.md).
    * NVIDIA drivers may already be installed on the nodes. In such cases, use the NVIDIA GPU Operator flags `--set driver.enabled=false`. [DGX OS](https://docs.nvidia.com/dgx/index.html){target=_blank} is one such example as it comes bundled with NVIDIA Drivers. 
    * To work with _containerd_ (e.g. for Tanzu), use the [defaultRuntime](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#chart-customization-options){target=_blank} flag accordingly.
    * To use [Dynamic MIG](../../../Researcher/scheduling/fractions.md/#dynamic-mig), the GPU Operator must be installed with the flag `mig.strategy=mixed`. If the GPU Operator is already installed, edit the clusterPolicy by running ```kubectl patch clusterPolicy cluster-policy -n gpu-operator --type=merge -p '{"spec":{"mig":{"strategy": "mixed"}}}```


### Ingress Controller

:octicons-versions-24: Version 2.8 and up.

Run:ai requires an ingress controller as a prerequisite. The Run:ai cluster installation configures one or more ingress objects on top of the controller. 

There are many ways to install and configure an ingress controller and configuration is environment-dependent. A simple solution is to install & configure _NGINX_:

=== "On Prem" 

    ``` bash
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm upgrade -i nginx-ingress ingress-nginx/ingress-nginx   \
        --namespace nginx-ingress --create-namespace \
        --set controller.kind=DaemonSet \
        --set controller.daemonset.useHostPort=true
    ```

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

The Run:ai user interface requires a URL to the Kubernetes cluster. You can use a domain name (FQDN) or an IP Address (deprecated).

!!! Note
    In a self-hosted installation, the typical scenario is to install the first Run:ai cluster on the same Kubernetes cluster as the control plane. In this case, the cluster URL need not be provided as it will be the same as the control-plane URL. 
#### Domain Name 

:octicons-versions-24: Version 2.8 and up.

You must supply a domain name as well as a __trusted__ certificate for that domain. 

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

#### Cluster IP

(Deprecated)

Following are instructions on how to get the IP and set firewall settings. 


=== "Unmanaged Kubernetes" 
    * Use the node IP of any of the Kubernetes nodes. 
    * Set up the firewall such that the IP is available to Researchers running within the organization (but not outside the organization).

=== "Unmanaged Kubernetes on the cloud" 
    * Use the node IPs of any of the Kubernetes nodes. Both internal and external IP in the format __external-IP,internal-IP__. 
    * Set up the firewall such that the external IP is available to Researchers running within the organization (but not outside the organization).


=== "EKS"

    You will need to externalize an IP address via a load balancer. If you do not have an existing load balancer already, install __NGINX__ as follows:

    ``` bash
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install nginx-ingress ingress-nginx/ingress-nginx
    ```

    Find the Cluster IP by running:

    ``` bash
    echo $(kubectl get svc nginx-ingress-ingress-nginx-controller  -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    ```

=== "GKE"

    You will need to externalize an IP address via a load balancer. If you do not have an existing load balancer already, install __NGINX__ as follows:

    ``` bash
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install nginx-ingress ingress-nginx/ingress-nginx
    ```

    Find the Cluster IP by running:

    ``` bash
    echo $(kubectl get svc nginx-ingress-ingress-nginx-controller  -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
    ```

### Prometheus 



The Run:ai Cluster installation will, by default, install [Prometheus](https://prometheus.io/){target=_blank}, but it can also connect to an existing Prometheus instance installed by the organization. Such a configuration can only be performed together with Run:ai support. In the latter case, it's important to:

* Verify that both [Prometheus Node Exporter](https://prometheus.io/docs/guides/node-exporter/){target=_blank} and [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics){target=_blank} are installed. Both are part of the default Prometheus installation
* Understand how Prometheus has been installed. Whether [directly](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus) or with the [Prometheus Operator](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack). The distinction is important during the Run:ai Cluster installation.


### Distributed Training

Distributed training is the ability to run workloads on multiple nodes (not just multiple GPUs on the same node). Run:ai provides this capability via Kubeflow MPI. If you need this functionality, you will need to install the [Kubeflow MPI Operator](https://github.com/kubeflow/mpi-operator){target=_blank}. Run:ai supports MPI version 0.3.0 (the latest version at the time of writing). 


Use the following [installation guide](https://github.com/kubeflow/mpi-operator#installation){target=_blank}. As per instruction, run:

* Verify that the `mpijob` custom resource does not currently exist in the cluster by running `kubectl get crds | grep mpijobs`. If it does, delete it by running `kubectl delete crd mpijobs.kubeflow.org`
* run `kubectl apply -f https://raw.githubusercontent.com/kubeflow/mpi-operator/master/deploy/v2beta1/mpi-operator.yaml`


### Inference

To use the Run:ai inference module you must pre-install [Knative Serving](https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/){target=_blank}. Follow the instructions [here](https://knative.dev/docs/install/){target=_blank} to install. Run:ai is certified on Knative 1.4 and 1.5 with Kubernetes 1.22 or later.  

Post-install, you must configure Knative to use the Run:ai scheduler by running: 

```
kubectl patch configmap/config-features \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"kubernetes.podspec-schedulername":"enabled"}}'
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

??? "Altenative Configuration"
    When the above DNS configuration is not possible, you can manually add the `Host` header to the REST request as follows:

    * Get an `<external-ip>` by running `kubectl get service -n kourier-system kourier`. If you have been using _istio_ during Run:ai installation, run:  `kubectl -n istio-system get service istio-ingressgateway` instead. 
    * Send a request to your workload by using the external ip, and place the workload url as a `Host` header. For example

    ```
    curl http://<external-ip>/<container-specific-path>
        -H 'Host: <host-name>'
    ```

## Hardware Requirements

(see picture below)

*   (Production only) __Run:ai System__ Nodes: To reduce downtime and save CPU cycles on expensive GPU Machines, we recommend that production deployments will contain __two or more__ worker machines, designated for Run:ai Software. The nodes do not have to be dedicated to Run:ai, but for Run:ai purposes we would need:
    
    *   4 CPUs
    *   8GB of RAM
    *   50GB of Disk space  
    
*   __Shared data volume:__ Run:ai uses Kubernetes to abstract away the machine on which a container is running:

    * Researcher containers: The Researcher's containers need to be able to access data from any machine in a uniform way, to access training data and code as well as save checkpoints, weights, and other machine-learning-related artifacts. 
    * The Run:ai system needs to save data on a storage device that is not dependent on a specific node.  

    Typically, this is achieved via Network File Storage (NFS) or Network-attached storage (NAS).

* __Docker Registry:__ With Run:ai, Workloads are based on Docker images. For container images to run on any machine, these images must be downloaded from a docker registry rather than reside on the local machine (though this also is [possible](../../../researcher-setup/docker-to-runai/#image-repository)). You can use a public registry such as [docker hub](https://hub.docker.com/){target=_blank} or set up a local registry on-prem (preferably on a dedicated machine). Run:ai can assist with setting up the repository.

*  __Kubernetes:__ Production Kubernetes installation requires separate nodes for the Kubernetes master. For more details see your specific Kubernetes distribution documentation. 

![img/prerequisites.png](img/prerequisites.jpg)

## User requirements

__Usage of containers and images:__ The individual Researcher's work should be based on [container](https://www.docker.com/resources/what-container){target=_blank} images. 

## Network Access Requirements

__Internal networking:__ Kubernetes networking is an add-on rather than a core part of Kubernetes. Different add-ons have different network requirements. You should consult the documentation of the specific add-on on which ports to open. It is however important to note that unless special provisions are made, Kubernetes assumes __all__ cluster nodes can interconnect using __all__ ports. 

__Outbound network:__ Run:ai user interface runs from the cloud. All container nodes must be able to connect to the Run:ai cloud. Inbound connectivity (connecting from the cloud into nodes) is not required. If outbound connectivity is proxied/limited, the following exceptions should be applied: 

### During Installation

Run:ai requires an installation over the Kubernetes cluster. The installation access the web to download various images and registries. Some organizations place limitations on what you can pull from the internet. The following list shows the various solution components and their origin: 

<table border="1" style="width: 650px; margin-left: 0px; margin-right: auto;">
<tbody>
<tr>
<th scope="row" style="width: 114.375px;">Name</th>
<th scope="row" style="width: 308.92px;">Description</th>
<th scope="row" style="width: 227.102px;">URLs</th>
<th scope="row" style="width: 43.4659px;">Ports</th>
</tr>

<tr>
<td style="padding: 6px; width: 104.375px;">
<p>Run:ai  Repository</p>
</td>
<td style="padding: 6px; width: 298.92px;">
<p> Run:ai Helm Package Repository </p>
</td>
<td style="padding: 6px; width: 217.102px;">
<p> <a href="http://runai-charts.storage.googleapis.com/">runai-charts.storage.googleapis.com</a> </p>
</td>
<td style="padding: 6px; width: 33.4659px;">
<p>443</p>
</td>
</tr>

<tr>
<td style="padding: 6px; width: 104.375px;">
<p>Docker Images Repository</p>
</td>
<td style="padding: 6px; width: 298.92px;">
<p>Run:ai images</p>
</td>
<td style="padding: 6px; width: 217.102px;">
gcr.io/run-ai-prod
</td>
<td style="padding: 6px; width: 33.4659px;">
<p>443</p>
</td>
</tr>

<tr>
<td style="padding: 6px; width: 104.375px;">
<p> Docker Images Repository </p>
</td>
<td style="padding: 6px; width: 298.92px;">
<p> Third party Images</p>
</td>
<td style="padding: 6px; width: 217.102px;">
<p><a href="http://hub.docker.com/">hub.docker.com </a></p>
<p><a href="http://quay.io/">quay.io</a>  </p>
</td>
<td style="padding: 6px; width: 33.4659px;">
<p>  443   </p>
</td>
</tr>

<tr>
<td style="padding: 6px; width: 106px;">
<p> Cert Manager </p>
</td>
<td style="padding: 6px; width: 304px;">
<p> (Run:ai version 2.7 or lower only) Creates a letsencrypt-based certificate for the cluster  </p>
</td>
<td style="padding: 6px; width: 205px;">
<p> 8.8.8.8, 1.1.1.1, dynu.com </p>
<p> </p>
</td>
<td style="padding: 6px; width: 32px;">
<p>53</p>
</td>

</tbody>
</table>

### Post Installation

In addition, once running, Run:ai requires an outbound network connection to the following targets:

<table border="1" style="margin-left: 0px; margin-right: auto; width: 650px;">
<tbody>
<tr style="height: 22px;">
<th scope="row" style="width: 116px; height: 22px;">Name</th>
<th scope="row" style="width: 314px; height: 22px;">Description</th>
<th scope="row" style="width: 215px; height: 22px;">URLs</th>
<th scope="row" style="width: 42px; height: 22px;">Ports</th>
</tr>

<tr>
<td style="padding: 6px; width: 106px;">
<p>Grafana</p>
</td>
<td style="padding: 6px; width: 304px;">
<p>Grafana Metrics Server</p>
</td>
<td style="padding: 6px; width: 205px;">
<p>prometheus-us-central1.grafana.net</p>
</td>
<td style="padding: 6px; width: 32px;">
<p>443 </p>
</td>
</tr>

<tr>
<td style="padding: 6px; width: 106px;">
<p> Run:ai </p>
</td>
<td style="padding: 6px; width: 304px;">
<p> Run:ai   Cloud instance </p>
</td>
<td style="padding: 6px; width: 205px;">
<p> <a href="https://app.run.ai">app.run.ai</a> </p>
<p> </p>
</td>
<td style="padding: 6px; width: 32px;">
<p>443</p>
</td>
</tr>

<tr>
<td style="padding: 6px; width: 106px;">
<p> Cert Manager </p>
</td>
<td style="padding: 6px; width: 304px;">
<p> (Run:ai version 2.7 or lower only) Creates a letsencrypt-based certificate for the cluster  </p>
</td>
<td style="padding: 6px; width: 205px;">
<p> 8.8.8.8, 1.1.1.1, dynu.com </p>
<p> </p>
</td>
<td style="padding: 6px; width: 32px;">
<p>53</p>
</td>

</tbody>
</table>


## Pre-install Script

Once you believe that the Run:ai prerequisites are met, we highly recommend installing and running the Run:ai [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

* Tests the below requirements as well as additional failure points related to Kubernetes, NVIDIA, storage, and networking.
* Looks at additional components installed and analyze their relevance to a successful Run:ai installation. 

To use the script [download](https://github.com/run-ai/preinstall-diagnostics/releases){target=_blank} the latest version of the script and run:

```
chmod +x preinstall-diagnostics-<platform>
./preinstall-diagnostics-<platform>
```

If the script fails, or if the script succeeds but the Kubernetes system contains components other than Run:ai, locate the file `runai-preinstall-diagnostics.txt` in the current directory and send it to Run:ai technical support. 

For more information on the script including additional command-line flags, see [here](https://github.com/run-ai/preinstall-diagnostics){target=_blank}.

