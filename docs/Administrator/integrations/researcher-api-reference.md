
# Submit Endpoint

Create a new Run:AI job. 

## General Details

**URL**:  `http://<Run:AI Server URL>/api/job`

**Method**: `POST`

**Headers**

- `RA-USER` : <Name of user>


## Request Definition

Following JSON:

    {
      "job": {
        <JOB Parameters. See below>
      }
    }


## Job Parameters

**Basic Parameters**

`name` *string*

> The name of the Job.

`project`  *****string* **(**required)

> Name of an existing Run:AI project. Run:AI Projects are used by the scheduler to calculate resource eligibility.
    

`interactive` *boolean*

> Mark this Job as Interactive. Interactive Jobs are not terminated automatically by the system.

**Container Definition**

`image` *****string* (required) 

> Image to use when creating the container for this Job

`command`

> If set, overrides the image's entry point


    

`arguments` *Array<string>*

> Arguments for the container’s command
    

`environment` *Map<string>*

> Define environment variables to be set in the container.
> Example:
    {
      "environment": {
        "BATCH_SIZE"=50, 
        "LEARNING_RAGE"=0.2,
      }
    }
    

`imagePullPolicy` *string*

> Pulling policy of the image When starting a container.  
> Options are:
    - `*always*` *(default): force image pulling to check whether local image already exists. If the image already exists locally and has the same digest, then the image will not be downloaded.*
    - `*ifNotPresent*`*: the image is pulled only if it is not already present locally.*
    - `*never*`*: the image is assumed to exist locally. No attempt is made to pull the image.*
