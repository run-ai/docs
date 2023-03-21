# Run:ai version 2.10
## Release date

March 2023

## Release content

### Authentication and access control

**SSO custom URL logout**

This feature configures a custom logout URL in your tenant. For configuration information, see [SSO UI Configuration](../admin/runai-setup/authentication/sso.md#logout-url).

**Department Administrator**

The new role of *Department Administrator* adds a layer of delegation in the administration of departments. For an explanation of the role, see [Create a user](../admin/admin-ui-setup/admin-ui-users.md#create-a-user). For Department configuration information, see [Assigning the Department Administrator role](../admin/admin-ui-setup/department-setup.md#assign-department-administrator-role).

**Enable SSO Using OIDC**

Added an additional SSO configuration option using OIDC as the identity provider. For configuration information, see [SSO UI Configuration](../admin/runai-setup/authentication/sso.md#step-1-ui-configuration).

**Inactivity timeout**

Added inactivity timeout for automated logout. The inactivity timeout is configured in minutes. For configuration information, see [Inactivity timeout](../admin/runai-setup/authentication/authentication-overview.md#inactivity-timeout)

### Researcher tools

**Pytorch**

Added CLI support for submitting Pytorch jobs. For more information, see [Submit Run:ai Pytorch job](../Researcher/cli-reference/runai-submit-pytorch.md).

**TensorFlow**

Added CLI support for submitting TensorFlow jobs. For more information, see [Submit Run:ai TensorFlow job](../Researcher/cli-reference/runai-submit-TF.md)

**Cron jobs support**

Added support for cron command-line job scheduler. For more information, see [Submit CRON job via YAML](../developer/cluster-api/submit-cron-yaml.md)

**Previous jobs menu**

Removed `Previous job` from the new job form.

**Annotations and labels**

Added to UI the capability to add k8s annotations and labels to job submission form.

**Scheduling workloads to AWS placement groups**

Added feature to leverage [Placement Groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html){target=_blank} within AWS to maximize throughput and performance of distributed training workloads. For more information, see [Scheduling workloads to AWS placement groups](../Researcher/scheduling/schedule-to-aws-groups.md).

**Job Status Notifications**

Added the capability to send job statuses notifications to Slack. For configuration information, see [Messaging](../admin/integration/messaging.md).

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
