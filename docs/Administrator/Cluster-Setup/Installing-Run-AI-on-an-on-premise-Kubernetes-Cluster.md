The following are instructions on how to install Run:AI on the customer Kubernetes Cluster. Prior to installation please review the installation prerequisites here:&nbsp;<https://support.run.ai/hc/en-us/articles/360010227960-Run-AI-GPU-Cluster-Prerequisites>

## Step 1: Install Kubernetes

Installing Kubernetes is beyond the scope of this guide. There are plenty of good ways to install Kubernetes (listed here: <https://kubernetes.io/docs/setup/&gt;&gt;&gt;). We recommend Kubespray&nbsp;[https://kubespray.io/\#/](https://kubespray.io/#/)&nbsp;. Download the latest __stable__ version from&nbsp;&lt;&lt;&lt;FLOATING LINK: https://github.com/kubernetes-sigs/kubespray>.&nbsp;

Some best practices on Kubernetes Configuration can be found here:&nbsp;<https://support.run.ai/hc/en-us/articles/360015302379-Kubernetes-Cluster-Configuration-Best-Practices>&nbsp;

The following next steps assume that you have the Kubernetes command-line _kubectl_ on your laptop and that it is configured to point to the Kubernetes cluster (by running _kubectl config use-context &lt;name&gt;_)&nbsp;&nbsp;

## Step 2: NVIDIA

On __each machine__ with GPUs run the following steps 2.1 - 2.3:

### Step 2.1 Install NVIDIA Drivers

If NVIDIA drivers are not already installed on your GPU machines, please install them now. Note that on original NVIDIA hardware, these drivers are already installed by default.&nbsp;

### Step 2.2: Install NVIDIA Docker

Run the following:

<pre>distribution=<span class="pl-s"><span class="pl-pds">$(</span>. /etc/os-release<span class="pl-k">;</span><span class="pl-c1">echo</span> <span class="pl-smi">$ID$VERSION_ID</span><span class="pl-pds">)</span></span>
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey <span class="pl-k">|</span> sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/<span class="pl-smi">$distribution</span>/nvidia-docker.list <span class="pl-k">|</span> sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update <span class="pl-k">&amp;&amp;</span> sudo apt-get install -y nvidia-docker2<br/>sudo pkill -SIGHUP dockerd</pre>

### Step 2.3: Make NVIDIA Docker the default docker runtime

You will need to enable the Nvidia runtime as your default docker runtime on your node. We will be editing the docker daemon config file which is usually present at<span>&nbsp;</span>`` /etc/docker/daemon.json ``:

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

__Note__: Run:AI is customizing the NVIDIA device plugin (<https://github.com/NVIDIA/k8s-device-plugin>). Do&nbsp;__not&nbsp;__install this software as it is installed by Run:AI.&nbsp;

## Step 3: Install Run:AI

*   Log in to Run:AI at [https://app.run.ai.&nbsp;](https://app.run.ai)&nbsp;Use credentials provided by Run:AI Customer Support to log in to the system
*   If this is the first time anyone from your company has logged in, you will receive a dialog with instructions on how to install Run:AI on your Kubernetes Cluster.
*   If not, open the menu on the top left and select "Clusters". On the top right-click "Add New Cluster". Continue according to instructions to install Run:AI on your Kubernetes Cluster

## Step 4: Verifying your Installation

*   Go to <https://app.run.ai>
*   Go to the Overview Dashboard
*   Verify that the number of GPUs on the top right reflects your GPU resources on your cluster and the list of machines with GPU resources appear on the bottom line

## Next Steps

*   Researchers work via a Command-line interface (CLI). See&nbsp;<https://support.run.ai/hc/en-us/articles/360010706120-Installing-the-Run-AI-Command-Line-Interface>&nbsp;on how to install the CLI for users
*   <span class="wysiwyg-color-black">Set up Admin UI Users.&nbsp;<a href="https://support.run.ai/hc/en-us/articles/360011591340-Working-with-Admin-UI-Users" target="_self">https://support.run.ai/hc/en-us/articles/360011591340-Working-with-Admin-UI-Users</a></span>