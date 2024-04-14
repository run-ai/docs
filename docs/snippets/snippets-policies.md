## Configurable Fields

The following parameters can be configured in the policy manager.

!!! Note
    In the tables below, when a **Type** has `null` as an option, you can choose to either not use the **Field** or use the value `null` in the policy YAML.

### Defaults

The `defaults` section of the policy file is...

|Field | Type | Description |
| -- | -- | --|
| `environment` | `object` or `null` | [Environment](#environment-fields) fields that can be overridden when creating a workload. |
| `compute` | `object` or `null` | Compute resources requested. |
| `hostPath` | `object` or `null` | Volumes resource definitions. |
| `nfs` | `object` or `null` | NFS volume definitions. |
| `pvc` | `object` or `null` | PVC definitions. |
| `git` | `object` or `null` | Git repository definitions. |
| `s3` | `object` or `null` | S3 resource definitions. |
| `configmap` | `object` or `null` | ConfigMap definitions. |
| `imposedAssets` | `object` or `null` | A list of asset to be imposed on the workloads created in org units affected by this policy. |

#### Environment Fields

|Field | Type | Description |
| -- | -- | --|
| `command` | `string` or `null` (non-empty) | A command sent to the server used as the entry point of the container running the workspace. |
| `args` | `string` or `null` (non-empty) | Arguments applied to the command that the container running the workspace executes. |
| `environmentVariables` | `array of objects` or `null` or `null` |An array of [environment variables](#environment-variables) to populate into the container running the workspace. |
| `runAsUid` | `integer` <int64> or `null` | The userid to run the entrypoint of the container. Default to the (optional) value specified in the environment asset `runAsUid` field. Can be provided only when the source uid/gid of the environment asset is not `fromTheImage`, and `overrideUidGidInWorkspace` is enabled. |
| `runAsGid` | `integer` <int64> or `null` | The group id to run the entrypoint of the container. Default to the (optional) value specified in the environment asset runAsGid field. Can be provided only when the source uid/gid of the environment asset is not `fromTheImage`, and `overrideUidGidInWorkspace` is enabled. |
| `supplementalGroups` | `string` or `null` | Comma seperated list of groups that the user running the container belongs to, in addition to the group indicated by `runAsGid`. Can be provided only when the source uid/gid of the environment asset is not `fromTheImage`, and `overrideUidGidInWorkspace` is enabled. Empty string implies reverting to the supplementary groups of the image. |
| `image`| `string` or `null` (non-empty) | Docker image name. Image name is mandatory for creating a workspace. See [Images](https://kubernetes.io/docs/concepts/containers/images>){target=_blank} |
| `imagePullPolicy` | `string` or `null` (non-empty) | Image pull policy.  Select from: `Always`, `Never`, or `IfNotPresent`. Defaults to Always if `latest tag` is specified, or `IfNotPresent` otherwise. |
| `workingDir` | `string` or `null` (non-empty) | The container's working directory. If not specified, the container runtime default will be used, which might be configured in the container image. |
| `hostIpc` | `boolean` or `null` | Enable host IPC. Defaults to `false`. |
| `hostNetwork` | `boolean` or `null` | Enable host networking. Default to `false`. |
| `connections` | `array of objects` | List of [connections](#connections-variables) that either expose ports from the container (each port is associated with a tool that the container runs), or URL's to be used for connecting to an external tool that is related to the action of the container (such as Weights & Biases). |
| `createHomeDir` | `boolean` or `null` | Create a home directory for the container. |
| `allowPrivilegeEscalation` | `boolean` or `null` | Allow the container running the workload and all launched processes to gain additional privileges after the workload starts. For more information, see [User Identity in Container](../../runai-setup/config/non-root-containers.md). |
| `uidGidSource` | `string` or `null` | Indicate the way to determine the user and group ids of the container. Choose from: </br> `fromTheImage`&mdash;user and group ids are determined by the docker image that the container runs (Default).</br> `custom`&mdash;user and group ids can be specified in the environment asset and/or the workspace creation request. <br/> `idpToken`&mdash;user and group ids are determined according to the identity provider (idp) access token. This option is intended for internal use of the environment UI form. For more information see [User Identity guide](../../runai-setup/config/non-root-containers.md). |
| `overrideUidGidInWorkspace` | `boolean` | Allow specifying uid/gid as part of create workspace. This is relevant only for custom uigGidSource. Default: false|
| `capabilities` | `array of strings` or `null` | The POSIX capabilities to add when running containers. Defaults to the default set of capabilities granted by the container runtime. Choose from: `AUDIT CONTROL `, `AUDIT READ `, `AUDIT WRITE `, `BLOCK SUSPEND `, `CHOWN `, `DAC OVERRIDE `, `DAC READ SEARCH `, `FOWNER `, `FSETID `, `IPC LOCK `, `IPC OWNER `, `KILL `, `LEASE `, `LINUX IMMUTABLE `, `MAC ADMIN `, `MAC OVERRIDE `, `MKNOD `, `NET ADMIN `, `NET BIND SERVICE `, `NET BROADCAST `, `NET RAW `, `SETGID `, `SETFCAP `, `SETPCAP `, `SETUID `, `SYS ADMIN `, `SYS BOOT `, `SYS CHROOT `, `SYS MODULE `, `SYS NICE `, `SYS PACCT `, `SYS PTRACE `, `SYS RAWIO `, `SYS RESOURCE `, `SYS TIME `, `SYS TTY CONFIG `, `SYSLOG `, `WAKE ALARM`. |
| `seccompProfileType` | `string` or `null` | Indicates which kind of seccomp profile will be applied to the container. Choose from: `Runtime` (default)&mdash;the container runtime default profile should be used. </br> `Unconfined`&mdashno profile should be applied. </br> `Localhost` is not yet supported by Run:ai. |
| `runAsNonRoot` | `boolean` or `null` | Indicates that the container must run as a non-root user. |

##### Environment Variables

|Field | Type | Description |
| -- | -- | --|
| `name` (required) | `string` (non-empty) | The name of the environment variable. |
| `value` (required) | `string` | The value to set the environment variable to. |
| `deleted` | `boolean` | Exclude this environment variable from the workload. This is necessary in case the variable definition is inherited from a policy.|

##### Connections Variables

|Field | Type | Description |
| -- | -- | --|
| `namerequired` | `string` (non-empty) | A unique name of this connection. This name correlates between the connection information specified at the environment asset, to the information about the connection as specified in `SpecificEnv` for a specific workspace. |
| `isExternal` | `boolean` | Internal tools (`isExternal=false`) are tools that run as part of the container. External tools (`isExternal=true`) run outside the container, typically in the cloud. Default: false. |
| `internalToolInfo` | `object` or `null` | Information about the [internal tool](#internal-tool-variables). |
| `externalToolInfo` | `object` or `null` | Information about the [external tool](). |

###### Internal Tool Variables

|Field | Type | Description |
| -- | -- | --|
| `toolType` (required) | `string` (non-empty) | The type of the internal tool. This runs within the container and exposes ports associated with the tool using `NodePort`, `LoadBalancer` or `ExternalUrl`. Choose from: `jupyter-notebook`, `pycharm`, `visual-studio-code`, `tensorboard`, `rstudio`, `mlflow`, `custom`, or `matlab`. |
| `connectionType` (required) | `string` (non-empty) | The type of connection that exposes the container port. Choose from: `LoadBalancer`, `NodePort`, or `ExternalUrl`. |
| `containerPort` (required) | `integer` <int32>  | The port within the container that the connection exposes. |
| `nodePortInfo` | `object` or `null` | Use the `isCustomPort` variable (`boolean`) to ensute that the node port is provided in the specific env of the workspace. Use the default `false` to ensure the node port is auto generated by the system. |
| `externalUrlInfo` | `object` or `null` | Use the `isCustomUrl` variable (boolean) to indicate whether the external url is provided in the specific env of the workspace. Use the default `false`to ensure the external url is auto generated by the system. </br> Use the `externalUrl` variable (`string` or `null` - non-empty) to decalre the default value for the external url. You can override it in the specific env of the workspace. |

###### External Tool Variables

|Field | Type | Description |
| -- | -- | --|
| `toolType` (required) | `string` (non-empty) | The type of external tool that is associated with the connection. External tools typically run in the cloud and require an external url to connect to it. Choose from `wandb` or `comet`. |
| `externalUrl` (required) | `string` (non-empty) | The external url for connecting to the external tool. The url can include environment variables that will be replaced with the values provided when the workspace is created. |

#### Compute Resource Fields

|Field | Type | Description |
| -- | -- | --|
| `gpuDevicesRequest` | `integer`<int32> or `null` | Requested number of GPU devices. Currently if more than one device is requested, it is not possible to provide values for gpuMemory/migProfile/gpuPortion. |
| `gpuRequestType` | `string` or `null` (GpuRequestType) non-empty | Enum: "portion" "memory" "migProfile"Whether the request for GPU resources is stated in terms of portion, memory or mig profile. If gpuDevicesRequest > 1, only portion with gpuPortionRequest 1 is supported. If gpuDeviceRequest = 1, request type can be stated as portion, memory or migProfile. |
| `gpuPortionRequest` | `number`<double> or `null` | Required if and only if gpuRequestType is portion. States the portion of the GPU to allocate for the created workload, per GPU device, between 0 and 1. The default is no allocated GPUs. |
| `gpuPortionLimit` | `number`<double> or `null` | Limitations on the portion consumed by the workload, per GPU device. The system guarantees The puPotionLimit must be no less than the gpuPortionRequest. |
| `gpuMemoryRequest` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | Required if and only if gpuRequestType is memory. States the GPU memory to allocate for the created workload, per GPU device. Note that the workload will not be scheduled unless the system can guarantee this amount of GPU memory to the workload. |
| `gpuMemoryLimit` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | Limitation on the memory consumed by the workload, per GPU device. The system guarantees The gpuMemoryLimit must be no less than gpuMemoryRequest. |
| `migProfile` | `string` or `null` (MigProfile) non-empty | Enum: "1g.5gb" "1g.10gb" "2g.10gb" "2g.20gb" "3g.20gb" "3g.40gb" "4g.20gb" "4g.40gb" "7g.40gb" "7g.80gb"Required if and only if gpuRequestType is migProfile. States the memory profile to be used for workload running on NVIDIA Multi-Instance GPU (MIG) technology. |
| `cpuCoreRequest` | `number`<double> or `null`| CPU units to allocate for the created workload (0.5, 1, .etc). The workload will receive at least this amount of CPU. Note that the workload will not be scheduled unless the system can guarantee this amount of CPUs to the workload. |
| `cpuCoreLimit` | `number`<double> or `null` | Limitations on the number of CPUs consumed by the workload (0.5, 1, .etc). The system guarantees that this workload will not be able to consume more than this amount of CPUs. |
| `cpuMemoryRequest` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The amount of CPU memory to allocate for this workload (1G, 20M, .etc). The workload will receive at least this amount of memory. Note that the workload will not be scheduled unless the system can guarantee this amount of memory to the workload |
| `cpuMemoryLimit` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | Limitations on the CPU memory to allocate for this workload (1G, 20M, .etc). The system guarantees that this workload will not be able to consume more than this amount of memory. The workload will receive an error when trying to allocate more memory than this limit. |
| `largeShmRequest` | `boolean` or `null` | A large /dev/shm device to mount into a container running the created workload. An shm is a shared file system mounted on RAM. |
| `extendedResources` | `Array` | An array of objects or null or null (ExtendedResources) - Set of extended resources with their quantity. |

##### Extended Resources Array

|Field | Type | Description |
| -- | -- | --|
| `resource required` | `string` non-empty | The name of the extended resource.|
| `quantity required` | `string` non-empty | The requested quantity for the given resource. |
| ` deleted` | `boolean` | Whether to exclude this extended resource from the workload. This is necessary in case the extended resource definition is inherited from a policy.

#### Hostpath Resource Fields

|Field | Type | Description |
| -- | -- | --|
| `pathrequired` | `string` or `null` non-empty |Local path within the controller to which the host volume will be mapped. Path is mandatory for creating a workspace. |
| `readOnly` | `boolean` or `null` Default: true | Whether to force the volume to be mounted with read-only permissions. Defaults to false. |
| ` mountPathrequired` | `string` or `null` non-empty | The path that the host volume will be mounted to when in use. MountPath is mandatory for creating a workspace. |

#### NFS Description Fields

|Field | Type | Description |
| -- | -- | --|
| `pathrequired` | `string` or `null` non-empty | Path that is exported by the NFS server. More info at <https://kubernetes.io/docs/concepts/storage/volumes#nfs>. Path is mandatory for creating a workspace. |
| `readOnly` | `boolean` or `null` Default: true | Whether to force the NFS export to be mounted with read-only permissions. |
| `serverrequired` | `string` or `null` non-empty | The hostname or IP address of the NFS server. Server is mandatory for creating a workspace. |
| `mountPathrequired` | `string` or `null` non-empty | The path that the NFS volume will be mounted to when in use. MountPath is mandatory for creating a workspace. |

#### PVC Description Fields

|Field | Type | Description |
| -- | -- | --|
| `existingPvc` | `boolean` or `null` Default: false | Whether to assume that the PVC exists. If set to true, PVC is assumed to exist. If set to false, the PVC will be create if it does not exist. |
| `claimNamerequired` | `string` or `null` non-empty | A given name for the PVC. Allowed referencing it across workspaces. ClaimName is mandatory for creating a workspace. |
| `pathrequired` | `string` or `null` non-empty | Local path within the workspace to which the PVC bucket will be mapped. Path is mandatory for creating a workspace. |
| `readOnly` | `boolean` or `null` Default: true | Whether the path to the PVC permits only read access. |
| `ephemeral` |`boolean` or `null` Default: false | Whether the PVC is ephemeral. If set to true, the PVC will be deleted when the workspace is stopped. |
| `claimInfo` | `object` or `null` [ClaimInfo](#claim-info) | Claim information for the newly created PVC. The information should not be provided when attempting to use existing PVC. |

##### Claim Info

|Field | Type | Description |
| -- | -- | --|
| `sizerequired` | `string` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ Requested size for the PVC. Mandatory when existingPvc is false. |
| `storageClass` | `string` or `null` non-empty | Storage class name to associate with the PVC. This parameter may be omitted if there is a single storage class in the system, or you are using the default storage class. For more information see [Storage classes](https://kubernetes.io/docs/concepts/storage/storage-classes){target=_blank}.
| `accessModes` | `object` or `null` [AccessModes]() | Requested access mode(s) for the newly created PVC.
| `volumeMode` | `string` or `null` | Enum: "Filesystem" "Block"The volume mode required by the claim, either Filesystem (default) or Block. |

###### Access Modes

|Field | Type | Description |
| -- | -- | --|
| `readWriteOnce` | `boolean` or `null` Default: true | Requesting claim that can be mounted in read/write mode to exactly one host. This is the default access mode. |
| `readOnlyMany` | `boolean` or `null` Default: false | Requesting claim that can be mounted in read-only mode to many hosts. |
| `readWriteMany` | `boolean` or `null` Default: false| Requesting claim that can be mounted in read/write mode to many hosts. |

#### Git Repository Description Fields

|Field | Type | Description |
| -- | -- | --|
| `repositoryrequired` | `string` or `null` non-empty | URL to a remote git repository. The content of this repository will be mapped to the container running the workload. Repository name is mandatory for creating a workspace. |
| `branch` | `string` or `null` non-empty | Specific branch to synchronize the repository from. |
| `revision` | `string` or `null` non-empty | Specific revision to synchronize the repository from. |
| `pathrequired` | `string` or `null` non-empty | Local path within the workspace to which the S3 bucket will be mapped. Path is mandatory for creating a workspace. |
| `passwordAssetId` | `string`<uuid> or `null` non-empty | ID of credentials asset of type password. Needed for non public repository which requires authentication. |

#### S3 Resource Description Fields

|Field | Type | Description |
| -- | -- | --|
| `bucketrequired` | `string` or `null` non-empty The name of the bucket Bucket name is mandatory for creating a workspace. |
| `pathrequired` | `string` or `null` non-empty | Local path within the workspace to which the S3 bucket will be mapped. Path is mandatory for creating a workspace. |
| `accessKeyAssetId` | `string`<uuid> or `null` non-empty | ID of credentials asset of type access-key, for private S3 buckets. |
| `url` | `string` or `null` non-empty | The url of the S3 service provider. The default is the URL of the Amazon AWS S3 service. |

#### ConfigMap Resource Description Fields

|Field | Type | Description |
| -- | -- | --|
|`json:"configMap"` | `string` | The name of the ConfigMap. ConfigMap is mandatory for creating a workspace. |
|`json:"mountPath"` | `string` | Local path within the workspace to which the ConfigMap will be mapped. ClaimName is mandatory for creating a workspace. |

#### Workspace

|Field | Type | Description |
| -- | -- | --|
| `nodeType` | `string` or `null` non-empty | Nodes or a group of nodes on which the workload will run. To use this feature, your Administrator will need to label nodes as explained in [Group Nodes](https://docs.run.ai/latest/admin/researcher-setup/limit-to-node-group). This flag can be used in conjunction with Project-based affinity. In this case, the flag is used to refine the list of allowable node groups set in the Project. For more information, see [Projects](https://docs.run.ai/latest/admin/admin-ui-setup/project-setup). |
| `nodePools` | `Array of strings` or `null` | A prioritize list of node pools for the scheduler to run the workspace on. The scheduler will always try to use the first node pool before moving to the next one when the fist is not available. |
| `allowOverQuota` | `boolean` or `null` | Whether to allow the workspace to exceed the quota of the project. |
| `annotations` | `Array of objects` or `null` [Annotations](#annotations) | Set of annotations to populate into the container running the workspace. |
| `labels` | `Array of objects` or `null` [Labels](#labels) | Set of labels to populate into the container running the workspace. |
| `autoDeletionTimeAfterCompletionSeconds` | `integer`<int64> or `null` | Specifies the duration after which a finished workload (Completed or Failed) will be automatically deleted. |
| `terminateAfterPreemption` | `boolean` or `null` | Indicates whether the job should be terminated, by the system, after it has been preempted. |

##### Annotations

|Field | Type | Description |
| -- | -- | --|
| `namerequired` | `string` non-empty | The name of the annotation. |
| `valuerequired` | `string` |The value to set the annotation to. |
| `deleted` | `boolean` | Whether to exclude this annotation from the workload. This is necessary in case the annotation definition is inherited from a policy. |

##### Labels

|Field | Type | Description |
| -- | -- | --|
| `namerequired` | `string` non-empty | The name of the annotation. |
| `valuerequired` | `string` |The value to set the annotation to. |
| `deleted` | `boolean` | Whether to exclude this annotation from the workload. This is necessary in case the annotation definition is inherited from a policy. |

#### Imposed Assets

|Field | Type | Description |
| -- | -- | --|
| `datasources`	| `Array of strings`<uuid> or `null` | -- |

### Rules

The `rules` section of the policy file is...

|Field | Type | Description |
| -- | -- | --|
| `environment` | `object` or `null` | [Rules Environment fields](#rules-environment-fields) fields that can be overridden when creating a workload. |
| `compute` | `object` or `null` | Compute resources requested.
| `hostPath` | `object` or `null` | Volumes resource definitions.
| `nfs` | `object` or `null` | NFS volume definitions.
| `pvc` | `object` or `null` | PVC definitions.
| `git` | `object` or `null` | Git repository definitions.
| `s3` | `object` or `null` | S3 resource definitions.
| `imposedAssets` | `object` or `null` | A list of asset to be imposed on the workloads created in org units affected by this policy.

#### Rules Environment fields

|Field | Type | Description |
| -- | -- | --|
| `allowPrivilegeEscalation` | `object` or `null` [Allow Privilege Escalation](#allow-privilege-escalation) | -- |
| `args` | `object` or `null` (StringRulesOptional) | -- |
| `capabilities` | `object` or `null` (ArrayRules) | -- |
| `command` | `object` or `null` (StringRulesOptional) | -- |
| `createHomeDir` | `object` or `null` (BooleanRules) | --|
| `environmentVariables` | `object` or `null` (EnvironmentVariablesRules) | -- |
| `hostIpc` | `object` or `null` (BooleanRules) | --|
| `hostNetwork` | `object` or `null` (BooleanRules) | -- |
| `image` | `object` or `null` (StringRules) | -- |
| `imagePullPolicy` | `object` or `null` (ImagePullPolicyRules) | -- |
| `overrideUidGidInWorkspace` | `object` or `null` (BooleanRulesOptional) | -- |
| `runAsUid` | `object` or `null` (IntegerRulesOptional) | -- |
| `runAsGid`	| `object` or `null` (IntegerRulesOptional) | -- |
| `supplementalGroups` | `object` or `null` (StringRulesOptional) | -- |
| `uidGidSource` | `object` or `null` (StringRules) | -- |
| `workingDir` | `object` or `null` (StringRules) | -- |
| `runAsNonRoot` | `object` or `null` (BooleanRules) | -- |
| `seccompProfileType` | `object` or `null` (StringRules) | -- |

##### Allow Privilege Escalation

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` Default = true | Whether the value of the field is editable. |

###### Source of Rule

|Field | Type | Description |
| -- | -- | --|
| `scoperequired` | `string` (Scope) | Enum: "tenant" "department" "project"The scope that the policy relates to. |
| `projectId` | `integer`<int32> or `null` (ProjectId) | The id of the project. Must be specified for project scoped assets. |
| `departmentId` | `string`<uuid> or `null` | (DepartmentId) non-emptyThe id of the department. Must be specified for department scoped policies. |

##### Args

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Capabilities

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` Default = true | Whether the value of the field is editable. |

##### Command

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Create Home Dir

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` Default = true | Whether the value of the field is editable. |

##### Rules Environment Variables

|Field | Type | Description |
| -- | -- | --|
| `itemRules` | `object` or `null` | <table><tbody><tr><td>`sourceOfRule`</td><td>`object` or `null` [Source Of Rule](#source-of-rule)</td><td>This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests.</td></tr><tr><td>`canAdd`</td><td>`boolean` or `null`</td><td>Whether it is permitted to add items. Default to true.</td><tr><tr><td>`locked`</td><td>`Array of strings`</td><td>Set of keys for items that are "locked", i.e. cannot be removed or deleted.</td></tr></table> |

##### Host IPC

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Host Network

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Image

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory.
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Image Pull Policy

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory.
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Override Uid/Gid In Workspace

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |

##### Run as Uid

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `canEdit` | `boolean` or `null` Default = true | Whether the value of the field is editable. |
| `min` | `integer`<int32> or `null` | The minimum value that the field can be assigned to. |
| `max` | `integer`<int32> or `null` | The maximum value that the field can be assigned to. |
| `step` | `integer`<int32> or `null` | The minimal difference between two values the field can be assigned to. For example, min=2, max=10, step=2 implies that the values the field can hold are 2, 4, 6, 8 and 10. |

##### Run as Gid

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `canEdit` | `boolean` or `null` Default = true | Whether the value of the field is editable. |
| `min` | `integer`<int32> or `null` | The minimum value that the field can be assigned to. |
| `max` | `integer`<int32> or `null` | The maximum value that the field can be assigned to. |
| `step` | `integer`<int32> or `null` | The minimal difference between two values the field can be assigned to. For example, min=2, max=10, step=2 implies that the values the field can hold are 2, 4, 6, 8 and 10. |

##### Supplemental Groups

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Uid/Gid Source

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory.
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Working Dir

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory.
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Run as Non-root

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory.
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |

##### Seccomp Profile Type

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |


#### Rules Compute Fields

##### CPU Core Request

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `min` | `number` or `null` | The minimum value that the field can be assigned to. |
| `max` | `number` or `null` | The maximum value that the field can be assigned to. |
| `step` | `number` or `null` | The minimal difference between two values the field can be assigned to. For example, min=2, max=3, step=0.25 implies that the values the field can hold are 2, 2.25, 2.5 and 3. |

##### CPU Core Limit

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `min` | `number` or `null` | The minimum value that the field can be assigned to. |
| `max` | `number` or `null` | The maximum value that the field can be assigned to. |
| `step` | `number` or `null` | The minimal difference between two values the field can be assigned to. For example, min=2, max=3, step=0.25 implies that the values the field can hold are 2, 2.25, 2.5 and 3. |

##### CPU Memory Request

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `min` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The minimum value that the field can be assigned to. |
| `max` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The maximum value that the field can be assigned to. |

##### CPU Memory Limit

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `min` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The minimum value that the field can be assigned to. |
| `max` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The maximum value that the field can be assigned to. |

##### Extended Resources

|Field | Type | Description |
| -- | -- | --|
| `itemRules` | `object` or `null` (ItemRules) | | `itemRules` | `object` or `null` | <table><tbody><tr><td>`sourceOfRule`</td><td>`object` or `null` [Source Of Rule](#source-of-rule)</td><td>This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests.</td></tr><tr><td>`canAdd`</td><td>`boolean` or `null`</td><td>Whether it is permitted to add items. Default to true.</td><tr><tr><td>`locked`</td><td>`Array of strings`</td><td>Set of keys for items that are "locked", i.e. cannot be removed or deleted.</td></tr></table> | |
| `members` | `object` or `null` | the [Quantity](#quantity) of rules. Use the following table for the fields and values. |

###### Quantity

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Large Shm Request

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |

##### GPU Request Type

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` | Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string` or `null` non empty</td><td> Enum: "portion" "memory" "migProfile". Whether the request for GPU resources is stated in terms of portion, memory or mig profile. If gpuDevicesRequest > 1, only portion with gpuPortionRequest 1 is supported. If gpuDeviceRequest = 1, request type can be stated as portion, memory or migProfile.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value.</td></tr></tbody></table> |

##### Mig Profile

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of Objects` or `null` | Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string` or `null` non-empty </td><td> Enum: "1g.5gb" "1g.10gb" "2g.10gb" "2g.20gb" "3g.20gb" "3g.40gb" "4g.20gb" "4g.40gb" "7g.40gb" "7g.80gb"
Required if and only if gpuRequestType is migProfile. States the memory profile to be used for workload running on NVIDIA Multi-Instance GPU (MIG) technology.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value.</td></tr></tbody></table> |

##### GPU Devices Request

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` Default = true | Whether the value of the field is editable. |
| `min` | `integer`<int32> or `null` | The minimum value that the field can be assigned to. |
| `max` | `integer`<int32> or `null` | The maximum value that the field can be assigned to. |
| `step` | `integer`<int32> or `null` | The minimal difference between two values the field can be assigned to. For example, min=2, max=10, step=2 implies that the values the field can hold are 2, 4, 6, 8 and 10. |

##### GPU Portion Request

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `min` | `number` or `null` | The minimum value that the field can be assigned to. |
| `max` | `number` or `null` | The maximum value that the field can be assigned to. |
| `step` | `number` or `null` | The minimal difference between two values the field can be assigned to. For example, min=2, max=3, step=0.25 implies that the values the field can hold are 2, 2.25, 2.5 and 3. |

##### GPU Portion Limit

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `min` | `number` or `null` | The minimum value that the field can be assigned to. |
| `max` | `number` or `null` | The maximum value that the field can be assigned to. |
| `step` | `number` or `null` | The minimal difference between two values the field can be assigned to. For example, min=2, max=3, step=0.25 implies that the values the field can hold are 2, 2.25, 2.5 and 3. |

##### GPU Memory Request

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `min` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The minimum value that the field can be assigned to. |
| `max` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The maximum value that the field can be assigned to. |

##### GPU Memory Limit

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `min` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The minimum value that the field can be assigned to. |
| `max` | `string` or `null` ^(\[+-\]?\[0-9.\]+)(\[eEinumkKMGTP\]\*\[-+\]?\[0-9\]\*)$ | The maximum value that the field can be assigned to. |

#### Host Path

|Field | Type | Description |
| -- | -- | --|
| `path` | `object` or `null` (StringRules) | -- |
| `readOnly` | `object` or `null`(BooleanRules) | -- |
| `mountPath` | `object` or `null` (StringRules) | -- |

##### Path

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Read Only

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |

###### Mount Path

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### NFS

|Field | Type | Description |
| -- | -- | --|
| `path` | `object` or `null` (StringRules) | -- |
| `readOnly` | `object` or `null` (BooleanRules) | -- |
| `server` | `object` or `null` (StringRules) | -- |
| `mountPath` | `object` or `null` (StringRules) | -- |

###### Path

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Read Only

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |

###### Server

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Mount Path

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### PVC

|Field | Type | Description |
| -- | -- | --|
| `claimName` | `object` or `null` (StringRules) | -- |
| `path` | `object` or `null` (StringRules) | -- |
| `readOnly` | `object` or `null` (BooleanRules) | -- |
| `claimInfo` | `object` or `null` (ClaimInfoRules) | -- |

###### Claim Name

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Path

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Read Only

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |

###### Claim Info

|Field | Type | Description |
| -- | -- | --|
| `size` | `object` or `null` (StringRules) | -- |
| `storageClass` | `object` or `null` (StringRules) | -- |

######  Size

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Storage Class

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Git

|Field | Type | Description |
| -- | -- | --|
| `repository` | `object` or `null` (StringRules) | -- |
| `branch` | `object` or `null` (StringRules) | -- |
| `revision` | `object` or `null` (StringRules) |
| `path` | `object` or `null` (StringRules) | -- |

###### Repository

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Branch

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Revision

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Path

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### S3

|Field | Type | Description |
| -- | -- | --|
| `bucket` | `object` or `null` (StringRules) | -- |
| `path` | `object` or `null` (StringRules) | -- |
| `url` | `object` or `null` (StringRules) | -- |

###### Bucket

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### Path

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

###### URL

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

#### Imposed Assets

|Field | Type | Description |
| -- | -- | --|
| `datasources` | `object` or `null` | Use any of the fields in the following table: |

##### Data Sources

|Field | Type | Description |
| -- | -- | --|
|`hostPath` | `object` or `null` | <table><tbody><tr><td>`canAdd`</td><td>`boolean` or `null`<br></td><td>Whether it is possible to add non-imposed assets in the workload</td></tr></tbody></table> |
|`nfs` | `object` or `null` | <table><tbody><tr><td>`canAdd`</td><td>`boolean` or `null`<br></td><td>Whether it is possible to add non-imposed assets in the workload</td></tr></tbody></table> |
|`pvc` | `object` or `null` | <table><tbody><tr><td>`canAdd`</td><td>`boolean` or `null`<br></td><td>Whether it is possible to add non-imposed assets in the workload</td></tr></tbody></table> |
|`git` | `object` or `null` | <table><tbody><tr><td>`canAdd`</td><td>`boolean` or `null`<br></td><td>Whether it is possible to add non-imposed assets in the workload</td></tr></tbody></table> |
|`s3` | `object` or `null` | <table><tbody><tr><td>`canAdd`</td><td>`boolean` or `null`<br></td><td>Whether it is possible to add non-imposed assets in the workload</td></tr></tbody></table> |

#### Workspace

|Field | Type | Description |
| -- | -- | --|
| `nodeType` | `object` or `null` (StringRules) | -- |
| `nodePools` | `object` or `null` (ArrayRules) | -- |
| `allowOverQuota` | `object` or `null` (BooleanRules) | -- |
| `annotations` | `object` or `null` (AnnotationsRules) | -- |
| `labels` | `object` or `null` (LabelsRules) | -- |
| `autoDeletionTimeAfterCompletionSeconds` | `object` or `null` (IntegerRules) | -- |
| `terminateAfterPreemption` | `object` or `null` (BooleanRules) | -- |

##### Node Type

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
| `options` | `Array of objects` or `null` (StringOption)Set of options that the value of the field must be chosen from. | <table><tbody><tr><td>`value required`</td><td>`string`</td><td>The value that the field should hold.</td></tr><tr><td>`displayed`</td><td>`string` or `null`</td><td>Textual description of the value. to be used by user interface applications.</td></tr></tbody></table> |

##### Node Pools

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |

##### Allowed Over-quota

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |

##### Annotations

|Field | Type | Description |
| -- | -- | --|
| `itemRules` | `object` or `null` | <table><tbody><tr><td>`sourceOfRule`</td><td>`object` or `null` [Source Of Rule](#source-of-rule)</td><td>This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests.</td></tr><tr><td>`canAdd`</td><td>`boolean` or `null`</td><td>Whether it is permitted to add items. Default to true.</td><tr><tr><td>`locked`</td><td>`Array of strings`</td><td>Set of keys for items that are "locked", i.e. cannot be removed or deleted.</td></tr></table> |

##### Labels

|Field | Type | Description |
| -- | -- | --|
| `itemRules` | `object` or `null` | <table><tbody><tr><td>`sourceOfRule`</td><td>`object` or `null` [Source Of Rule](#source-of-rule)</td><td>This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests.</td></tr><tr><td>`canAdd`</td><td>`boolean` or `null`</td><td>Whether it is permitted to add items. Default to true.</td><tr><tr><td>`locked`</td><td>`Array of strings`</td><td>Set of keys for items that are "locked", i.e. cannot be removed or deleted.</td></tr></table> |

##### Auto Deletion Time After Completion Seconds

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` Default = true | Whether the value of the field is editable. |
| `min` | `integer`<int32> or `null` | The minimum value that the field can be assigned to. |
| `max` | `integer`<int32> or `null` | The maximum value that the field can be assigned to. |
| `step` | `integer`<int32> or `null` | The minimal difference between two values the field can be assigned to. For example, min=2, max=10, step=2 implies that the values the field can hold are 2, 4, 6, 8 and 10. |

###### Time after Preemption

|Field | Type | Description |
| -- | -- | --|
| `sourceOfRule` | `object` or `null` [Source Of Rule](#source-of-rule) | This field is used by the system along with effective rules, in order to specify the org unit from which this effective rule has been derived. It should be left empty when sending apply policy requests. |
| `required` | `boolean` or `null` Default = false | Whether the field is mandatory. |
| `canEdit` | `boolean` or `null` | Whether the value of the field is editable, default to true |
