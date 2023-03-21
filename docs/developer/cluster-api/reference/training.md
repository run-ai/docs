# Training Workload Parameters

Following is a full list of all training workload parameters. The text below is equivalent to running `kubectl explain trainingworkload.spec`. You can also run `kubectl explain trainingworkload.spec.<parameter-name>` to see the description of a specific parameter. 

``` YAML
KIND:     TrainingWorkload
VERSION:  run.ai/v2alpha1

RESOURCE: spec <Object>

DESCRIPTION:
     The specifications of this TrainingWorkload

FIELDS:
   allowPrivilegeEscalation	<Object>
     Allow the container running the workload and all launched processes to gain
     additional privileges after the workload starts. For more information see
     the "User Identity in Container" guide at
     https://docs.run.ai/admin/runai-setup/config/non-root-containers/

   annotations	<Object>
     Specifies annotations to be set in the container that is running the
     created workload.

   arguments	<Object>
     When set,contains the arguments sent along with the command. These override
     the entry point of the image in the created workload.

   backoffLimit	<Object>
     Specifies the number of retries before marking a workload as failed.
     Defaults to 6

   baseWorkload	<string>
     Reference to another workload. When set, this workload inherits its values
     from the base workload. Base workload can either reside on the same
     namespace of this workload (referred to as "user" template) or can reside
     in the runai namespace (referred to as a "global" template)

   capabilities	<Object>
     The capabilities field allows adding a set of unix capabilities to the
     container running the workload. Capabilities are Linux distinct privileges
     traditionally associated with superuser which can be independently enabled
     and disabled. For more information see
     https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-capabilities-for-a-container

   command	<Object>
     If set, overrides the image's entry point with the supplied command.

   completions	<Object>
     Used with Hyperparameter Optimization. Specifies the number of successful
     pods the job should reach to be completed. The Job will be marked as
     successful once the specified amount of pods has succeeded. The default
     value for 'completions' is 1. The 'parallelism' flag should be smaller or
     equal to 'completions' For more information see:
     https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/

   cpu	<Object>
     Specifies CPU units to allocate for the created workload (0.5, 1, .etc).
     The workload will receive at least this amount of CPU. Note that the
     workload will not be scheduled unless the system can guarantee this amount
     of CPUs to the workload.

   cpuLimit	<Object>
     Specifies a limit on the number of CPUs consumed by the workload (0.5, 1,
     .etc). The system guarantees that this workload will not be able to consume
     more than this amount of CPUs.

   createHomeDir	<Object>
     Instructs the system to create a temporary home directory for the user
     within the container. Data stored in this directory will not be saved when
     the container exits. When the runAsUser flag is set to true, this flag will
     default to true as well.

   environment	<Object>
     Specifies environment variables to be set in the container running the
     created workload.

   exposedUrls	<Object>
     Specifies a set of exported url (e.g. ingress) from the container running
     the created workload.

   extendedResources	<Object>
     Specifies values for extended resources. Extended resources are third-party
     devices (such as high-performance NICs, FPGAs, or InfiniBand adapters) that
     you want to allocate to your Job. For more information see:
     https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/

   gitSync	<Object>
     Specifies git repositories to mount into the container running the
     workload.

   gpu	<Object>
     Specifies the number on the number of GPUs to allocate for the created
     workload. The default is no allocated GPUs. The GPU value can be an integer
     or a fraction between 0 and 1.

   gpuLimit	<Object>
     Specifies a limit on the GPUs to allocate for this workload (1G, 20M,
     .etc). Intended to use for Opportunistic jobs (with the smart
     node-scheduler).

   gpuMemory	<Object>
     Specifies GPU memory to allocate for the created workload. The workload
     will receive this amount of memory. Note that the workload will not be
     scheduled unless the system can guarantee this amount of GPU memory to the
     workload.

   hostIpc	<Object>
     Specifies that the created workload will use the host's ipc namespace.

   hostNetwork	<Object>
     Specifies that the created workload will use the host's network stack
     inside its container. For more information see the Docker Run Reference at
     https://docs.docker.com/engine/reference/run/

   image	<Object>
     Specifies the image to use when creating the container running the
     workload.

   imagePullPolicy	<Object>
     Specifies the pull policy of the image when starting a container running
     the created workload. Options are: always, ifNotPresent, or never. For more
     information see: https://kubernetes.io/docs/concepts/containers/images

   ingressUrl	<Object>
     This field is for internal use only.

   labels	<Object>
     Specifies labels to be set in the container running the created workload.

   largeShm	<Object>
     Specifies a large /dev/shm device to mount into a container running the
     created workload. SHM is a shared file system mounted on RAM.

   memory	<Object>
     Specifies the amount of CPU memory to allocate for this workload (1G, 20M,
     .etc). The workload will receive at least this amount of memory. Note that
     the workload will not be scheduled unless the system can guarantee this
     amount of memory to the workload

   memoryLimit	<Object>
     Specifies a limit on the CPU memory to allocate for this workload (1G, 20M,
     .etc). The system guarantees that this workload will not be able to consume
     more than this amount of memory. The workload will receive an error when
     trying to allocate more memory than this limit.

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
     The specific name of the created resource. Either name of namePrefix should
     be provided, but not both.

   namePrefix	<Object>
     A prefix used for assigning a name to the created resource. Either name of
     namePrefix should be provided, but not both.

   nodePool	<Object>
     Specifies the NodePool name to be used to schedule this job on - DEPRECATED
     use NodePools instead

   nodePools	<Object>
     Specifies the list of node pools to use for scheduling the job, ordered by
     preference.

   nodeType	<Object>
     Specifies nodes (machines) or a group of nodes on which the workload will
     run. To use this feature, your Administrator will need to label nodes as
     explained in the Group Nodes guide at
     https://docs.run.ai/admin/researcher-setup/limit-to-node-group. This flag
     can be used in conjunction with Project-based affinity. In this case, the
     flag is used to refine the list of allowable node groups set in the
     Project. For more information see the Projects setup guide at
     https://docs.run.ai/admin/admin-ui-setup/project-setup.

   parallelism	<Object>
     Specifies the maximum desired number of pods the workload should run at any
     given time. The actual number of pods running in a steady state will be
     less than this number when ((.spec.completions - .status.successful) <
     .spec.parallelism), i.e. when the work left to do is less than max
     parallelism. For more information, see:
     https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/

   podAffinity	<Object>
     Indicates whether pod affinity scheduling rules applies.

   podAffinitySchedulingRule	<Object>
     Indicates if we want to use the Pod affinity rule as : the "hard"
     (required) or the "soft" (preferred) This field can be specified only if
     PodAffinity is set to true

   podAffinityTopology	<Object>
     Specifies the Pod Affinity Topology to be used for scheduling the job This
     field can be specified only if PodAffinity is set to true

   ports	<Object>
     Specifies a set of ports exposed from the container running the created
     workload. Used together with --service-type.

   processes	<Object>
     Number of distributed training processes that will be allocated for the
     created mpijob.

   pvcs	<Object>
     Specifies persistent volume claims to mount into a container running the
     created workload.

   runAsGid	<Object>
     Specifies the Unix group id with which the container should run. Will be
     used only if runAsUser is set to true.

   runAsUid	<Object>
     Specifies the Unix user id with which the container running the created
     workload should run. Will be used only if runAsUser is set to true.

   runAsUser	<Object>
     Limits the container running the created workload to run in the context of
     a specific non-root user. The user id is provided by the runAsUid field.
     This would manifest itself in access to operating system resources, in the
     ownership of new folders created under shared directories, etc.
     Alternatively, if your cluster is connected to Run:ai via SAML, you can map
     the container to use the Linux UID/GID which is stored in the
     organization's directory. For more information see the User Identity guide
     at https://docs.run.ai/admin/runai-setup/config/non-root-containers/

   s3	<Object>
     Specifies S3 buckets to mount into the container running the workload

   serviceType	<Object>
     Specifies the default service exposure method for ports. The default shall
     be used for ports which do not specify service type. Options are:
     LoadBalancer, NodePort or ClusterIP. For more information see the External
     Access to Containers guide on
     https://docs.run.ai/admin/runai-setup/config/allow-external-access-to-containers/

   slotsPerWorker	<Object>
     Number of slots to allocate per worker in the created mpijob.

   stdin	<Object>
     Instructs the system to keep stdin open for the container(s) running the
     created workload, even if nothing is attached.

   supplementalGroups	<Object>
     ';' separated list of supplemental group IDs. Will be added to the security
     context of the container running the created workload.

   tolerations	<Object>
     Toleration rules which apply to the pods running the workload. Toleration
     rules guide (but do not require) the system to which node each pod can be
     scheduled to or evicted from, based on matching between those rules and the
     set of taints defined for each Kubernetes node.

   ttlAfterFinish	<Object>
     Specifies the duration after which it is possible for a finished workload
     to be automatically deleted. When the workload is being deleted, its
     lifecycle guarantees (e.g. finalizers) will be honored. If this field is
     unset, the workload won't be automatically deleted. If this field is set to
     zero, the workload becomes eligible to be deleted immediately after it
     finishes. This field is alpha-level and is only honored by servers that
     enable the TTLAfterFinished feature.

   tty	<Object>
     Instructs the system to allocate a pseudo-TTY for the created workload.

   usage	<string>
     The intended usage of this workload. possible values are "Template": this
     workload is used as the base for other workloads. "Submit": this workload
     is used for submitting a job and/or other Kubernetes resources.

   userId	<Object>
     The user ID ("Subject" in the jwt-token) of the authenticated user who owns
     the workload. The data might be used for authentication or authorization
     purposes.

   username	<Object>
     Display-only field describing the user who owns the workload. The data is
     not used for authentication or authorization purposes.

   volumes	<Object>
     Specifies volumes to mount into a container running the created workload.

   workingDir	<Object>
     Specifies a directory that will be used as the current directory when the
     container running the created workload starts.
```