# Walk-through: Launch Interactive Build Workloads

## Introduction

Deep learning workloads can be divided into two generic types:

*   Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm or similar and accesses GPU resources directly. 
*   Unattended "training" sessions. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the customer can examine the results.

With this Walk-through you will learn how to:

*   Use the Run:AI command-line interface (CLI) to start a deep learning __Build__ workload
*   Open an ssh session to the Build workload
*   Stop the Build workload

It is also possible to open ports to specific services within the container. See "Next Steps" at the end of this article.

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
        runai submit build1 -i python -g 1 --interactive --command sleep --args infinity

*   The job is based on a sample docker image ``python``
*   We named the job _build1_.
*   Note the _interactive_ flag which means the job will not have a start or end. It is the researcher's responsibility to close the job. 
*   The job is assigned to team-a with an allocation of a single GPU. 
*   The command provided is ``--command sleep --args infinity``. You must provide a command or the container will start and then exit immediately. 

Follow up on the job's status by running:

    runai list

The result:

![mceclip20.png](img/mceclip20.png)

Typical statuses you may see:

*   ContainerCreating - The docker container is being downloaded from the cloud repository
*   Pending - the job is waiting to be scheduled
*   Running - the job is running

A full list of Job statuses can be found [here](../Scheduling/Job-Statuses.md)

To get additional status on your job run:

    runai get build1


### Get a Shell to the container

Run:

    runai bash build1

This should provide a direct shell into the computer

### View status on the Run:AI User Interface

*   Go to <https://app.run.ai>

*   Under "Jobs" you can view the new Workload:

![mceclip24.png](img/mceclip24.png)

 

### Stop Workload

Run the following:

    runai delete build1

This would stop the training workload. You can verify this by running ``runai list`` again.

## Next Steps

*   Expose internal ports to your interactive build workload: [Walk-through Launch an Interactive Build Workload with Connected Ports](walkthrough-build-ports.md).
*   Follow the Walk-through: [Walk-through Launch Unattended Training Workloads](walkthrough-train.md).