> For more information see Kubernetes [documentation](https://kubernetes.io/docs/concepts/configuration/overview/#container-images).
    

`stdin` *boolean*

> Keep stdin open for the container(s) in the pod, even if nothing is attached.  
    

`tty` *boolean*

> Allocate a pseudo-TTY.
    

`workingDir` *string*

> Starts the container with the specified directory as the current directory.
    

`createHomeDir` *boolean*

> Create a temporary home directory for the user in the container. Data saved in this directory will not be saved when the container exits. For more information see [non root containers](https://docs.run.ai/Administrator/Cluster-Setup/non-root-containers/).

**Resource Allocation Parameters**
`gpu` *double*

> Number of GPUs to allocated for the Job. The default is no allocated GPUs. the GPU value can be an integer or a fraction between 0 and 1.
    

`cpu` *double*

> CPU units to allocate for the Job (0.5, 1, .etc). The Job will receive **at least** this amount of CPU. Note that the Job will **not** be scheduled unless the system can guarantee this amount of CPUs to the Job.
    

`cpuLimit` *int*

> Limitations on the number of CPU consumed by the Job (0.5, 1, .etc). The system guarantees that this Job will not be able to consume more than this amount of GPUs.
    

`memory` *string*

> CPU memory to allocate for this Job (1G, 20M, .etc). The Job will receive **at least** this amount of memory. Note that the Job will **not** be scheduled unless the system can guarantee this amount of memory to the Job.

`memoryLimit` *string*

> CPU memory to allocate for this Job (1G, 20M, .etc). The system guarantees that this Job will not be able to consume more than this amount of memory. The Job will receive an error when trying to allocate more memory than this limit.
    

`largeShm` *boolean*

> Mount a large /dev/shm device. An shm is a shared file system mounted on RAM.

**Storage**
`pvc`  *Array of* `*PVC*` type *map (see below)*

> Mount a persistent volume claim of Network Attached Storage into a container. See https://kubernetes.io/docs/concepts/storage/persistent-volumes/
    type Pvc {
       storageClass string
       size         string
       path         string
       readOnly     boolean
    }

`volume` *Map<string>*

> Volume to mount into the container.
> For example:
    { 
      "volume": {
        "/raid/public/john/data": "/root/data"
      }
    }

**Network**
`hostIpc` *boolean*

> Use the host's ipc namespace. Controls whether the pod containers can share the host IPC namespace. IPC (POSIX/SysV IPC) namespace provides separation of named shared memory segments, semaphores and message queues. Shared memory segments are used to accelerate inter-process communication at memory speed, rather than through pipes or through the network stack.
> For further information see [docker run reference](https://docs.docker.com/engine/reference/run/%22).

`hostNetwork` *boolean*

> Use the host's network stack inside the container. For further information see [docker run reference](https://docs.docker.com/engine/reference/run/%22).

`ports` *Array<PortMap> (see below)*

> Expose ports from the Job container. Used together with ServiceType

**Job Lifecycle**
`backoffLimit` *int*

> The number of times the Job will be retried before failing. The default is 6. This flag will only work with training workloads (when the `interactive` flag is not set).

`completions` *int*

> The number of successful pods required for this Job to be completed. Used for [Hyperparameter optimization](https://docs.run.ai/Researcher/Walkthroughs/walkthrough-hpo/). Use together with `parallelism`.

`parallelism`  *int*

> The number of pods this Job tries to run in parallel at any time. Used for [Hyperparameter optimization](https://docs.run.ai/Researcher/Walkthroughs/walkthrough-hpo/). Use together with `completions`.

`elastic` *boolean*

> Mark the Job as elastic. For further information on Elasticity see [Elasticity Dynamically Stretch Compress Jobs According to GPU Availability](https://docs.run.ai/Researcher/researcher-library/rl-elasticity/).

`preemptible` *boolean*

> Mark an interactive Job as preemptible. Preemptible Jobs can be scheduled above guaranteed quota but may be reclaimed at any time.

`serviceType` *string*

> Service exposure method for interactive Job. 
> Options are: `loadbalancer`, `nodeport`, `ingress`.

`ttlAfterFinish` *string*

> Define the duration, post Job finish, after which the Job is automatically deleted (5s, 2m, 3h, etc).
> Note: This setting must first be enabled at the cluster level. See [Automatically Delete Jobs After Job Finish](https://docs.run.ai/Researcher/Scheduling/auto-delete-jobs/).

**Miscellaneous**
`preventPrivilegeEscalation` *boolean*

> Prevent the Job’s container and all launched processes from gaining additional privileges after the Job starts. Default is `false`. For more information see [non root containers](https://docs.run.ai/Administrator/Cluster-Setup/non-root-containers/).

`nodeType` *string*

> Allows defining specific nodes (machines) or a group of nodes on which the workload will run. 
    

`jobNamePrefix` *string*

> The prefix to use to automatically generate a Job name with an incremental index. When a Job name is omitted Run:AI will generate a Job name. The optional `--job-name-prefix flag` creates Job names with the provided prefix


## Response Definition

Following JSON:

    {
      "name":<new job name>
    }


## Submit Examples

**Basic job with auto-generated name**

    {
      "job": {
        "project": "RunAiProject",
        "image": "gcr.io/run-ai-demo/quickstart",
        "gpu": 1,
      }
    }

# Jobs list Endpoint

Gets the list of all Run:AI jobs of the given project

## General Details

**URL**:  `http://<Run:AI Server URL>/api/job`

**Method**: `GET`

## Request Definition

```
        "project"=<project-name>
```

## Response Definition
```
    {
    "data": Array<Job info>
    }
```

Job info:
```
        {
            "id": <JOB ID>,
            "project": <Job Project>,
            "name": <Job Name>
            "status": <Job status. Can be either: "Pending", "Running", "Succeeded", "Failed" or "Unknown"
            "type": <Job type. Can be either "Train" or "Interactive">
            "nodes": <the names of the nodes that are hosting the job>
            "createdAt": <unix timestamp in ms of the job's creation>,
            "images": <The job's image>,
            "user": "<the user that started the job>,
            "currentAllocatedGPUs": <number of GPUs allocated for the job>
        }
```


## Jobs list Example

request:
```
curl --location --request GET 'http://www.example.com/api/job?project=project-0'
```

response:

```
{
    "data": [
        {
            "id": "b915c8ec-19b6-4135-b473-164971278fff",
            "project": "project-0",
            "name": "job-0",
            "status": "Running",
            "type": "Train",
            "nodes": "node-0",
            "createdAt": 1609340976000,
            "images": "gcr.io/run-ai-demo/quickstart",
            "user": "Jhon Smith",
            "currentAllocatedGPUs": 1
        },
        {
            "id": "b915c8ec-19b6-4135-b473-164971278fff",
            "project": "project-0",
            "name": "job-1",
            "status": "Pending",
            "type": "Train",
            "nodes": "node-0",
            "createdAt": 1609340976000,
            "images": "gcr.io/run-ai-demo/quickstart",
            "user": "Jhon Smith",
            "currentAllocatedGPUs": 1
        }
    ]
}
```


    

