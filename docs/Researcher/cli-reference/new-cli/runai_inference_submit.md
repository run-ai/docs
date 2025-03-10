## runai inference submit

submit inference

```
runai inference submit [flags]
```

### Examples

```

# Submit a inference workload with scale to zero
runai inference submit <name> -p <project_name> -i ubuntu --gpu-devices-request 1 
--serving-port=8000 --min-scale=0 --max-scale=1 

# Submit a inference workload with autoscaling and authorization
runai inference submit <name> -p <project_name> -i ubuntu --gpu-devices-request 1
--serving-port=container=8000,authorization-type=authorizedUsersOrGroups,authorized-users=user1:user2,protocol=http 
--min-scale=1 --max-scale=4 --metric=concurrency  --metric-threshold=100 
```

### Options

```
      --activation-replicas int32               The number of replicas to run when scaling-up from zero. Defaults to minReplicas, or to 1 if minReplicas is set to 0
      --annotation stringArray                  Set of annotations to populate into the container running the workspace
      --attach                                  If true, wait for the pod to start running, and then attach to the pod as if 'runai attach' was called. Attach makes tty and stdin true by default. Defaults to false
      --capability stringArray                  The POSIX capabilities to add when running containers. Defaults to the default set of capabilities granted by the container runtime.
  -c, --command                                 If true, override the image's entrypoint with the command supplied after '--'
      --concurrency-hard-limit int32            The maximum number of requests allowed to flow to a single replica at any time. 0 means no limit
      --configmap-map-volume stringArray        Mount ConfigMap as a volume. Use the fhe format name=CONFIGMAP_NAME,path=PATH
      --cpu-core-limit float                    CPU core limit (e.g. 0.5, 1)
      --cpu-core-request float                  CPU core request (e.g. 0.5, 1)
      --cpu-memory-limit string                 CPU memory limit to allocate for the job (e.g. 1G, 500M)
      --cpu-memory-request string               CPU memory to allocate for the job (e.g. 1G, 500M)
      --create-home-dir                         Create a temporary home directory. Defaults to true when --run-as-user is set, false otherwise
  -e, --environment stringArray                 Set environment variables in the container
      --existing-pvc stringArray                Mount an existing persistent volume. Use the format: claimname=CLAIM_NAME,path=PATH <auto-complete supported>
      --extended-resource stringArray           Request access to an extended resource. Use the format: resource_name=quantity
      --external-url stringArray                Expose URL from the job container. Use the format: container=9443,url=https://external.runai.com,authusers=user1,authgroups=group1
      --git-sync stringArray                    Specifies git repositories to mount into the container. Use the format: name=NAME,repository=REPO,path=PATH,secret=SECRET,rev=REVISION
  -g, --gpu-devices-request int32               GPU units to allocate for the job (e.g. 1, 2)
      --gpu-memory-limit string                 GPU memory limit to allocate for the job (e.g. 1G, 500M)
      --gpu-memory-request string               GPU memory to allocate for the job (e.g. 1G, 500M)
      --gpu-portion-limit float                 GPU portion limit, must be no less than the gpu-memory-request (between 0 and 1, e.g. 0.5, 0.2)
      --gpu-portion-request float               GPU portion request (between 0 and 1, e.g. 0.5, 0.2)
      --gpu-request-type string                 GPU request type (portion|memory|migProfile[Deprecated])
  -h, --help                                    help for submit
      --host-path stringArray                   host paths (Volumes) to mount into the container. Format: path=PATH,mount=MOUNT,mount-propagation=None|HostToContainer,readwrite
  -i, --image string                            The image for the workload
      --image-pull-policy string                Set image pull policy. One of: Always, IfNotPresent, Never. Defaults to Always (default "Always")
      --initial-replicas int32                  The number of replicas to run when initializing the workload for the first time. Defaults to minReplicas, or to 1 if minReplicas is set to 0
      --initialization-timeout-seconds int32    The maximum amount of time (in seconds) to wait for the container to become ready
      --label stringArray                       Set of labels to populate into the container running the workspace
      --large-shm                               Request large /dev/shm device to mount
      --max-replicas int32                      The maximum number of replicas for autoscaling. Defaults to minReplicas, or to 1 if minReplicas is set to 0
      --metric string                           Autoscaling metric is required if minReplicas < maxReplicas, except when minReplicas = 0 and maxReplicas = 1. Use 'throughput', 'concurrency', 'latency', or custom metrics.
      --metric-threshold int32                  The threshold to use with the specified metric for autoscaling. Mandatory if metric is specified
      --metric-threshold-percentage float32     The percentage of metric threshold value to use for autoscaling. Defaults to 70. Applicable only with the 'throughput' and 'concurrency' metrics
      --min-replicas int32                      The minimum number of replicas for autoscaling. Defaults to 1. Use 0 to allow scale-to-zero
      --name-prefix string                      Set defined prefix for the workload name and add index as a suffix
      --new-pvc stringArray                     Mount a persistent volume, create it if it does not exist. Use the format: claimname=CLAIM_NAME,storageclass=STORAGE_CLASS,size=SIZE,path=PATH,accessmode-rwo,accessmode-rom,accessmode-rwm,ro,ephemeral
      --nfs stringArray                         NFS volumes to use in the workload. Format: path=PATH,server=SERVER,mountpath=MOUNT_PATH,readwrite
      --node-pools stringArray                  List of node pools to use for scheduling the job, ordered by priority
      --node-type string                        Enforce node type affinity by setting a node-type label
      --pod-running-timeout duration            Pod check for running state timeout.
      --port stringArray                        Expose ports from the job container. Use the format: service-type=NodePort,container=80,external=8080
      --preferred-pod-topology-key string       If possible, all pods of this job will be scheduled onto nodes that have a label with this key and identical values
  -p, --project string                          Specify the project to which the command applies. By default, commands apply to the default project. To change the default project use ‘runai config project <project name>’
      --required-pod-topology-key string        Enforce scheduling pods of this job onto nodes that have a label with this key and identical values
      --run-as-gid int                          The group ID the container will run with
      --run-as-uid int                          The user ID the container will run with
      --run-as-user                             takes the uid, gid, and supplementary groups fields from the token, if all the fields do not exist, uses the local running terminal user credentials. if any of the fields exist take only the existing fields
      --scale-down-delay-seconds int32          The minimum amount of time (in seconds) that a replica will remain active after a scale-down decision
      --scale-to-zero-retention-seconds int32   The minimum amount of time (in seconds) that the last replica will remain active after a scale-to-zero decision. Defaults to 0. Available only if minReplicas is set to 0
      --seccomp-profile string                  Indicates which kind of seccomp profile will be applied to the container, options: RuntimeDefault|Unconfined|Localhost
      --secret-volume stringArray               Secret volumes to use in the workload. Format: path=PATH,name=SECRET_RESOURCE_NAME
      --serving-port string                     Defines various attributes for the serving port. Usage formats: (1) Simplified format: --serving-port=CONTAINER_PORT (2) Full format: --serving-port=container=CONTAINER_PORT,[authorization-type=public|authenticatedUsers|authorizedUsersOrGroups],[authorized-users=USER1:USER2...],[authorized-groups=GROUP1:GROUP2...],[cluster-local-access-only],[protocol=http|grpc]
      --supplemental-groups ints                Comma seperated list of groups (IDs) that the user running the container belongs to
      --toleration stringArray                  Toleration details. Use the format: operator=Equal|Exists,key=KEY,[value=VALUE],[effect=NoSchedule|NoExecute|PreferNoSchedule],[seconds=SECONDS]
      --user-group-source string                Indicate the way to determine the user and group ids of the container, options: fromTheImage|fromIdpToken|fromIdpToken
      --wait-for-submit duration                Waiting duration for the workload to be created in the cluster. Defaults to 1 minute (1m)
      --working-dir string                      Set the container's working directory
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

* [runai inference](runai_inference.md)	 - inference management

