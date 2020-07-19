# Introduction

Deep learning workloads can be divided into two generic types:

*   Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm or similar and accesses GPU resources directly.&nbsp;
*   Unattended "training" sessions. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the customer can examine the results.

With this Walkthrough you will learn how to:

*   Use the Run:AI command-line interface (CLI) to start a deep learning __build__ workload
*   Open an ssh session to the build workload
*   Stop the build workload

It is also possible to open ports to specific services within the container. See "Next Steps" at the end of this article.

# Prerequisites&nbsp;

To complete this walkthrough you must have:

*   Run:AI software is installed on your Kubernetes cluster. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360010280179-Installing-Run-AI-on-an-on-premise-Kubernetes-Cluster>
*   Run:AI CLI installed on your machine. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360010706120-Installing-the-Run-AI-Command-Line-Interface>

# Step by Step Walkthrough

## Setup

*   Open the Run:AI user interface at <https://app.run.ai>
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

## Run Workload

*   At the command line run:

<div>
<pre>runai project set team-a<br/><br/>runai submit build1 -i gcr.io/run-ai-lab/build-demo -g 1 --interactive</pre>
</div>

*   The job is based on a sample docker image&nbsp;_gcr.io/run-ai-lab/build-demo_<span>&nbsp;</span>
*   <span>We named the job _build1.&nbsp;_</span>
*   Note the "interactive" flag which means the job will not have a start or end. It is the researcher's responsibility to close the job.&nbsp;
*   The job is assigned to team-a with an allocation of a single GPU.&nbsp;

Follow up on the job's status by running:

<pre>runai list</pre>

The result:

![mceclip0.png](https://support.run.ai/hc/article_attachments/360014011199/mceclip0.png)

Typical statuses you may see:

*   ContainerCreating - The docker container is being downloaded from the cloud repository
*   Pending - the job is waiting to be scheduled
*   Running - the job is running

To get additional status on your job run:

<pre>runai get build1</pre>

&nbsp;
&nbsp;

## Get a Shell to the container

Run:

<pre>runai bash build1</pre>

This should provide a direct shell into the computer

## View status on the Run:AI User Interface

*   Go to <https://app.run.ai>
*   Under Dashboards | Overview you should see:

![mceclip3.png](https://support.run.ai/hc/article_attachments/360006988279/mceclip3.png)

*   Under "Jobs" you can view the new Workload:

![mceclip4.png](https://support.run.ai/hc/article_attachments/360006983560/mceclip4.png)

&nbsp;

## Stop Workload

Run the following:

<pre>runai delete build1</pre>

This would stop the training workload. You can verify this by running_&nbsp;runai list_ again.

# Next Steps

*   Expose internal ports to your interactive build workload:&nbsp;<https://support.run.ai/hc/en-us/articles/360011131919-Walkthrough-Launch-an-Interactive-Build-Workload-with-Connected-Ports>&nbsp;
*   Follow the Walkthrough: Launch unattended training workloads&nbsp;<https://support.run.ai/hc/en-us/articles/360010706360-Walkthrough-Launch-Unattended-Training-Workloads->&nbsp;