# Quickstart: Over-Quota and Bin Packing

## Goals

The goal of this Quickstart is to explain the concepts of over-quota and bin-packing (consolidation) and how they help in maximizing cluster utilization: 

* Show the simplicity of resource provisioning, and how resources are abstracted from users.
* Show how the system eliminates compute bottlenecks by allowing teams/users to go over their resource quota if there are free GPUs in the cluster.

## Setup and configuration:

* 4 GPUs on 2 machines with 2 GPUs each
* 2 Projects: team-a and team-b with 2 allocated GPUs each
* Run:ai canonical image gcr.io/run-ai-demo/quickstart

## Part I: Over-quota

Run the following commands:

    runai submit a2 -i gcr.io/run-ai-demo/quickstart -g 2 -p team-a
    runai submit a1 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-a
    runai submit b1 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-b

System status after run:
![overquota1](img/overquota1.png)


!!! Discussion
    * team-a has 3 GPUs allocated. Which is over its quota by 1 GPU. 
    * The system allows this over-quota as long as there are available resources
    * The system is at full capacity with all GPUs utilized. 

## Part 2: Basic Fairness via Preemption

Run the following command:

    runai submit b2 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-b

System status after run:
![overquota2](img/overquota2.png)

!!! Discussion
    * team-a can no longer remain in over-quota. Thus, one Job, must be _preempted_: moved out to allow team-b to grow.
    * Run:ai scheduler chooses to preempt Job _a1_.
    * It is important that unattended Jobs will save [checkpoints](../best-practices/save-dl-checkpoints.md). This will ensure that whenever Job _a1_ resume, it will do so from where it left off.

## Part 3: Bin Packing

Run the following command:

    runai delete job a2 -p team-a

_a1_ is now going to start running again.

Run:

    runai list jobs -A

You have __two__ Jobs that are running on the first node and __one__ Job that is running alone the second node. 

Choose one of the two Jobs from the full node and delete it:

    runai delete job <job-name> -p <project>

The status now is:
![overquota3](img/overquota3.png)

Now, run a 2 GPU Job:

    runai submit a2 -i gcr.io/run-ai-demo/quickstart -g 2 -p team-a

The status now is:
![overquota4](img/overquota4.png)

!!! Discussion 
    Note that Job _a1_ has been preempted and then restarted on the second node, in order to clear space for the new _a2_ Job. This is __bin-packing__ or __consolidation__





