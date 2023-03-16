# Run:ai version 2.10
## Release date

March 2023

## Release content

### Authentication and access control

**SSO custom URL logout**

This feature configures a custom logout URL in your tenant. For configuration information, see [SSO UI Configuration](../admin/runai-setup/authentication/sso.md#ui-configuration).

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

### Storage

**Cluster wide PVC**

Added the ability to use cluster wide PVCs. A PersistentVolumeClaim (PVC) is a request for storage by a user and is similar to a Pod. Pods consume node resources and PVCs consume PV resources. Pods can request specific levels of resources (CPU and Memory). Claims can request specific size and access modes. For more information about PVCs, see [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/){targe=_blank}. For PVC configuration, see [Setting up cluster wide PVCs](../admin/researcher-setup/cluster-wide-pvc.md).

**Ephemeral PVC**

Added support Ephemeral PVC in CLI and in the job submission form. For more information, see CLI reference [runai submit](../Researcher/cli-reference/runai-submit.md#-pvc-exist-string).

## Known issues

|Internal ID|Description|Workaround|
|-----------|--------------|--------------|

## Fixed issues

|Internal ID|Description|
|-----------|--------------|
