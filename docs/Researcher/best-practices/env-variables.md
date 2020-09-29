# Best Practice: Identifying your Job from within the Container

## Motivation

There may be use cases where your container may need to uniquely identify the job it is currently running in. A typical use case is for saving job artifacts under a unique name. 

Run:AI provides environment variables you can use. These variables are guaranteed to be unique even if the job is preempted or evicted and then runs again. 

## Identifying your Job

Run:AI provides the following environment variables:

* ``jobName`` - the name of the job
* ``jobUUID`` - a unique identifier for the job. 

Note that the job can be deleted and then recreated with the same name. A job UUID will be different even if the job names are the same.

## Usage Example in Python

``` python
import os

jobUUID = os.environ['jobUUID']
jobName = os.environ['jobName']
```