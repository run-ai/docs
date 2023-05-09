# Run:ai version 2.10

## Version 2.10.8

## Release date

May 2023

## Fixed issues

|Internal ID|Description|
|-----------|--------------|
| RUN-9250 | Fixed trimming of wrong characters from API server URL in the CLI command `runai portfoward`. |
| RUN-9579 | Fixed nodepool priority assignment and persistance in API and UI.|
| RUN-9590 | Fixed PVC propagation not working due to improper handling of shared PVCs' annotations. |
| RUB-9631 | Added flag `--pod-running-timeout` to CLI commands `runai attach` and `runai bash`. |

## Version 2.10.7

## Release date

May 2023

## Fixed issues

|Internal ID|Description|
|-----------|--------------|
| RUN_9226 | Fixed implementation of MIG utilization metrics in graphs. |
| RUN-9309 | Changed the `backoffLimit` default for distributed workloads from 0 to 6 * (the number of workers).|
| RUN-9324 | Fixed volume capacity check on PVC when its not immediately bound. |

--------------------
## Version 2.10.6

## Release date

April 2023

## Release content

**runai port-forward**

The `port forward` CLI command can forward ports to any of the pods in a job.

The `port forward` CLI command now includes the `pod-running-timeout` flag. This determines how long the command will wait for the pod to run before it times out.  The default is 10 minutes.

**Scheduler**

Corrected scheduler message about availability of "other resources".

**Jobs**

Fixed the output of `runai describe job` for jobs without pods.

**Cluster wide PVC**

Cluster wide PVC is now replicated to namespaces that do not have an existing PVC with the same name.

## Fixed issues

|Internal ID|Description|
|-----------|--------------|
| RUN-9196 | Fixed dashboard overview displaying `running_workloads:cpu_only` rule.|
| RUN-9256 | Now supports the global configuration of memory request of memory-sensitive pods in the cluster.|
| RUN-9219 | Fixed `runai describe` on pytorch outputs "Is Distributed Workload: false".|
| RUN-9221 | Fixed CLI `runai describe` job nil pointer exception.|
| RUN-9220 | Fixed PVC duplication errors so that it does not duplicate for namespaces with the same PVC name and bound PVCs.|
| RUN-9224 | Fixed Scheduler not reporting the correct event on EFA (status history).|
| RUN-9189 | Improved Scheduler performance to reclaim action slowness in really big clusters.|
| RUN-450 | Change "edit boxes" to labels. |
| RUN-9218 | Added support for `pod-running-timeout` when using `runai port-forward`.|
| RUN-9252 | Fixed `runai port-forward` to be consistent with `runai bash` (`--target` is now `--pod`).|
| RUN-9071 | Fixed registries api call crashing the ui when returning an error.|
| RUN-8794 | Newer dashboards are now deployed for tenants using grafanlabs.|
| RUN-9212 | Fixed filter jobs by type. As a workaround, you can also you can sort by type.|

---------------------
## Version 2.10.5

## Release date

April 2023

## Release content
### Authentication and access control

**Credential Manager**

This feature provides configuration for credentials that are used to unlock protected resources such as applications, containers, and other assets. For configuration information, see [Credentials](../admin/admin-ui-setup/credentials-setup.md).

**SSO custom URL logout**

