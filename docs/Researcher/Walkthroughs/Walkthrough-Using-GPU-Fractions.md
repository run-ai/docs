## Introduction

Run:AI provides a Fractional GPU sharing system for containerized workloads on Kubernetes. The system supports workloads running CUDA programs and is especially suited for lightweight AI tasks such as inference and model building. The fractional GPU system transparently gives data science and AI engineering teams the ability to run multiple workloads simultaneously on a single GPU, enabling companies to run more workloads such as computer vision, voice recognition and natural language processing on the same hardware, lowering costs.

Run:AI’s fractional GPU system effectively creates virtualized logical GPUs, with their own memory and computing space that containers can use and access as if they were self-contained processors. This enables several workloads to run in containers side-by-side on the same GPU without interfering with each other. The solution is transparent, simple, and portable; it requires no changes to the containers themselves.

A typical use-case could see 2-8 jobs running on the same GPU, meaning you could do eight times the work with the same hardware.&nbsp;

## Prerequisites&nbsp;

To complete this walkthrough you must have:

*   Run:AI software is installed on your Kubernetes cluster. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360010280179-Installing-Run-AI-on-an-on-premise-Kubernetes-Cluster>
*   Run:AI CLI installed on your machine. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360010706120-Installing-the-Run-AI-Command-Line-Interface>

## Step by Step Walkthrough

### Setup

*   Open the Run:AI user interface at<span>&nbsp;</span><https://app.run.ai>
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 1 GPU to the project

### Run Workload

*   At the command line run:

<pre>runai project set team-a<br/><br/>runai submit frac05 -i gcr.io/run-ai-demo/quickstart -g 0.5 --interactive<br/>runai submit frac03 -i gcr.io/run-ai-demo/quickstart -g 0.3 --interactive </pre>

*   The jobs are based on a sample docker image<span>&nbsp;</span>_gcr.io/run-ai-demo/quickstart_ the image contains a startup script that runs a deep learning TensorFlow-based workload.
*   <span>We named the jobs&nbsp;_frac05&nbsp;_and_&nbsp;frac03&nbsp;_respectively_.&nbsp;_</span>
*   Note the "interactive" flag which means the job will not have a start or end. It is the researcher's responsibility to delete the job. Currently, all jobs using GPU fractions must be interactive.&nbsp;
*   The jobs are assigned to<span>&nbsp;</span>_team-a_<span>&nbsp;</span>with an allocation of a single GPU.&nbsp;

Follow up on the job's status by running:

<pre>runai list</pre>

The result:

![mceclip0.png](https://support.run.ai/hc/article_attachments/360013997340/mceclip0.png)

Note that both jobs were allocated to the __same__ node.

When both jobs are running, bash into one of them:

<pre>runai bash frac05</pre>

&nbsp;Now, inside the container,&nbsp; run:&nbsp;

<pre>nvidia-smi</pre>

The result:

![mceclip2.png](https://support.run.ai/hc/article_attachments/360014014239/mceclip2.png)

Notes:

*   The total memory is circled in red. It should be 50% of the GPUs memory size. In the picture above we see 8GB which is half of the 16GB of Tesla V100 GPUs.
*   The script running on the container is limited by 8GB. In this case, TensorFlow, which tends to allocate almost all of the GPU memory has allocated 7.7GB RAM (and not close to 16 GB). Overallocation beyond 8GB will lead to an out-of-memory exception