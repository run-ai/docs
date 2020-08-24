# Walk-through: Launch Unattended Training Workloads

## Introduction

Deep learning workloads can be divided into two generic types:

*   Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm or similar and accesses GPU resources directly.
*   Unattended "training" sessions. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the customer can examine the results.

With this Walk-through you will learn how to:

*   Use the Run:AI command-line interface (CLI) to start a deep learning __training__ workload
*   View training status and resource consumption using the Run:AI user interface and the Run:AI CLI
*   View training logs 
*   Stop the training

## Prerequisites 

To complete this walk-through you must have:

*   Run:AI software is installed on your Kubernetes cluster. See: [Installing Run:AI on an on-premise Kubernetes Cluster](../../Administrator/Cluster-Setup/cluster-install.md)
*   Run:AI CLI installed on your machine. See: [Installing the Run:AI Command-Line Interface](../../Administrator/Researcher-Setup/cli-install.md)

## Step by Step Walk-through

### Setup

*   Open the Run:AI user interface at <https://app.run.ai>
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Run Workload

*   At the command-line run:

        runai project set team-a
        runai submit train1 -i gcr.io/run-ai-demo/quickstart -g 1

This would start an unattended training job for team-a with an allocation of a single GPU. The job is based on a sample docker image ``gcr.io/run-ai-demo/quickstart``. We named the job ``train1``

*   Follow up on the job's progress by running:

        runai list

The result:

![mceclip00.png](img/mceclip00.png)

Typical statuses you may see:

*   ContainerCreating - The docker container is being downloaded from the cloud repository
*   Pending - the job is waiting to be scheduled
*   Running - the job is running
*   Succeeded - the job has ended

A full list of Job statuses can be found [here](../Scheduling/Job-Statuses.md) 

To get additional status on your job run:

    runai get train1

### View Logs

Run the following:

    runai logs train1

You should see a log of a running deep learning session:

![mceclip1.png](img/mceclip1.png)

### View status on the Run:AI User Interface

*   Go to <https://app.run.ai>
* Under "Jobs" you can view the new Workload:

![mceclip2.png](img/mceclip2.png)

The image we used for training includes the Run:AI Training library. Among other features, this library allows the reporting of metrics from within the deep learning job. Metrics such as progress, accuracy, loss, and epoch and step numbers.  

*   Progress can be seen in the status column above. 
*   To see other metrics, press the settings wheel on the top right ![mceclip4.png](img/mceclip4.png) and select additional deep learning metrics from the list


Under Nodes you can see node utilization:

![mceclip5.png](img/mceclip5.png)

### Stop Workload

Run the following:

    runai delete train1

This would stop the training workload. You can verify this by running ``runai list`` again.

## Next Steps

*   Follow the Walk-through: [Launch Interactive Workloads](walkthrough-build.md)
*   Use your own containers to run an unattended training workload