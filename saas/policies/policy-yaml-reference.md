# Policy YAML reference

A workload policy is an end-to-end solution for AI managers and administrators to control and simplify how workloads are submitted, setting best practices, enforcing limitations, and standardizing processes for AI projects within their organization.

This article explains the policy YAML fields and the possible rules and defaults that can be set for each field.

## Policy YAML fields - reference table

The policy fields are structured in a similar format to the workload API fields. The following tables represent a structured guide designed to help you understand and configure policies in a YAML format. It provides the fields, descriptions, defaults and rules for each workload type.

Click the link to view the value type of each field.

| Fields                                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Value type                                       | Supported Run:ai workload type               |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | -------------------------------------------- |
| args                                   | When set, contains the arguments sent along with the command. These override the entry point of the image in the created workload                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| command                                | A command to serve as the entry point of the container running the workspace                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| createHomeDir                          | Instructs the system to create a temporary home directory for the user within the container. Data stored in this directory is not saved when the container exists. When the runAsUser flag is set to true, this flag defaults to true as well                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | [boolean](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| environmentVariables                   | Set of environmentVariables to populate the container running the workspace                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | [array](policy-yaml-reference.md#value-types)    | <ul><li>Workspace</li><li>Training</li></ul> |
| image                                  | Specifies the image to use when creating the container running the workload                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| imagePullPolicy                        | Specifies the pull policy of the image when starting t a container running the created workload. Options are: always, ifNotPresent, or never                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| workingDir                             | Container’s working directory. If not specified, the container runtime default is used, which might be configured in the container image                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| nodeType                               | Nodes (machines) or a group of nodes on which the workload runs                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| nodePools                              | A prioritized list of node pools for the scheduler to run the workspace on. The scheduler always tries to use the first node pool before moving to the next one when the first is not available.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | [array](policy-yaml-reference.md#value-types)    | <ul><li>Workspace</li><li>Training</li></ul> |
| annotations                            | Set of annotations to populate into the container running the workspace                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| labels                                 | Set of labels to populate into the container running the workspace                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| terminateAfterPreemtpion               | Indicates whether the job should be terminated, by the system, after it has been preempted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | [boolean](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| autoDeletionTimeAfterCompletionSeconds | Specifies the duration after which a finished workload (Completed or Failed) is automatically deleted. If this field is set to zero, the workload becomes eligible to be deleted immediately after it finishes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | [integer](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| backoffLimit                           | Specifies the number of retries before marking a workload as failed                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [integer](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| cleanPodPolicy                         | <p>Specifies which pods will be deleted when the workload reaches a terminal state (completed/failed). The policy can be one of the following values:</p><ul><li><code>Running</code> - Only pods still running when a job completes (for example, parameter servers) will be deleted immediately. Completed pods will not be deleted so that the logs will be preserved. (Default).</li><li><code>All</code> - All (including completed) pods will be deleted immediately when the job finishes.</li><li><code>None</code> - No pods will be deleted when the job completes. It will keep running pods that consume GPU, CPU and memory over time. It is recommended to set to None only for debugging and obtaining logs from running pods.</li></ul> | [string](policy-yaml-reference.md#value-types)   | Distributed                                  |
| completions                            | Used with Hyperparameter Optimization. Specifies the number of successful pods the job should reach to be completed. The Job is marked as successful once the specified amount of pods has succeeded.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | [integer](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| parallelism                            | Used with Hyperparameters Optimization. Specifies the maximum desired number of pods the workload should run at any given time.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| exposeUrls                             | Specifies a set of exported URL (e.g. ingress) from the container running the created workload.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| largeShmRequest                        | Specifies a large /dev/shm device to mount into a container running the created workload. SHM is a shared file system mounted on RAM.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | [boolean](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| PodAffinitySchedulingRule              | Indicates if we want to use the Pod affinity rule as: the “hard” (required) or the “soft” (preferred) option. This field can be specified only if PodAffinity is set to true.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| podAffinityTopology                    | Specifies the Pod Affinity Topology to be used for scheduling the job. This field can be specified only if PodAffinity is set to true.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| ports                                  | Specifies a set of ports exposed from the container running the created workload. More information in Ports fields below.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| probes                                 | Specifies the ReadinessProbe to use to determine if the container is ready to accept traffic. More information in [Probes fields](policy-yaml-reference.md#probes-fields) below                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | -                                                | <ul><li>Workspace</li><li>Training</li></ul> |
| tolerations                            | Toleration rules which apply to the pods running the workload. Toleration rules guide (but do not require) the system to which node each pod can be scheduled to or evicted from, based on matching between those rules and the set of taints defined for each Kubernetes node.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| priorityClass                          | Priority class of the workload. The values for workspace are build (default) or interactive-preemptible. For training only, use train. Enum: "build", "train", "interactive-preemptible"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | [string](policy-yaml-reference.md#value-types)   | Workspace                                    |
| storage                                | Contains all the fields related to storage configurations. More information in [Storage fields](policy-yaml-reference.md#storage-fields) below.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | -                                                | <ul><li>Workspace</li><li>Training</li></ul> |
| security                               | Contains all the fields related to security configurations. More information in [Security fields](policy-yaml-reference.md#security-fields) below.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | -                                                | <ul><li>Workspace</li><li>Training</li></ul> |
| compute                                | Contains all the fields related to compute configurations. More information in [Compute fields ](policy-yaml-reference.md#compute-fields)below.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | -                                                | <ul><li>Workspace</li><li>Training</li></ul> |

### Ports fields

| Fields      | Description                                                                                                                                                                                                                                                                                                   | Value type                                      | Supported Run:ai workload type               |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- | -------------------------------------------- |
| container   | The port that the container running the workload exposes.                                                                                                                                                                                                                                                     | [string](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| serviceType | Specifies the default service exposure method for ports. the default shall be sued for ports which do not specify service type. Options are: LoadBalancer, NodePort or ClusterIP. For more information see the [External Access to Containers](../admin/config/allow-external-access-to-containers.md) guide. | [string](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| external    | The external port which allows a connection to the container port. If not specified, the port is auto-generated by the system.                                                                                                                                                                                | [integer](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| toolType    | The tool type that runs on this port.                                                                                                                                                                                                                                                                         | [string](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| toolName    | A name describing the tool that runs on this port.                                                                                                                                                                                                                                                            | [string](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |

### Probes fields

| Fields    | Description                                                                                    | Value type | Supported Run:ai workload type               |
| --------- | ---------------------------------------------------------------------------------------------- | ---------- | -------------------------------------------- |
| readiness | Specifies the Readiness Probe to use to determine if the container is ready to accept traffic. | -          | <ul><li>Workspace</li><li>Training</li></ul> |

### Readiness field details

| **Spec fields**                     | readiness                                                                                     |   |
| ----------------------------------- | --------------------------------------------------------------------------------------------- | - |
| **Description**                     | Specifies the Readiness Probe to use to determine if the container is ready to accept traffic |   |
| **Supported Run:ai workload types** | <p>Workspace</p><p>Training</p>                                                               |   |
| **Value type**                      | [itemized](policy-yaml-reference.md#value-types)                                              |   |
| **Example workload snippet**        | <pre class="language-yaml"><code class="lang-yaml">defaults:
</code></pre>                    |   |
|                                     |                                                                                               |   |
| probes:                             |                                                                                               |   |

```
 readiness:
     initialDelaySeconds: 2
```

\| | | **Spec Readiness fields** | **Description** | **Value type** | | initialDelaySeconds | Number of seconds after the container has started before liveness or readiness probes are initiated. | [integer](policy-yaml-reference.md#value-types) | | periodSeconds | How often (in seconds) to perform the probe. | [integer](policy-yaml-reference.md#value-types) | | timeoutSeconds | Number of seconds after which the probe times out | [integer](policy-yaml-reference.md#value-types) | | successThreshold | Minimum consecutive successes for the probe to be considered successful after having failed. | [integer](policy-yaml-reference.md#value-types) | | failureThreshold | When a probe fails, the number of times to try before giving up. | [integer](policy-yaml-reference.md#value-types) |

### Security fields

| Fields                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Value type                                      | Supported Run:ai workload type               |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- | -------------------------------------------- |
| uidGidSource             | <p>Indicates the way to determine the user and group ids of the container. The options are:</p><ul><li><code>fromTheImage</code> - user and group IDs are determined by the docker image that the container runs. This is the default option.</li><li><code>custom</code> - user and group IDs can be specified in the environment asset and/or the workspace creation request.</li><li><code>idpToken</code> - user and group IDs are determined according to the identity provider (idp) access token. This option is intended for internal use of the environment UI form. For more information, see <a href="https://docs.run.ai/latest/admin/config/non-root-containers/">Non-root containers</a>.</li></ul> | [string](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| capabilities             | The capabilities field allows adding a set of unix capabilities to the container running the workload. Capabilities are Linux distinct privileges traditionally associated with superuser which can be independently enabled and disabled                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | [array](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| seccompProfileType       | <p>Indicates which kind of seccomp profile is applied to the container. The options are:</p><ul><li>RuntimeDefault - the container runtime default profile should be used</li><li>Unconfined - no profile should be applied</li></ul>                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | [string](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| runAsNonRoot             | Indicates that the container must run as a non-root user.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | [boolean](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| readOnlyRootFilesystem   | If true, mounts the container's root filesystem as read-only.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [boolean](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| runAsUid                 | Specifies the Unix user id with which the container running the created workload should run.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | [integer](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| runasGid                 | Specifies the Unix Group ID with which the container should run.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | [integer](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| supplementalGroups       | Comma separated list of groups that the user running the container belongs to, in addition to the group indicated by runAsGid.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | [string](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| allowPrivilegeEscalation | Allows the container running the workload and all launched processes to gain additional privileges after the workload starts                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | [boolean](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| hostIpc                  | Whether to enable hostIpc. Defaults to false.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | [boolean](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| hostNetwork              | Whether to enable host network.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | [boolean](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |

### Compute fields

| Fields                  | Description                                                                                                                                                                                                                                                          | Value type                                       | Supported Run:ai workload type               |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | -------------------------------------------- |
| cpuCoreRequest          | CPU units to allocate for the created workload (0.5, 1, .etc). The workload receives at least this amount of CPU. Note that the workload is not scheduled unless the system can guarantee this amount of CPUs to the workload.                                       | [number](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| cpuCoreLimit            | Limitations on the number of CPUs consumed by the workload (0.5, 1, .etc). The system guarantees that this workload is not able to consume more than this amount of CPUs.                                                                                            | [number](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| cpuMemoryRequest        | The amount of CPU memory to allocate for this workload (1G, 20M, .etc). The workload receives at least this amount of memory. Note that the workload is not scheduled unless the system can guarantee this amount of memory to the workload                          | [quantity](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| cpuMemoryLimit          | Limitations on the CPU memory to allocate for this workload (1G, 20M, .etc). The system guarantees that this workload is not be able to consume more than this amount of memory. The workload receives an error when trying to allocate more memory than this limit. | [quantity](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| largeShmRequest         | A large /dev/shm device to mount into a container running the created workload (shm is a shared file system mounted on RAM).                                                                                                                                         | [boolean](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| gpuRequestType          | Sets the unit type for GPU resources requests to either portion, memory or mig profile. Only if `gpuDeviceRequest = 1`, the request type can be stated as `portion`, `memory` or `migProfile`.                                                                       | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| migProfile (Deprecated) | Specifies the memory profile to be used for workload running on NVIDIA Multi-Instance GPU (MIG) technology.                                                                                                                                                          | [string](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| gpuPortionRequest       | Specifies the fraction of GPU to be allocated to the workload, between 0 and 1. For backward compatibility, it also supports the number of gpuDevices larger than 1, currently provided using the gpuDevices field.                                                  | [number](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| gpuDeviceRequest        | Specifies the number of GPUs to allocate for the created workload. Only if `gpuDeviceRequest = 1`, the gpuRequestType can be defined.                                                                                                                                | [integer](policy-yaml-reference.md#value-types)  | <ul><li>Workspace</li><li>Training</li></ul> |
| gpuPortionLimit         | When a fraction of a GPU is requested, the GPU limit specifies the portion limit to allocate to the workload. The range of the value is from 0 to 1.                                                                                                                 | [number](policy-yaml-reference.md#value-types)   | <ul><li>Workspace</li><li>Training</li></ul> |
| gpuMemoryRequest        | Specifies GPU memory to allocate for the created workload. The workload receives this amount of memory. Note that the workload is not scheduled unless the system can guarantee this amount of GPU memory to the workload.                                           | [quantity](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| gpuMemoryLimit          | Specifies a limit on the GPU memory to allocate for this workload. Should be no less than the gpuMemory.                                                                                                                                                             | [quantity](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| extendedResources       | Specifies values for extended resources. Extended resources are third-party devices (such as high-performance NICs, FPGAs, or InfiniBand adapters) that you want to allocate to your Job.                                                                            | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |

### Storage fields

| Fields           | Description                                                                                                                                                                 | Value type                                       | Supported Run:ai workload type               |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | -------------------------------------------- |
| dataVolume       | Set of data volumes to use in the workload. Each data volume is mapped to a file-system mount point within the container running the workload.                              | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| hostPath         | Maps a folder to a file-system mount point within the container running the workload.                                                                                       | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| git              | Details of the git repository and items mapped to it.                                                                                                                       | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| pvc              | Specifies persistent volume claims to mount into a container running the created workload.                                                                                  | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| nfs              | Specifies NFS volume to mount into the container running the workload.                                                                                                      | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| s3               | Specifies S3 buckets to mount into the container running the workload.                                                                                                      | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| configMapVolumes | Specifies ConfigMaps to mount as volumes into a container running the created workload.                                                                                     | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |
| secretVolume     | Set of secret volumes to use in the workload. A secret volume maps a secret resource in the cluster to a file-system mount point within the container running the workload. | [itemized](policy-yaml-reference.md#value-types) | <ul><li>Workspace</li><li>Training</li></ul> |

#### Storage field details

| **Spec fields**                     | hostPath                                                                            |   |
| ----------------------------------- | ----------------------------------------------------------------------------------- | - |
| **Description**                     | Maps a folder to a file system mount oint within the container running the workload |   |
| **Supported Run:ai workload types** | <ul><li>Workspace</li><li>Training</li></ul>                                        |   |
| **Value type**                      | [itemized](policy-yaml-reference.md#value-types)                                    |   |
| **Example workload snippet**        | <pre class="language-yaml"><code class="lang-yaml">defaults:
</code></pre>          |   |
|                                     |                                                                                     |   |
| storage:                            |                                                                                     |   |

```
hostPath:
  instances:
    - path: h3-path-1
      mountPath: h3-mount-1
    - path: h3-path-2
      mountPath: h3-mount-2
  attributes:
    - readOnly: true
```

\| | | **hostPath** **fields** | **Description** | **Value type** | | name | Unique name to identify the instance. primarily used for policy locked rules. | [string](policy-yaml-reference.md#value-types) | | path | Local path within the controller to which the host volume is mapped. | [string](policy-yaml-reference.md#value-types) | | readOnly | Force the volume to be mounted with read-only permissions. Defaults to false. | [boolean](policy-yaml-reference.md#value-types) | | mountPath | The path that the host volume is mounted to when in use. | [string](policy-yaml-reference.md#value-types) | | mountPropagation |

Enum: "None" "HostToContainer"

Share this volume mount with other containers. If set to HostToContainer, this volume mount receives all subsequent mounts that are mounted to this volume or any of its subdirectories. In case of multiple hostPath entries, this field should have the same value for all of them

\| [string](policy-yaml-reference.md#value-types) |

| **Spec fields**                     | git                                                                        |   |
| ----------------------------------- | -------------------------------------------------------------------------- | - |
| **Description**                     | Details of the git repository and items mapped to it.                      |   |
| **Supported Run:ai workload types** | <ul><li>Workspace</li><li>Training</li></ul>                               |   |
| **Value type**                      | [itemized](policy-yaml-reference.md#value-types)                           |   |
| **Example workload snippet**        | <pre class="language-yaml"><code class="lang-yaml">defaults:
</code></pre> |   |
|                                     |                                                                            |   |
| storage:                            |                                                                            |   |

```
git:
  attributes:
    Repository: https://runai.public.github.com
  instances
    - branch: "master"
      path: /container/my-repository
      passwordSecret: my-password-secret
```

\| | | **Git fields** | **Description** | **Value type** | | repository | URL to a remote git repository. The content of this repository is mapped to the container running the workload | [string](policy-yaml-reference.md#value-types) | | revision | Specific revision to synchronize the repository from | [string](policy-yaml-reference.md#value-types) | | path | Local path within the workspace to which the S3 bucket is mapped. | [string](policy-yaml-reference.md#value-types) | | secretName | Optional name of Kubernetes secret that holds your git username and password. | [string](policy-yaml-reference.md#value-types) | | username | If secretName is provided, this field should contain the key, within the provided Kubernetes secret, which holds the value of your git username. Otherwise, this field should specify your git username in plain text (example: myuser). | [string](policy-yaml-reference.md#value-types) |

| **Spec fields**                     | pvc                                                                                       |   |
| ----------------------------------- | ----------------------------------------------------------------------------------------- | - |
| **Description**                     | Specifies persistent volume claims to mount into a container running the created workload |   |
| **Supported Run:ai workload types** | <ul><li>Workspace</li><li>Training</li></ul>                                              |   |
| **Value type**                      | [itemized](policy-yaml-reference.md#value-types)                                          |   |
| **Example workload snippet**        | <pre class="language-yaml"><code class="lang-yaml">defaults:
</code></pre>                |   |
|                                     |                                                                                           |   |
| storage:                            |                                                                                           |   |

```
pvc:
  instances:
    - claimName: pvc-staging-researcher1-home
      existingPvc: true
      path: /myhome
      readOnly: false
      claimInfo:
        accessModes:
          readWriteMany: true
```

\| | | **Spec PVC fields** | **Description** | **Value type** | | claimName (mandatory) | A given name for the PVC. Allowed referencing it across workspaces. | [string](policy-yaml-reference.md#value-types) | | ephemeral | Use **true** to set PVC to ephemeral. If set to **true**, the PVC is deleted when the workspace is stopped. | [boolean](policy-yaml-reference.md#value-types) | | path | Local path within the workspace to which the PVC bucket is mapped. | [string](policy-yaml-reference.md#value-types) | | readonly | Permits read only from the PVC, prevents additions or modifications to its content. | [boolean](policy-yaml-reference.md#value-types) | | ReadwriteOnce | Requesting claim that can be mounted in read/write mode to exactly 1 host. If none of the modes are specified, the default is readWriteOnce. | [boolean](policy-yaml-reference.md#value-types) | | size | Requested size for the PVC. Mandatory when existing PVC is false. | [string](policy-yaml-reference.md#value-types) | | storageClass | Storage class name to associate with the PVC. This parameter may be omitted if there is a single storage class in the system, or you are using the default storage class. Further details at [Kubernetes storage classes](https://kubernetes.io/docs/concepts/storage/storage-classes.). | [string](policy-yaml-reference.md#value-types) | | readOnlyMany | Requesting claim that can be mounted in read-only mode to many hosts. | [boolean](policy-yaml-reference.md#value-types) | | readWriteMany | Requesting claim that can be mounted in read/write mode to many hosts. | [boolean](policy-yaml-reference.md#value-types) |

| **Spec fields**                     | nfs                                                                        |   |
| ----------------------------------- | -------------------------------------------------------------------------- | - |
| **Description**                     | Specifies NFS volume to mount into the container running the workload      |   |
| **Supported Run:ai workload types** | <ul><li>Workspace</li><li>Training</li></ul>                               |   |
| **Value type**                      | [itemized](policy-yaml-reference.md#value-types)                           |   |
| **Example workload snippet**        | <pre class="language-yaml"><code class="lang-yaml">defaults:
</code></pre> |   |
|                                     |                                                                            |   |
| storage:                            |                                                                            |   |
| nfs:                                |                                                                            |   |

```
 instances:
   - path: nfs-path
     readOnly: true
     server: nfs-server
     mountPath: nfs-mount
```

rules: storage: nfs: instances: canAdd: false | | | **nfs fields** | **Description** | **Value type** | | mountpath | The path that the NFS volume is mounted to when in use. | [string](policy-yaml-reference.md#value-types) | | path | Path that is exported by the NFS server. | [string](policy-yaml-reference.md#value-types) | | readOnly | Whether to force the NFS export to be mounted with read-only permissions. | [boolean](policy-yaml-reference.md#value-types) | | nfsServer | The hostname or IP address of the NFS server. | [string](policy-yaml-reference.md#value-types) |

| **Spec fields**                     | s3                                                                         |   |
| ----------------------------------- | -------------------------------------------------------------------------- | - |
| **Description**                     | Specifies S3 buckets to mount into the container running the workload      |   |
| **Supported Run:ai workload types** | <ul><li>Workspace</li><li>Training</li></ul>                               |   |
| **Value type**                      | [itemized](policy-yaml-reference.md#value-types)                           |   |
| **Example workload snippet**        | <pre class="language-yaml"><code class="lang-yaml">defaults:
</code></pre> |   |
|                                     |                                                                            |   |
| storage:                            |                                                                            |   |

```
s3:
  instances:
    - bucket: bucket-opt-1
      path: /s3/path
      accessKeySecret: s3-access-key
      secretKeyOfAccessKeyId: s3-secret-id
      secretKeyOfSecretKey: s3-secret-key
  attributes:
    url: https://amazonaws.s3.com
```

\| | | **s3 fields** | **Description** | **Value type** | | Bucket | The name of the bucket | [string](policy-yaml-reference.md#value-types) | | path | Local path within the workspace to which the S3 bucket is mapped | [string](policy-yaml-reference.md#value-types) | | url | The URL of the S3 service provider. The default is the URL of the Amazon AWS Se service | [string](policy-yaml-reference.md#value-types) |

## Value types

Each field has a specific value type. The following value types are supported.

| Value type | Description                                                                                                                                                                      | Supported rule type                                                                                 | Defaults                                               |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| Boolean    | A binary value that can be either True or False                                                                                                                                  | <ul><li>canEdit</li><li>required</li></ul>                                                          | true/false                                             |
| String     | A sequence of characters used to represent text. It can include letters, numbers, symbols, and spaces                                                                            | <ul><li>canEdit</li><li>required</li><li>options</li></ul>                                          | abc                                                    |
| Itemized   | An ordered collection of items (objects), which can be of different types (all items in the list are of the same type). For further information see the chapter below the table. | <ul><li>canAdd</li><li>locked</li></ul>                                                             | See below                                              |
| Integer    | An Integer is a whole number without a fractional component.                                                                                                                     | <ul><li>canEdit</li><li>required</li><li>min</li><li>max</li><li>step</li><li>defaultFrom</li></ul> | 100                                                    |
| Number     | Capable of having non-integer values                                                                                                                                             | <ul><li>canEdit</li><li>required</li><li>min</li><li>defaultFrom</li></ul>                          | 10.3                                                   |
| Quantity   | Holds a string composed of a number and a unit representing a quantity                                                                                                           | <ul><li>canEdit</li><li>required</li><li>min</li><li>max</li><li>defaultFrom</li></ul>              | 5M                                                     |
| Array      | Set of values that are treated as one, as opposed to Itemized in which each item can be referenced separately.                                                                   | <ul><li>canEdit</li><li>required</li></ul>                                                          | <ul><li>node-a</li><li>node-b</li><li>node-c</li></ul> |

## Itemized

Workload fields of type itemized have multiple instances, however in comparison to objects, each can be referenced by a key field. The key field is defined for each field.

Consider the following workload spec:

```yaml
spec:
  image: ubuntu
  compute:
    extendedResources:
      - resource: added/cpu
        quantity: 10
      - resource: added/memory
        quantity: 20M
```

In this example, extendedResources have two instances, each has two attributes: resource (the key attribute) and quantity.

In policy, the defaults and rules for itemized fields have two sub sections:

* Instances: default items to be added to the policy or rules which apply to an instance as a whole.
* Attributes: defaults for attributes within an item or rules which apply to attributes within each item.

Consider the following example:

```yaml
defaults:
  compute:
    extendedResources:
      instances: 
        - resource: default/cpu
          quantity: 5
        - resource: default/memory
          quantity: 4M
      attributes:
        quantity: 3
rules:
  compute:
    extendedResources:
      instances:
        locked: 
          - default/cpu
      attributes:
        quantity: 
          required: true
```

Assume the following workload submission is requested:

```yaml
spec:
  image: ubuntu
  compute:
    extendedResources:
      - resource: default/memory
        exclude: true
      - resource: added/cpu
      - resource: added/memory
        quantity: 5M
```

The effective policy for the above mentioned workload has the following extendedResources instances:

| Resource     | Source of the instance | Quantity | Source of the attribute quantity                                  |
| ------------ | ---------------------- | -------- | ----------------------------------------------------------------- |
| default/cpu  | Policy defaults        | 5        | The default of this instance in the policy defaults section       |
| added/cpu    | Submission request     | 3        | The default of the quantity attribute from the attributes section |
| added/memory | Submission request     | 5M       | Submission request                                                |

{% hint style="info" %}
The default/memory is not populated to the workload, this is because it has been excluded from the workload using “exclude: true”.
{% endhint %}

A workload submission request cannot exclude the default/cpu resource, as this key is included in the locked rules under the instances section. {#a-workload-submission-request-cannot-exclude-the-default/cpu-resource,-as-this-key-is-included-in-the-locked-rules-under-the-instances-section.}

## Rule types

| Rule types | Description                                                                                                                      | Supported value types                            | Rule type example                                                         |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | ------------------------------------------------------------------------- |
| canAdd     | Whether the submission request can add items to an itemized field other than those listed in the policy defaults for this field. | [itemized](policy-yaml-reference.md#value-types) | <pre class="language-yaml"><code class="lang-yaml">storage:
</code></pre> |
|            |                                                                                                                                  |                                                  |                                                                           |
| hostPath:  |                                                                                                                                  |                                                  |                                                                           |

```
 instances:
   canAdd: false
```

\| | locked | Set of items that the workload is unable to modify or exclude. In this example, a workload policy default is given to HOME and USER, that the submission request cannot modify or exclude from the workload. | [itemized](policy-yaml-reference.md#value-types) |

```yaml
storage:
hostPath:
Instances:
locked:
- HOME
- USER
```

\| | canEdit | Whether the submission request can modify the policy default for this field. In this example, it is assumed that the policy has default for imagePullPolicy. As canEdit is set to false, submission requests are not able to alter this default. |

* [string](policy-yaml-reference.md#value-types)
* [boolean](policy-yaml-reference.md#value-types)
* [integer](policy-yaml-reference.md#value-types)
* [number](policy-yaml-reference.md#value-types)
* [quantity](policy-yaml-reference.md#value-types)
* [array](policy-yaml-reference.md#value-types)

|

```yaml
imagePullPolicy:
canEdit: false
```

\| | required | When set to true, the workload must have a value for this field. The value can be obtained from policy defaults. If no value specified in the policy defaults, a value must be specified for this field in the submission request. |

* [string](policy-yaml-reference.md#value-types)
* [boolean](policy-yaml-reference.md#value-types)
* [integer](policy-yaml-reference.md#value-types)
* [number](policy-yaml-reference.md#value-types)
* [quantity](policy-yaml-reference.md#value-types)
* [array](policy-yaml-reference.md#value-types)

|

```yaml
image:
required: true
```

\| | min | The minimal value for the field. |

* [integer](policy-yaml-reference.md#value-types)
* [number](policy-yaml-reference.md#value-types)
* [quantity](policy-yaml-reference.md#value-types)

|

```yaml
compute:
gpuDevicesRequest:
min: 3
```

\| | max | The maximal value for the field. |

* [integer](policy-yaml-reference.md#value-types)
* [number](policy-yaml-reference.md#value-types)
* [quantity](policy-yaml-reference.md#value-types)

|

```yaml
compute:
gpuMemoryRequest:
max: 2G
```

\| | step | The allowed gap between values for this field. In this example the allowed values are: 1, 3, 5, 7 |

* [integer](policy-yaml-reference.md#value-types)
* [number](policy-yaml-reference.md#value-types)

|

```yaml
compute:
cpuCoreRequest:
min: 1
max: 7
Step: 2
```

\| | options | Set of allowed values for this field. | [string](policy-yaml-reference.md#value-types) |

```yaml
image:
options:
- value: image-1
- value: image-2
```

\| | defaultFrom |

Set a default value for a field that will be calculated based on the value of another field.\\

|

* [integer](policy-yaml-reference.md#value-types)
* [number](policy-yaml-reference.md#value-types)
* [quantity](policy-yaml-reference.md#value-types)

|

```yaml
cpuCoreRequest:
defaultFrom:
field: compute.cpuCoreLimit
factor: 0.5
```

|

## Policy Spec Sections

For each field of a specific policy, you can specify both rules and defaults. A policy spec consists of the following sections:

* Rules
* Defaults
* Imposed Assets

### Rules

Rules set up constraints on workload policy fields. For example, consider the following policy:

```yaml
rules:
  compute:
    gpuDevicesRequest: 
      max: 8
  security:
    runAsUid: 
      min: 500
```

Such a policy restricts the maximum value for gpuDeviceRequests to 8, and the minimal value for runAsUid, provided in the security section to 500.

### Defaults

The defaults section is used for providing defaults for various workload fields. For example, consider the following policy:

```yaml
defaults:
  imagePullPolicy: Always
  security:
    runAsNonRoot: true
    runAsUid: 500
```

Assume a submission request with the following values:

* Image: ubuntu
* runAsUid: 501

The effective workload that runs has the following set of values:

| Field                 | Value  | Source             |
| --------------------- | ------ | ------------------ |
| Image                 | Ubuntu | Submission request |
| ImagePullPolicy       | Always | Policy defaults    |
| security.runAsNonRoot | true   | Policy defaults    |
| security.runAsUid     | 501    | Submission request |

{% hint style="info" %}
It is possible to specify a rule for each field, which states if a submission request is allowed to change the policy default for that given field, for example:

```yaml
defaults:
imagePullPolicy: Always
security:
    runAsNonRoot: true
    runAsUid: 500
 rules:
 security:
    runAsUid:
    canEdit: false
```

If this policy is applied, the submission request above fails, as it attempts to change the value of secuirty.runAsUid from 500 (the policy default) to 501 (the value provided in the submission request), which is forbidden due to canEdit rule set to false for this field.
{% endhint %}

### Imposed assets

Default instances of a storage field can be provided using a datasource containing the details of this storage instance. To add such instances in the policy, specify those asset IDs in the imposedAssets section of the policy.

```yaml
defaults: null
rules: null
imposedAssets:
  - f12c965b-44e9-4ff6-8b43-01d8f9e630cc
```

Assets with references to credential assets (for example: private S3, containing reference to an AccessKey asset) cannot be used as imposedAssets.
