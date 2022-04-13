# Quickstart: Queue Fairness

## Goal

The goal of this Quickstart is to explain __fairness__. The [over-quota Quickstart](walkthrough-overquota.md) shows basic fairness where allocated GPUs per Project are adhered to such that if a Project is in over-quota, its Job will be preempted once another Project requires its resources.

This Quickstart is about __queue fairness__. It shows that Jobs will be scheduled fairly regardless of the time they have been submitted. As such, if a person in Project A has submitted 50 Jobs and soon after that, a person in Project B has submitted 25 Jobs, the Jobs in the queue will be processed fairly.


## Setup and configuration:

* 4 GPUs on 2 machines with 2 GPUs each.
* 2 Projects: team-a and team-b with __1__ allocated GPU each.
* Run:ai canonical image gcr.io/run-ai-demo/quickstart


## Part I: Immediate Displacement of Over-Quota

Run the following commands:

    runai submit a1 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-a
    runai submit a2 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-a
    runai submit a3 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-a
    runai submit a4 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-a

System status after run:
![overquota-fairness11](img/overquota-fairness1.png)


!!! Discussion
    team-a, even though it has a single GPU as quota, is now using all 4 GPUs.


Run the following commands:

    runai submit b1 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-b
    runai submit b2 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-b
    runai submit b3 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-b
    runai submit b4 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-b

System status after run:
![overquota-fairness12](img/overquota-fairness2.png)


!!! Discussion
    * Two team-b Jobs have immediately displaced team-a. 
    * team-a and team-b each have a quota of 1 GPU, thus the remaining over-quota (2 GPUs) is distributed equally between the Projects.

## Part 2: Queue Fairness

Now lets start deleting Jobs. Alternatively, you can wait for Jobs to complete.

    runai delete job b2 -p team-b

!!! Discussion
    As the quotas are equal (1 for each Project, the remaining pending Jobs will get scheduled one by one alternating between Projects, regardless of the time in which they were submitted. 

