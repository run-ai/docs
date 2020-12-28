Below are instructions on how to install Run:AI cluster. Before installing, please review the installation prerequisites here: [Run AI GPU Cluster Prerequisites](cluster-prerequisites.md).


## Step 1: NVIDIA

On __each machine__ with GPUs run the following steps 1.1 - 1.4:

### Step 1.1 Install NVIDIA Drivers

If NVIDIA drivers are not already installed on your GPU machines, please install them now. After installing NVIDIA drivers, reboot the machine. Then verify that the installation succeeded by running:

    nvidia-smi

### Step 1.2: Install Docker

Install Docker by following the steps here: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/){target=_blank}. Specifically, you can use a convenience script provided in the document:
``` shell
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### Step 1.3: Install NVIDIA Docker

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

For a detailed review of the above instructions, see the [NVIDIA Docker installation instructions](https://nvidia.github.io/nvidia-docker/){target=_blank}.

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

There are several good ways to install Kubernetes. A full list can be found here: [https://kubernetes.io/docs/setup/](https://kubernetes.io/docs/setup/){target=_blank}. Two good alternatives:

1. __Native__ installation. For simple Kubernetes installation, the easiest and fastest way to setup Kubernetes is through a [Native Kubernetes Installation](install-k8s.md).
2. __Kubespray__ [https://kubespray.io/](https://kubespray.io/#/){target=_blank}. Kubespray uses Ansible scripts.  Download the latest __stable__ version of Kubespray from: [https://github.com/kubernetes-sigs/kubespray](https://github.com/kubernetes-sigs/kubespray){target=_blank}. 

!!! Note
    Run:AI is customizing the NVIDIA Kubernetes device [plugin](https://github.com/NVIDIA/k8s-device-plugin){target=_blank}. Do __not__ install this software as it is installed by Run:AI. 

Some best practices on Kubernetes configuration can be found here: [Kubernetes Cluster Configuration Best Practices](kubernetes-config-best-practices.md).

The following next steps assume that you have the Kubernetes command-line _kubectl_ on your laptop and that it is configured to point to a functioning Kubernetes cluster.

## Step 3: Install Run:AI

### Step 3.1: Install Run:AI

*   Log in to Run:AI Admin UI at [https://app.run.ai.](https://app.run.ai){target=_blank} Use credentials provided by Run:AI Customer Support.
*   If no clusters are configured, you will see a dialog with instructions on how to install a Run:AI cluster.
*   If a cluster has already been configured, open the menu on the top left and select "Clusters". On the top right-click "Add New Cluster". 

Please read the next section __before__ proceeding.

### Step 3.2: Customize Installation

The Run:AI Admin UI cluster creation wizard asks you to download a YAML file ``runai-operator-<cluster-name>.yaml``. You must then _apply_ the file to Kubernetes. __Before__ applying to Kubernetes, you may need to edit this file. Examples:

* Set aside an IP address for _ingress_ access to containers (e.g. for Jupyter Notebooks, PyCharm, VisualStudio Code). See: [Allow external access to Containers](allow-external-access-to-containers.md). Note that you can access containers via _port forwarding_ without requiring an ingress point. 
* Allow outbound internet connectivity in a proxied environment. See: [Installing Run:AI with an Internet Proxy Server](proxy-server.md).


## Step 4: Verify your Installation

*   Go to [https://app.run.ai/dashboards/now](https://app.run.ai/dashboards/now){target=_blank}.
*   Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appear on the bottom line.

For a more extensive verification of cluster health, see [Determining the health of a cluster](../cluster-troubleshooting/#determining-the-health-of-a-runai-cluster).

## Step 5: (Optional) Set Node Roles

When installing a production cluster you may want to:

* Set one or more Run:AI system nodes. These are nodes dedicated to Run:AI software. 
* Machine learning frequently requires jobs that require CPU but __not GPU__. You may want to direct these jobs to dedicated nodes that do not have GPUs, so as not to overload these machines. 
* Limit Run:AI to specific nodes in the cluster. 

To perform these tasks. See [Set Node Roles](node-roles.md).



## Next Steps

* Set up Admin UI Users [Working with Admin UI Users](../Admin-User-Interface-Setup/Adding-Updating-and-Deleting-Admin-UI-Users.md).
* Set up Projects [Working with Projects](../Admin-User-Interface-Setup/Working-with-Projects.md).
* Set up Researchers to work with the Run:AI Command-line interface (CLI). See  [Installing the Run AI Command-line Interface](../Researcher-Setup/cli-install.md) on how to install the CLI for users.
* Set up [Project-based Researcher Access Control](researcher-authentication.md).
