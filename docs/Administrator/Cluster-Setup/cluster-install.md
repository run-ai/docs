Below are instructions on how to install Run:AI cluster. Before installing, please review the installation prerequisites here: [Run AI GPU Cluster Prerequisites](cluster-prerequisites.md).


## Step 1: NVIDIA

On __each machine__ with GPUs run the following steps 1.1 - 1.4. If you are using [DGX OS](https://docs.nvidia.com/dgx/index.html){target=_blank} 4.0 or later, you may skip to step 2.

### Step 1.1 Install the CUDA Toolkit 

Run: 

``` 
nvidia-smi
```

If the command is __not__ successful, you must install the CUDA Toolkit. Follow the instructions [here](https://developer.nvidia.com/cuda-downloads){target=_blank} to install. When the installation is finished you must reboot your computer. 

If the machine is __DGX A100__, then apart from the CUDA Toolkit you must also install the __NVIDIA Fabric Manager__:

* Run: `nvidia-smi` and get the NVIDIA Driver version (it must be 450 or later).
* Run: `sudo apt search fabricmanager` to find a Fabric Manager package with the same version and install it.


### Step 1.2: Install Docker

Install Docker by following the steps here: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/){target=_blank}. Specifically, you can use a convenience script provided in the document:
``` shell
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### Step 1.3: Install NVIDIA Container Toolkit (previously named NVIDIA Docker)

To install NVIDIA Docker on Debian-based distributions (such as Ubuntu), run the following:

``` shell
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
```

For RHEL-based distributions, run:

``` shell
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo
sudo yum install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
```

For a detailed review of the above instructions, see the [NVIDIA Container Toolkit  installation instructions](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html){target=_blank}.

!!! Warning
    Kubernetes does [not currently support](https://github.com/NVIDIA/nvidia-docker/issues/1268){target=_blank}  the [NVIDIA container runtime](https://github.com/NVIDIA/nvidia-container-runtime){target=_blank}, which is the successor of NVIDIA Docker/NVIDIA container toolkit.

### Step 1.4: Make NVIDIA Docker the default docker runtime

Set the NVIDIA runtime as the default Docker runtime on your node. Edit the docker daemon config file at ``/etc/docker/daemon.json `` and add the ``default-runtime`` key as follows: 

``` json
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```
Then run the following again:

    sudo pkill -SIGHUP dockerd


## Step 2: Install Kubernetes

A full list of Kubernetes set up methods can be found here: [https://kubernetes.io/docs/setup/](https://kubernetes.io/docs/setup/){target=_blank}. Below are some: 

* Kubernetes is promoting [Kubespray](https://kubespray.io/#/){target=_blank}. Download the latest __stable__ version of Kubespray from: [https://github.com/kubernetes-sigs/kubespray](https://github.com/kubernetes-sigs/kubespray){target=_blank}. 

* Run:AI provides instructions for a simple Kubernetes installation. See [Native Kubernetes Installation](install-k8s.md).

* Run:AI has been tested with the following certified Kubernetes distributions: 

| Target Platform | Description | Notes | 
|-----------------|-------------|-------|
| On Premise      |  Kubernetes is installed by the customer and not managed by a service  | Example: Native installation,  _Kubespray_ |
| EKS | Amazon Elastic Kubernetes Service ||
| AKS | Azure Kubernetes Services    ||
| GKE | Google Kubernetes Engine ||
| OCP | OpenShift Container Platform |  Please contact Run:AI customer support for full installation instructions | 
| RKE | Rancher Kubernetes Engine | Perform the mandatory extra step [here](../cluster-troubleshooting/#symptom-cluster-installation-failed-on-rancher-based-kubernetes-rke). When installing Run:AI, select _On Premise_ |

!!! Warning
    Run:AI is customizing the NVIDIA Kubernetes device [plugin](https://github.com/NVIDIA/k8s-device-plugin){target=_blank}. Do __not__ install this software as it is installed by Run:AI. 


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
