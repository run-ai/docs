## Description

Submit a Run:ai Job for execution.

## Synopsis

``` shell
runai submit 
    [--attach]
    [--backoff-limit int] 
    [--completions int]
    [--cpu double] 
    [--cpu-limit double] 
    [--create-home-dir]
    [--environment stringArray | -e stringArray] 
    [--git-sync string]
    [--gpu double | -g double] 
    [--gpu-memory string]
    [--host-ipc] 
    [--host-network] 
    [--image string | -i string]
    [--imagePullPolicy string] 
    [--interactive] 
    [--jupyter] 
    [--job-name-prefix string]
    [--large-shm] 
    [--local-image] 
    [--memory string] 
    [--memory-limit string] 
    [--mount-propagation]
    [--mps] 
    [--name string]
    [--node-type string] 
    [--parallelism int]
    [--port stringArray] 
    [--preemptible] 
    [--prevent-privilege-escalation]
    [--pvc [StorageClassName]:Size:ContainerMountPath:[ro]]
    [--run-as-user] 
    [--s3 string]
    [--service-type string | -s string] 
    [--stdin]
    [--ttl-after-finish duration] 
    [--tty | -t]
    [--volume stringArray | -v stringArray] 
    [--nfs-server string]
    [--working-dir] 
    
    [--loglevel string] 
    [--project string | -p string] 
    [--help | -h]
    
    -- [COMMAND] [ARGS...] [options]
```

 Syntax notes:

* Flags of type _stringArray_ mean that you can add multiple values. You can either separate values with a comma or add the flag twice.


## Examples

All examples assume a Run:ai Project has been set using `runai config project <project-name>`.

Start an interactive Job:

```
runai submit -i ubuntu --interactive --attach -g 1
```

Or

```
runai submit --name build1 -i ubuntu -g 1 --interactive -- sleep infinity 
```

(see: [build Quickstart](../Walkthroughs/walkthrough-build.md)).

Externalize ports:

    runai submit --name build-remote -i rastasheep/ubuntu-sshd:14.04 --interactive \
        --service-type=nodeport --port 30022:22
        -- /usr/sbin/sshd -D 

(see: [build with ports Quickstart](../Walkthroughs/walkthrough-build-ports.md)).

Start a Training Job

    runai submit --name train1 -i gcr.io/run-ai-demo/quickstart -g 1 
    
(see: [training Quickstart](../Walkthroughs/walkthrough-train.md)).

Use GPU Fractions

    runai submit --name frac05 -i gcr.io/run-ai-demo/quickstart -g 0.5 

(see: [GPU fractions Quickstart](../Walkthroughs/walkthrough-fractions.md)).

Hyperparameter Optimization

    runai submit --name hpo1 -i gcr.io/run-ai-demo/walkthrough-hpo -g 1  \
        --parallelism 3 --completions 12 -v /nfs/john/hpo:/hpo 

(see: [hyperparameter optimization Quickstart](../Walkthroughs/walkthrough-hpo.md)).

Submit a Job without a name (automatically generates a name)

    runai submit -i gcr.io/run-ai-demo/quickstart -g 1 
    
Submit a Job without a name with a pre-defined prefix and an incremental index suffix

    runai submit --job-name-prefix -i gcr.io/run-ai-demo/quickstart -g 1 

## Options

### Aliases and Shortcuts

#### --name
> The name of the Job.
<!-- 
#### --inference
>  Mark this workload as an Inference workload. This starts a deep learning inference _Deployment_ service. See [here](../../developer/inference/overview.md) -->

#### --interactive
>  Mark this Job as Interactive. Interactive Jobs are not terminated automatically by the system.

#### --jupyter
>  Shortcut for running a Jupyter notebook container. Uses a pre-created image and a default notebook configuration. 

> Example:

> `runai submit --name jup1 --jupyter -g 0.5 --service-type=ingress` will start an interactive session named jup1 and use an ingress load balancer to connect to it. The output of the command is an access token for the notebook. Run `runai list jobs` to find the URL for the notebook.