This feature configures a custom logout URL in your tenant. For configuration information, see [SSO UI Configuration](../admin/runai-setup/authentication/sso.md#logout-url).

**Department Administrator**

The new role of *Department Administrator* adds a layer of delegation in the administration of departments. For an explanation of the role, see [Create a user](../admin/admin-ui-setup/admin-ui-users.md#create-a-user). For Department configuration information, see [Assigning the Department Administrator role](../admin/admin-ui-setup/department-setup.md#assign-department-administrator-role).

**Enable SSO Using OIDC**

Added an additional SSO configuration option using OIDC as the identity provider. For configuration information, see [SSO UI Configuration](../admin/runai-setup/authentication/sso.md#step-1-ui-configuration).

**Inactivity timeout**

Added inactivity timeout for automated logout. The inactivity timeout is configured in minutes. For configuration information, see [Inactivity timeout](../admin/runai-setup/authentication/authentication-overview.md#inactivity-timeout).

### Researcher tools

**Pytorch**

Added CLI support for submitting Pytorch jobs. For more information, see [Submit Run:ai Pytorch job](../Researcher/cli-reference/runai-submit-pytorch.md).

**TensorFlow**

Added CLI support for submitting TensorFlow jobs. For more information, see [Submit Run:ai TensorFlow job](../Researcher/cli-reference/runai-submit-TF.md).

**Cron jobs support**

Added support for cron command-line job scheduler. For more information, see [Submit CRON job via YAML](../developer/cluster-api/submit-cron-yaml.md).

**Previous jobs menu**

The option to re-run a job is supported via the `Clone Job` action in the `Jobs` screen. The option to select a previous job in the "New Job" form is no longer supported

**Annotations and labels**

Added to the UI the capability to add Kubernetes annotations and labels to the new job form.

### Scheduling

**Bin-Packing or Spread CPU scheduling strategy**

The administrator can set a cluster-wide scheduling parameter to determine if the scheduler should spread or bin-pack workloads. Added a new distinct parameter for pure CPU workloads so administrators can use different strategies for different workloads. For more information, see [Scheduling Strategies](../Researcher/scheduling/strategies.md)

**Scheduling workloads to AWS placement groups**

Added feature to leverage [Placement Groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html){target=_blank} within AWS to maximize throughput and performance of distributed training workloads. For more information, see [Scheduling workloads to AWS placement groups](../Researcher/scheduling/schedule-to-aws-groups.md).

**Job Status Notifications**

Added the capability to send job statuses notifications to Slack. For configuration information, see [Event Router](../admin/integration/messaging.md).

### Storage

**Cluster wide PVC**

Added the ability to use cluster wide PVCs. A PersistentVolumeClaim (PVC) is a request for storage by a user and is similar to a Pod. Pods consume node resources and PVCs consume PV resources. Pods can request specific levels of resources (CPU and Memory). Claims can request specific size and access modes. For more information about PVCs, see [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/){target=_blank}. For PVC configuration, see [Setting up cluster wide PVCs](../admin/researcher-setup/cluster-wide-pvc.md).

**Ephemeral PVC**

Added support Ephemeral PVC in CLI and in the job submission form. For more information, see CLI reference [runai submit](../Researcher/cli-reference/runai-submit.md#-pvc-exist-string).

## Known issues

|Internal ID|Description|Workaround|
|-----------|--------------|--------------|
| RUN-8695 | SSO users that logged in via SAML can't login again after disabling and reenabling SSO. |     |
| RUN-8680 | A user in an OCP group with roles that belong to that group should be able to submit a job from the UI. |     |
| RUN-8601 | Warning when the CLI command `runai suspend` is used.  |     |
| RUN-8422 | Remove Knative unnecessary requests when inference is not enabled. |     |
| RUN-7874 | A new job returns `malformed URL` when a project is not connected to a namespace. |     |
| RUN-6301 | A job in the job list side panel shows both `pending` and `running` at the same time.  |     |

## Fixed issues

|Internal ID|Description|
|-----------|--------------|
| RUN-8223 | Missed foreign key to tenants table. |
| RUN-5187 | S3 can now be configured to work in airgapped environments. |
| RUN-8276 | 503 error when creating a workload (request timeout for validation webhook). |
| RUN-7266 | Allocation bug - a researcher asked for 2 GPU for Interactive Job and other jobs received the allocated GPU within the same node |
| RUN-8418 | different user when submitting via runai cli and vi ui submit form |
| RUN-6838 | When submitting a job with port out of range, the job is submitted successfully however the submission actually fails. |
| RUN-8196 | Nodepools aren't visible in 2.9 UI. |
| RUN-7435 | Run:ai CLI submit doesn't parse correctly environment variables that end with a '='. |
| RUN-8192 | The UI shows a deleted job in the Current Jobs tab. |
| RUN-7776 | User does not exist in the UI due to pagination limitation. |
