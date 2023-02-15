# Quickstart: Launch Interactive Build Workloads

## Introduction

Deep learning workloads can be divided into two generic types:

*   Interactive "build" sessions. With these types of workloads, the data scientist opens an interactive session, via bash, Jupyter notebook, remote PyCharm, or similar and accesses GPU resources directly. 
*   Unattended "training" sessions. With these types of workloads, the data scientist prepares a self-running workload and sends it for execution. During the execution, the customer can examine the results.

With this Quickstart you will learn how to:

*   Use the Run:ai command-line interface (CLI) to start a deep learning __Build__ workload
*   Open an ssh session to the Build workload
*   Stop the Build workload

It is also possible to open ports to specific services within the container. See "Next Steps" at the end of this article.

## Prerequisites 

To complete this Quickstart you must have:

*   Run:ai software installed on your Kubernetes cluster. See: [Installing Run:ai on a Kubernetes Cluster](../../admin/runai-setup/installation-types.md)
*   Run:ai CLI installed on your machine. See: [Installing the Run:ai Command-Line Interface](../../admin/researcher-setup/cli-install.md)

## Step by Step Quickstart

### Setup

*  Login to the Projects area of the Run:ai user interface.
*   Add a Project named "team-a".
*   Allocate 2 GPUs to the Project.

### Run Workload

*   At the command-line run:

        runai config project team-a
        runai submit build1 -i ubuntu -g 1 --interactive -- sleep infinity

*   The job is based on a sample docker image ``ubuntu``
*   We named the job _build1_.
*   Note the _interactive_ flag which means the job will not have a start or end. It is the Researcher's responsibility to close the job. 
*   The job is assigned to team-a with an allocation of a single GPU. 
*   The command provided is ``sleep infinity``. You must provide a command or the container will start and then exit immediately. Alternatively, replace these flags with `--attach` to attach immediately to a session.

Follow up on the job's status by running:

    runai list jobs

The result:

![mceclip20.png](img/mceclip20.png)

Typical statuses you may see:

*   ContainerCreating - The docker container is being downloaded from the cloud repository
*   Pending - the job is waiting to be scheduled
*   Running - the job is running

A full list of Job statuses can be found [here](../scheduling/job-statuses.md)

To get additional status on your job run:

    runai describe job build1


### Get a Shell to the container

Run:

    runai bash build1

This should provide a direct shell into the computer

### View status on the Run:ai User Interface

* Open the Run:ai user interface.
* Under "Jobs" you can view the new Workload:

![mceclip24.png](img/mceclip24.png)

 

### Stop Workload

Run the following:

    runai delete job build1

This would stop the training workload. You can verify this by running `runai list jobs` again.

## Next Steps

*   Expose internal ports to your interactive build workload: [Quickstart Launch an Interactive Build Workload with Connected Ports](walkthrough-build-ports.md).
*   Follow the Quickstart document: [Launch Unattended Training Workloads](walkthrough-train.md).
