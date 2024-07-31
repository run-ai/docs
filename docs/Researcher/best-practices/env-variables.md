# Environment Variables inside a Run:ai Workload


## Identifying a Job
There may be use cases where your container may need to uniquely identify the Job it is currently running in. A typical use case is for saving Job artifacts under a unique name. 
Run:ai provides pre-defined environment variables you can use. These variables are guaranteed to be unique even if the Job is preempted or evicted and then runs again. 

Run:ai provides the following environment variables:

* ``JOB_NAME`` - the name of the Job.
* ``JOB_UUID`` - a unique identifier for the Job. 

Note that the Job can be deleted and then recreated with the same name. A Job UUID will be different even if the Job names are the same.


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
