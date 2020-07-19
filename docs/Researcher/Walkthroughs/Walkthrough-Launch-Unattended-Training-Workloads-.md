## Introduction

Deep learning workloads can be divided into two generic types:

*   Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm or similar and accesses GPU resources directly.&nbsp;
*   Unattended "training" sessions. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the customer can examine the results.

With this Walkthrough you will learn how to:

*   Use the Run:AI command-line interface (CLI) to start a deep learning __training__ workload
*   View training status and resource consumption using the Run:AI user interface and the Run:AI CLI
*   View training logs&nbsp;
*   Stop the training

## Prerequisites&nbsp;

To complete this walkthrough you must have:

*   Run:AI software is installed on your Kubernetes cluster. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360010280179-Installing-Run-AI-on-an-on-premise-Kubernetes-Cluster>
*   Run:AI CLI installed on your machine. See:&nbsp;<https://support.run.ai/hc/en-us/articles/360010706120-Installing-the-Run-AI-Command-Line-Interface>

## Step by Step Walkthrough

### Setup

*   Open the Run:AI user interface at <https://app.run.ai>
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Run Workload

*   At the command line run:

<pre><span>runai project set team-a<br/>runai submit hyper1 -i gcr.io/run-ai-demo/quickstart -g 1<br/></span></pre>

This would start an unattended training job for team-a with an allocation of a single GPU. The job is based on a sample docker image&nbsp;<span>_gcr.io/run-ai-lab/quickstart_. We named the job&nbsp;_hyper1_</span>

*   Follow up on the job's progress by running:

<pre>runai list</pre>

The result:

![mceclip0.png](https://support.run.ai/hc/article_attachments/360014010719/mceclip0.png)

Typical statuses you may see:

*   ContainerCreating - The docker container is being downloaded from the cloud repository
*   Pending - the job is waiting to be scheduled
*   Running - the job is running
*   Succeeded - the job has ended

&nbsp;

To get additional status on your job run:

<pre>runai get hyper1</pre>

### View Logs

Run the following:

<pre>runai logs <span>hyper1</span></pre>

You should see a log of a running deep learning session:

![mceclip1.png](https://support.run.ai/hc/article_attachments/360006987919/mceclip1.png)

### View status on the Run:AI User Interface

*   Go to <https://app.run.ai>
*   Under Dashboards | Overview you should see:

![mceclip3.png](https://support.run.ai/hc/article_attachments/360006988279/mceclip3.png)

&nbsp;

Under "Jobs" you can view the new Workload:

![mceclip3.png](https://support.run.ai/hc/article_attachments/360007522759/mceclip3.png)

The image we used for training includes the Run:AI Training library. Among other features, this library allows the reporting of metrics from within the deep learning job. Metrics such as progress, accuracy, loss, and epoch and step numbers.&nbsp;&nbsp;

*   Progress can be seen in the status column above.&nbsp;
*   To see other metrics, press the settings wheel on the top right&nbsp;![mceclip4.png](https://support.run.ai/hc/article_attachments/360007522779/mceclip4.png)&nbsp;and select additional deep learning metrics from the list

&nbsp;

Under Nodes you can see node utilization:

![mceclip2.png](https://support.run.ai/hc/article_attachments/360007522519/mceclip2.png)

### Stop Workload

Run the following:

<pre>runai delete hyper1</pre>

This would stop the training workload. You can verify this by running _runai list_ again.

## Next Steps

*   Follow the Walkthrough: Launch Interactive Workloads&nbsp;<https://support.run.ai/hc/en-us/articles/360010894959-Walkthrough-Start-and-Use-Interactive-Build-Workloads->&nbsp;
*   Use your own containers to run an unattended training workload