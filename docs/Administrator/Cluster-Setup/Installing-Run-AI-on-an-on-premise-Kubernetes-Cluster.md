The following are instructions on how to install Run:AI on the customer's Kubernetes Cluster. Before installation please review the installation prerequisites here: [Run AI GPU Cluster Prerequisites](Run-AI-GPU-Cluster-Prerequisites.md).


## Step 1: NVIDIA

On __each machine__ with GPUs run the following steps 1.1 - 1.3:

### Step 1.1 Install NVIDIA Drivers

If NVIDIA drivers are not already installed on your GPU machines, please install them now. Note that on original NVIDIA hardware, these drivers are already installed by default. 
After installing NVIDIA drivers reoobt the machine. Then verify that the installation succeeded by running:

    nvidia-smi

### Step 1.2: Install NVIDIA Docker

Run the following:

    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    sudo apt-get update && sudo apt-get install -y nvidia-docker2
    sudo pkill -SIGHUP dockerd

### Step 1.3: Make NVIDIA Docker the default docker runtime

You will need to enable the Nvidia runtime as your default docker runtime on your node. We will be editing the docker daemon config file which is usually present at ``/etc/docker/daemon.json ``:

    {
        "default-runtime": "nvidia",
        "runtimes": {
            "nvidia": {
                "path": "/usr/bin/nvidia-container-runtime",
                "runtimeArgs": []
            }
        }
    }

Then run the following again:

    sudo pkill -SIGHUP dockerd

__Note__: Run:AI is customizing the NVIDIA device plugin (<https://github.com/NVIDIA/k8s-device-plugin>). Do __not__ install this software as it is installed by Run:AI. 

## Step 2: Install Kubernetes

Installing Kubernetes is beyond the scope of this guide. There are plenty of good ways to install Kubernetes (listed here: [https://kubernetes.io/docs/setup/](https://kubernetes.io/docs/setup/). We recommend Kubespray [https://kubespray.io/\#/](https://kubespray.io/#/) . Download the latest __stable__ version from  : [https://github.com/kubernetes-sigs/kubespray](https://github.com/kubernetes-sigs/kubespray). 

Some best practices on Kubernetes Configuration can be found here: [Kubernetes Cluster Configuration Best Practices](Kubernetes-Cluster-Configuration-Best-Practices.md).

The following next steps assume that you have the Kubernetes command-line _kubectl_ on your laptop and that it is configured to point to the Kubernetes cluster.

#### Step 2.1 Default Storage Class

Find out if you have a _default_ storage class by running

    kubectl get storageclass

If the output list contains a __default__ storage class you must, in step 3.1 below, remove the Run:AI default storage class.


## Step 3: Install Run:AI

*   Log in to Run:AI Admin UI at [https://app.run.ai.](https://app.run.ai) Use credentials provided by Run:AI Customer Support to log in to the system.
*   If this is the first time anyone from your company has logged in, you will receive a dialog with instructions on how to install Run:AI on your Kubernetes Cluster.
*   If not, open the menu on the top left and select "Clusters". On the top right-click "Add New Cluster". Continue according to instructions to install Run:AI on your Kubernetes Cluster.

### Step 3.1: Customized Installation
The Run:AI Admin UI cluster creation wizard asks you to download a YAML file ``runai-operator-<cluster-name>.yaml``. You must then _apply_ the file to Kubernetes. __Before__ applying to Kubernetes, you may need to edit this file. Examples:

* To allow access to containers (e.g. for Jupyter Notebooks, PyCharm etc) you will need to add an ingress load-balancing point. See: [Exposing Ports from Researcher Containers].(Exposing-Ports-from-Researcher-Containers-using-Ingress.md)
* To allow outbound internet connectivity in a proxied environment. See: [Installing Run AI with an Internet Proxy Server](Installing-Run-AI-with-an-Internet-Proxy-Server-.md).
* To remove the Run:AI default Storage Class if a default storage class already exists. See: [remove default storage class](../Troubleshooting-a-Run-AI-Cluster-Installation/#internal-database-has-not-started).

## Step 4: Verify your Installation

*   Go to <https://app.run.ai>.
*   Go to the Overview Dashboard.
*   Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appear on the bottom line.

For a more extensive verification of cluster health, see [Determining the health of a cluster](../Troubleshooting-a-Run-AI-Cluster-Installation/#determining-the-health-of-a-runai-cluster).

## Next Steps

*   Researchers work via a Command-line interface (CLI). See  [Installing the Run AI Command-line Interface](../Researcher-Setup/Installing-the-Run-AI-Command-Line-Interface.md) on how to install the CLI for users
*   Set up Admin UI Users [Working with Admin UI Users](../Admin-User-Interface-Setup/Adding-Updating-and-Deleting-Admin-UI-Users.md)