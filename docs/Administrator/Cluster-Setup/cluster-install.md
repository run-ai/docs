Below are instructions on how to install Run:AI cluster. Before installing, please review the installation prerequisites here: [Run AI GPU Cluster Prerequisites](cluster-prerequisites.md).


## Step 1: Kubernetes

Run:AI has been tested with the following certified Kubernetes distributions: 

| Target Platform | Description | Notes | 
|-----------------|-------------|-------|
| On-Premise      |  Kubernetes is installed by the customer and not managed by a service  | Example: Native installation,  _Kubespray_ |
| EKS | Amazon Elastic Kubernetes Service ||
| AKS | Azure Kubernetes Services    ||
| GKE | Google Kubernetes Engine ||
| OCP | OpenShift Container Platform |  Please contact Run:AI customer support for full installation instructions | 
| RKE | Rancher Kubernetes Engine | When installing Run:AI, select _On Premise_. You must perform the mandatory extra step [here](../cluster-troubleshooting/#symptom-cluster-installation-failed-on-rancher-based-kubernetes-rke). |

A full list of Kubernetes partners can be found here: [https://kubernetes.io/docs/setup/](https://kubernetes.io/docs/setup/){target=_blank}. Run:AI provides instructions for a simple (non production-ready) [Kubernetes Installation](install-k8s.md).

<!-- !!! Warning
    Run:AI is customizing the NVIDIA Kubernetes device [plugin](https://github.com/NVIDIA/k8s-device-plugin){target=_blank}. Do __not__ install this software as it is installed by Run:AI.  -->


## Step 2: NVIDIA

There are two alternatives for installing NVIDIA prerequisites:

1. (Recommended) Use the _NVIDIA GPU Operator on Kubernetes_. To install the NVIDIA GPU Operator use the [Getting Started guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/getting-started.html){target=blank}.
2. Install the _NVIDIA CUDA Toolkit_ and _NVIDIA Docker_ on __each node with GPUs__. See [NVIDIA Drivers installation](nvidia.md) for details.

!!! Important
    * The options are mutually exclusive. If the NVIDIA CUDA toolkit is installed, you will not be able to install the NVIDIA GPU Operator. 
    * NVIDIA GPU Operator does not currently work with DGX. If you are using [DGX OS](https://docs.nvidia.com/dgx/index.html){target=_blank} then NVIDIA prerequisites are already installed and you may skip to the next step.


### NVIDIA Device Plugin

Run:AI has customized the [NVIDIA device plugin for Kubernetes](https://github.com/NVIDIA/k8s-device-plugin){target=_blank}. If you have installed the NVIDIA GPU Operator or have previously installed this plug-in, run the following to disable the existing plug-in:

```
kubectl -n gpu-operator-resources patch daemonset nvidia-device-plugin-daemonset \
   -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
```

## Step 3: Install Run:AI

Log in to Run:AI Admin UI at [https://app.run.ai.](https://app.run.ai){target=_blank} Use credentials provided by Run:AI Customer Support:

*   If no clusters are currently configured, you will see a Cluster installation wizard
*   If a cluster has already been configured, use the menu on the top left and select "Clusters". On the top right, click "Add New Cluster". 

Using the Wizard:

1. Choose a target Kubernetes platform (see table above)
2. Download a _Helm_ values YAML file ``runai-<cluster-name>.yaml``
3. (Optional) customize the values file. See [Customize Cluster Installation](customize-cluster-install.md)
4. Install [Helm](https://helm.sh/docs/intro/install/)
5. Run:

``` bash
helm repo add runai https://run-ai-charts.storage.googleapis.com
helm repo update

helm install runai-cluster runai/runai-cluster -n runai --create-namespace \
    -f runai-<cluster-name>.yaml
```


## Step 4: Verify your Installation

*   Go to [https://app.run.ai/dashboards/now](https://app.run.ai/dashboards/now){target=_blank}.
*   Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appears on the bottom line.

For a more extensive verification of cluster health, see [Determining the health of a cluster](../cluster-troubleshooting/#determining-the-health-of-a-runai-cluster).

## Step 5: (Optional) Set Node Roles

When installing a production cluster you may want to:

* Set one or more Run:AI system nodes. These are nodes dedicated to Run:AI software. 
* Machine learning frequently requires jobs that require CPU but __not GPU__. You may want to direct these jobs to dedicated nodes that do not have GPUs, so as not to overload these machines. 
* Limit Run:AI to specific nodes in the cluster. 

To perform these tasks. See [Set Node Roles](node-roles.md).



## Next Steps

* Set up Admin UI Users [Working with Admin UI Users](../admin-ui-setup/admin-ui-users.md).
* Set up Projects [Working with Projects](../admin-ui-setup/project-setup.md).
* Set up Researchers to work with the Run:AI Command-line interface (CLI). See  [Installing the Run AI Command-line Interface](../Researcher-Setup/cli-install.md) on how to install the CLI for users.
* Set up [Project-based Researcher Access Control](researcher-authentication.md).
