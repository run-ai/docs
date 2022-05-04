# Quickstart: Elasticity, Dynamically Stretch or Compress Workload's GPU Allocation


## Introduction

_Elasticity_ allows unattended, train-based workloads to __shrink__ or __expand__ based on the cluster's availability.

* Shrinking a training Job allows your workload to run on a smaller number of GPUs than the Researcher code was originally written for.
* Expanding a training Job allows your workload to run on more GPUs than the Researcher code was originally written for. 


## Prerequisites 

To complete this Quickstart you must have:

*   Run:ai software installed on your Kubernetes cluster. See: [Installing Run:ai on a Kubernetes Cluster](../../admin/runai-setup/installation-types.md)
*   Run:ai CLI installed on your machine. See: [Installing the Run:ai Command-Line Interface](../../admin/researcher-setup/cli-install.md)
*   [Run:ai Python Researcher Library](../researcher-library/researcher-library-overview.md) installed on a docker image

## Step by Step Walkthrough

### Setup

*   A GPU cluster with a __single__ node of __2__ GPUs. 

    *  If the cluster contains more than one node,  use [Node affinity](../../../admin/admin-ui-setup/project-setup/#further-affinity-refinement-by-the-researcher) to simulate a single node or use more filler Jobs as described below.
    *  If the cluster nodes contain more than 2 GPUs, you can create an interactive Job on a different project to consume the remaining GPUs.    


*   Login to the Projects area of the Run:ai user interface.
*   Add a Project named "team-a".
*   Allocate 2 GPUs to the Project.

### Expansion 

*   At the command-line run:
    
        runai config project team-a
        runai submit elastic1 -i gcr.io/run-ai-demo/quickstart -g 1 --elastic

* This would start an unattended training Job for team-a 
* The Job is based on a sample docker image ``gcr.io/run-ai-demo/quickstart``. We named the Job ``elastic1``and have requested 1 GPU for the Job
* The flag ``--elastic`` enables the Elasticity feature
* Follow up on the Job's progress by running:

        runai list workloads

    The result:

    ![elasticity1.png](img/elasticity1.png)


    !!! Discussion
        * The Job has requested 1 GPU but has been allocated with 2, as 2 are available right now.
        * The code needs to be ready to accept more GPUs than requested, otherwise, the GPUs will not be utilized. The Run:ai Elasticity library helps with expanding the Job effectively.

* Add a filler class:
        
        runai submit filler1 -i ubuntu -g 1 --interactive --command -- sleep infinity
        runai list workloads
    
    The result: 

    ![elasticity4.png](img/elasticity4.png)

    !!! Discussion
        An interactive Job (filler1) needs to be scheduled. The elastic Job is now reduced to the originally requested single-GPU.


* Finally, delete the Jobs:

        runai delete elastic1 filler1


### Shrinking

*   At the command-line run:
    
        runai submit filler2 -i ubuntu  -g 1 --interactive --command -- sleep infinity
        runai submit elastic2 -i gcr.io/run-ai-demo/quickstart -g 2 --elastic 

*   This would start a filler Job on 1 GPU and attempt to start another unattended Job with 2 GPUs


*   Follow up on the Job's progress by running:
    
        runai list workloads

    The result:

    ![elasticity2.png](img/elasticity2.png)


    !!! Discussion
        Since only a single GPU remains unallocated, under normal circumstances, the Job should not start. However, the ``--elastic`` flag tells the system to allocate a single GPU instead.


*   Delete the filler Job and list the Jobs again:

        runai delete filler2
        runai list workloads

    The result:

    ![elasticity3.png](img/elasticity3.png)

    !!! Discussion
        With the filler Job gone, the elastic Job has more room to expand, which it does.

*   Finally, delete the Job:

        runai delete elastic2



## See Also

* For more information on the elasticity module of the Researcher python library, see [Researcher library : Elasticity](../researcher-library/rl-elasticity.md)
* Keras Sample code in [Github](https://github.com/run-ai/docs/tree/master/quickstart/main){target=_blank}
* Pytorch Sample code in [Github](https://github.com/run-ai/docs/tree/master/quickstart/elasticity-pytorch){target=_blank}

