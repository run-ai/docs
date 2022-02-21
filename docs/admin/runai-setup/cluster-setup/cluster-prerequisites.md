Below are the prerequisites of a cluster installed with Run:AI. 

## Software Requirements
### Kubernetes

Run:AI has been tested with the following certified Kubernetes distributions: 

| Target Platform                          | Description | Notes | 
|------------------------------------------|-------------|-------|
| Vanilla Kubernetes                       |  Using no specific distribution but rather k8s native installation  | |
| EKS | Amazon Elastic Kubernetes Service  | |
| AKS | Azure Kubernetes Services          | |
| GKE | Google Kubernetes Engine           | |
| OCP | OpenShift Container Platform       | The Run:AI operator is [certified](https://catalog.redhat.com/software/operators/detail/60be3acc3308418324b5e9d8){target=_blank} for OpenShift by Red Hat. | 
| RKE | Rancher Kubernetes Engine          | When installing Run:AI, select _On Premise_. You must perform the mandatory extra step [here](../cluster-troubleshooting/#symptom-cluster-installation-failed-on-rancher-based-kubernetes-rke). |
| Ezmeral | HPE Ezmeral Container Platform | See Run:AI at [Ezmeral marketplace](https://www.hpe.com/us/en/software/marketplace/runai.html){target=_blank}  |
| Tanzu | VMWare Kubernetes | Tanzu supports _containerd_ rather than _docker_. The NVIDIA prerequisites need to take this into account. See more below |

A full list of Kubernetes partners can be found here: [https://kubernetes.io/docs/setup/](https://kubernetes.io/docs/setup/){target=_blank}. In addition, Run:AI provides instructions for a simple (non production-ready) [Kubernetes Installation](install-k8s.md).


!!! Notes
    * Run:AI requires Kubernetes 1.19 or above. Kubernetes 1.21 is recommended.
    * Kubernetes [recommends](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/){target=_blank} the usage of the `systemd` as the [container runtime cgroup driver](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker){target=_blank}. Kubernetes 1.22 and above defaults to `systemd`.
    * If you are using RedHat OpenShift. Run:AI requires OpenShift 4.6 or later. 
    * Run:AI Supports Kubernetes [Pod Security Policy](https://kubernetes.io/docs/concepts/policy/pod-security-policy/){target=_blank} if used. 
### NVIDIA 

NVIDIA pre-requisites are provided in detail in the [NVIDIA documentation](https://docs.nvidia.com/datacenter/cloud-native/kubernetes/install-k8s.html#step-4-setup-nvidia-software){target=_blank}. The following provides a walkthrough of the documentation steps:


Install the _NVIDIA GPU Operator on Kubernetes_. This single installation contains the required NVIDIA drivers and software for __all__ nodes within the Kubernetes cluster containing NVIDIA GPUs.

!!! Important
    * If you are using [DGX OS](https://docs.nvidia.com/dgx/index.html){target=_blank} then NVIDIA prerequisites are already installed and you may skip to the next step.
    * The combination of _NVIDIA A100 hardware_ and the _CoreOS operating system_ (which is popular when using OpenShift) will only work using the GPU Operator version 1.8 or higher. 


Follow the [Getting Started guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#install-nvidia-gpu-operator){target=blank}.

* Note that the document contains a separate section in the case where the NVIDIA CUDA Toolkit is already installed on the nodes.
* To work with containerd (e.g. for Tanzu), change the [defaultRuntime](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html#chart-customization-options){target=_blank} accordingly.


### Prometheus 

Run:AI requires [Prometheus](https://prometheus.io/){target=_blank}. The Run:AI Cluster installation will, by default, install Prometheus, but it can also connect to an existing Prometheus instance installed by the organization. In the latter case, it's important to:

* Verify that both [Prometheus Node Exporter](https://prometheus.io/docs/guides/node-exporter/){target=_blank} and [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics){target=_blank} are installed. Both are part of the default Prometheus installation
* Understand how Prometheus has been installed. Whether [directly](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus) or with the [Prometheus Operator](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack). The distinction is important during the Run:AI Cluster installation.



### Distributed Training via Kubeflow MPI

Distributed training is the ability to run workloads on multiple nodes (not just multiple GPUs on the same node). Run:AI provides this capability via Kubeflow MPI. If you need this functionality, you will need to install the [Kubeflow MPI Operator](https://github.com/kubeflow/mpi-operator){target=_blank}. Use the following [installation guide](https://github.com/kubeflow/mpi-operator/tree/v0.2.3#installation){target=_blank}. Note that Run:AI does not currently support the latest MPI version. but only version `v0.2.3`.

As per instructions: 

* Clone tag `v0.2.3` (and not master)
* `vi mpi-operator/deploy/v1alpha2/mpi-operator.yaml`: 
  * search for `mpioperator/mpi-operator:latest` and change it to `mpioperator/mpi-operator:v0.2.3`.
  * search for `mpioperator/kubectl-delivery:latest` and change it to `mpioperator/kubectl-delivery:v0.2.3`.


!!! Notes
    Kubeflow MPI requires containers to run as root, which will not work well when running on OpenShift or when PodSecurityPolicy is enabled in Kubernetes.
    


## Hardware Requirements

(see picture below)

*   (Production only) __Run:AI System__ Nodes: To reduce downtime and save CPU cycles on expensive GPU Machines, we recommend that production deployments will contain __two or more__ worker machines, designated for Run:AI Software. The nodes do not have to be dedicated to Run:AI, but for Run:AI purposes we would need:
    
    *   4 CPUs
    *   8GB of RAM
    *   50GB of Disk space  
    
*   __Shared data volume:__ Run:AI uses Kubernetes to abstract away the machine on which a container is running:

    * Researcher containers: The Researcher's containers need to be able to access data from any machine in a uniform way, to access training data and code as well as save checkpoints, weights, and other machine-learning-related artifacts. 
    * The Run:AI system needs to save data on a storage device that is not dependent on a specific node.  

    Typically, this is achieved via Network File Storage (NFS) or Network-attached storage (NAS).

* __Docker Registry:__ With Run:AI, Workloads are based on Docker images. For container images to run on any machine, these images must be downloaded from a docker registry rather than reside on the local machine (though this also is [possible](../../../researcher-setup/docker-to-runai/#image-repository)). You can use a public registry such as [docker hub](https://hub.docker.com/){target=_blank} or set up a local registry on-prem (preferably on a dedicated machine). Run:AI can assist with setting up the repository.

*  __Kubernetes:__ Production Kubernetes installation requires separate nodes for the Kubernetes master. For more details see your specific Kubernetes distribution documentation. 

![img/prerequisites.png](img/prerequisites.jpg)

## User requirements

__Usage of containers and images:__ The individual Researcher's work should be based on [container](https://www.docker.com/resources/what-container){target=_blank} images. 

## Network Requirements

__Internal networking:__ Kubernetes networking is an add-on rather than a core part of Kubernetes. Different add-ons have different network requirements. You should consult the documentation of the specific add-on on which ports to open. It is however important to note that unless special provisions are made, Kubernetes assumes __all__ cluster nodes can interconnect using __all__ ports. 

__Outbound network:__ Run:AI user interface runs from the cloud. All container nodes must be able to connect to the Run:AI cloud. Inbound connectivity (connecting from the cloud into nodes) is not required. If outbound connectivity is proxied/limited, the following exceptions should be applied: 

### During Installation

Run:AI requires an installation over the Kubernetes cluster. The installation access the web to download various images and registries. Some organizations place limitations on what you can pull from the internet. The following list shows the various solution components and their origin: 

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
<p>Run:AI  Repository</p>
</td>
<td style="padding: 6px; width: 298.92px;">
<p> The Run:AI Package Repository is hosted on Run:AI’s account on Google Cloud </p>
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
<p>Various Run:AI images</p>
</td>
<td style="padding: 6px; width: 217.102px;">
<p><a href="http://hub.docker.com/">hub.docker.com </a></p>
<p>gcr.io/run-ai-prod </p>
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
<p> Various third party Images</p>
</td>
<td style="padding: 6px; width: 217.102px;">
<p><a href="http://quay.io/">quay.io</a>  </p>
</td>
<td style="padding: 6px; width: 33.4659px;">
<p>  443   </p>
</td>
</tr>
</tbody>
</table>

### Post Installation

In addition, once running, Run:AI will send metrics to two sources:

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
<p> Run:AI </p>
</td>
<td style="padding: 6px; width: 304px;">
<p> Run:AI   Cloud instance </p>
</td>
<td style="padding: 6px; width: 205px;">
<p> <a href="https://app.run.ai">app.run.ai</a> </p>
<p> </p>
</td>
<td style="padding: 6px; width: 32px;">
<p>443</p>
</td>
<tr>
<td style="padding: 6px; width: 106px;">
<p> Auth0 </p>
</td>
<td style="padding: 6px; width: 304px;">
<p> Authentication Provider </p>
</td>
<td style="padding: 6px; width: 205px;">
<p> <a href="https://runai-prod.auth0.com/">runai-prod.auth0.com</a> </p>
<p> </p>
</td>
<td style="padding: 6px; width: 32px;">
<p>443</p>
</td>

</tbody>
</table>


## Pre-install Script

Once you believe that the Run:AI prerequisites are met, we highly recommend installing and running the Run:AI  [pre-install diagnostics script](https://github.com/run-ai/preinstall-diagnostics){target=_blank}. The tool:

* Tests the below requirements as well as additional failure points related to Kubernetes, NVIDIA, storage, and networking.
* Looks at additional components installed and analyzes their relevancy to a successful Run:AI installation. 

To use the script [download](https://github.com/run-ai/preinstall-diagnostics/releases){target=_blank} the latest version of the script and run:

```
chmod +x preinstall-diagnostics-<platform>
./preinstall-diagnostics-<platform>
```

If the script fails, or if the script succeeds but the Kubernetes system contains components other than Run:AI, locate the file `runai-preinstall-diagnostics.txt` in the current directory and send it to Run:AI technical support. 

For more information on the script including additional command-line flags, see [here](https://github.com/run-ai/preinstall-diagnostics){target=_blank}.