#### --job-name-prefix string
> The prefix to use to automatically generate a Job name with an incremental index. When a Job name is omitted Run:ai will generate a Job name. The optional `--job-name-prefix flag` creates Job names with the provided prefix

### Container Related

#### --attach                        
>  Default is false. If set to true, wait for the Pod to start running. When the pod starts running, attach to the Pod. The flag is equivalent to the command [runai attach](runai-attach.md).
> 
> The --attach flag also sets `--tty` and `--stdin` to true. 

#### -- [COMMAND]
>  Overrides the image's entry point with the command supplied after '--'
>
>  Example: 
> > `-- python script.py 10000` 

-e stringArray | --environment stringArray
>  Define environment variables to be set in the container. To set multiple values add the flag multiple times (`-e BATCH_SIZE=50 -e LEARNING_RATE=0.2`).
<!-- or separate by a comma (`-e BATCH_SIZE:50,LEARNING_RATE:0.2`) -->

#### --image string | -i string
>  Image to use when creating the container for this Job

#### --image-pull-policy string
>  Pulling policy of the image When starting a container. Options are: 
>
> - `always` (default): force image pulling to check whether local image already exists. If the image already exists locally and has the same digest, then the image will not be downloaded. 
>
> - `ifNotPresent`: the image is pulled only if it is not already present locally.
>
> - `never`: the image is assumed to exist locally. No attempt is made to pull the image.
>
> For more information see Kubernetes [documentation](https://kubernetes.io/docs/concepts/configuration/overview/#container-images){target=_blank}.

#### --local-image (deprecated)
>  Deprecated. Please use `image-pull-policy=never` instead.
>  Use a local image for this Job. A local image is an image that exists on all local servers of the Kubernetes Cluster. 

[](){:name='mps'}

#### --mps
> Use NVIDIA MPS. NIVDIA MPS is useful with _Inference_ workloads for optimizing multiple processes running on a single GPU. The `--mps` flag only works in conjunction with GPU fractions (--gpu `<num>` where `<num>` is not an integer or using --gpu-memory).

#### --stdin
>  Keep stdin open for the container(s) in the pod, even if nothing is attached.

-t, --tty
>  Allocate a pseudo-TTY.

#### --working-dir string
>  Starts the container with the specified directory as the current directory.


### Resource Allocation

#### --cpu double
> CPU units to allocate for the Job (0.5, 1, .etc). The Job will receive __at least__ this amount of CPU. Note that the Job will __not__ be scheduled unless the system can guarantee this amount of CPUs to the Job.

#### --cpu-limit double
> Limitations on the number of CPUs consumed by the Job (0.5, 1, .etc). The system guarantees that this Job will not be able to consume more than this amount of CPUs.

#### --gpu double | -g double
> Number of GPUs to allocate for the Job. The default is no allocated GPUs. The GPU value can be an integer or a fraction between 0 and 1.

#### --gpu-memory
> GPU memory to allocate for this Job (1G, 20M, .etc). The Job will receive this amount of memory. Note that the Job will __not__ be scheduled unless the system can guarantee this amount of GPU memory to the Job.

#### --large-shm
> Mount a large /dev/shm device. An _shm_ is a shared file system mounted on RAM.

#### --memory string
>  CPU memory to allocate for this Job (1G, 20M, .etc). The Job will receive __at least__ this amount of memory. Note that the Job will __not__ be scheduled unless the system can guarantee this amount of memory to the Job.

#### --memory-limit string
>  CPU memory to allocate for this Job (1G, 20M, .etc). The system guarantees that this Job will not be able to consume more than this amount of memory. The Job will receive an error when trying to allocate more memory than this limit.

### Storage

#### --pvc `[Storage_Class_Name]:Size:Container_Mount_Path:[ro]`

#### --pvc `Pvc_Name:Container_Mount_Path:[ro]`

> Mount a persistent volume claim of Network Attached Storage into a container.
>
> The 2 syntax types of this command are mutually exclusive. You can either use the first or second form, but not a mixture of both.
>
> __Storage_Class_Name__ is a storage class name that can be obtained by running `kubectl get storageclasses.storage.k8s.io`. This parameter may be omitted if there is a single storage class in the system, or you are using the default storage class. 
>
>    __Size__ is the volume size you want to allocate. See [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/){target=_blank} for how to specify volume sizes
>
>    __Container_Mount_Path__. A path internal to the container where the storage will be mounted
>
>    __Pvc_Name__. The name of a pre-existing [Persistent Volume Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#dynamic){target=_blank} to mount into the container
> 
> Examples:
> 
> > `--pvc :3Gi:/tmp/john:ro`  - Allocate `3GB` from the default Storage class. Mount it to `/tmp/john` as read-only 
> 
> > `--pvc my-storage:3Gi:/tmp/john:ro`  - Allocate `3GB` from the `my-storage` storage class. Mount it to /tmp/john as read-only 
>
> > `--pvc :3Gi:/tmp/john` - Allocate `3GB` from the default storage class. Mount it to `/tmp/john` as read-write 
>
> > `--pvc my-pvc:/tmp/john` - Use a Persistent Volume Claim named `my-pvc`. Mount it to `/tmp/john` as read-write 
>
> > `--pvc my-pvc-2:/tmp/john:ro` - Use a Persistent Volume Claim named `my-pvc-2`. Mount it to `/tmp/john` as read-only

#### --volume 'Source:Container_Mount_Path:[ro]:[nfs-host]'
>  Volumes to mount into the container.  
>  
> Examples:
> 
> > `-v /raid/public/john/data:/root/data:ro` 
> Mount /root/data to local path /raid/public/john/data for read-only access.
>
> > `-v /public/data:/root/data::nfs.example.com`
> Mount /root/data to NFS path /public/data on NFS server nfs.example.com for read-write access.

#### --nfs-server string
> Use this flag to specify the default NFS host for --volume flag.
> Alternatively, you can specify NFS host for each volume 
> individually (see --volume for details).

#### --mount-propagation
> The flag allows for sharing volumes mounted by a container to other containers in the same pod, or even to other pods on the same node.
> When the flag is set, Run:ai will set mount propagation to the value of `HostToContainer` as documented [here](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation){target=_blank}. With `HostToContainer` the volume mount will receive all subsequent mounts that are mounted to this volume or any of its subdirectories.

#### --git-sync string
> Clone a git repository into the container running the job. The parameter should follow the syntax:
> > `source=REPOSITORY,branch=BRANCH_NAME,rev=REVISION,username=USERNAME,password=PASSWORD,target=TARGET_DIRECTORY_TO_CLONE`
>
> Note that source=REPOSITORY is the only mandatory field

#### --s3 string
> Mount an S3 compatible storage into the container running the job. The parameter should follow the syntax:
> > `bucket=BUCKET,key=KEY,secret=SECRET,url=URL,target=TARGET_PATH`
>
> All the fields, except url=URL, are mandatory. Default for url is
> > `url=https://s3.amazon.com`

#### --toleration string
> Specify one or more toleration criteria, to ensure that the workload is not scheduled onto 
> inappropriate node. This is done by matching the workload tolerations to the taints defined
> for each node. Further details can be found in Kubernetes
> [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/){target=_blank} Guide.
> 
> The format of the string:
> ```
> operator=Equal|Exists,key=KEY,[value=VALUE],[effect=NoSchedule|NoExecute|PreferNoSchedule],[seconds=SECONDS]
> ```

### Network

#### --host-ipc
>  Use the host's ipc namespace. Controls whether the pod containers can share the host IPC namespace. IPC (POSIX/SysV IPC) namespace provides separation of named shared memory segments, semaphores and message queues.
> Shared memory segments are used to accelerate inter-process communication at memory speed, rather than through pipes or the network stack.
> 
> For further information see [docker run reference](https://docs.docker.com/engine/reference/run/"){target=_blank}.

#### --host-network
>  Use the host's network stack inside the container.
> For further information see [docker run reference](https://docs.docker.com/engine/reference/run/"){target=_blank}.

#### --port stringArray
>  Expose ports from the Job container. Used together with `--service-type`.  
>
>  Examples:  
>>    `--port 8080:80 --service-type loadbalancer`
>>    `--port 8080 --service-type ingress`

#### --service-type string | -s string
>  Service exposure method for interactive Job. Options are: `portforward`, `loadbalancer`, `nodeport`, ingress.
>  Use the command runai list to obtain the endpoint to use the service when the Job is running. Different service methods have different endpoint structures.

#### --address string              
> Comma separated list of IP addresses to listen to when running interactive job 
> with portforward service type (default is localhost).
>
> Example:
> 
> >   `--interactive --service-type portforward --address "localhost,192.168.1.2" --port 8888:5555`
>
> Any traffic on port 8888 of both localhost and 192.168.1.2 will be forwarded
> to port 5555 of the running job.

### Job Lifecycle

#### --backoff-limit int
> The number of times the Job will be retried before failing. The default is 6. This flag will only work with training workloads (when the `--interactive` flag is not specified).

#### --completions int
>  The number of successful pods required for this Job to be completed. Used for [Hyperparameter optimization](../Walkthroughs/walkthrough-hpo.md). Use together with `--parallelism`.

#### --parallelism int
> The number of pods this Job tries to run in parallel at any time.  Used for [Hyperparameter optimization](../Walkthroughs/walkthrough-hpo.md). Use together with `--completions`.

#### --ttl-after-finish duration
>  Define the duration, post Job finish, after which the Job is automatically deleted (5s, 2m, 3h, etc).  
> Note: This setting must first be enabled at the cluster level. See [Automatically Delete Jobs After Job Finish](../scheduling/auto-delete-jobs.md).


### Access Control

#### --create-home-dir
> Create a temporary home directory for the user in the container. Data saved in this directory will not be saved when the container exits. The flag is set by default to true when the --run-as-user flag is used, and false if not. For more information see [non root containers](../../admin/runai-setup/config/non-root-containers.md).

#### --prevent-privilege-escalation
> Prevent the Job’s container and all launched processes from gaining additional privileges after the Job starts. Default is `false`. For more information see [non root containers](../../admin/runai-setup/config/non-root-containers.md).

#### --run-as-user
>  Run in the context of the current user running the Run:ai command rather than the root user. While the default container user is _root_ (same as in Docker), this command allows you to submit a Job running under your Linux user. This would manifest itself in access to operating system resources, in the owner of new folders created under shared directories, etc. Alternatively, if your cluster is connected to Run:ai via SAML , you can map the container to use the Linux UID/GID which is stored in the organization's directory. For more information see [non root containers](../../admin/runai-setup/config/non-root-containers.md).


### Scheduling

#### --node-type string
>  Allows defining specific nodes (machines) or a group of nodes on which the workload will run. To use this feature your Administrator will need to label nodes as explained here: [Limit a Workload to a Specific Node Group](../../admin/researcher-setup/limit-to-node-group.md).
> This flag can be used in conjunction with Project-based affinity. In this case, the flag is used to refine the list of allowable node groups set in the Project. For more information see: [Working with Projects](../../admin/admin-ui-setup/project-setup.md).

#### --preemptible
>  Mark an interactive Job as preemptible. Preemptible Jobs can be scheduled above the guaranteed quota but may be reclaimed at any time.


### Global Flags

#### --loglevel (string)
>  Set the logging level. One of: debug | info | warn | error (default "info").

#### --project | -p (string)
>  Specify the Project to which the command applies. Run:ai Projects are used by the scheduler to calculate resource eligibility. By default, commands apply to the default Project. To change the default Project use `runai config project <project-name>`.

#### --help | -h
>  Show help text.

## Output

The command will attempt to submit a Job. You can follow up on the Job by running `runai list jobs` or `runai describe job <job-name>`.

Note that the submit call may use a _policy_ to provide defaults to any of the above flags.

## See Also

*   See any of the Quickstart documents [here:](../Walkthroughs/quickstart-overview.md).
*   See [policy configuration](../../admin/workloads/policies.md) for a description on how policies work.

