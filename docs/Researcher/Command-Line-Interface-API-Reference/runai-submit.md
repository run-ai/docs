## Description

Submit a Run:AI job for execution

## Synopsis

    runai submit job-name 
        [--always-pull-image] 
        [--args stringArray] 
        [--backoffLimit int] 
        [--command stringArray] 
        [--cpu double] 
        [--cpu-limit double] 
        [--elastic] 
        [--environment stringArray | -e stringArray] 
        [--gpu int | -g int] 
        [--host-ipc] 
        [--host-network] 
        [--image string | -i string] 
        [--interactive] [--jupyter] 
        [--large-shm] 
        [--local-image] 
        [--memory string] 
        [--memory-limit string] 
        [--node-type string] 
        [--port stringArray] 
        [--preemptible] 
        [--pvc [StorageClassName]:Size:ContainerMountPath:[ro]]
        [--run-as-user] 
        [--service-type string | -s string] 
        [--template string] 
        [--ttl-after-finish duration] 
        [--volume stringArray | -v stringArray] 
        [--working-dir] 
        .
        [--loglevel string] 
        [--project string | -p string] 
        [--help | -h]

 Syntax notes:

*   Options with value type of stringArray mean that you can add multiple values. You can either separate values with a comma or add the flag twice.

## Options

<job-name\> the name of the job.

--always-pull-image stringArray

>  When starting a container, always pull the image from the registry, even if the image is cached on the running node. This is useful when you are re-saving updates to the image using the same tag.

--args stringArray

>  Arguments to pass to the command run on container start. Use together with ``--command``.   
>  Example: ``--command sleep --args 10000`` 

--backoffLimit int
 
> The number of times the job will be retried before failing. The default is 6. This flag will only work with training workloads (when the ``--interactive`` flag is not specified)

--command stringArray

>  Command to run at container start. Use together with ``--args``.

--cpu double

> CPU units to allocate for the job (0.5, 1, .etc). The Job will receive at least this amount of CPU. Note that the Job will __not__ be scheduled unless the system can guarantee this amount of CPUs to the job.

--cpu-limit double

> Limitations on the number of CPU consumed by the job (0.5, 1, .etc). The system guarantees that this Job will not be able to consume more than this amount of GPUs.

--elastic

> Mark the job as elastic. For further information on Elasticity see [Elasticity Dynamically Stretch Compress Jobs According to GPU Availability](../Run-AI-Researcher-Library/Elasticity-Dynamically-Stretch-Compress-Jobs-According-to-GPU-Availability.md)
> 

-e stringArray | --environment stringArray

>  Define environment variables to be set in the container. To set multiple values add the flag multiple times (``-e BATCH_SIZE=50 -e LEARNING_RATE=0.2``) or separate by a comma (``-e BATCH_SIZE:50,LEARNING_RATE:0.2``)

--gpu int | -g int

>  Number of GPUs to allocation to the Job. The default is no GPUs.

--host-ipc

>  Use the host's ipc namespace. Controls whether the pod containers can share the host IPC namespace. IPC (POSIX/SysV IPC) namespace provides separation of named shared memory segments, semaphores and message queues.
> Shared memory segments are used to accelerate inter-process communication at memory speed, rather than through pipes or through the network stack
> 
> For further information see docker <a href="https://docs.docker.com/engine/reference/run/" target="_self">documentation</a>


--host-network

>  Use the host's network stack inside the container
>  For further information see docker <a href="https://docs.docker.com/engine/reference/run/" style="background-color: #ffffff; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;" target="_self">documentation</a>

--image string | -i string

>  Image to use when creating the container for this Job

--interactive

>  Mark this Job as Interactive. Interactive jobs are not terminated automatically by the system

--jupyter

>  (Deprecated) Shortcut for running a Jupyter notebook container. Uses a pre-created image and a default notebook configuration. Use the s flag instead.

--large-shm
 
> Mount a large /dev/shm device. _shm_ is a shared file system mounted on RAM

--local-image

>  Use a local image for this job. A local image is an image which exists on all local servers of the Kubernetes Cluster.

--memory string

>  CPU memory to allocate for this job (1G, 20M, .etc).The Job will receive at least this amount of memory. Note that the Job will __not__ be scheduled unless the system can guarantee this amount of memory to the job.

--memory-limit string

>  CPU memory to allocate for this job (1G, 20M, .etc).The system guarantees that this Job will not be able to consume more than this amount of memory. The Job will receive an error when trying to allocate more memory than this limit.

--node-type string

