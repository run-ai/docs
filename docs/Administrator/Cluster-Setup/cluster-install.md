Below are instructions on how to install Run:AI cluster. Before installing, please review the installation prerequisites here: [Run AI GPU Cluster Prerequisites](cluster-prerequisites.md).


## Step 1: NVIDIA

On __each machine__ with GPUs run the following steps 1.1 - 1.4:

### Step 1.1 Install NVIDIA Drivers

If NVIDIA drivers are not already installed on your GPU machines, please install them now. After installing NVIDIA drivers, reboot the machine. Then verify that the installation succeeded by running:

    nvidia-smi

### Step 1.2: Install Docker

Install Docker by following the steps here: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

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

For a detailed review of the above instructions, see the [NVIDIA Docker installation instructions](https://nvidia.github.io/nvidia-docker/).

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


## Step 2: Install & Configure Kubernetes

### Step 2.1 Install Kubernetes

Installing Kubernetes is beyond the scope of this guide. There are plenty of good ways to install Kubernetes (listed here: [https://kubernetes.io/docs/setup/](https://kubernetes.io/docs/setup/). We recommend __Kubespray__ [https://kubespray.io/](https://kubespray.io/#/). Download the latest __stable__ version of Kubespray from: [https://github.com/kubernetes-sigs/kubespray](https://github.com/kubernetes-sigs/kubespray). 

!!! Note
    Run:AI is customizing the NVIDIA Kubernetes device plugin (<https://github.com/NVIDIA/k8s-device-plugin>). Do __not__ install this software as it is installed by Run:AI. 

Some best practices on Kubernetes configuration can be found here: [Kubernetes Cluster Configuration Best Practices](kubernetes-config-best-practices.md).

The following next steps assume that you have the Kubernetes command-line _kubectl_ on your laptop and that it is configured to point to a functioning Kubernetes cluster.

### Step 2.2 Storage

Run:AI requires some storage for functioning. How this storage is configured differs based on intended usage:

*  If the purpose of this installation is testing/proof-of-concept, then local storage on one of the nodes is good enough.  
*  If the purpose of this installation is a production environment, then it is a good practice to setup the system such that if one node is down, the Run:AI software will seamlessly migrate to another node. For this to happen, the storage has to reside on __shared storage__.

To install Run:AI on local storage, first run:

    kubectl get storageclass

If the output contains a __default__ storage class you must, in step 3.2 below, remove the Run:AI default storage class.

To install on shared storage, you must, in step 3.2 below, provide information about your NFS (Network File Storage).

### Step 2.3 CPU-Only Worker Nodes

If you have CPU-only worker (non-master) nodes in your cluster (see [Hardware Requirements](../Run-AI-GPU-Cluster-Prerequisites/#hardware-requirements)), you will need to _label_ them. Labels help Run:AI to place its software correctly, by __avoiding__ placement of Run:AI containers on GPU nodes used for processing data science and by __placing__ monitoring software on the GPU nodes. To get the list of nodes, run:

    kubectl get nodes

To label CPU-only nodes, run the following on __each__ CPU-only node:

    kubectl label node <node-name> run.ai/cpu-node=true

Where ``<node-name>`` is the name of the node. Node names can be obtained by running ``kubectl get nodes``

!!! Note
    Kubernetes master node(s) typically have a ["NoSchedule" taint](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) so as to avoid non-system pods running on a master node. Pressuring master nodes may lead to the Kubernetes system not functioning properly. If your master node is not a GPU node, make sure that this taint exists so that Run:AI too, does not run on a master node.

## Step 3: Install Run:AI

### Step 3.1: Install Run:AI

*   Log in to Run:AI Admin UI at [https://app.run.ai.](https://app.run.ai) Use credentials provided by Run:AI Customer Support to log in to the system.
*   If no clusters are configured, you will receive a dialog with instructions on how to install a Run:AI cluster.
*   If a cluster is already configured, open the menu on the top left and select "Clusters". On the top right-click "Add New Cluster". 

Take care to read the next section (Customize Installation) before proceeding.

### Step 3.2: Customize Installation

The Run:AI Admin UI cluster creation wizard asks you to download a YAML file ``runai-operator-<cluster-name>.yaml``. You must then _apply_ the file to Kubernetes. __Before__ applying to Kubernetes, you may need to edit this file. Examples:

* To allow access to containers (e.g. for Jupyter Notebooks, PyCharm etc) you will need to add an ingress load-balancing point. See: [Exposing Ports from Researcher Containers](allow-external-access-to-containers.md).
* To allow outbound internet connectivity in a proxied environment. See: [Installing Run:AI with an Internet Proxy Server](proxy-server.md).
* (See step 2.2) To remove the Run:AI default Storage Class when a default storage class already exists. See: [remove default storage class](../cluster-troubleshooting/#internal-database-has-not-started).
* (See step 2.2) To install Run:AI on NFS, see: [Installing Run:AI over network file storage](nfs-install.md)

## Step 4: Verify your Installation

*   Go to <https://app.run.ai>.
*   Go to the Overview Dashboard.
*   Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appear on the bottom line.

For a more extensive verification of cluster health, see [Determining the health of a cluster](../cluster-troubleshooting/#determining-the-health-of-a-runai-cluster).

## Next Steps

* Set up Admin UI Users [Working with Admin UI Users](../Admin-User-Interface-Setup/Adding-Updating-and-Deleting-Admin-UI-Users.md).
* Set up Projects [Working with Projects](../Admin-User-Interface-Setup/Working-with-Projects.md).
* Researchers work via a Command-line interface (CLI). See  [Installing the Run AI Command-line Interface](../Researcher-Setup/cli-install.md) on how to install the CLI for users.
