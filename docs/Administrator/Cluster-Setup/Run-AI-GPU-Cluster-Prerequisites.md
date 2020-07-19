Run:AI helps organizations optimize the resources of a data science operation. Below are the prerequisites of the Run:AI solution.&nbsp;

__Important note__: This document relates to the cloud version of Run:AI and discusses the prerequisites for the GPU Cluster.&nbsp;

# Kubernetes Software

Run:AI requires Kubernetes 1.15 or above. Kubernetes 1.17 is recommended (as of June 2020).

If you are using Red Hat OpenShift. The minimal version is&nbsp; OpenShift 4.3 which runs on Kubernetes 1.16&nbsp;

# NVIDIA Driver

Run:AI requires all GPU nodes to be installed with NVIDIA driver version&nbsp;<span>384.81 or later due to this&nbsp;<a href="https://github.com/NVIDIA/k8s-device-plugin#prerequisites" target="_self">dependency.</a></span>

# Hardware Requirements

*   __Kubernetes: Dedicated CPU-only machine:__&nbsp;To save on expensive GPUs-based hardware, we recommend a dedicated, CPU-only machine, that is not running user workloads.&nbsp; Run:AI requires the following resources <span class="wysiwyg-underline">on top</span> of the Kubernetes hardware requirements
    
    *   2GB of RAM
    *   20GB of Disk space&nbsp;
    
    
    
*   __Shared data volume:__ Run:AI, via Kubernetes,&nbsp;abstracts away the machine on which a container is running.&nbsp;For containers to run anywhere, they need to be able to access data from any machine in a uniform way. Typically, this requires a NAS (Network-attached storage) which allows any node to connect to storage outside the box.

# Network Requirements

Run:AI user interface runs from the cloud. All container nodes must be able to connect to the Run:AI cloud.&nbsp;Inbound connectivity (connecting from the cloud into nodes) is not required. If outbound connectivity is proxied/limited, the following exceptions should be applied:&nbsp;

## During Installation

Run:AI requires an installation over the Kubernetes cluster. The installation access the web to download various images and registries. Some organizations place limitations on what you can pull from the internet. The following list shows the various solution components and their origin:&nbsp;

<table border="1" style="width: 707px; margin-left: 0px; margin-right: auto;">
<tbody>
<tr>
<th scope="row" style="width: 114.375px;">Name</th>
<th scope="row" style="width: 308.92px;">Description</th>
<th scope="row" style="width: 227.102px;">URLs</th>
<th scope="row" style="width: 43.4659px;">Ports</th>
</tr>
<tr>
<td style="padding: 6px; width: 104.375px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Run:AI&nbsp; Repository</font> </span></p>
</td>
<td style="padding: 6px; width: 298.92px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif"> The Run:AI Package Repository is hosted on Run:AI’s account on Google Cloud </font> </span></p>
</td>
<td style="padding: 6px; width: 217.102px;">
<p><font color="#333333" face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif"> <span style="font-size: 15px;"><a href="http://runai-charts.storage.googleapis.com/"><span>runai-charts.storage.googleapis.com</span></a><span>&nbsp;</span></span> </font></p>
</td>
<td style="padding: 6px; width: 33.4659px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">443</font> </span></p>
</td>
</tr>
<tr>
<td style="padding: 6px; width: 104.375px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Docker Images Repository</font> </span></p>
</td>
<td style="padding: 6px; width: 298.92px;">
<p><span style="font-weight: 400;"><font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Various Run:AI images</font></span></p>
</td>
<td style="padding: 6px; width: 217.102px;">
<p><a href="http://hub.docker.com/"><span><font color="#333333" face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">hub.docker.com</font></span></a></p>
<p><span><font color="#333333" face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">gcr.io/run-ai-prod&nbsp;</font></span></p>
</td>
<td style="padding: 6px; width: 33.4659px;">
<p><span style="font-weight: 400;"><font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">443</font> </span></p>
</td>
</tr>
<tr>
<td style="padding: 6px; width: 104.375px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Docker Images Repository</font> </span></p>
</td>
<td style="padding: 6px; width: 298.92px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Various third party Images</font></span></p>
</td>
<td style="padding: 6px; width: 217.102px;">
<p><font color="#333333" face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif"> <span style="font-size: 15px;"><a href="http://quay.io/"><span>quay.io</span></a>&nbsp;</span> </font></p>
</td>
<td style="padding: 6px; width: 33.4659px;">
<p><font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif"> <span style="font-size: 15px;">443&nbsp;</span> </font></p>
</td>
</tr>
</tbody>
<caption>
<p>&nbsp;</p>
</caption>
</table>

## Post Installation

In addition, once running, Run:AI will send metrics to two sources:

<table border="1" style="margin-left: 0px; margin-right: auto;">
<tbody>
<tr style="height: 22px;">
<th scope="row" style="width: 116px; height: 22px;">Name</th>
<th scope="row" style="width: 314px; height: 22px;">Description</th>
<th scope="row" style="width: 215px; height: 22px;">URLs</th>
<th scope="row" style="width: 42px; height: 22px;">Ports</th>
</tr>
<tr>
<td style="padding: 6px; width: 106px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Grafana&nbsp;</font> </span></p>
</td>
<td style="padding: 6px; width: 304px;">
<p>Grafana&nbsp;&nbsp; <span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Metrics Server</font> </span></p>
</td>
<td style="padding: 6px; width: 205px;">
<p>prometheus-us-central1.grafana.net</p>
</td>
<td style="padding: 6px; width: 32px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">443</font> </span></p>
</td>
</tr>
<tr>
<td style="padding: 6px; width: 106px;">
<p><font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Run:AI</font></p>
</td>
<td style="padding: 6px; width: 304px;">
<p>&nbsp;Run:AI&nbsp; <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">Cloud instance</font></p>
</td>
<td style="padding: 6px; width: 205px;">
<p><font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif"> <span style="font-size: 15px;">app.run.ai</span> </font></p>
<p>&nbsp;</p>
</td>
<td style="padding: 6px; width: 32px;">
<p><span style="font-weight: 400;"> <font face="-apple-system, system-ui, Segoe UI, Helvetica, Arial, sans-serif">443</font> </span></p>
</td>
</tr>
</tbody>
</table>

# User requirements

__Usage of containers and images:__&nbsp;The individual researcher's work is based on container images. Containers allow IT to create standard software environments based on mix and match of various cutting-edge software&nbsp;

# Fractional GPU Requirements

The Run:AI platform provides a unique technology that allows the sharing of a single GPU between multiple containers. Each container receives an isolated subset of the GPU memory. For more details see&nbsp;[https://support.run.ai/hc/en-us/articles/360014989740-Walkthrough-Using-GPU-Fractions.](https://support.run.ai/hc/en-us/articles/360014989740-Walkthrough-Using-GPU-Fractions)

This technology has more stringent software requirements than the rest of the Run:AI system. Specifically, virtualization has been tested on:

*   NVIDIA device driver 418 or later
*   Cuda 9.0 or later
*   TensorFlow, Keras or Pytorch

We keep testing the technology on additional software.