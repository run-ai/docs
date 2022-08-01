# Training Workload Parameters

Following is a full list of all training workload parameters. The text below is equivalent to running `kubectl explain trainingpolicy.spec`. You can also run `kubectl explain trainingpolicy.spec.<parameter-name>` to see the description of a specific parameter. 

```
KIND:     TrainingWorkload
VERSION:  run.ai/v2alpha1

RESOURCE: spec <Object>

DESCRIPTION:
     The specifications of this TrainingWorkload

FIELDS:
   allowPrivilegeEscalation	<Object>
     Allow the container running the workload and all launched processes to gain
     additional privileges after the workload starts. For more information
     consult the User Identity in Container guide at
     https://docs.run.ai/admin/runai-setup/config/non-root-containers/

   annotations	<Object>
     Specifies annotations to be set in the container running the created
     workload.

   arguments	<Object>
     If set, the arguments are sent along with the command which overrides the
     image's entry point of the created workload.

   backoffLimit	<Object>
     Specifies the number of retries before marking a workload as failed.
     Defaults to 6

   baseWorkload	<string>
     Another workload that inherits its values to this workload. Base workload
     can either reside on the same namespace of this workload (referred to as
     "user" template) or can reside in runai namespace (referred to as "global"
     template)

   capabilities	<Object>
     Starting with kernel 2.2, Linux divides the privileges traditionally
     associated with superuser into distinct units, known as capabilities, which
     can be independently enabled and disabled. The capabilities field allows
     adding a set of unix unix capabilities to the container running the
     workload.

   command	<Object>
     If set, overrides the image's entry point with the supplied command.

   completions	<Object>
     Specifies the desired number of successfully finished pods the created
     workload should be run with. No completion defines means that the success
     of any pod signals the success of all pods, and allows parallelism to have
     any positive value. Setting to 1 means that parallelism is limited to 1 and
     the success of that pod signals the success of the workload. More info:
     https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/

   cpu	<Object>
     Specifies CPU units to allocate for the created workload (0.5, 1, .etc).
     The workload will receive at least this amount of CPU. Note that the
     workload will not be scheduled unless the system can guarantee this amount
     of CPUs to the workload.

   cpuLimit	<Object>
     Specifies limitations on the number of CPUs consumed by the workload (0.5,
     1, .etc). The system guarantees that this workload will not be able to
     consume more than this amount of CPUs.

   createHomeDir	<Object>
     Instructs the system to create a temporary home directory for the user in
     the container running the created workload. Data stored in this directory
     will not be saved when the container exits. The flag is set by default when
     runAsUser flag is set.

   environment	<Object>
     Specifies environment variables to be set in the container running the
     created workload.

   extendedResources	<Object>
     Specifies limits for extended resources which the customer may have

   gitSync	<Object>
     Specifies git repositories to mount into the container running the
     workload.

   gpu	<Object>
     Specifies the number of GPUs to allocate for the created workload. The
     default is no allocated GPUs. The GPU value can be an integer or a fraction
     between 0 and 1.

   gpuMemory	<Object>
     Specifies GPU memory to allocate for the created workload. The workload
     will receive this amount of memory. Note that the workload will not be
     scheduled unless the system can guarantee this amount of GPU memory to the
     workload.

   hostIpc	<Object>
     Specifies that the created workload will use the host's ipc namespace.

   hostNetwork	<Object>
     Specifies that the created workload will use the host's network stack
     inside its container. For further information consult the Docker Run
     Reference at https://docs.docker.com/engine/reference/run/

   image	<Object>
     Specifies the image to use when creating the container running the created
     workload.

   imagePullPolicy	<Object>
     Specifies the pulling policy of the image when starting a container running
     the created workload. Options are: always, ifNotPresent or never. For
     further details, consult Kubernetes images guide at
     https://kubernetes.io/docs/concepts/containers/images

   ingressUrl	<Object>
     Specifies the URL path of ingress port exposed from the created workload.
     Used together with --service-type ingress

   labels	<Object>
     Specifies labels to be set in the container running the created workload.

   largeShm	<Object>
     Specifies a large /dev/shm device to mount into a container running the
     created workload. An shm is a shared file system mounted on RAM.

   memory	<Object>
     Specifies the amount of CPU memory to allocate for this workload (1G, 20M,
     .etc). The workload will receive at least this amount of memory. Note that
     the workload will not be scheduled unless the system can guarantee this
     amount of memory to the workload

   memoryLimit	<Object>
     Specifies limitations on the CPU memory to allocate for this workload (1G,
     20M, .etc). The system guarantees that this workload will not be able to
     consume more than this amount of memory. The workload will receive an error
     when trying to allocate more memory than this limit.

   migProfile	<Object>
     Specifies the memory profile to be used for workload running on NVIDIA
     Multi-Instance GPU (MIG) technology.

   mountPropagation	<Object>
     Allows for sharing volumes mounted by a container to other containers in
     the same pod, or even to other pods on the same node. The volume mount will
     receive all subsequent mounts that are mounted to this volume or any of its
     subdirectories.

   mpi	<Object>
     This workload produces mpijob

   name	<Object>
     Specific name of the created resource. Either name of namePrefix should be
     provided, not both.

   namePrefix	<Object>
     A prefix used for assigning a name to the created resource. Either name of
     namePrefix should be provided, not both.

   nodeType	<Object>
     Specifies nodes (machines) or a group of nodes on which the workload will
     run. To use this feature, your Administrator will need to label nodes as
     explained in the Group Nodes guide at
     https://docs.run.ai/admin/researcher-setup/limit-to-node-group. This flag
     can be used in conjunction with Project-based affinity. In this case, the
     flag is used to refine the list of allowable node groups set in the
     Project. For more information consult the Projects guide at
     https://docs.run.ai/admin/admin-ui-setup/project-setup.

   parallelism	<Object>
     Specifies the maximum desired number of pods the workload should run at any
     given time. The actual number of pods running in steady state will be less
     than this number when ((.spec.completions - .status.successful) <
     .spec.parallelism), i.e. when the work left to do is less than max
     parallelism. More info:
     https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/

   ports	<Object>
     Specify the set of ports exposed from the container running the created
     workload. Used together with --service-type.

   processes	<Object>
     Number of distributed training processes which will be allocated for the
     created mpijob.

   pvcs	<Object>
     Specifies persistent volume claims to mount into a container running the
     created workload.

   runAsGid	<Object>
     Specifies the Unix group id with which the container ruinning the created
     workload should run. Will be used only if runAsUser is set to true.

   runAsUid	<Object>
     Specifies the Unix user id with which the container running the created
     workload should run. Will be used only if runAsUser is set to true.

   runAsUser	<Object>
     Limits the container running the created workload to run in the context of
     specific non-root user. The user id is provided by runAsUid field. This
     would manifest itself in access to operating system resources, in the owner
     of new folders created under shared directories, etc. Alternatively, if
     your cluster is connected to Run:AI via SAML, you can map the container to
     use the Linux UID/GID which is stored in the organization's directory. For
     further details consult the User Identity guide at
     https://docs.run.ai/admin/runai-setup/config/non-root-containers/

   s3	<Object>
     Specifies S3 buckets to mount into the container running the workload

   serviceType	<Object>
     Specifies service exposure method for created interactive workloads.
     Options are: portforward, loadbalancer, nodeport, ingress. Different
     service methods have different endpoint structures. For further information
     consult the External Access to Containers guide on
     https://docs.run.ai/admin/runai-setup/config/allow-external-access-to-containers/

   stdin	<Object>
     Instructs the system to keep stdin open for the container(s) running the
     created workload, even if nothing is attached.

   supplementalGroups	<Object>
     ';' seperated list of group supplemental group IDs. will be added to the
     security context of the container running the created workload.

   tolerations	<Object>
     Toleration rules which apply to the pods running the workload. The rules
     guides (but not require) the system which node each pod can be scheduled to
     or evicted from, based on matching between those rules and the set of
     taints defined for each kubernetes node.

   ttlAfterFinish	<Object>
     Specifies the duration after which it is eligible for a finished workload
     to be automatically deleted. When the workload is being deleted, its
     lifecycle guarantees (e.g. finalizers) will be honored. If this field is
     unset, the workload won't be automatically deleted. If this field is set to
     zero, the workload becomes eligible to be deleted immediately after it
     finishes. This field is alpha-level and is only honored by servers that
     enable the TTLAfterFinished feature.

   tty	<Object>
     Instructs the system to allocate a pseudo-TTY for the created workload.

   usage	<string>
     The usage of this workload. possible values: - Template: this workload is
     used as the base for other workloads - Submit: this workload is used for
     submitting job and/or other k8s resources

   username	<Object>
     Informatory field describing the user who owns the workload. It is not used
     for authentication or authorization purposes.

   volumes	<Object>
     Specifies volumes to mount into a container running the created workload.

   workingDir	<Object>
     Specifies a directory that will be used as the current directory when the
     container running the created workload starts.
```

