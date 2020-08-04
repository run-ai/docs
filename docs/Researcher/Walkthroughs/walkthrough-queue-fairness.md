# Walk-through: Queue Fairness

## Goal

The goal of this walk-through is to explain __fairness__. The [over-quota walk-through](walkthrough-overquota.md) shows basic fairness where allocated GPUs per project are adhered to such that if a project is in over-quota, its job will be preempted once another project requires its resources.

This walk-through is about __queue fairness__. It shows that jobs will be scheduled fairly regardless of the time they have been submitted. As such, if a person in project A has submitted 50 jobs and soon after that, a person in project B has submitted 25 jobs, the jobs in the queue will be processed fairly.


## Setup and configuration:

* 4 GPUs on 2 machines with 2 GPUs each.
* 2 Projects: team-a and team-b with __1__ allocated GPU each.
* Run:AI canonical image gcr.io/run-ai-demo/quickstart


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
    * Two team-b jobs have immediately displaced team-a. 
    * team-a and team-b each have a quota of 1 GPU, thus the remaining over-quota (2 GPUs) is distributed equally between the projects.

## Part 2: Queue Fairness

Now lets start deleting jobs. Alternatively, you can wait for jobs to complete.

    runai delete b2 -p team-b

!!! Discussion
    As the quotas are equal (1 for each project, the remaining pending jobs will get scheduled one by one alternating between projects, regardless of the time in which they were submitted. 

