## runai training mpi submit

submit mpi training

```
runai training mpi submit [flags]
```

### Examples

```
# Submit a mpi training workload
runai training mpi submit <name> -p <project_name> -i runai.jfrog.io/demo/quickstart-demo

# Submit a mpi training workload with arguments
runai training mpi submit <name> -p <project_name> -i ubuntu -- ls -la

# Submit a mpi training workload with a custom command
runai training mpi submit <name> -p <project_name> -i ubuntu --command -- echo "Hello, World"

# Submit a mpi training master args with worker args
runai training mpi submit <name> -p <project_name> -i ubuntu --master-args "-a master_arg_a -b master-arg_b'" -- '-a worker_arg_a'

# Submit a mpi training master command with worker args
runai training mpi submit <name> -p <project_name> -i ubuntu --master-command "echo -e 'master command'" -- '-a worker_arg_a'

# Submit a mpi training master command with worker command
runai training mpi submit <name> -p <project_name> -i ubuntu --master-command "echo -e 'master command'" --command -- echo -e 'worker command'
```

### Options

```
      --allow-privilege-escalation                     Allow the job to gain additional privileges after starting
      --annotation stringArray                         Set of annotations to populate into the container running the workspace
      --attach                                         If true, wait for the pod to start running, and then attach to the pod as if 'runai attach' was called. Attach makes tty and stdin true by default. Defaults to false
      --auto-deletion-time-after-completion duration   The length of time (like 5s, 2m, or 3h, higher than zero) after which a completed job is automatically deleted (default 0s)
      --backoff-limit int                              The number of times the job will be retried before failing (default 6)
      --capability stringArray                         The POSIX capabilities to add when running containers. Defaults to the default set of capabilities granted by the container runtime.
      --clean-pod-policy string                        Specifies which pods will be deleted when the workload reaches a terminal state (completed/failed)
  -c, --command                                        If true, override the image's entrypoint with the command supplied after '--'
      --configmap-map-volume stringArray               Mount ConfigMap as a volume. Use the fhe format name=CONFIGMAP_NAME,path=PATH
      --cpu-core-limit float                           CPU core limit (e.g. 0.5, 1)
      --cpu-core-request float                         CPU core request (e.g. 0.5, 1)
      --cpu-memory-limit string                        CPU memory limit to allocate for the job (e.g. 1G, 500M)
      --cpu-memory-request string                      CPU memory to allocate for the job (e.g. 1G, 500M)
      --create-home-dir                                Create a temporary home directory. Defaults to true when --run-as-user is set, false otherwise
  -e, --environment stringArray                        Set environment variables in the container
      --existing-pvc stringArray                       Mount an existing persistent volume. Use the format: claimname=CLAIM_NAME,path=PATH <auto-complete supported>
      --extended-resource stringArray                  Request access to an extended resource. Use the format: resource_name=quantity
      --external-url stringArray                       Expose URL from the job container. Use the format: container=9443,url=https://external.runai.com,authusers=user1,authgroups=group1
      --git-sync stringArray                           Specifies git repositories to mount into the container. Use the format: name=NAME,repository=REPO,path=PATH,secret=SECRET,rev=REVISION
  -g, --gpu-devices-request int32                      GPU units to allocate for the job (e.g. 1, 2)
      --gpu-memory-limit string                        GPU memory limit to allocate for the job (e.g. 1G, 500M)
      --gpu-memory-request string                      GPU memory to allocate for the job (e.g. 1G, 500M)
      --gpu-portion-limit float                        GPU portion limit, must be no less than the gpu-memory-request (between 0 and 1, e.g. 0.5, 0.2)
      --gpu-portion-request float                      GPU portion request (between 0 and 1, e.g. 0.5, 0.2)
      --gpu-request-type string                        GPU request type (portion|memory|migProfile[Deprecated])
  -h, --help                                           help for submit
      --host-ipc                                       Whether to enable host IPC. (Default: false)
      --host-network                                   Whether to enable host networking. (Default: false)
      --host-path stringArray                          host paths (Volumes) to mount into the container. Format: path=PATH,mount=MOUNT,mount-propagation=None|HostToContainer,readwrite
  -i, --image string                                   The image for the workload
      --image-pull-policy string                       Set image pull policy. One of: Always, IfNotPresent, Never. Defaults to Always (default "Always")
      --label stringArray                              Set of labels to populate into the container running the workspace
      --large-shm                                      Request large /dev/shm device to mount
      --master-args string                             Specifies the arguments to pass to the master pod container command
      --master-command string                          Specifies the command to run in the master pod container, overriding the image's default entrypoint. The command can include arguments following it.
      --master-environment stringArray                 Set master environment variables in the container
      --master-extended-resource stringArray           Request access to an extended resource. Use the format: resource_name=quantity
      --master-no-pvcs                                 Do not mount any persistent volumes in the master pod
      --name-prefix string                             Set defined prefix for the workload name and add index as a suffix
      --new-pvc stringArray                            Mount a persistent volume, create it if it does not exist. Use the format: claimname=CLAIM_NAME,storageclass=STORAGE_CLASS,size=SIZE,path=PATH,accessmode-rwo,accessmode-rom,accessmode-rwm,ro,ephemeral
      --nfs stringArray                                NFS volumes to use in the workload. Format: path=PATH,server=SERVER,mountpath=MOUNT_PATH,readwrite
      --node-pools stringArray                         List of node pools to use for scheduling the job, ordered by priority
      --node-type string                               Enforce node type affinity by setting a node-type label
      --pod-running-timeout duration                   Pod check for running state timeout.
      --port stringArray                               Expose ports from the job container. Use the format: service-type=NodePort,container=80,external=8080
      --preferred-pod-topology-key string              If possible, all pods of this job will be scheduled onto nodes that have a label with this key and identical values
  -p, --project string                                 Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --required-pod-topology-key string               Enforce scheduling pods of this job onto nodes that have a label with this key and identical values
      --run-as-gid int                                 The group ID the container will run with
      --run-as-uid int                                 The user ID the container will run with
      --run-as-user                                    takes the uid, gid, and supplementary groups fields from the token, if all the fields do not exist, uses the local running terminal user credentials. if any of the fields exist take only the existing fields
      --s3 stringArray                                 s3 buckets to use in the workload. Format: name=NAME,bucket=BUCKET,path=PATH,accesskey=ACCESS_KEY,url=URL
      --seccomp-profile string                         Indicates which kind of seccomp profile will be applied to the container, options: RuntimeDefault|Unconfined|Localhost
      --secret-volume stringArray                      Secret volumes to use in the workload. Format: path=PATH,name=SECRET_RESOURCE_NAME
      --slots-per-worker int32                         Number of slots to allocate for each worker
      --stdin                                          Keep stdin open on the container(s) in the pod, even if nothing is attached
      --supplemental-groups ints                       Comma seperated list of groups (IDs) that the user running the container belongs to
      --termination-grace-period duration              The length of time (like 5s or 2m, higher than zero) the workload's pod is expected to terminate gracefully upon probe failure. In case value is not specified, kubernetes default of 30 seconds applies (default 0s)
      --toleration stringArray                         Toleration details. Use the format: operator=Equal|Exists,key=KEY,[value=VALUE],[effect=NoSchedule|NoExecute|PreferNoSchedule],[seconds=SECONDS]
  -t, --tty                                            Allocate a TTY for the container
      --user-group-source string                       Indicate the way to determine the user and group ids of the container, options: fromTheImage|fromIdpToken|fromIdpToken
      --wait-for-submit duration                       Waiting duration for the workload to be created in the cluster. Defaults to 1 minute (1m)
      --workers int32                                  the number of workers that will be allocated for running the workload
      --working-dir string                             Set the container's working directory
```

### Options inherited from parent commands

```
      --config-file string   config file name; can be set by environment variable RUNAI_CLI_CONFIG_FILE (default "config.json")
      --config-path string   config path; can be set by environment variable RUNAI_CLI_CONFIG_PATH
  -d, --debug                enable debug mode
  -q, --quiet                enable quiet mode, suppress all output except error messages
      --verbose              enable verbose mode
```

### SEE ALSO

* [runai training mpi](runai_training_mpi.md)	 - mpi management

