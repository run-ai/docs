# Walk-through: Elasticity: Dynamically Stretch or Compress Workload's GPU Quota


## Introduction

_Elasticity_ allows unattended, train-based  workloads to __shrink__ or __expand__ based on the cluster's availability.

* Shrinking a training job allows your workload to run on a smaller number of GPUs than the researcher code was originally written for.
* Expanding a training job allows your GPUs to runs on more GPUs than the researcher code was originally written for. 

## Prerequisites 

To complete this walk-through you must have:

*   Run:AI software is installed on your Kubernetes cluster. See: [Installing Run:AI on an on-premise Kubernetes Cluster](../../Administrator/Cluster-Setup/cluster-install.md)
*   Run:AI CLI installed on your machine. See: [Installing the Run:AI Command-Line Interface](../../Administrator/Researcher-Setup/cli-install.md)

## Step by Step Walk-through

### Setup

*   A GPU cluster with a __single__ node of __2__ GPUs. 

    *  If your cluster nodes contain more than 2 GPUs, you can create an interactive job on a different project to consume the remaining GPUs.    
    *  If the cluster contains more than one node,  use [Node affinity](../../Administrator/Admin-User-Interface-Setup/Working-with-Projects/#further-affinity-refinement-by-the-researcher) to simulate a single node. Or use more filler jobs as described below.

*   Open the Run:AI user interface at <https://app.run.ai>
*   Login
*   Go to "Projects"
*   Add a project named "team-a"
*   Allocate 2 GPUs to the project

### Expansion 

*   At the command-line run:

        runai project set team-a
        runai submit elastic1 -i gcr.io/run-ai-demo/quickstart -g 1 --elastic 

* This would start an unattended training job for team-a. 
* The job is based on a sample docker image ``gcr.io/run-ai-demo/quickstart``. We named the job ``elastic1``and have allocated 2 GPUs for the job

*   Follow up on the job's progress by running:

        runai list

The result:

```
~> runai list
Showing jobs for project team-a
NAME      STATUS   AGE  NODE      IMAGE                          TYPE   PROJECT  USER   GPUs (Allocated/Requested)  PODs Running (Pending)
elastic1  Running  36s  worker-1  gcr.io/run-ai-demo/quickstart  Train  team-a   yaron  2/1                         1 (0)
```

!!! Discussion
* The Job has requested 2 GPUs, but has been allocated with 2. As 2 are available right now.
* The Job needs to be ready to accept more GPUs than it requested, otherwise, the GPUs will not be utilized. The Run:AI Elasticity library helps with expanding the job effectively.

Finally, delete the job:

    runai delete elastic1


### Shrinking

*   At the command-line run:

        runai submit filler1 -i ubuntu --command sleep --args infinity -g 1 --interactive
        runai submit elastic2 -i gcr.io/run-ai-demo/quickstart -g 2 --elastic 

* This would start a filler job on 1 GPU and attempt to start another unattended job with 2 GPUs.  
* Since only a single GPU remains, under normal circumstances, the job should not start. However, the ``--elastic`` flag tells the system to allocate a single GPU instead.

*   Follow up on the job's progress by running:

        runai list

The result:

```
~> runai list
Showing jobs for project team-a
NAME      STATUS   AGE  NODE      IMAGE                          TYPE         PROJECT  USER   GPUs (Allocated/Requested)  PODs Running (Pending)  
elastic2  Running  1h   worker-1  gcr.io/run-ai-demo/quickstart  Train        team-a   yaron  1/2                         1 (0)
filler1   Running  1h   worker-1  ubuntu                         Interactive  team-a   yaron  1/1                         1 (0)
```


Finally, delete the jobs:

    runai delete elastic2, filler1


## Elasticity Sample Code

>>XXXX

## See Also

* For more information on the elasticity module of the Researcher python library, see [Researcher library : Elasticity](../researcher-library/rl-elasticity.md)
