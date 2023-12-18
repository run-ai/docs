---
title:  Workspaces Policy
summary: This article outlines what is a  workspaces policy and details the variables that are used in the policy.
authors:
    - Jason Novich
date: 2023-Dec-18
---

A workspaces policy is...

## Example

```yml

# insert example here

```
## Parameters List

## List of Configurable Parameters

The following parameters can be configured in the policy manager.

### Defaults

The `defaults` section of the policy file is...

|Parameter | Type | Definition |
| -- | -- | --|
| `environment` | `object` or `null` | [Environment](#environment-fields) fields that can be overridden when creating a workload. |
| `compute` | `object` or `null` | Compute resources requested. |
| `hostPath` | `object` or `null` | Volumes resource definitions. |
| `nfs` | `object` or `null` | NFS volume definitions. |
| `pvc` | `object` or `null` | PVC definitions. |
| `git` | `object` or `null` | Git repository definitions. |
| `s3` | `object` or `null` | S3 resource definitions.
| `imposedAssets` | `object` or `null` | A list of asset to be imposed on the workloads created in org units affected by this policy.|

#### Environment Fields

|Parameter | Type | Definition |
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
| `allowPrivilegeEscalation` | `boolean` or `null` | Allow the container running the workload and all launched processes to gain additional privileges after the workload starts. For more information, see [User Identity in Container](https://docs.run.ai/admin/runai-setup/config/non-root-containers/){target_blank}. |
| `uidGidSource` | `string` or `null` | Indicate the way to determine the user and group ids of the container. Choose from: </br> `fromTheImage`&mdash;user and group ids are determined by the docker image that the container runs (Default).</br> `custom`&mdash;user and group ids can be specified in the environment asset and/or the workspace creation request. <br/> `idpToken`&mdash;user and group ids are determined according to the identity provider (idp) access token. This option is intended for internal use of the environment UI form. For more information see [User Identity guide](../runai-setup/config/non-root-containers.md). |
| `overrideUidGidInWorkspace` | `boolean` | Allow specifying uid/gid as part of create workspace. This is relevant only for custom uigGidSource. Default: false|
| `capabilities` | `array of strings` or `null` | The POSIX capabilities to add when running containers. Defaults to the default set of capabilities granted by the container runtime. Choose from: `AUDIT CONTROL `, `AUDIT READ `, `AUDIT WRITE `, `BLOCK SUSPEND `, `CHOWN `, `DAC OVERRIDE `, `DAC READ SEARCH `, `FOWNER `, `FSETID `, `IPC LOCK `, `IPC OWNER `, `KILL `, `LEASE `, `LINUX IMMUTABLE `, `MAC ADMIN `, `MAC OVERRIDE `, `MKNOD `, `NET ADMIN `, `NET BIND SERVICE `, `NET BROADCAST `, `NET RAW `, `SETGID `, `SETFCAP `, `SETPCAP `, `SETUID `, `SYS ADMIN `, `SYS BOOT `, `SYS CHROOT `, `SYS MODULE `, `SYS NICE `, `SYS PACCT `, `SYS PTRACE `, `SYS RAWIO `, `SYS RESOURCE `, `SYS TIME `, `SYS TTY CONFIG `, `SYSLOG `, `WAKE ALARM`. |
| `seccompProfileType` | `string` or `null` | Indicates which kind of seccomp profile will be applied to the container. Choose from: `Runtime` (default)&mdash;the container runtime default profile should be used. </br> `Unconfined`&mdashno profile should be applied. </br> `Localhost` is not yet supported by Run:ai. |
| `runAsNonRoot` | `boolean` or `null` | Indicates that the container must run as a non-root user. |

##### Environment Variables

|Parameter | Type | Definition |
| -- | -- | --|
| `name` (required) | `string` (non-empty) | The name of the environment variable. |
| `value` (required) | `string` | The value to set the environment variable to. |
| `deleted` | `boolean` | Exclude this environment variable from the workload. This is necessary in case the variable definition is inherited from a policy.|

##### Connections Variables

|Parameter | Type | Definition |
| -- | -- | --|
| `namerequired` | `string` (non-empty) | A unique name of this connection. This name correlates between the connection information specified at the environment asset, to the information about the connection as specified in `SpecificEnv` for a specific workspace. |
| `isExternal` | `boolean` | Internal tools (`isExternal=false`) are tools that run as part of the container. External tools (`isExternal=true`) run outside the container, typically in the cloud. Default: false. |
| `internalToolInfo` | `object` or `null` | Information about the [internal tool](#internal-tool-variables). |
| `externalToolInfo` | `object` or `null` | Information about the [external tool](). |

###### Internal Tool Variables

|Parameter | Type | Definition |
| -- | -- | --|
| `toolType` (required) | `string` (non-empty) | The type of the internal tool. This runs within the container and exposes ports associated with the tool using `NodePort`, `LoadBalancer` or `ExternalUrl`. Choose from: `jupyter-notebook`, `pycharm`, `visual-studio-code`, `tensorboard`, `rstudio`, `mlflow`, `custom`, or `matlab`. |
| `connectionType` (required) | `string` (non-empty) | The type of connection that exposes the container port. Choose from: `LoadBalancer`, `NodePort`, or `ExternalUrl`. |
| `containerPort` (required) | `integer` <int32>  | The port within the container that the connection exposes. |
| `nodePortInfo` | `object` or `null` | Use the `isCustomPort` variable (`boolean`) to ensute that the node port is provided in the specific env of the workspace. Use the default `false` to ensure the node port is auto generated by the system. |
| `externalUrlInfo` | `object` or `null` | Use the `isCustomUrl` variable (boolean) to indicate whether the external url is provided in the specific env of the workspace. Use the default `false`to ensure the external url is auto generated by the system. </br> Use the `externalUrl` variable (`string` or `null` - non-empty) to decalre the default value for the external url. You can override it in the specific env of the workspace. |

###### External Tool Variables

|Parameter | Type | Definition |
| -- | -- | --|
| `toolType` (required) | `string` (non-empty) | The type of external tool that is associated with the connection. External tools typically run in the cloud and require an external url to connect to it. Choose from `wandb` or `comet`. |
| `externalUrl` (required) | `string` (non-empty) | The external url for connecting to the external tool. The url can include environment variables that will be replaced with the values provided when the workspace is created. |


#### Compute Resource Fields

|Parameter | Type | Definition |
| -- | -- | --|

#### Hostpath Resource Fields

#### NFS Definition Fields

#### PVC Definition Fields

#### Git Repository Definition Fields

#### S3 Resource Definition Fields

#### Imposed Assets




### Rules

The `rules` section of the policy file is...
