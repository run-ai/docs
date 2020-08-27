# Walk-through: Elasticity: Dynamically Stretch or Compress Workload's GPU Quota


## Introduction

_Elasticity_ allows _train_ workloads to __shrink__ or __expand__ based on the cluster's availability.
* Shrinking a training job allows your workload to run on a smaller number of GPUs than the researcher code was originally written for.
* Expanding a training job allows your GPUs to runs on more GPUs than the researcher code was originally written for. 

For more information on The Elasticity module see [Researcher library : Elasticity](../researcher-library/rl-elasticity.md)

## Prerequisites 

To complete this walk-through you must have:

*   Run:AI software is installed on your Kubernetes cluster. See: [Installing Run:AI on an on-premise Kubernetes Cluster](../../Administrator/Cluster-Setup/cluster-install.md)
*   Run:AI CLI installed on your machine. See: [Installing the Run:AI Command-Line Interface](../../Administrator/Researcher-Setup/cli-install.md)

## Step by Step Walk-through

### Setup

*   A GPU cluster with a __single__ node of 4 GPUs or more. If there are other nodes, you can use [Node affinity](../../Administrator/Admin-User-Interface-Setup/Working-with-Projects/#further-affinity-refinement-by-the-researcher) to simulate a single node.
*   Open the Run:AI user interface at <https://app.run.ai>
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Run Workload

*   At the command-line run:

        runai project set team-a
        runai submit elastic1 -i gcr.io/run-ai-demo/quickstart -g 2 --elastic 

* This would start an unattended training job for team-a. 
* The job is based on a sample docker image ``gcr.io/run-ai-demo/quickstart``. We named the job ``elastic1``
* We allocated 2 GPUs for the job

*   Follow up on the job's progress by running:

        runai list

The result:

![mceclipxx.png](img/mceclip00.png)


!!! Discussion
* The Job has requested 2 GPUs, but has been allocated with 4. As 4 are available right now.
* The Job needs to be ready to accept more GPUs than it requested, otherwise, the GPUs will not be utilized. The Run:AI Elasticity library helps with expanding and shrinking XXXX




### Stop Workload

Run the following:

    runai delete train1

This would stop the training workload. You can verify this by running ``runai list`` again.

## Next Steps

*   Follow the Walk-through: [Launch Interactive Workloads](walkthrough-build.md)
*   Use your own containers to run an unattended training workload