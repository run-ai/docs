# Quickstart: Launch Unattended Training Workloads

## Introduction

Deep learning workloads can be divided into two generic types:

*   Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm, or similar and accesses GPU resources directly.
*   Unattended "training" sessions. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the customer can examine the results.

With this Quickstart you will learn how to:

*   Use the Run:ai command-line interface (CLI) to start a deep learning __training__ workload.
*   View training status and resource consumption using the Run:ai user interface and the Run:ai CLI.
*   View training logs.
*   Stop the training.

## Prerequisites 

To complete this Quickstart you must need the Run:ai CLI installed on your machine. There are two CLI versions:

* The older CLI. See installation [here](../../admin/researcher-setup/cli-install.md)
* A newer CLI, supported with clusters of version 2.18 and up. See installation [here](../../admin/researcher-setup/new-cli-install.md)

## Step by Step Walkthrough

### Setup

*  Login to the Projects area of the Run:ai user interface.
*  Add a Project named "team-a".
*  Allocate 2 GPUs to the Project.

### Run Workload

*   At the command-line run:

=== "Old CLI"
    ``` bash
    runai config project team-a   
    runai submit train1 -i gcr.io/run-ai-demo/quickstart -g 1
    ```

=== "New CLI"
    ``` bash
    runai project set team-a
    runai training submit train1 -i gcr.io/run-ai-demo/quickstart -g 1
    ```

This would start an unattended training Workload for team-a with an allocation of a single GPU. The Worlload is based on a [sample](https://github.com/run-ai/docs/tree/master/quickstart/main){target=_blank} docker image ``gcr.io/run-ai-demo/quickstart``. We named the Workload ``train1``

### List Workloads

Follow up on the Workload's progress by running:

=== "Old CLI"
    ``` bash
    runai list jobs
    ```
    The result:
    ![mceclip00.png](img/mceclip00.png)

=== "New CLI"
    ``` bash
    runai training list
    ```

    The result:

    ```
    Workload               Type        Status      Project     Preemptible      Running/Requested Pods     GPU Allocation
    ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    train1                 Training    Running     team-a      Yes              1/1                        0.00
    ```


Typical statuses you may see:

*   ContainerCreating - The docker container is being downloaded from the cloud repository
*   Pending - the Workload is waiting to be scheduled
*   Running - the Workload is running
*   Succeeded - the Workload has ended

A full list of Workload statuses can be found [here](../scheduling/job-statuses.md) 

### Describe Workload

To get additional status on your Workload run:

=== "Old CLI"
    ``` bash
    runai describe job train1
    ```

=== "New CLI"
    ``` bash
    runai training describe train1
    ```

### View Logs

Run the following:

=== "Old CLI"
    ```
    runai logs train1
    ```
=== "New CLI"
    ``` bash
    runai training logs train1
    ```
You should see a log of a running deep learning session:

![mceclip1.png](img/mceclip1.png)

### View status on the Run:ai User Interface

* Open the Run:ai user interface.
* Under "Workloads" you can view the new Training Workload:

![mceclip2.png](img/mceclip2.png)

Select the Workloads and press `Show Details` to see the Workload details

![mceclip4.png](img/mceclip4.png) 


Under Metrics you can see utilization graphs:

![mceclip5.png](img/mceclip5.png)

### Stop Workload

Run the following:

=== "Old CLI"
    ``` bash
    runai delete job train1
    ```

=== "New CLI"
    ```    
    runai training delete train1
    ```
  
This would stop the training workload. You can verify this by [listing](#list-workloads) training workloads again.

## Next Steps

*   Follow the Quickstart document: [Launch Interactive Workloads](walkthrough-build.md)
*   Use your container to run an unattended training workload