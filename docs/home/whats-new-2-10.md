# run:ai version 2.10

## Release date

March 2023

## Release content

### Authentication and access control

**SSO custom URL logout**

This feature configures a custom logout URL in your tenant. For configuration information, see [SSO UI Configuration](../admin/runai-setup/authentication/sso.md#ui-configuration).

**Department Administrator**

The new role of *Department Administrator* adds a layer of delegation in the administration of departments. For an explanation of the role, see [Create a user](../admin/admin-ui-setup/admin-ui-users.md#create-a-user). For Department configuration information, see [Assigning the Department Administrator role](../admin/admin-ui-setup/department-setup.md#assign-department-administrator-role).

**Enable SSO Using OIDC**

Added an additional SSO configuration option using OIDC as the identity provider. For configuration information, see [SSO UI Configuration](../admin/runai-setup/authentication/sso.md#ui-configuration).

### Registry integration (alpha feature)

**Container registry integration**

A new feature added that integrates container registry images into the list of images in a job or workspace. Images are limited to one registry that's configured by the system administrator Image names are filled in using autocomplete from the names of the images in the configured registry. For configuration information, see [Registry integration](registry-integration-alpha-feature). To select an image for a job, see [Submit a job](../admin/admin-ui-setup/jobs.md#submit-a-job).

**Registry images container with feature flag**

This feature added a configuration option for an admin to add a registry images container to the environment as a feature flag. For configuration information, see [Using a Docker Registry with Credentials](##../admin/researcher-setup/docker-registry-config.md).

### Researcher tools

**Pytorch**

Added CLI support for submitting Pytorch jobs. For more information, see [Submit run:ai Pytorch job](../Researcher/cli-reference/runai-submit-pytorch.md).

**TensorFlow**

Added CLI support for submitting TensorFlow jobs. For more information, see [Submit run:ai TensorFlow job](../Researcher/cli-reference/runai-submit-TF.md)

**CRON jobs support**

Fill in about cron jobs here.

### Dashboards

**Consumption dashboard**

Added a new dashboard to enable users and admins to view consumption usage using run:AI services. The dashboard provides views based on configurable filters and timelines. For more information,  see [Consumption dashboard](../admin/admin-ui-setup/dashboard-analysis.md#consumption-dashboard).

### Storage

**Cluster wide PVC**

Added the ability to use cluster wide PVCs. A PersistentVolumeClaim (PVC) is a request for storage by a user and is similar to a Pod. Pods consume node resources and PVCs consume PV resources. Pods can request specific levels of resources (CPU and Memory). Claims can request specific size and access modes. For more information about PVCs, see [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/){targe=_blank}. For PVC configuration, see [Setting up cluster wide PVCs](../admin/researcher-setup/cluster-wide-pvc.md).




## Known issues

|Internal ID|Description|Workaround|
|-----------|--------------|--------------|

## Fixed issues

|Internal ID|Description|
|-----------|--------------|

