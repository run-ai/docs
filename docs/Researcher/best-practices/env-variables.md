# Environment Variables inside a Run:ai Workload


## Identifying a Job
There may be use cases where your container may need to uniquely identify the Job it is currently running in. A typical use case is for saving Job artifacts under a unique name. 
Run:ai provides pre-defined environment variables you can use. These variables are guaranteed to be unique even if the Job is preempted or evicted and then runs again. 

Run:ai provides the following environment variables:

* ``JOB_NAME`` - the name of the Job.
* ``JOB_UUID`` - a unique identifier for the Job. 

Note that the Job can be deleted and then recreated with the same name. A Job UUID will be different even if the Job names are the same.


## Identifying a Pod 

With [Hyperparameter Optimization](../Walkthroughs/walkthrough-hpo.md), experiments are run as _Pods_ within the Job. Run:ai provides the following environment variables to identify the Pod.

* ``POD_INDEX`` -  An index number (0, 1, 2, 3....) for a specific Pod within the Job. This is useful for Hyperparameter Optimization to allow easy mapping to individual experiments. The Pod index will remain the same if restarted (due to a failure or preemption). Therefore, it can be used by the Researcher to identify experiments. 
* ``POD_UUID`` - a unique identifier for the Pod. if the Pod is restarted, the Pod UUID will change.

## GPU Allocation

Run:ai provides an environment variable, visible inside the container, to help identify the number of GPUs allocated for the container. Use `RUNAI_NUM_OF_GPUS`

## Node Name

There may be use cases where your container may need to identify the node it is currently running on. Run:ai provides an environment variable, visible inside the container, to help identify the name of the node on which the pod was scheduled. Use `NODE_NAME`


## Usage Example in Python

``` python
import os

jobName = os.environ['JOB_NAME']
jobUUID = os.environ['JOB_UUID']
```
