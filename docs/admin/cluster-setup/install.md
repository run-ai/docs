#Installing Run:AI on an on-premise Kubernetes Cluster

The following are instructions on how to install Run:AI on the customer Kubernetes Cluster. Prior to installation please review the installation prerequisites here: [https://support.run.ai/hc/en-us/articles/360010227960-Run-AI-GPU-Cluster-Prerequisites](https://support.run.ai/hc/en-us/articles/360010227960-Run-AI-GPU-Cluster-Prerequisites)

# Step 1: Install Kubernetes

Installing Kubernetes is beyond the scope of this guide. There are plenty of good ways to install Kubernetes (listed here: [https://kubernetes.io/docs/setup/](https://kubernetes.io/docs/setup/)). We recommend Kubespray [https://kubespray.io/#/](https://kubespray.io/#/) . Download the latest **stable** version from [https://github.com/kubernetes-sigs/kubespray](https://github.com/kubernetes-sigs/kubespray). 

The following next steps assume that you have the Kubernetes command-line _kubectl_ on your laptop and that it is configured to point to the Kubernetes cluster (by running _kubectl config use-context <name>_)  

# Step 2: NVIDIA

On **each machine** with GPUs run the following steps 2.1 - 2.3:

## Step 2.1 Install NVIDIA Drivers

If NVIDIA drivers are not already installed on your GPU machines, please install them now. Note that on original NVIDIA hardware, these drivers are already installed by default. 

## Step 2.2: Install NVIDIA Docker

Run the following:

    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    sudo apt-get update && sudo apt-get install -y nvidia-docker2
    sudo pkill -SIGHUP dockerd

## Step 2.3: Make NVIDIA Docker the default docker runtime

You will need to enable the Nvidia runtime as your default docker runtime on your node. We will be editing the docker daemon config file which is usually present at<span> </span>`/etc/docker/daemon.json`:

<div class="highlight highlight-source-json">

<pre>{
    <span class="pl-s"><span class="pl-pds">"</span>default-runtime<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>nvidia<span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>runtimes<span class="pl-pds">"</span></span>: {
        <span class="pl-s"><span class="pl-pds">"</span>nvidia<span class="pl-pds">"</span></span>: {
            <span class="pl-s"><span class="pl-pds">"</span>path<span class="pl-pds">"</span></span>: <span class="pl-s"><span class="pl-pds">"</span>/usr/bin/nvidia-container-runtime<span class="pl-pds">"</span></span>,
            <span class="pl-s"><span class="pl-pds">"</span>runtimeArgs<span class="pl-pds">"</span></span>: []
        }
    }
}</pre>

</div>

Then run the following again:

<pre>sudo pkill -SIGHUP dockerd</pre>

# Step 3: Install Run:AI

*   Log in to Run:AI at [https://app.run.ai. ](https://app.run.ai) Use credentials provided by Run:AI Customer Support to log in to the system
*   If this is the first time anyone from your company has logged in, you will receive a dialog with instructions on how to install Run:AI on your Kubernetes Cluster.
*   If not, open the menu on the top left and select "Clusters". On the top right-click "Add New Cluster". Continue according to instructions to install Run:AI on your Kubernetes Cluster

# Step 4: Verifying your Installation

*   Go to [https://app.run.ai](https://app.run.ai)
*   Go to the Overview Dashboard
*   Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appear on the bottom line

# Next Steps

*   Researchers work via a Command-line interface (CLI). See [https://support.run.ai/hc/en-us/articles/360010706120-Installing-the-Run-AI-Command-Line-Interface](https://support.run.ai/hc/en-us/articles/360010706120-Installing-the-Run-AI-Command-Line-Interface) on how to install the CLI for users
*   <span class="wysiwyg-color-black">Set up Admin UI Users. [https://support.run.ai/hc/en-us/articles/360011591340-Working-with-Admin-UI-Users](https://support.run.ai/hc/en-us/articles/360011591340-Working-with-Admin-UI-Users)</span>