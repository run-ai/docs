## Description

Submit a Distributed Training (MPI) Run:ai Job to run.

!!! Note
    To use distributed training you need to have installed the Kubeflow MPI Operator as specified in [Distributed training](../../admin/runai-setup/cluster-setup/cluster-prerequisites.md#distributed-training).

Syntax notes:

* Options with a value type of *stringArray* mean that you can add multiple values. You can either separate values with a comma or add the flag twice.

## Examples

You can start an unattended mpi training Job of name dist1, based on Project *team-a* using a *quickstart-distributed* image:

    runai submit-dist mpi --name dist1 --workers=2 -g 1 \
        -i runai.jfrog.io/demo/quickstart-distributed:v0.3.0 -e RUNAI_SLEEP_SECS=60 

(see: [distributed training Quickstart](../workloads/training/distributed-training/quickstart-distributed-training.md)).

## Options

### Distributed

#### --clean-pod-policy < string >

> The CleanPodPolicy controls deletion of pods when a job terminates. The policy can be one of the following values:
>
>* **Running**&mdash;only pods still running when a job completes (for example, parameter servers) will be deleted immediately. Completed pods will not be deleted so that the logs will be preserved. (Default)
>* **All**&mdash;all (including completed) pods will be deleted immediately when the job finishes.
>* **None**&mdash;no pods will be deleted when the job completes.

#### --workers < int >

> Number of replicas for Inference jobs.

#### --slots-per-worker < int >

> Number of slots to allocate for each worker.

<!-- Start of common content from snippets/common-submit-cli-commands.md -->
### Naming and Shortcuts

#### --job-name-prefix `<string>`
> The prefix to use to automatically generate a Job name with an incremental index. When a Job name is omitted Run:ai will generate a Job name. The optional `--job-name-prefix flag` creates Job names with the provided prefix.

#### --name `<string>`
> The name of the Job.

#### --template `<string>`
> Load default values from a workload.

### Container Definition

#### --add-capability `<stringArray>`

> Add linux capabilities to the container.

#### -a | --annotation `<stringArray>`

> Set annotations variables in the container.

#### --attach

>  Default is false. If set to true, wait for the Pod to start running. When the pod starts running, attach to the Pod. The flag is equivalent to the command [runai attach](runai-attach.md).
>
> The --attach flag also sets `--tty` and `--stdin` to true.

#### --command

>  Overrides the image's entry point with the command supplied after '--'. When **not** using the `--command` flag, the entry point will **not** be overrided and the string after `--` will be appended as arguments to the entry point command.
>
> Example:
>
> `--command -- run.sh 1 54` will start the docker and run `run.sh 1 54`
>
> `-- script.py 10000` will augment `script.py 10000` to the entry point command (e.g. `python`)

#### --create-home-dir

> Create a temporary home directory for the user in the container. Data saved in this directory will not be saved when the container exits. For more information see [non root containers](../../admin/authentication/non-root-containers.md).

#### -e `<stringArray>  | --environment `<stringArray>`

>  Define environment variables to be set in the container. To set multiple values add the flag multiple times (`-e BATCH_SIZE=50 -e LEARNING_RATE=0.2`).
 <!-- or separate by a comma (`-e BATCH_SIZE:50,LEARNING_RATE:0.2`). -->
  
#### --image `<string>` | -i `<string>`

>  Image to use when creating the container for this Job

#### --image-pull-policy `<string>`

>  Pulling policy of the image when starting a container. Options are:
>
> - `Always` (default): force image pulling to check whether local image already exists. If the image already exists locally and has the same digest, then the image will not be downloaded.
> - `IfNotPresent`: the image is pulled only if it is not already present locally.
> - `Never`: the image is assumed to exist locally. No attempt is made to pull the image.
>
> For more information see Kubernetes [documentation](https://kubernetes.io/docs/concepts/configuration/overview/#container-images){target=_blank}.

####  -l | --label `<stringArray>`

> Set labels variables in the container.

#### --master-args string `<string>`

>  Arguments to pass to the master pod container command. If used together with `--command`, overrides the image's entrypoint of the master pod container with the given command.

#### --master-environment `<stringArray>`

>  Set environment variables in the master pod container. To prevent from a worker environment variable from being set in the master, use the format: `name=-`.

#### --master-extended-resource `<stringArray>`

>  Request access to an extended resource in the master pod. Use the format: `resource_name=quantity`.

#### --master-gpu `<float>`

>  GPU units to allocate for the master pod.

#### --master-no-pvcs

>  Do not mount any persistent volumes in the master pod.

#### --preferred-pod-topology-key `<string>`

> If possible, all pods of this job will be scheduled onto nodes that have a label with this key and identical values.

#### --required-pod-topology-key `<string>`

> Enforce scheduling pods of this job onto nodes that have a label with this key and identical values.

#### --stdin

>  Keep stdin open for the container(s) in the pod, even if nothing is attached.is attached.
 
#### -t | --tty

>  Allocate a pseudo-TTY.

#### --working-dir `<string>`

>  Starts the container with the specified directory as the current directory.

### Resource Allocation

#### --cpu `<double>`

> CPU units to allocate for the Job (0.5, 1, .etc). The Job will receive **at least** this amount of CPU. Note that the Job will **not** be scheduled unless the system can guarantee this amount of CPUs to the Job.

#### --cpu-limit `<double>`

> Limitations on the number of CPUs consumed by the Job (for example 0.5, 1). The system guarantees that this Job will not be able to consume more than this amount of CPUs.

#### --extended-resource `<stringArray>

> Request access to extended resource, syntax `<resource-name> = < resource_quantity >`

#### -g | --gpu `<float>`

> GPU units to allocate for the Job (0.5, 1).

#### --gpu-memory

> GPU memory to allocate for this Job (1G, 20M, .etc). The Job will receive this amount of memory. Note that the Job will **not** be scheduled unless the system can guarantee this amount of GPU memory to the Job.

#### --memory `<string>`

>  CPU memory to allocate for this Job (1G, 20M, .etc). The Job will receive **at least** this amount of memory. Note that the Job will **not** be scheduled unless the system can guarantee this amount of memory to the Job.

#### --memory-limit `<string>

>  CPU memory to allocate for this Job (1G, 20M, .etc). The system guarantees that this Job will not be able to consume more than this amount of memory. The Job will receive an error when trying to allocate more memory than this limit.

#### --mig-profile `<string>` (Deprecated)

> MIG profile to allocate for the job (1g.5gb, 2g.10gb, 3g.20gb, 4g.20gb, 7g.40gb)

### Job Lifecycle

#### --backoff-limit `<int>`

> The number of times the Job will be retried before failing. The default is 6.

#### --ttl-after-finish < duration >

> The duration, after which a finished job is automatically deleted (e.g. 5s, 2m, 3h).

### Storage

#### --git-sync `<stringArray>`

> Clone a git repository into the container running the Job. The parameter should follow the syntax: `source=REPOSITORY,branch=BRANCH_NAME,rev=REVISION,username=USERNAME,password=PASSWORD,target=TARGET_DIRECTORY_TO_CLONE`.

#### --large-shm

> Mount a large /dev/shm device.

#### --mount-propagation

> Enable HostToContainer mount propagation for all container volumes

#### --nfs-server `<string>`

> Use this flag to specify a default NFS host for --volume flag.
> Alternatively, you can specify NFS host for each volume
> individually (see --volume for details).

#### --pvc `[Storage_Class_Name]:Size:Container_Mount_Path:[ro]`

#### --pvc `Pvc_Name:Container_Mount_Path:[ro]`

> Mount a persistent volume claim into a container.
>
>!!!Note
    This option is being deprecated from version 2.10 and above. To mount existing or newly created Persistent Volume Claim (PVC), use the parameters `--pvc-exists` and `--pvc-new`.
>
> The 2 syntax types of this command are mutually exclusive. You can either use the first or second form, but not a mixture of both.
>
> **Storage_Class_Name** is a storage class name that can be obtained by running `kubectl get storageclasses.storage.k8s.io`. This parameter may be omitted if there is a single storage class in the system, or you are using the default storage class. 
>
> **Size** is the volume size you want to allocate. See [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/){target=_blank} for how to specify volume sizes
>
> **Container_Mount_Path**. A path internal to the container where the storage will be mounted
>
> **Pvc_Name**. The name of a pre-existing [Persistent Volume Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#dynamic){target=_blank} to mount into the container
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

#### --pvc-exists `<string>`

> Mount a persistent volume. You must include a `claimname` and `path`.
>
> - **claim name**&mdash;The name of the persistent colume claim. Can be obtained by running 
>
> `kubectl get storageclasses.storage.k8s.io`
>
> - **path**&mdash;the path internal to the container where the storage will be mounted
>
> Use the format:
>
> `claimname=<CLAIM_NAME>,path=<PATH>`

#### --pvc-new  `<string>`

> Mount a persistent volume claim (PVC). If the PVC does not exist, it will be created based on the parameters entered. If a PVC exists, it will be used with its defined attributes and the parameters in the command will be ignored.
>
> - **claim name**&mdash;The name of the persistent colume claim.
> - **storage class**&mdash;A storage class name that can be obtained by running
>
> > `kubectl get storageclasses.storage.k8s.io.`
>
> > `storageclass` may be omitted if there is a single storage class in the system, or you are using the default storage class.
>
> - **size**&mdash;The volume size you want to allocate for the PVC when creating it. See [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/){target=_blank} to specify volume sizes.
> - **accessmode**&mdash;The description ofthedesired volume capabilities for the PVC.
> - **ro**&mdash;Mount the PVC with read-only access.
> - **ephemeral**&mdash;The PVC will be created as volatile temporary storage which is only present during the running lifetime of the job.
>
> Use the format:
>
>`storageclass=  <storageclass>,size= <size>, path= <path>, ro, accessmode-rwm`

#### --s3 `<string>`

> Mount an S3 compatible storage into the container running the job. The parameter should follow the syntax:
> 
> `bucket=BUCKET,key=KEY,secret=SECRET,url=URL,target=TARGET_PATH`
>
> All the fields, except url=URL, are mandatory. Default for url is
> 
> `url=https://s3.amazon.com`

#### -v | --volume 'Source:Container_Mount_Path:[ro]:[nfs-host]'

> Volumes to mount into the container.
>
> Examples:
>
>  `-v /raid/public/john/data:/root/data:ro`
> 
> Mount /root/data to local path /raid/public/john/data for read-only access.
>
>  `-v /public/data:/root/data::nfs.example.com`
> 
> Mount /root/data to NFS path /public/data on NFS server nfs.example.com for read-write access.

#### --configmap-volume name=<name of configmap>,path=<path to mount> ...'

> Mount a `ConfigMap` object for use as a data volume.

### Network

#### --address `<string>`

> Comma separated list of IP addresses to listen to when running with --service-type portforward (default: localhost)

#### --host-ipc

>  Use the host's _ipc_ namespace. Controls whether the pod containers can share the host IPC namespace. IPC (POSIX/SysV IPC) namespace provides separation of named shared memory segments, semaphores, and message queues.
> Shared memory segments are used to accelerate inter-process communication at memory speed, rather than through pipes or the network stack.
> 
> For further information see [docker run reference](https://docs.docker.com/engine/reference/run/) documentation.

#### --host-network

> Use the host's network stack inside the container.
> For further information see [docker run reference](https://docs.docker.com/engine/reference/run/)documentation.

#### --port `<stringArray>`

> Expose ports from the Job container.

#### -s | --service-type `<string>`

> External access type to interactive jobs. Options are: portforward, loadbalancer, nodeport, ingress.
  
### Access Control

#### --allow-privilege-escalation

> Allow the job to gain additional privileges after start.

#### --run-as-user

>  Run in the context of the current user running the Run:ai command rather than the root user. While the default container user is _root_ (same as in Docker), this command allows you to submit a Job running under your Linux user. This would manifest itself in access to operating system resources, in the owner of new folders created under shared directories, etc. Alternatively, if your cluster is connected to Run:ai via SAML, you can map the container to use the Linux UID/GID which is stored in the organization's directory. For more information see [non root containers](../../admin/authentication/non-root-containers.md).

### Scheduling

#### --node-pools `<string>`

> Instructs the scheduler to run this workload using specific set of nodes which are part of a [Node Pool](../../Researcher/scheduling/the-runai-scheduler.md#). You can specify one or more node pools to form a prioritized list of node pools that the scheduler will use to find one node pool that can provide the workload's specification. To use this feature your Administrator will need to label nodes as explained here: [Limit a Workload to a Specific Node Group](../../admin/config/limit-to-node-group.md) or use existing node labels, then create a node-pool and assign the label to the node-pool.
> This flag can be used in conjunction with node-type and Project-based affinity. In this case, the flag is used to refine the list of allowable node groups set from a node-pool. For more information see: [Working with Projects](../../platform-admin/aiinitiatives/org/projects.md).

#### --node-type `<string>`

>  Allows defining specific Nodes (machines) or a group of Nodes on which the workload will run. To use this feature your Administrator will need to label nodes as explained here: [Limit a Workload to a Specific Node Group](../../admin/config/limit-to-node-group.md).

#### --toleration `<string>`

> Specify one or more toleration criteria, to ensure that the workload is not scheduled onto an inappropriate node. 
> This is done by matching the workload tolerations to the taints defined for each node. For further details see Kubernetes
> [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/){target=_blank} Guide.
>
> The format of the string:
>
> ```
> operator=Equal|Exists,key=KEY,[value=VALUE],[effect=NoSchedule|NoExecute|PreferNoSchedule],[seconds=SECONDS]
> ```

### Global Flags

#### --loglevel (string)

> Set the logging level. One of: debug | info | warn | error (default "info")

#### --project | -p (string)

> Specify the Project to which the command applies. Run:ai Projects are used by the scheduler to calculate resource eligibility. By default, commands apply to the default Project. To change the default Project use `runai config project <project-name>`.

#### --help | -h

> Show help text.

<!-- END of common content from snippets/common-submit-cli-commands.md -->
## Output

The command will attempt to submit an _mpi_ Job. You can follow up on the Job by running `runai list jobs` or `runai describe job <job-name>`.

## See Also

*   See Quickstart document [Running Distributed Training](../workloads/training/distributed-training/quickstart-distributed-training.md).