>  Allows defining specific nodes (machines) or a group of nodes on which the workload will run. To use this feature your administrator will need to label nodes as explained here: [Limit a Workload to a Specific Node Group](../../Administrator/Researcher-Setup/Limit-a-Workload-to-a-Specific-Node-Group.md)
> This flag can be used in conjunction with Project-based affinity. In this case, the flag is used to refine the list of allowable node groups set in the project. For more information see: [Working with Projects](../../Administrator/Admin-User-Interface-Setup/Working-with-Projects.md)

--port stringArray

>  Expose ports from the Job container. Used together with ``--service-type``.  
>  Examples:  
>    ``--port 8080:80 --service-type loadbalancer``

>    ``--port 8080 --service-type ingress``

--preemptible

>  Mark an interactive job as preemptible. Preemptible jobs can be scheduled above guaranteed quota but may be reclaimed at any time.

--pvc `[Storage_Class_Name]:Size:Container_Mount_Path:[ro]`

--pvc `Pvc_Name:Container_Mount_Path:[ro]`

> Mount a persistent volume claim into a container
>
> The 2 syntax types of this command are mutually exclusive. You can either use the first or second form, but not a mixture of both.

> __Storage_Class_Name__ is a storage class name which can be obtained by running ``kubectl get storageclasses.storage.k8s.io``. This parameter may be omitted if there is a single storage class in the system, or you are using the default storage class. 

>    __Size__ is the volume size you want to allocate. See [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) for how to specify volume sizes

>    __Container_Mount_Path__. A path internal to the container where the storage will be mounted

>    __Pvc_Name__. The name of a pre-existing [Persistent Volume Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#dynamic) to mount into the pod
> 
> Examples:

> ``--pvc :3Gi:/tmp/john:ro``  - Allocate `3GB` from the default Storage class. Mount it to `/tmp/john` as read-only 

> ``--pvc my-storage:3Gi:/tmp/john:ro``  - Allocate `3GB` from the `my-storage` storage class. Mount it to /tmp/john as read-only 

> ``--pvc :3Gi:/tmp/john`` - Allocate `3GB` from the default storage class. Mount it to `/tmp/john` as read-write 

> ``--pvc my-pvc:/tmp/john`` - Use a Persistent Volume Claim named `my-pvc`. Mount it to `/tmp/john` as read-write 

> ``--pvc my-pvc-2:/tmp/john:ro`` - Use a Persistent Volume Claim named `my-pvc-2`. Mount it to `/tmp/john` as read-only

--run-as-user

>  Run in the context of the current user running the Run:AI command rather than the root user. While the default container user is _root_ (same as in Docker), this command allows you to submit a job running under your Linux user. This would manifest itself in access to operating system resources, in the owner of new folders created under shared directories etc.

--service-type string | -s string

>  Service exposure method for interactive Job. Options are: ``portforward``, ``loadbalancer``, ``nodeport``, ingress.
>  Use the command runai list to obtain the endpoint to use the service when the job is running. Different service methods have different endpoint structure

--template string

>  Templates are currently not supported

--ttl-after-finish duration

>  Define the duration, post job finish, after which the job is automatically deleted (5s, 2m, 3h, etc).  
> Note: This setting must first be enabled at the cluster level. See [Automatically Delete Jobs After Job Finish](../Scheduling/Automatically-Delete-Jobs-After-Job-Finish.md)

--volume stringArray | -v stringArray

>  Volume to mount into the container. Example ``-v /raid/public/john/data:/root/data:ro`` The flag may optionally be suffixed with ``:ro`` or ``:rw`` to mount the volumes in read-only or read-write mode, respectively.

--working-dir string

>  Starts the container with the specified directory

### Global Flags

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

--project | -p (string)

>  Specify the project to which the command applies. Run:AI Projects are used by the scheduler to calculate resource eligibility. By default, commands apply to the default project. To change the default project use ``runai project set <project-name>``.

--help | -h

>  Show help text

## Examples

start an unattended training job of name run1, based on project team-a using a quickstart image:

    runai submit run1 -i gcr.io/run-ai-demo/quickstart -g 1 -p team-a


start an interactive job of name run2, based on project team-a using a Jupyter notebook image. The Notebook will be externalized via a load balancer on port 8888:

    runai submit run2 -i jupyter/base-notebook -g 1 \
       -p team-a --interactive --service-type=loadbalancer --port 8888:8888

## Output

The command will attempt to submit a job. You can follow up on the job by running ``runai list`` or ``runai get job-name -e``

Note that the submit call may use templates to provide defaults to any of the above flags.

## See Also

*   See any of the Walk-through documents here: [Run:AI Walk-through](../Walkthroughs/Run-AI-Walkthroughs.md)
<!-- *   See [runai template](runai-template.md) for a description on how templates work -->

